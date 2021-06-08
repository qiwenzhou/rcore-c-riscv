
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3t_deadloop:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0060006f          	j	8 <__start_main>

0000000000000006 <main>:
理想结果：执行一段时间之后被正确杀死，不会陷入死循环。
*/

int main()
{
    for (;;)
   6:	a001                	j	6 <main>

0000000000000008 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
   8:	1141                	addi	sp,sp,-16
   a:	e406                	sd	ra,8(sp)
    exit(main());
   c:	ffbff0ef          	jal	ra,6 <main>
  10:	05e000ef          	jal	ra,6e <exit>
    return 0;
}
  14:	60a2                	ld	ra,8(sp)
  16:	4501                	li	a0,0
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret

000000000000001c <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
  1c:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
  20:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
  22:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
  26:	2501                	sext.w	a0,a0
  28:	8082                	ret

000000000000002a <close>:
    register long a7 __asm__("a7") = n;
  2a:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
  2e:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
  32:	2501                	sext.w	a0,a0
  34:	8082                	ret

0000000000000036 <read>:
    register long a7 __asm__("a7") = n;
  36:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
  3a:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
  3e:	8082                	ret

0000000000000040 <write>:
    register long a7 __asm__("a7") = n;
  40:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
  44:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
  48:	8082                	ret

000000000000004a <getpid>:
    register long a7 __asm__("a7") = n;
  4a:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
  4e:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
  52:	2501                	sext.w	a0,a0
  54:	8082                	ret

0000000000000056 <sched_yield>:
    register long a7 __asm__("a7") = n;
  56:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
  5a:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
  5e:	2501                	sext.w	a0,a0
  60:	8082                	ret

0000000000000062 <fork>:
    register long a7 __asm__("a7") = n;
  62:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
  66:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
  6a:	2501                	sext.w	a0,a0
  6c:	8082                	ret

000000000000006e <exit>:
    register long a7 __asm__("a7") = n;
  6e:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
  72:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
  76:	8082                	ret

0000000000000078 <waitpid>:
    register long a7 __asm__("a7") = n;
  78:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  7c:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
  80:	2501                	sext.w	a0,a0
  82:	8082                	ret

0000000000000084 <exec>:
    register long a7 __asm__("a7") = n;
  84:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
  88:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
  8c:	2501                	sext.w	a0,a0
  8e:	8082                	ret

0000000000000090 <get_time>:

int64 get_time()
{
  90:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
  92:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
  96:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
  98:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  9a:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
  9e:	2501                	sext.w	a0,a0
  a0:	ed09                	bnez	a0,ba <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
  a2:	67a2                	ld	a5,8(sp)
  a4:	3e800713          	li	a4,1000
  a8:	00015503          	lhu	a0,0(sp)
  ac:	02e7d7b3          	divu	a5,a5,a4
  b0:	02e50533          	mul	a0,a0,a4
  b4:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
  b6:	0141                	addi	sp,sp,16
  b8:	8082                	ret
        return -1;
  ba:	557d                	li	a0,-1
  bc:	bfed                	j	b6 <get_time+0x26>

00000000000000be <sys_get_time>:
    register long a7 __asm__("a7") = n;
  be:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  c2:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
  c6:	2501                	sext.w	a0,a0
  c8:	8082                	ret

00000000000000ca <sleep>:

int sleep(unsigned long long time)
{
  ca:	1141                	addi	sp,sp,-16
  cc:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
  ce:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
  d2:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
  d4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  d6:	00000073          	ecall
    if (err == 0)
  da:	2501                	sext.w	a0,a0
  dc:	e13d                	bnez	a0,142 <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
  de:	6722                	ld	a4,8(sp)
  e0:	3e800693          	li	a3,1000
  e4:	00015783          	lhu	a5,0(sp)
  e8:	02d75733          	divu	a4,a4,a3
  ec:	02d787b3          	mul	a5,a5,a3
  f0:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
  f2:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
  f6:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
  f8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
  fa:	00000073          	ecall
    if (err == 0)
  fe:	2501                	sext.w	a0,a0
 100:	ed15                	bnez	a0,13c <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 102:	6841                	lui	a6,0x10
 104:	963e                	add	a2,a2,a5
 106:	187d                	addi	a6,a6,-1
 108:	3e800693          	li	a3,1000
 10c:	a819                	j	122 <sleep+0x58>
    __asm_syscall("r"(a7))
 10e:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 112:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 116:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 118:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 11a:	00000073          	ecall
    if (err == 0)
 11e:	2501                	sext.w	a0,a0
 120:	ed11                	bnez	a0,13c <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 122:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 124:	07c00893          	li	a7,124
 128:	02d7d733          	divu	a4,a5,a3
 12c:	6782                	ld	a5,0(sp)
 12e:	0107f7b3          	and	a5,a5,a6
 132:	02d787b3          	mul	a5,a5,a3
 136:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 138:	fcc7ebe3          	bltu	a5,a2,10e <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 13c:	4501                	li	a0,0
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret
 142:	57fd                	li	a5,-1
 144:	b77d                	j	f2 <sleep+0x28>

0000000000000146 <set_priority>:
    register long a7 __asm__("a7") = n;
 146:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 14a:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 14e:	2501                	sext.w	a0,a0
 150:	8082                	ret

0000000000000152 <mmap>:
    register long a7 __asm__("a7") = n;
 152:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 156:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 15a:	2501                	sext.w	a0,a0
 15c:	8082                	ret

000000000000015e <munmap>:
    register long a7 __asm__("a7") = n;
 15e:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 162:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 166:	2501                	sext.w	a0,a0
 168:	8082                	ret

000000000000016a <wait>:

int wait(int *code)
{
 16a:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 16c:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 170:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 172:	00000073          	ecall
    return waitpid(-1, code);
}
 176:	2501                	sext.w	a0,a0
 178:	8082                	ret

000000000000017a <spawn>:
    register long a7 __asm__("a7") = n;
 17a:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 17e:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 182:	2501                	sext.w	a0,a0
 184:	8082                	ret

0000000000000186 <mailread>:
    register long a7 __asm__("a7") = n;
 186:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 18a:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 18e:	2501                	sext.w	a0,a0
 190:	8082                	ret

0000000000000192 <mailwrite>:
    register long a7 __asm__("a7") = n;
 192:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 196:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 19a:	2501                	sext.w	a0,a0
 19c:	8082                	ret

000000000000019e <fstat>:
    register long a7 __asm__("a7") = n;
 19e:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 1a2:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 1a6:	2501                	sext.w	a0,a0
 1a8:	8082                	ret

00000000000001aa <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 1aa:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 1ac:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 1b0:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 1b2:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 1b6:	2501                	sext.w	a0,a0
 1b8:	8082                	ret

00000000000001ba <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 1ba:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 1bc:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 1c0:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 1c2:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 1c6:	2501                	sext.w	a0,a0
 1c8:	8082                	ret

00000000000001ca <link>:

int link(char *old_path, char *new_path)
{
 1ca:	87aa                	mv	a5,a0
 1cc:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 1ce:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 1d2:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 1d6:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 1d8:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 1dc:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 1de:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 1e2:	2501                	sext.w	a0,a0
 1e4:	8082                	ret

00000000000001e6 <unlink>:

int unlink(char *path)
{
 1e6:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 1e8:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 1ec:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 1f0:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 1f2:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 1f6:	2501                	sext.w	a0,a0
 1f8:	8082                	ret
