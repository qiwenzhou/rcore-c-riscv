
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch2_exit:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0180006f          	j	1a <__start_main>

0000000000000006 <main>:
const int MAGIC = 1234;

/// 正确输出： 不输出 FAIL，以 1234 退出

int main(void)
{
   6:	1141                	addi	sp,sp,-16
    exit(MAGIC);
   8:	4d200513          	li	a0,1234
{
   c:	e406                	sd	ra,8(sp)
    exit(MAGIC);
   e:	072000ef          	jal	ra,80 <exit>
    return 0;
}
  12:	60a2                	ld	ra,8(sp)
  14:	4501                	li	a0,0
  16:	0141                	addi	sp,sp,16
  18:	8082                	ret

000000000000001a <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  1a:	1141                	addi	sp,sp,-16
  1c:	e406                	sd	ra,8(sp)
    exit(main());
  1e:	fe9ff0ef          	jal	ra,6 <main>
  22:	05e000ef          	jal	ra,80 <exit>
    return 0;
}
  26:	60a2                	ld	ra,8(sp)
  28:	4501                	li	a0,0
  2a:	0141                	addi	sp,sp,16
  2c:	8082                	ret

000000000000002e <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
  2e:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
  32:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
  34:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
  38:	2501                	sext.w	a0,a0
  3a:	8082                	ret

000000000000003c <close>:
    register long a7 __asm__("a7") = n;
  3c:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
  40:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
  44:	2501                	sext.w	a0,a0
  46:	8082                	ret

0000000000000048 <read>:
    register long a7 __asm__("a7") = n;
  48:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
  4c:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
  50:	8082                	ret

0000000000000052 <write>:
    register long a7 __asm__("a7") = n;
  52:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
  56:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
  5a:	8082                	ret

000000000000005c <getpid>:
    register long a7 __asm__("a7") = n;
  5c:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
  60:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
  64:	2501                	sext.w	a0,a0
  66:	8082                	ret

0000000000000068 <sched_yield>:
    register long a7 __asm__("a7") = n;
  68:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
  6c:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
  70:	2501                	sext.w	a0,a0
  72:	8082                	ret

0000000000000074 <fork>:
    register long a7 __asm__("a7") = n;
  74:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
  78:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
  7c:	2501                	sext.w	a0,a0
  7e:	8082                	ret

0000000000000080 <exit>:
    register long a7 __asm__("a7") = n;
  80:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
  84:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
  88:	8082                	ret

000000000000008a <waitpid>:
    register long a7 __asm__("a7") = n;
  8a:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  8e:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
  92:	2501                	sext.w	a0,a0
  94:	8082                	ret

0000000000000096 <exec>:
    register long a7 __asm__("a7") = n;
  96:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
  9a:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
  9e:	2501                	sext.w	a0,a0
  a0:	8082                	ret

00000000000000a2 <get_time>:

