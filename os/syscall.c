#include "defs.h"
#include "fcntl.h"
#include "proc.h"
#include "syscall_ids.h"
#include "trap.h"
#include "fs.h"
#include "file.h"
#include "timer.h"
#include "stat.h"

uint64 console_write(uint64 va, uint64 len) {
    struct proc *p = curr_proc();
    char str[200];
    int size = copyinstr(p->pagetable, str, va, MIN(len, 200));
    for(int i = 0; i < size; ++i) {
        console_putchar(str[i]);
    }
    return size;
}

uint64 console_read(uint64 va, uint64 len) {
    struct proc *p = curr_proc();
    char str[200];
    for(int i = 0; i < MIN(len, 200); ++i) {
        int c = console_getchar();
        str[i] = c;
    }
    copyout(p->pagetable, va, str, len);
    return len;
}

uint64 sys_write(int fd, uint64 va, uint64 len) {
    if (fd == 1) {
        return console_write(va, len);
    }
    if(fd == 0 || fd == 2)
        return -1;
    if(fd > 15)
        return -1;
    struct proc *p = curr_proc();
    struct file *f = p->files[fd];
    if (f->type == FD_PIPE) {
        return pipewrite(f->pipe, va, len);
    } else if (f->type == FD_INODE) {
        return filewrite(f, va, len);
    }
    error("unknown file type %d\n", f->type);
    return -1;
}

uint64 sys_read(int fd, uint64 va, uint64 len) {
    if (fd == 0) {
        return console_read(va, len);
    }
    if(fd == 1 || fd == 2)
        return -1;
    if(fd > 15)
        return -1;
    struct proc *p = curr_proc();
    struct file *f = p->files[fd];
    if (f->type == FD_PIPE) {
        return piperead(f->pipe, va, len);
    } else if (f->type == FD_INODE) {
        return fileread(f, va, len);
    }
    error("unknown file type %d\n", f->type);
    return -1;
}

uint64
sys_pipe(uint64 fdarray) {
    info("init pipe\n");
    struct proc *p = curr_proc();
    uint64 fd0, fd1;
    struct file *f0, *f1;
    if (f0 < 0 || f1 < 0) {
        return -1;
    }
    f0 = filealloc();
    f1 = filealloc();
    if (pipealloc(f0, f1) < 0)
        return -1;
    fd0 = fdalloc(f0);
    fd1 = fdalloc(f1);
    if (copyout(p->pagetable, fdarray, (char *) &fd0, sizeof(fd0)) < 0 ||
        copyout(p->pagetable, fdarray + sizeof(uint64), (char *) &fd1, sizeof(fd1)) < 0) {
        fileclose(f0);
        fileclose(f1);
        p->files[fd0] = 0;
        p->files[fd1] = 0;
        return -1;
    }
    return 0;
}

uint64 sys_exit(int code) {
    exit(code);
    return 0;
}

uint64 sys_sched_yield() {
    yield();
    return 0;
}

uint64 sys_getpid() {
    return curr_proc()->pid;
}

uint64 sys_clone() {
    return fork();
}

uint64 sys_exec(uint64 va) {
    struct proc* p = curr_proc();
    char name[200];
    copyinstr(p->pagetable, name, va, 200);
    return exec(name);
}

uint64 sys_wait(int pid, uint64 va) {
    struct proc *p = curr_proc();
    int *code = (int *) useraddr(p->pagetable, va);
    return wait(pid, code);
}

uint64 sys_times() {
    uint64 time = get_time_ms();
    return time;
}

uint64 sys_close(int fd) {
    if (fd == 0)
        return 0;
    struct proc *p = curr_proc();
    struct file *f = p->files[fd];
    fileclose(f);
    p->files[fd] = 0;
    return 0;
}

uint64 sys_openat(uint64 va, uint64 omode, uint64 _flags) {
    struct proc *p = curr_proc();
    char path[200];
    copyinstr(p->pagetable, path, va, 200);
    return fileopen(path, omode);
}

uint64 sys_mailread(uint64 buf,uint64 len){
    if(len > 256) len = 256;
    struct proc* p = curr_proc();
    // printf("testread %p %p\n",buf,len);
    if(p->size == 0)
        return -1;
    if(len == 0)
        return 0;
    // printf("passcheck!\n");
    if(len > p->lens[p->head]) len = p->lens[p->head];
    // printf("to copyout!\n");
    if(copyout(p->pagetable,buf,p->ringbuffer[p->head],len))
        return -1;
    // printf("fininsh copyout! %d\n",len);
    // printf("read %s\n",p->ringbuffer[p->head]);
    p->head = (p->head + 1) % 16;
    p->size -= 1;
    return len;
}