int64 get_time()
{
  a2:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
  a4:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
  a8:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
  aa:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  ac:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
  b0:	2501                	sext.w	a0,a0
  b2:	ed09                	bnez	a0,cc <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
  b4:	67a2                	ld	a5,8(sp)
  b6:	3e800713          	li	a4,1000
  ba:	00015503          	lhu	a0,0(sp)
  be:	02e7d7b3          	divu	a5,a5,a4
  c2:	02e50533          	mul	a0,a0,a4
  c6:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret
        return -1;
  cc:	557d                	li	a0,-1
  ce:	bfed                	j	c8 <get_time+0x26>

00000000000000d0 <sys_get_time>:
    register long a7 __asm__("a7") = n;
  d0:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  d4:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
  d8:	2501                	sext.w	a0,a0
  da:	8082                	ret

00000000000000dc <sleep>:

int sleep(unsigned long long time)
{
  dc:	1141                	addi	sp,sp,-16
  de:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
  e0:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
  e4:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
  e6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  e8:	00000073          	ecall
    if (err == 0)
  ec:	2501                	sext.w	a0,a0
  ee:	e13d                	bnez	a0,154 <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
  f0:	6722                	ld	a4,8(sp)
  f2:	3e800693          	li	a3,1000
  f6:	00015783          	lhu	a5,0(sp)
  fa:	02d75733          	divu	a4,a4,a3
  fe:	02d787b3          	mul	a5,a5,a3
 102:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 104:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 108:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 10a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 10c:	00000073          	ecall
    if (err == 0)
 110:	2501                	sext.w	a0,a0
 112:	ed15                	bnez	a0,14e <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 114:	6841                	lui	a6,0x10
 116:	963e                	add	a2,a2,a5
 118:	187d                	addi	a6,a6,-1
 11a:	3e800693          	li	a3,1000
 11e:	a819                	j	134 <sleep+0x58>
    __asm_syscall("r"(a7))
 120:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 124:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 128:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 12a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 12c:	00000073          	ecall
    if (err == 0)
 130:	2501                	sext.w	a0,a0
 132:	ed11                	bnez	a0,14e <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 134:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 136:	07c00893          	li	a7,124
 13a:	02d7d733          	divu	a4,a5,a3
 13e:	6782                	ld	a5,0(sp)
 140:	0107f7b3          	and	a5,a5,a6
 144:	02d787b3          	mul	a5,a5,a3
 148:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 14a:	fcc7ebe3          	bltu	a5,a2,120 <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 14e:	4501                	li	a0,0
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret
 154:	57fd                	li	a5,-1
 156:	b77d                	j	104 <sleep+0x28>

0000000000000158 <set_priority>:
    register long a7 __asm__("a7") = n;
 158:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 15c:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 160:	2501                	sext.w	a0,a0
 162:	8082                	ret

0000000000000164 <mmap>:
    register long a7 __asm__("a7") = n;
 164:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 168:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 16c:	2501                	sext.w	a0,a0
 16e:	8082                	ret

0000000000000170 <munmap>:
    register long a7 __asm__("a7") = n;
 170:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 174:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 178:	2501                	sext.w	a0,a0
 17a:	8082                	ret

000000000000017c <wait>:

int wait(int *code)
{
 17c:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 17e:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 182:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 184:	00000073          	ecall
    return waitpid(-1, code);
}
 188:	2501                	sext.w	a0,a0
 18a:	8082                	ret

000000000000018c <spawn>:
    register long a7 __asm__("a7") = n;
 18c:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 190:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 194:	2501                	sext.w	a0,a0
 196:	8082                	ret

0000000000000198 <mailread>:
    register long a7 __asm__("a7") = n;
 198:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 19c:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 1a0:	2501                	sext.w	a0,a0
 1a2:	8082                	ret

00000000000001a4 <mailwrite>:
    register long a7 __asm__("a7") = n;
 1a4:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 1a8:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 1ac:	2501                	sext.w	a0,a0
 1ae:	8082                	ret

00000000000001b0 <fstat>:
    register long a7 __asm__("a7") = n;
 1b0:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 1b4:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 1b8:	2501                	sext.w	a0,a0
 1ba:	8082                	ret

00000000000001bc <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 1bc:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 1be:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 1c2:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 1c4:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 1c8:	2501                	sext.w	a0,a0
 1ca:	8082                	ret

00000000000001cc <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 1cc:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 1ce:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 1d2:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 1d4:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 1d8:	2501                	sext.w	a0,a0
 1da:	8082                	ret

00000000000001dc <link>:

int link(char *old_path, char *new_path)
{
 1dc:	87aa                	mv	a5,a0
 1de:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 1e0:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 1e4:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 1e8:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 1ea:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 1ee:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 1f0:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 1f4:	2501                	sext.w	a0,a0
 1f6:	8082                	ret

00000000000001f8 <unlink>:

int unlink(char *path)
{
 1f8:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 1fa:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 1fe:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 202:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 204:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 208:	2501                	sext.w	a0,a0
 20a:	8082                	ret