uint64 sys_mailwrite(int pid,uint64 buf,uint64 len){
    if(len > 256) len = 256;
    struct proc* p = curr_proc();
    struct proc* tar = find_proc(pid);
    // printf("tar %d size %d\n",pid,tar->size);
    if(tar->size >= FD_MAX)
        return -1;
    if(len == 0) return 0;
    // printf("pass check!\n");
    // printf("tar ustack %p\n",tar->ustack);
    // printf("find pa %p\n",walkaddr(tar->pagetable,buf));
    if(copyin(p->pagetable,tar->ringbuffer[tar->tail],buf,len))
        return -1;
    // printf("write %s\n",tar->ringbuffer[tar->tail]);
    tar->lens[tar->tail] = len;
    tar->size += 1;
    tar->tail = (tar->tail+1) % 16;
    // printf("finish writing! %d\n",len);
    return len;
}

uint64 sys_spawn(uint64 filename){
    char name[200];
    copyinstr(curr_proc()->pagetable, name, filename, 200);
    int pid = fork();
    // printf("pp %d %d\n",curr_proc()->pid,pid);
    struct proc *p = find_proc(pid);
    if(exec_proc(p,name))
        return -1;
    return pid;
}

uint64 sys_gettime(uint64 ts, int tz){
    // printf("kernelsp: %p\n",ts);
    struct TimeVal* nts;
    if(curr_pid < 1){
        nts = (struct TimeVal*) walkaddr(curr_proc()->pagetable, ts);
        // printf("ts addr %p %p\n",&(nts->sec),&(nts->usec));
        // printf("get addr %p %p\n",walkaddr(curr_proc()->pagetable, ts),walkaddr(curr_proc()->pagetable,ts+8));
    }
    else{
        nts = (struct TimeVal*) useraddr(curr_proc()->pagetable, ts);
        // printf("ts addr %p %p\n",&(nts->sec),&(nts->usec));
        // printf("get addr %p %p\n",useraddr(curr_proc()->pagetable, ts),useraddr(curr_proc()->pagetable,ts+8));
    }
    gettime(nts, tz);
    // printf("gettime fin.\n");
    // printf("get data %d\n",*((uint64*)walkaddr(curr_proc()->pagetable,ts+8)));
    return 0;
}

uint64 sys_set_priority(long long prio){
    if(prio>=2){
        if(setpriority(prio))
            return prio;
        else return -1;
    }
    // printf("%s\n","wrong prio");
    return -1;
}

uint64 sys_mmap(uint64 start, uint64 len, int port){
    if((port>>3)!=0||port==0) return -1;
    printf("check %p %p\n",start,len);
    if(start%0x1000!=0) return -1;
    port = (port << 1) | (1ul<<4);
    if(len % 0x1000 != 0)
        len = len / 0x1000 * 0x1000 + 0x1000;
    for(int i=0;i<len / 0x1000;i++){
        if(mappages(curr_proc()->pagetable,start+i*0x1000,0x1000,(uint64) kalloc(),port)){
            return -1;
        }
    }
    // printf("%s\n","ok");
    printf("check %p\n",walkaddr(curr_proc()->pagetable,start));
    return len;
}

uint64 sys_munmap(uint64 start, uint64 len){
    printf("check unmap!! %p %p\n",start,len);
    if(start % 0x1000 != 0) return -1;
    if(len % 0x1000 != 0) return -1;
    uvmunmap(curr_proc()->pagetable, start, len / 4096, 0);
    return len;
}


uint64 sys_fstat(int fd, uint64 stat_va){
    if(fd == 0 || fd == 1)
        return -1;
    struct proc* p = curr_proc();
    if(p->files[fd] == 0)
        return -1;
    struct Stat* st = (struct Stat*) useraddr(curr_proc()->pagetable, stat_va);
    st -> mode = 0x100000;
    struct inode *dp;
    struct dirent de;
    dp = root_dir();
    uint off;
    uint inum = p->files[fd]->ip->inum;
    uint count = 0;
    for (off = 0; off < dp->size; off += sizeof(de)) {
        if (readi(dp, 0, (uint64) &de, off, sizeof(de)) != sizeof(de))
            panic("dirlookup read");
        if (de.inum == 0)
            continue;
        if (de.inum == inum) {
            count ++;
        }
    }
    printf("count is: %d\n",count);
    st -> nlink = count;
    if(p->files[fd]->type == FD_INODE)
        st -> ino = p->files[fd]->ip->inum;
    return 0;
}

uint64 sys_unlinkat(int dirfd, uint64 path_va, unsigned int flags){
    struct proc *p = curr_proc();
    char path[200];
    copyinstr(p->pagetable, path, path_va, 200);
    struct inode *ip, *dp;
    dp = root_dir();
    ivalid(dp);
    if ((ip = dirlookup(dp, path, 0)) == 0) {
        warn("file not exist!\n");
        return -1;
    }  
    iput(ip);
    uint off;
    struct dirent de;
    for (off = 0; off < dp->size; off += sizeof(de)) {
        if (readi(dp, 0, (uint64) &de, off, sizeof(de)) != sizeof(de))
            panic("dirlookup read");
        if (de.inum == 0)
            continue;
        if (strncmp(path, de.name, DIRSIZ) == 0) {
            de.inum = 0; // unlink.
            if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
                warn("unlink failed!");
        }
    }
    return 0;
}

uint64 sys_linkat(int olddirfd, uint64 oldpath_va, int newdirfd, uint64 newpath_va, unsigned int flags){
    struct proc *p = curr_proc();
    char old_path[200];
    char new_path[200];
    copyinstr(p->pagetable, old_path, oldpath_va, 200);
    copyinstr(p->pagetable, new_path, newpath_va, 200);
    struct inode *ip, *dp;
    dp = root_dir();
    ivalid(dp);
    printf("old_path:%s\n",old_path);
    printf("new path:%s\n",new_path);  
    if ((ip = dirlookup(dp, old_path, 0)) == 0) {
        warn("file not exist!\n");
        return -1;
    } 
    ivalid(ip);
    iupdate(ip);
    if(dirlink(dp, new_path, ip->inum) < 0)
        panic("create: dirlink");
    // ip->nlink += 1;
    iput(dp);
    iput(ip);
    return 0;
}


void syscall() {
    struct proc *p = curr_proc();
    struct trapframe *trapframe = p->trapframe;
    int id = trapframe->a7, ret;
    uint64 args[7] = {trapframe->a0, trapframe->a1, trapframe->a2, trapframe->a3, trapframe->a4, trapframe->a5, trapframe->a6};
    trace("syscall %d args:%p %p %p %p %p %p %p\n", id, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
    switch (id) {
        case SYS_write:
            ret = sys_write(args[0], args[1], args[2]);
            break;
        case SYS_read:
            ret = sys_read(args[0], args[1], args[2]);
            break;
        case SYS_openat:
            ret = sys_openat(args[0], args[1], args[2]);
            break;
        case SYS_close:
            ret = sys_close(args[0]);
            break;
        case SYS_exit:
            ret = sys_exit(args[0]);
            break;
        case SYS_sched_yield:
            ret = sys_sched_yield();
            break;
        case SYS_getpid:
            ret = sys_getpid();
            break;
        case SYS_clone:// SYS_fork
            ret = sys_clone();
            break;
        case SYS_execve:
            ret = sys_exec(args[0]);
            break;
        case SYS_wait4:
            ret = sys_wait(args[0], args[1]);
            break;
        case SYS_times:
            ret = sys_times();
            break;
        case SYS_pipe2:
            ret = sys_pipe(args[0]);
            break;
        case SYS_spawn:
            ret = sys_spawn(args[0]);
            break;
        case SYS_mailread:
            ret = sys_mailread(args[0],args[1]);
            // printf("mailread syscall ret %d\n", ret);
            break;
        case SYS_mailwrite:
            ret = sys_mailwrite(args[0],args[1],args[2]);
            // printf("mailwrite syscall ret %d\n", ret);
            break;
        case SYS_gettimeofday:
            ret = sys_gettime(args[0], args[1]);
            break;
        case SYS_mmap:
            ret = sys_mmap(args[0],args[1],args[2]);
            break;
        case SYS_munmap:
            ret = sys_munmap(args[0],args[1]);
            break;
        case SYS_setpriority:
            ret = sys_set_priority(args[0]);
            break;
        
        case SYS_unlinkat:
            ret = sys_unlinkat(args[0],args[1],args[2]);
            break;
        case SYS_linkat:
            ret = sys_linkat(args[0],args[1],args[2],args[3],args[4]);
            break;
        case SYS_fstat:
            ret = sys_fstat((int)args[0],args[1]);
            break;
        
        default:
            ret = -1;
            warn("unknown syscall %d\n", id);
    }
    trapframe->a0 = ret;
    trace("syscall ret %d\n", ret);
}