
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch2t_write0:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0860006f          	j	88 <__start_main>

0000000000000006 <r_sp>:
const int STACK_SIZE = 0x1000;

uint64 r_sp()
{
    uint64 sp;
    __asm__ __volatile__("mv %0, sp"
   6:	850a                	mv	a0,sp
                         : "=r"(sp)::);
    return sp;
}
   8:	8082                	ret

000000000000000a <stack_top>:
    __asm__ __volatile__("mv %0, sp"
   a:	878a                	mv	a5,sp
// 注意，这里要求 user_stack 大小为 4096 且按照 4096 字节对齐。
// 请调整你内核中的用户栈的设定。
uint64 stack_top()
{
    uint64 sp = r_sp();
    uint64 top = (sp + STACK_SIZE - 1) & (~(STACK_SIZE - 1));
   c:	6505                	lui	a0,0x1
   e:	157d                	addi	a0,a0,-1
  10:	97aa                	add	a5,a5,a0
  12:	757d                	lui	a0,0xfffff
    return top;
}
  14:	8d7d                	and	a0,a0,a5
  16:	8082                	ret

0000000000000018 <main>:

/// 正确输出：
/// Test write0 OK!

int main()
{
  18:	1141                	addi	sp,sp,-16
    assert(write(stdout, (const void *)0, 10) == -1);
  1a:	4629                	li	a2,10
  1c:	4581                	li	a1,0
  1e:	4505                	li	a0,1
{
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
    assert(write(stdout, (const void *)0, 10) == -1);
  24:	5cb000ef          	jal	ra,dee <write>
  28:	57fd                	li	a5,-1
  2a:	00f50563          	beq	a0,a5,34 <main+0x1c>
  2e:	557d                	li	a0,-1
  30:	5ed000ef          	jal	ra,e1c <exit>
    __asm__ __volatile__("mv %0, sp"
  34:	840a                	mv	s0,sp
    uint64 top = (sp + STACK_SIZE - 1) & (~(STACK_SIZE - 1));
  36:	6785                	lui	a5,0x1
  38:	17fd                	addi	a5,a5,-1
  3a:	943e                	add	s0,s0,a5
  3c:	77fd                	lui	a5,0xfffff
  3e:	8c7d                	and	s0,s0,a5
    uint64 top = stack_top(), bottom = top - STACK_SIZE;
    assert(write(stdout, (const void *)(top - 5), 10) == -1);
  40:	4629                	li	a2,10
  42:	ffb40593          	addi	a1,s0,-5
  46:	4505                	li	a0,1
  48:	5a7000ef          	jal	ra,dee <write>
  4c:	57fd                	li	a5,-1
  4e:	00f50563          	beq	a0,a5,58 <main+0x40>
  52:	557d                	li	a0,-1
  54:	5c9000ef          	jal	ra,e1c <exit>
    assert(write(stdout, (const void *)(bottom - 5), 10) == -1);
  58:	75fd                	lui	a1,0xfffff
  5a:	15ed                	addi	a1,a1,-5
  5c:	4629                	li	a2,10
  5e:	95a2                	add	a1,a1,s0
  60:	4505                	li	a0,1
  62:	58d000ef          	jal	ra,dee <write>
  66:	57fd                	li	a5,-1
  68:	00f50563          	beq	a0,a5,72 <main+0x5a>
  6c:	557d                	li	a0,-1
  6e:	5af000ef          	jal	ra,e1c <exit>
    puts("Test write0 OK!");
  72:	00001517          	auipc	a0,0x1
  76:	f3650513          	addi	a0,a0,-202 # fa8 <unlink+0x14>
  7a:	05e000ef          	jal	ra,d8 <puts>
    return 0;
}
  7e:	60a2                	ld	ra,8(sp)
  80:	6402                	ld	s0,0(sp)
  82:	4501                	li	a0,0
  84:	0141                	addi	sp,sp,16
  86:	8082                	ret

0000000000000088 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  88:	1141                	addi	sp,sp,-16
  8a:	e406                	sd	ra,8(sp)
    exit(main());
  8c:	f8dff0ef          	jal	ra,18 <main>
  90:	58d000ef          	jal	ra,e1c <exit>
    return 0;
}
  94:	60a2                	ld	ra,8(sp)
  96:	4501                	li	a0,0
  98:	0141                	addi	sp,sp,16
  9a:	8082                	ret

000000000000009c <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  9c:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  9e:	00f10593          	addi	a1,sp,15
  a2:	4605                	li	a2,1
  a4:	4501                	li	a0,0
{
  a6:	ec06                	sd	ra,24(sp)
    char byte = 0;
  a8:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  ac:	539000ef          	jal	ra,de4 <read>
    return byte;
}
  b0:	60e2                	ld	ra,24(sp)
  b2:	00f14503          	lbu	a0,15(sp)
  b6:	6105                	addi	sp,sp,32
  b8:	8082                	ret

00000000000000ba <putchar>:

int putchar(int c)
{
  ba:	1101                	addi	sp,sp,-32
  bc:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  be:	00f10593          	addi	a1,sp,15
  c2:	4605                	li	a2,1
  c4:	4505                	li	a0,1
{
  c6:	ec06                	sd	ra,24(sp)
    char byte = c;
  c8:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  cc:	523000ef          	jal	ra,dee <write>
}
  d0:	60e2                	ld	ra,24(sp)
  d2:	2501                	sext.w	a0,a0
  d4:	6105                	addi	sp,sp,32
  d6:	8082                	ret

00000000000000d8 <puts>:

int puts(const char *s)
{
  d8:	1101                	addi	sp,sp,-32
  da:	e822                	sd	s0,16(sp)
  dc:	ec06                	sd	ra,24(sp)
  de:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
  e0:	145000ef          	jal	ra,a24 <strlen>
  e4:	862a                	mv	a2,a0
  e6:	85a2                	mv	a1,s0
  e8:	4505                	li	a0,1
  ea:	505000ef          	jal	ra,dee <write>
  ee:	00055763          	bgez	a0,fc <puts+0x24>
    return r;
}
  f2:	60e2                	ld	ra,24(sp)
  f4:	6442                	ld	s0,16(sp)
  f6:	557d                	li	a0,-1
  f8:	6105                	addi	sp,sp,32
  fa:	8082                	ret
    return write(stdout, &byte, 1);
  fc:	00f10593          	addi	a1,sp,15
    char byte = c;
 100:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
 102:	4605                	li	a2,1
 104:	4505                	li	a0,1
    char byte = c;
 106:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
 10a:	4e5000ef          	jal	ra,dee <write>
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	41f5551b          	sraiw	a0,a0,0x1f
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
 11a:	7131                	addi	sp,sp,-192
 11c:	ecce                	sd	s3,88(sp)
 11e:	e8d2                	sd	s4,80(sp)
 120:	e4d6                	sd	s5,72(sp)
 122:	e0da                	sd	s6,64(sp)
 124:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
 126:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
 128:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
 12a:	6ae1                	lui	s5,0x18
 12c:	000f4a37          	lui	s4,0xf4
 130:	00989b37          	lui	s6,0x989
{
 134:	fc86                	sd	ra,120(sp)
 136:	f8a2                	sd	s0,112(sp)
 138:	f4a6                	sd	s1,104(sp)
 13a:	f0ca                	sd	s2,96(sp)
 13c:	fc5e                	sd	s7,56(sp)
 13e:	e52e                	sd	a1,136(sp)
 140:	e932                	sd	a2,144(sp)
 142:	ed36                	sd	a3,152(sp)
 144:	f13a                	sd	a4,160(sp)
 146:	f942                	sd	a6,176(sp)
 148:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
 14a:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
 14c:	70f98993          	addi	s3,s3,1807 # 270f <digits+0x172f>
 150:	69fa8a93          	addi	s5,s5,1695 # 1869f <digits+0x176bf>
 154:	23fa0a13          	addi	s4,s4,575 # f423f <digits+0xf325f>
 158:	67fb0b13          	addi	s6,s6,1663 # 98967f <digits+0x98869f>
    for (;;)
    {
        if (!*s)
 15c:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
 160:	02500913          	li	s2,37
        if (!*s)
 164:	1a078f63          	beqz	a5,322 <printf+0x208>
 168:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 16a:	17278e63          	beq	a5,s2,2e6 <printf+0x1cc>
 16e:	00164783          	lbu	a5,1(a2)
 172:	0605                	addi	a2,a2,1
 174:	fbfd                	bnez	a5,16a <printf+0x50>
 176:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 178:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 17c:	85aa                	mv	a1,a0
 17e:	8622                	mv	a2,s0
 180:	4505                	li	a0,1
 182:	46d000ef          	jal	ra,dee <write>
        out(f, a, l);
        if (l)
 186:	18041963          	bnez	s0,318 <printf+0x1fe>
            continue;
        if (s[1] == 0)
 18a:	0014c783          	lbu	a5,1(s1)
 18e:	18078a63          	beqz	a5,322 <printf+0x208>
            break;
        switch (s[1])
 192:	07300713          	li	a4,115
 196:	28e78e63          	beq	a5,a4,432 <printf+0x318>
 19a:	18f76f63          	bltu	a4,a5,338 <printf+0x21e>
 19e:	06400713          	li	a4,100
 1a2:	2ae78c63          	beq	a5,a4,45a <printf+0x340>
 1a6:	07000713          	li	a4,112
 1aa:	3ce79c63          	bne	a5,a4,582 <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 1ae:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1b0:	00001797          	auipc	a5,0x1
 1b4:	e3078793          	addi	a5,a5,-464 # fe0 <digits>
            printptr(va_arg(ap, uint64));
 1b8:	6298                	ld	a4,0(a3)
 1ba:	00868093          	addi	ra,a3,8
 1be:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 1c0:	00471293          	slli	t0,a4,0x4
 1c4:	00c71f13          	slli	t5,a4,0xc
 1c8:	01471e13          	slli	t3,a4,0x14
 1cc:	01c71893          	slli	a7,a4,0x1c
 1d0:	02471813          	slli	a6,a4,0x24
 1d4:	02871513          	slli	a0,a4,0x28
 1d8:	02c71593          	slli	a1,a4,0x2c
 1dc:	03071693          	slli	a3,a4,0x30
 1e0:	00871f93          	slli	t6,a4,0x8
 1e4:	01071e93          	slli	t4,a4,0x10
 1e8:	01871313          	slli	t1,a4,0x18
 1ec:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1f0:	03c2d293          	srli	t0,t0,0x3c
 1f4:	03cf5f13          	srli	t5,t5,0x3c
 1f8:	03ce5e13          	srli	t3,t3,0x3c
 1fc:	03c8d893          	srli	a7,a7,0x3c
 200:	03c85813          	srli	a6,a6,0x3c
 204:	9171                	srli	a0,a0,0x3c
 206:	91f1                	srli	a1,a1,0x3c
 208:	92f1                	srli	a3,a3,0x3c
 20a:	92be                	add	t0,t0,a5
 20c:	9f3e                	add	t5,t5,a5
 20e:	9e3e                	add	t3,t3,a5
 210:	98be                	add	a7,a7,a5
 212:	983e                	add	a6,a6,a5
 214:	953e                	add	a0,a0,a5
 216:	95be                	add	a1,a1,a5
 218:	96be                	add	a3,a3,a5
 21a:	03c75393          	srli	t2,a4,0x3c
 21e:	01c75b9b          	srliw	s7,a4,0x1c
 222:	03cfdf93          	srli	t6,t6,0x3c
 226:	03cede93          	srli	t4,t4,0x3c
 22a:	03c35313          	srli	t1,t1,0x3c
 22e:	9271                	srli	a2,a2,0x3c
 230:	0002c403          	lbu	s0,0(t0)
 234:	93be                	add	t2,t2,a5
 236:	000f4283          	lbu	t0,0(t5)
 23a:	9fbe                	add	t6,t6,a5
 23c:	000e4f03          	lbu	t5,0(t3)
 240:	9ebe                	add	t4,t4,a5
 242:	0008ce03          	lbu	t3,0(a7)
 246:	933e                	add	t1,t1,a5
 248:	00084883          	lbu	a7,0(a6)
 24c:	9bbe                	add	s7,s7,a5
 24e:	00054803          	lbu	a6,0(a0)
 252:	963e                	add	a2,a2,a5
 254:	0005c503          	lbu	a0,0(a1) # fffffffffffff000 <digits+0xffffffffffffe020>
 258:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 25c:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 260:	0003c903          	lbu	s2,0(t2)
 264:	00064603          	lbu	a2,0(a2)
 268:	000fc383          	lbu	t2,0(t6)
 26c:	8b3d                	andi	a4,a4,15
 26e:	000ecf83          	lbu	t6,0(t4)
 272:	92f1                	srli	a3,a3,0x3c
 274:	00034e83          	lbu	t4,0(t1)
 278:	000bc303          	lbu	t1,0(s7)
 27c:	96be                	add	a3,a3,a5
 27e:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 280:	7761                	lui	a4,0xffff8
 282:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 286:	00710623          	sb	t2,12(sp)
 28a:	005106a3          	sb	t0,13(sp)
 28e:	01f10723          	sb	t6,14(sp)
 292:	01e107a3          	sb	t5,15(sp)
 296:	01d10823          	sb	t4,16(sp)
 29a:	01c108a3          	sb	t3,17(sp)
 29e:	00610923          	sb	t1,18(sp)
 2a2:	011109a3          	sb	a7,19(sp)
 2a6:	01010a23          	sb	a6,20(sp)
 2aa:	00a10aa3          	sb	a0,21(sp)
 2ae:	00b10b23          	sb	a1,22(sp)
 2b2:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 2b6:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2ba:	01210523          	sb	s2,10(sp)
 2be:	008105a3          	sb	s0,11(sp)
 2c2:	0006c703          	lbu	a4,0(a3)
 2c6:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 2ca:	4649                	li	a2,18
 2cc:	002c                	addi	a1,sp,8
 2ce:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2d0:	00e10c23          	sb	a4,24(sp)
 2d4:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 2d8:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 2dc:	313000ef          	jal	ra,dee <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 2e0:	00248513          	addi	a0,s1,2
 2e4:	bda5                	j	15c <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 2e6:	00064783          	lbu	a5,0(a2)
 2ea:	84b2                	mv	s1,a2
 2ec:	01278963          	beq	a5,s2,2fe <printf+0x1e4>
 2f0:	b561                	j	178 <printf+0x5e>
 2f2:	0024c783          	lbu	a5,2(s1)
 2f6:	0605                	addi	a2,a2,1
 2f8:	0489                	addi	s1,s1,2
 2fa:	e7279fe3          	bne	a5,s2,178 <printf+0x5e>
 2fe:	0014c783          	lbu	a5,1(s1)
 302:	ff2788e3          	beq	a5,s2,2f2 <printf+0x1d8>
        l = z - a;
 306:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 30a:	85aa                	mv	a1,a0
 30c:	8622                	mv	a2,s0
 30e:	4505                	li	a0,1
 310:	2df000ef          	jal	ra,dee <write>
        if (l)
 314:	e6040be3          	beqz	s0,18a <printf+0x70>
 318:	8526                	mv	a0,s1
        if (!*s)
 31a:	00054783          	lbu	a5,0(a0)
 31e:	e40795e3          	bnez	a5,168 <printf+0x4e>
    }
    va_end(ap);
 322:	70e6                	ld	ra,120(sp)
 324:	7446                	ld	s0,112(sp)
 326:	74a6                	ld	s1,104(sp)
 328:	7906                	ld	s2,96(sp)
 32a:	69e6                	ld	s3,88(sp)
 32c:	6a46                	ld	s4,80(sp)
 32e:	6aa6                	ld	s5,72(sp)
 330:	6b06                	ld	s6,64(sp)
 332:	7be2                	ld	s7,56(sp)
 334:	6129                	addi	sp,sp,192
 336:	8082                	ret
        switch (s[1])
 338:	07800713          	li	a4,120
 33c:	24e79363          	bne	a5,a4,582 <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 340:	6782                	ld	a5,0(sp)
 342:	4394                	lw	a3,0(a5)
 344:	07a1                	addi	a5,a5,8
 346:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 348:	2606c263          	bltz	a3,5ac <printf+0x492>
        buf[i--] = digits[x % base];
 34c:	00001797          	auipc	a5,0x1
 350:	c9478793          	addi	a5,a5,-876 # fe0 <digits>
 354:	00f6f713          	andi	a4,a3,15
 358:	973e                	add	a4,a4,a5
 35a:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <digits+0xffffffffffff7020>
    buf[16] = 0;
 35e:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 362:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 364:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 368:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 36c:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 370:	0046d51b          	srliw	a0,a3,0x4
 374:	0ad5d563          	bge	a1,a3,41e <printf+0x304>
        buf[i--] = digits[x % base];
 378:	8a3d                	andi	a2,a2,15
 37a:	963e                	add	a2,a2,a5
 37c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 380:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 384:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 388:	30a5fe63          	bgeu	a1,a0,6a4 <printf+0x58a>
        buf[i--] = digits[x % base];
 38c:	00f77613          	andi	a2,a4,15
 390:	963e                	add	a2,a2,a5
 392:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 396:	45bd                	li	a1,15
 398:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 39c:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 3a0:	00475513          	srli	a0,a4,0x4
 3a4:	30e5f963          	bgeu	a1,a4,6b6 <printf+0x59c>
        buf[i--] = digits[x % base];
 3a8:	8a3d                	andi	a2,a2,15
 3aa:	963e                	add	a2,a2,a5
 3ac:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 3b0:	00875893          	srli	a7,a4,0x8
 3b4:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 3b8:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 3bc:	30a5fd63          	bgeu	a1,a0,6d6 <printf+0x5bc>
        buf[i--] = digits[x % base];
 3c0:	8a3d                	andi	a2,a2,15
 3c2:	963e                	add	a2,a2,a5
 3c4:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3c8:	00c75813          	srli	a6,a4,0xc
 3cc:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 3d0:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 3d4:	3315fe63          	bgeu	a1,a7,710 <printf+0x5f6>
        buf[i--] = digits[x % base];
 3d8:	8a3d                	andi	a2,a2,15
 3da:	963e                	add	a2,a2,a5
 3dc:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3e0:	01075893          	srli	a7,a4,0x10
 3e4:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 3e8:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 3ec:	3305ff63          	bgeu	a1,a6,72a <printf+0x610>
        buf[i--] = digits[x % base];
 3f0:	8a3d                	andi	a2,a2,15
 3f2:	963e                	add	a2,a2,a5
 3f4:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 3f8:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 3fc:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 400:	3515f863          	bgeu	a1,a7,750 <printf+0x636>
        buf[i--] = digits[x % base];
 404:	97ba                	add	a5,a5,a4
 406:	0007c783          	lbu	a5,0(a5)
 40a:	45a1                	li	a1,8
 40c:	00f10823          	sb	a5,16(sp)
    if (sign)
 410:	0006d763          	bgez	a3,41e <printf+0x304>
        buf[i--] = '-';
 414:	02d00793          	li	a5,45
 418:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 41c:	459d                	li	a1,7
    write(f, s, l);
 41e:	4641                	li	a2,16
 420:	003c                	addi	a5,sp,8
 422:	9e0d                	subw	a2,a2,a1
 424:	4505                	li	a0,1
 426:	95be                	add	a1,a1,a5
 428:	1c7000ef          	jal	ra,dee <write>
        s += 2;
 42c:	00248513          	addi	a0,s1,2
 430:	b335                	j	15c <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 432:	6782                	ld	a5,0(sp)
 434:	6380                	ld	s0,0(a5)
 436:	07a1                	addi	a5,a5,8
 438:	e03e                	sd	a5,0(sp)
 43a:	22040a63          	beqz	s0,66e <printf+0x554>
            l = strnlen(a, 200);
 43e:	0c800593          	li	a1,200
 442:	8522                	mv	a0,s0
 444:	6cc000ef          	jal	ra,b10 <strnlen>
    write(f, s, l);
 448:	0005061b          	sext.w	a2,a0
 44c:	85a2                	mv	a1,s0
 44e:	4505                	li	a0,1
 450:	19f000ef          	jal	ra,dee <write>
        s += 2;
 454:	00248513          	addi	a0,s1,2
 458:	b311                	j	15c <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 45a:	6782                	ld	a5,0(sp)
 45c:	4390                	lw	a2,0(a5)
 45e:	07a1                	addi	a5,a5,8
 460:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 462:	1a064363          	bltz	a2,608 <printf+0x4ee>
        buf[i--] = digits[x % base];
 466:	46a9                	li	a3,10
 468:	02d6773b          	remuw	a4,a2,a3
 46c:	00001797          	auipc	a5,0x1
 470:	b7478793          	addi	a5,a5,-1164 # fe0 <digits>
    buf[16] = 0;
 474:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 478:	4525                	li	a0,9
        x = xx;
 47a:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 47e:	973e                	add	a4,a4,a5
 480:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 484:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 488:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 48c:	2cc55063          	bge	a0,a2,74c <printf+0x632>
 490:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 494:	02d5f73b          	remuw	a4,a1,a3
 498:	1702                	slli	a4,a4,0x20
 49a:	9301                	srli	a4,a4,0x20
 49c:	973e                	add	a4,a4,a5
 49e:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 4a2:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 4a6:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 4aa:	1f057d63          	bgeu	a0,a6,6a4 <printf+0x58a>
        buf[i--] = digits[x % base];
 4ae:	4529                	li	a0,10
    } while ((x /= base) != 0);
 4b0:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 4b2:	02a5f73b          	remuw	a4,a1,a0
 4b6:	973e                	add	a4,a4,a5
 4b8:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 4bc:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 4c0:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 4c4:	1ab6f163          	bgeu	a3,a1,666 <printf+0x54c>
 4c8:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 4cc:	02a776bb          	remuw	a3,a4,a0
 4d0:	96be                	add	a3,a3,a5
 4d2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4d6:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4da:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 4de:	20b87c63          	bgeu	a6,a1,6f6 <printf+0x5dc>
 4e2:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 4e6:	02a776bb          	remuw	a3,a4,a0
 4ea:	96be                	add	a3,a3,a5
 4ec:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4f0:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4f4:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 4f8:	20b87363          	bgeu	a6,a1,6fe <printf+0x5e4>
        buf[i--] = digits[x % base];
 4fc:	02a776bb          	remuw	a3,a4,a0
 500:	96be                	add	a3,a3,a5
 502:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 506:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 50a:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 50e:	20b9f563          	bgeu	s3,a1,718 <printf+0x5fe>
        buf[i--] = digits[x % base];
 512:	02a776bb          	remuw	a3,a4,a0
 516:	96be                	add	a3,a3,a5
 518:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 51c:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 520:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 524:	20bafb63          	bgeu	s5,a1,73a <printf+0x620>
        buf[i--] = digits[x % base];
 528:	02a776bb          	remuw	a3,a4,a0
 52c:	96be                	add	a3,a3,a5
 52e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 532:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 536:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 53a:	1eba7c63          	bgeu	s4,a1,732 <printf+0x618>
        buf[i--] = digits[x % base];
 53e:	02a776bb          	remuw	a3,a4,a0
 542:	96be                	add	a3,a3,a5
 544:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 548:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 54c:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 550:	14bb7163          	bgeu	s6,a1,692 <printf+0x578>
        buf[i--] = digits[x % base];
 554:	1702                	slli	a4,a4,0x20
 556:	9301                	srli	a4,a4,0x20
 558:	97ba                	add	a5,a5,a4
 55a:	0007c783          	lbu	a5,0(a5)
 55e:	4599                	li	a1,6
 560:	00f10723          	sb	a5,14(sp)
    if (sign)
 564:	ea065de3          	bgez	a2,41e <printf+0x304>
        buf[i--] = '-';
 568:	02d00793          	li	a5,45
 56c:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 570:	4595                	li	a1,5
    write(f, s, l);
 572:	003c                	addi	a5,sp,8
 574:	4641                	li	a2,16
 576:	9e0d                	subw	a2,a2,a1
 578:	4505                	li	a0,1
 57a:	95be                	add	a1,a1,a5
 57c:	073000ef          	jal	ra,dee <write>
 580:	b575                	j	42c <printf+0x312>
    char byte = c;
 582:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 586:	4605                	li	a2,1
 588:	002c                	addi	a1,sp,8
 58a:	4505                	li	a0,1
    char byte = c;
 58c:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 590:	05f000ef          	jal	ra,dee <write>
    char byte = c;
 594:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 598:	4605                	li	a2,1
 59a:	002c                	addi	a1,sp,8
 59c:	4505                	li	a0,1
    char byte = c;
 59e:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 5a2:	04d000ef          	jal	ra,dee <write>
        s += 2;
 5a6:	00248513          	addi	a0,s1,2
 5aa:	be4d                	j	15c <printf+0x42>
        x = -xx;
 5ac:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 5b0:	00001797          	auipc	a5,0x1
 5b4:	a3078793          	addi	a5,a5,-1488 # fe0 <digits>
 5b8:	00f77613          	andi	a2,a4,15
 5bc:	963e                	add	a2,a2,a5
 5be:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 5c2:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5c6:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 5c8:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 5cc:	0047551b          	srliw	a0,a4,0x4
 5d0:	0047561b          	srliw	a2,a4,0x4
 5d4:	0ab6d263          	bge	a3,a1,678 <printf+0x55e>
        buf[i--] = digits[x % base];
 5d8:	8a3d                	andi	a2,a2,15
 5da:	963e                	add	a2,a2,a5
 5dc:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 5e0:	463d                	li	a2,15
 5e2:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 5e6:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 5ea:	daa661e3          	bltu	a2,a0,38c <printf+0x272>
        buf[i--] = '-';
 5ee:	02d00793          	li	a5,45
 5f2:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 5f6:	45b5                	li	a1,13
    write(f, s, l);
 5f8:	003c                	addi	a5,sp,8
 5fa:	4641                	li	a2,16
 5fc:	9e0d                	subw	a2,a2,a1
 5fe:	4505                	li	a0,1
 600:	95be                	add	a1,a1,a5
 602:	7ec000ef          	jal	ra,dee <write>
 606:	b51d                	j	42c <printf+0x312>
        x = -xx;
 608:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 60c:	46a9                	li	a3,10
 60e:	02d875bb          	remuw	a1,a6,a3
 612:	00001797          	auipc	a5,0x1
 616:	9ce78793          	addi	a5,a5,-1586 # fe0 <digits>
    buf[16] = 0;
 61a:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 61e:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 620:	95be                	add	a1,a1,a5
 622:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 626:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 62a:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 62e:	04a65563          	bge	a2,a0,678 <printf+0x55e>
 632:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 636:	02d775bb          	remuw	a1,a4,a3
 63a:	95be                	add	a1,a1,a5
 63c:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 640:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 644:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 648:	fb0573e3          	bgeu	a0,a6,5ee <printf+0x4d4>
        buf[i--] = digits[x % base];
 64c:	4529                	li	a0,10
    } while ((x /= base) != 0);
 64e:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 650:	02a5f73b          	remuw	a4,a1,a0
 654:	973e                	add	a4,a4,a5
 656:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 65a:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 65e:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 662:	e6b6e3e3          	bltu	a3,a1,4c8 <printf+0x3ae>
        buf[i--] = digits[x % base];
 666:	45b5                	li	a1,13
    if (sign)
 668:	da065be3          	bgez	a2,41e <printf+0x304>
 66c:	a881                	j	6bc <printf+0x5a2>
                a = "(null)";
 66e:	00001417          	auipc	s0,0x1
 672:	94a40413          	addi	s0,s0,-1718 # fb8 <unlink+0x24>
 676:	b3e1                	j	43e <printf+0x324>
        buf[i--] = '-';
 678:	02d00793          	li	a5,45
 67c:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 680:	45b9                	li	a1,14
    write(f, s, l);
 682:	003c                	addi	a5,sp,8
 684:	4641                	li	a2,16
 686:	9e0d                	subw	a2,a2,a1
 688:	4505                	li	a0,1
 68a:	95be                	add	a1,a1,a5
 68c:	762000ef          	jal	ra,dee <write>
 690:	bb71                	j	42c <printf+0x312>
        buf[i--] = digits[x % base];
 692:	459d                	li	a1,7
    if (sign)
 694:	d80655e3          	bgez	a2,41e <printf+0x304>
        buf[i--] = '-';
 698:	02d00793          	li	a5,45
 69c:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 6a0:	4599                	li	a1,6
 6a2:	bbb5                	j	41e <printf+0x304>
 6a4:	45b9                	li	a1,14
    write(f, s, l);
 6a6:	003c                	addi	a5,sp,8
 6a8:	4641                	li	a2,16
 6aa:	9e0d                	subw	a2,a2,a1
 6ac:	4505                	li	a0,1
 6ae:	95be                	add	a1,a1,a5
 6b0:	73e000ef          	jal	ra,dee <write>
 6b4:	bba5                	j	42c <printf+0x312>
        buf[i--] = digits[x % base];
 6b6:	45b5                	li	a1,13
    if (sign)
 6b8:	d606d3e3          	bgez	a3,41e <printf+0x304>
        buf[i--] = '-';
 6bc:	02d00793          	li	a5,45
 6c0:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 6c4:	45b1                	li	a1,12
    write(f, s, l);
 6c6:	003c                	addi	a5,sp,8
 6c8:	4641                	li	a2,16
 6ca:	9e0d                	subw	a2,a2,a1
 6cc:	4505                	li	a0,1
 6ce:	95be                	add	a1,a1,a5
 6d0:	71e000ef          	jal	ra,dee <write>
 6d4:	bba1                	j	42c <printf+0x312>
        buf[i--] = digits[x % base];
 6d6:	45b1                	li	a1,12
    if (sign)
 6d8:	d406d3e3          	bgez	a3,41e <printf+0x304>
        buf[i--] = '-';
 6dc:	02d00793          	li	a5,45
 6e0:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 6e4:	45ad                	li	a1,11
    write(f, s, l);
 6e6:	003c                	addi	a5,sp,8
 6e8:	4641                	li	a2,16
 6ea:	9e0d                	subw	a2,a2,a1
 6ec:	4505                	li	a0,1
 6ee:	95be                	add	a1,a1,a5
 6f0:	6fe000ef          	jal	ra,dee <write>
 6f4:	bb25                	j	42c <printf+0x312>
        buf[i--] = digits[x % base];
 6f6:	45b1                	li	a1,12
    if (sign)
 6f8:	d20653e3          	bgez	a2,41e <printf+0x304>
 6fc:	b7c5                	j	6dc <printf+0x5c2>
        buf[i--] = digits[x % base];
 6fe:	45ad                	li	a1,11
    if (sign)
 700:	d0065fe3          	bgez	a2,41e <printf+0x304>
        buf[i--] = '-';
 704:	02d00793          	li	a5,45
 708:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 70c:	45a9                	li	a1,10
 70e:	bb01                	j	41e <printf+0x304>
 710:	45ad                	li	a1,11
    if (sign)
 712:	d006d6e3          	bgez	a3,41e <printf+0x304>
 716:	b7fd                	j	704 <printf+0x5ea>
        buf[i--] = digits[x % base];
 718:	45a9                	li	a1,10
    if (sign)
 71a:	d00652e3          	bgez	a2,41e <printf+0x304>
        buf[i--] = '-';
 71e:	02d00793          	li	a5,45
 722:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 726:	45a5                	li	a1,9
 728:	b9dd                	j	41e <printf+0x304>
 72a:	45a9                	li	a1,10
    if (sign)
 72c:	ce06d9e3          	bgez	a3,41e <printf+0x304>
 730:	b7fd                	j	71e <printf+0x604>
        buf[i--] = digits[x % base];
 732:	45a1                	li	a1,8
    if (sign)
 734:	ce0655e3          	bgez	a2,41e <printf+0x304>
 738:	b9f1                	j	414 <printf+0x2fa>
        buf[i--] = digits[x % base];
 73a:	45a5                	li	a1,9
    if (sign)
 73c:	ce0651e3          	bgez	a2,41e <printf+0x304>
        buf[i--] = '-';
 740:	02d00793          	li	a5,45
 744:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 748:	45a1                	li	a1,8
 74a:	b9d1                	j	41e <printf+0x304>
    i = 15;
 74c:	45bd                	li	a1,15
 74e:	b9c1                	j	41e <printf+0x304>
        buf[i--] = digits[x % base];
 750:	45a5                	li	a1,9
    if (sign)
 752:	cc06d6e3          	bgez	a3,41e <printf+0x304>
 756:	b7ed                	j	740 <printf+0x626>

0000000000000758 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 758:	02000793          	li	a5,32
 75c:	00f50663          	beq	a0,a5,768 <isspace+0x10>
 760:	355d                	addiw	a0,a0,-9
 762:	00553513          	sltiu	a0,a0,5
 766:	8082                	ret
 768:	4505                	li	a0,1
}
 76a:	8082                	ret

000000000000076c <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 76c:	fd05051b          	addiw	a0,a0,-48
}
 770:	00a53513          	sltiu	a0,a0,10
 774:	8082                	ret

0000000000000776 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 776:	02000613          	li	a2,32
 77a:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 77c:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 780:	ff77069b          	addiw	a3,a4,-9
 784:	04c70d63          	beq	a4,a2,7de <atoi+0x68>
 788:	0007079b          	sext.w	a5,a4
 78c:	04d5f963          	bgeu	a1,a3,7de <atoi+0x68>
        s++;
    switch (*s)
 790:	02b00693          	li	a3,43
 794:	04d70a63          	beq	a4,a3,7e8 <atoi+0x72>
 798:	02d00693          	li	a3,45
 79c:	06d70463          	beq	a4,a3,804 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 7a0:	fd07859b          	addiw	a1,a5,-48
 7a4:	4625                	li	a2,9
 7a6:	873e                	mv	a4,a5
 7a8:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 7aa:	4e01                	li	t3,0
    while (isdigit(*s))
 7ac:	04b66a63          	bltu	a2,a1,800 <atoi+0x8a>
    int n = 0, neg = 0;
 7b0:	4501                	li	a0,0
    while (isdigit(*s))
 7b2:	4825                	li	a6,9
 7b4:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 7b8:	0025179b          	slliw	a5,a0,0x2
 7bc:	9d3d                	addw	a0,a0,a5
 7be:	fd07031b          	addiw	t1,a4,-48
 7c2:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 7c6:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 7ca:	0685                	addi	a3,a3,1
 7cc:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 7d0:	0006071b          	sext.w	a4,a2
 7d4:	feb870e3          	bgeu	a6,a1,7b4 <atoi+0x3e>
    return neg ? n : -n;
 7d8:	000e0563          	beqz	t3,7e2 <atoi+0x6c>
}
 7dc:	8082                	ret
        s++;
 7de:	0505                	addi	a0,a0,1
 7e0:	bf71                	j	77c <atoi+0x6>
 7e2:	4113053b          	subw	a0,t1,a7
 7e6:	8082                	ret
    while (isdigit(*s))
 7e8:	00154783          	lbu	a5,1(a0)
 7ec:	4625                	li	a2,9
        s++;
 7ee:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7f2:	fd07859b          	addiw	a1,a5,-48
 7f6:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 7fa:	4e01                	li	t3,0
    while (isdigit(*s))
 7fc:	fab67ae3          	bgeu	a2,a1,7b0 <atoi+0x3a>
 800:	4501                	li	a0,0
}
 802:	8082                	ret
    while (isdigit(*s))
 804:	00154783          	lbu	a5,1(a0)
 808:	4625                	li	a2,9
        s++;
 80a:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 80e:	fd07859b          	addiw	a1,a5,-48
 812:	0007871b          	sext.w	a4,a5
 816:	feb665e3          	bltu	a2,a1,800 <atoi+0x8a>
        neg = 1;
 81a:	4e05                	li	t3,1
 81c:	bf51                	j	7b0 <atoi+0x3a>

000000000000081e <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 81e:	16060d63          	beqz	a2,998 <memset+0x17a>
 822:	40a007b3          	neg	a5,a0
 826:	8b9d                	andi	a5,a5,7
 828:	00778713          	addi	a4,a5,7
 82c:	482d                	li	a6,11
 82e:	0ff5f593          	andi	a1,a1,255
 832:	fff60693          	addi	a3,a2,-1
 836:	17076263          	bltu	a4,a6,99a <memset+0x17c>
 83a:	16e6ea63          	bltu	a3,a4,9ae <memset+0x190>
 83e:	16078563          	beqz	a5,9a8 <memset+0x18a>
 842:	00b50023          	sb	a1,0(a0)
 846:	4705                	li	a4,1
 848:	00150e93          	addi	t4,a0,1
 84c:	14e78c63          	beq	a5,a4,9a4 <memset+0x186>
 850:	00b500a3          	sb	a1,1(a0)
 854:	4709                	li	a4,2
 856:	00250e93          	addi	t4,a0,2
 85a:	14e78d63          	beq	a5,a4,9b4 <memset+0x196>
 85e:	00b50123          	sb	a1,2(a0)
 862:	470d                	li	a4,3
 864:	00350e93          	addi	t4,a0,3
 868:	12e78b63          	beq	a5,a4,99e <memset+0x180>
 86c:	00b501a3          	sb	a1,3(a0)
 870:	4711                	li	a4,4
 872:	00450e93          	addi	t4,a0,4
 876:	14e78163          	beq	a5,a4,9b8 <memset+0x19a>
 87a:	00b50223          	sb	a1,4(a0)
 87e:	4715                	li	a4,5
 880:	00550e93          	addi	t4,a0,5
 884:	12e78c63          	beq	a5,a4,9bc <memset+0x19e>
 888:	00b502a3          	sb	a1,5(a0)
 88c:	471d                	li	a4,7
 88e:	00650e93          	addi	t4,a0,6
 892:	12e79763          	bne	a5,a4,9c0 <memset+0x1a2>
 896:	00750e93          	addi	t4,a0,7
 89a:	00b50323          	sb	a1,6(a0)
 89e:	4f1d                	li	t5,7
 8a0:	00859713          	slli	a4,a1,0x8
 8a4:	8f4d                	or	a4,a4,a1
 8a6:	01059e13          	slli	t3,a1,0x10
 8aa:	01c76e33          	or	t3,a4,t3
 8ae:	01859313          	slli	t1,a1,0x18
 8b2:	006e6333          	or	t1,t3,t1
 8b6:	02059893          	slli	a7,a1,0x20
 8ba:	011368b3          	or	a7,t1,a7
 8be:	02859813          	slli	a6,a1,0x28
 8c2:	40f60333          	sub	t1,a2,a5
 8c6:	0108e833          	or	a6,a7,a6
 8ca:	03059693          	slli	a3,a1,0x30
 8ce:	00d866b3          	or	a3,a6,a3
 8d2:	03859713          	slli	a4,a1,0x38
 8d6:	97aa                	add	a5,a5,a0
 8d8:	ff837813          	andi	a6,t1,-8
 8dc:	8f55                	or	a4,a4,a3
 8de:	00f806b3          	add	a3,a6,a5
 8e2:	e398                	sd	a4,0(a5)
 8e4:	07a1                	addi	a5,a5,8
 8e6:	fed79ee3          	bne	a5,a3,8e2 <memset+0xc4>
 8ea:	ff837693          	andi	a3,t1,-8
 8ee:	00de87b3          	add	a5,t4,a3
 8f2:	01e6873b          	addw	a4,a3,t5
 8f6:	0ad30663          	beq	t1,a3,9a2 <memset+0x184>
 8fa:	00b78023          	sb	a1,0(a5)
 8fe:	0017069b          	addiw	a3,a4,1
 902:	08c6fb63          	bgeu	a3,a2,998 <memset+0x17a>
 906:	00b780a3          	sb	a1,1(a5)
 90a:	0027069b          	addiw	a3,a4,2
 90e:	08c6f563          	bgeu	a3,a2,998 <memset+0x17a>
 912:	00b78123          	sb	a1,2(a5)
 916:	0037069b          	addiw	a3,a4,3
 91a:	06c6ff63          	bgeu	a3,a2,998 <memset+0x17a>
 91e:	00b781a3          	sb	a1,3(a5)
 922:	0047069b          	addiw	a3,a4,4
 926:	06c6f963          	bgeu	a3,a2,998 <memset+0x17a>
 92a:	00b78223          	sb	a1,4(a5)
 92e:	0057069b          	addiw	a3,a4,5
 932:	06c6f363          	bgeu	a3,a2,998 <memset+0x17a>
 936:	00b782a3          	sb	a1,5(a5)
 93a:	0067069b          	addiw	a3,a4,6
 93e:	04c6fd63          	bgeu	a3,a2,998 <memset+0x17a>
 942:	00b78323          	sb	a1,6(a5)
 946:	0077069b          	addiw	a3,a4,7
 94a:	04c6f763          	bgeu	a3,a2,998 <memset+0x17a>
 94e:	00b783a3          	sb	a1,7(a5)
 952:	0087069b          	addiw	a3,a4,8
 956:	04c6f163          	bgeu	a3,a2,998 <memset+0x17a>
 95a:	00b78423          	sb	a1,8(a5)
 95e:	0097069b          	addiw	a3,a4,9
 962:	02c6fb63          	bgeu	a3,a2,998 <memset+0x17a>
 966:	00b784a3          	sb	a1,9(a5)
 96a:	00a7069b          	addiw	a3,a4,10
 96e:	02c6f563          	bgeu	a3,a2,998 <memset+0x17a>
 972:	00b78523          	sb	a1,10(a5)
 976:	00b7069b          	addiw	a3,a4,11
 97a:	00c6ff63          	bgeu	a3,a2,998 <memset+0x17a>
 97e:	00b785a3          	sb	a1,11(a5)
 982:	00c7069b          	addiw	a3,a4,12
 986:	00c6f963          	bgeu	a3,a2,998 <memset+0x17a>
 98a:	00b78623          	sb	a1,12(a5)
 98e:	2735                	addiw	a4,a4,13
 990:	00c77463          	bgeu	a4,a2,998 <memset+0x17a>
 994:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 998:	8082                	ret
 99a:	472d                	li	a4,11
 99c:	bd79                	j	83a <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 99e:	4f0d                	li	t5,3
 9a0:	b701                	j	8a0 <memset+0x82>
 9a2:	8082                	ret
 9a4:	4f05                	li	t5,1
 9a6:	bded                	j	8a0 <memset+0x82>
 9a8:	8eaa                	mv	t4,a0
 9aa:	4f01                	li	t5,0
 9ac:	bdd5                	j	8a0 <memset+0x82>
 9ae:	87aa                	mv	a5,a0
 9b0:	4701                	li	a4,0
 9b2:	b7a1                	j	8fa <memset+0xdc>
 9b4:	4f09                	li	t5,2
 9b6:	b5ed                	j	8a0 <memset+0x82>
 9b8:	4f11                	li	t5,4
 9ba:	b5dd                	j	8a0 <memset+0x82>
 9bc:	4f15                	li	t5,5
 9be:	b5cd                	j	8a0 <memset+0x82>
 9c0:	4f19                	li	t5,6
 9c2:	bdf9                	j	8a0 <memset+0x82>

00000000000009c4 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 9c4:	00054783          	lbu	a5,0(a0)
 9c8:	0005c703          	lbu	a4,0(a1)
 9cc:	00e79863          	bne	a5,a4,9dc <strcmp+0x18>
 9d0:	0505                	addi	a0,a0,1
 9d2:	0585                	addi	a1,a1,1
 9d4:	fbe5                	bnez	a5,9c4 <strcmp>
 9d6:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 9d8:	9d19                	subw	a0,a0,a4
 9da:	8082                	ret
 9dc:	0007851b          	sext.w	a0,a5
 9e0:	bfe5                	j	9d8 <strcmp+0x14>

00000000000009e2 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 9e2:	ce05                	beqz	a2,a1a <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9e4:	00054703          	lbu	a4,0(a0)
 9e8:	0005c783          	lbu	a5,0(a1)
 9ec:	cb0d                	beqz	a4,a1e <strncmp+0x3c>
    if (!n--)
 9ee:	167d                	addi	a2,a2,-1
 9f0:	00c506b3          	add	a3,a0,a2
 9f4:	a819                	j	a0a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9f6:	00a68e63          	beq	a3,a0,a12 <strncmp+0x30>
 9fa:	0505                	addi	a0,a0,1
 9fc:	00e79b63          	bne	a5,a4,a12 <strncmp+0x30>
 a00:	00054703          	lbu	a4,0(a0)
 a04:	0005c783          	lbu	a5,0(a1)
 a08:	cb19                	beqz	a4,a1e <strncmp+0x3c>
 a0a:	0005c783          	lbu	a5,0(a1)
 a0e:	0585                	addi	a1,a1,1
 a10:	f3fd                	bnez	a5,9f6 <strncmp+0x14>
        ;
    return *l - *r;
 a12:	0007051b          	sext.w	a0,a4
 a16:	9d1d                	subw	a0,a0,a5
 a18:	8082                	ret
        return 0;
 a1a:	4501                	li	a0,0
}
 a1c:	8082                	ret
 a1e:	4501                	li	a0,0
    return *l - *r;
 a20:	9d1d                	subw	a0,a0,a5
 a22:	8082                	ret

0000000000000a24 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 a24:	00757793          	andi	a5,a0,7
 a28:	cf89                	beqz	a5,a42 <strlen+0x1e>
 a2a:	87aa                	mv	a5,a0
 a2c:	a029                	j	a36 <strlen+0x12>
 a2e:	0785                	addi	a5,a5,1
 a30:	0077f713          	andi	a4,a5,7
 a34:	cb01                	beqz	a4,a44 <strlen+0x20>
        if (!*s)
 a36:	0007c703          	lbu	a4,0(a5)
 a3a:	fb75                	bnez	a4,a2e <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 a3c:	40a78533          	sub	a0,a5,a0
}
 a40:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 a42:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 a44:	6394                	ld	a3,0(a5)
 a46:	00000597          	auipc	a1,0x0
 a4a:	5825b583          	ld	a1,1410(a1) # fc8 <STACK_SIZE+0x8>
 a4e:	00000617          	auipc	a2,0x0
 a52:	58263603          	ld	a2,1410(a2) # fd0 <STACK_SIZE+0x10>
 a56:	a019                	j	a5c <strlen+0x38>
 a58:	6794                	ld	a3,8(a5)
 a5a:	07a1                	addi	a5,a5,8
 a5c:	00b68733          	add	a4,a3,a1
 a60:	fff6c693          	not	a3,a3
 a64:	8f75                	and	a4,a4,a3
 a66:	8f71                	and	a4,a4,a2
 a68:	db65                	beqz	a4,a58 <strlen+0x34>
    for (; *s; s++)
 a6a:	0007c703          	lbu	a4,0(a5)
 a6e:	d779                	beqz	a4,a3c <strlen+0x18>
 a70:	0017c703          	lbu	a4,1(a5)
 a74:	0785                	addi	a5,a5,1
 a76:	d379                	beqz	a4,a3c <strlen+0x18>
 a78:	0017c703          	lbu	a4,1(a5)
 a7c:	0785                	addi	a5,a5,1
 a7e:	fb6d                	bnez	a4,a70 <strlen+0x4c>
 a80:	bf75                	j	a3c <strlen+0x18>

0000000000000a82 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a82:	00757713          	andi	a4,a0,7
{
 a86:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 a88:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a8c:	cb19                	beqz	a4,aa2 <memchr+0x20>
 a8e:	ce25                	beqz	a2,b06 <memchr+0x84>
 a90:	0007c703          	lbu	a4,0(a5)
 a94:	04b70e63          	beq	a4,a1,af0 <memchr+0x6e>
 a98:	0785                	addi	a5,a5,1
 a9a:	0077f713          	andi	a4,a5,7
 a9e:	167d                	addi	a2,a2,-1
 aa0:	f77d                	bnez	a4,a8e <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 aa2:	4501                	li	a0,0
    if (n && *s != c)
 aa4:	c235                	beqz	a2,b08 <memchr+0x86>
 aa6:	0007c703          	lbu	a4,0(a5)
 aaa:	04b70363          	beq	a4,a1,af0 <memchr+0x6e>
        size_t k = ONES * c;
 aae:	00000517          	auipc	a0,0x0
 ab2:	52a53503          	ld	a0,1322(a0) # fd8 <STACK_SIZE+0x18>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 ab6:	471d                	li	a4,7
        size_t k = ONES * c;
 ab8:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 abc:	02c77a63          	bgeu	a4,a2,af0 <memchr+0x6e>
 ac0:	00000897          	auipc	a7,0x0
 ac4:	5088b883          	ld	a7,1288(a7) # fc8 <STACK_SIZE+0x8>
 ac8:	00000817          	auipc	a6,0x0
 acc:	50883803          	ld	a6,1288(a6) # fd0 <STACK_SIZE+0x10>
 ad0:	431d                	li	t1,7
 ad2:	a029                	j	adc <memchr+0x5a>
 ad4:	1661                	addi	a2,a2,-8
 ad6:	07a1                	addi	a5,a5,8
 ad8:	02c37963          	bgeu	t1,a2,b0a <memchr+0x88>
 adc:	6398                	ld	a4,0(a5)
 ade:	8f29                	xor	a4,a4,a0
 ae0:	011706b3          	add	a3,a4,a7
 ae4:	fff74713          	not	a4,a4
 ae8:	8f75                	and	a4,a4,a3
 aea:	01077733          	and	a4,a4,a6
 aee:	d37d                	beqz	a4,ad4 <memchr+0x52>
 af0:	853e                	mv	a0,a5
 af2:	97b2                	add	a5,a5,a2
 af4:	a021                	j	afc <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 af6:	0505                	addi	a0,a0,1
 af8:	00f50763          	beq	a0,a5,b06 <memchr+0x84>
 afc:	00054703          	lbu	a4,0(a0)
 b00:	feb71be3          	bne	a4,a1,af6 <memchr+0x74>
 b04:	8082                	ret
    return n ? (void *)s : 0;
 b06:	4501                	li	a0,0
}
 b08:	8082                	ret
    return n ? (void *)s : 0;
 b0a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 b0c:	f275                	bnez	a2,af0 <memchr+0x6e>
}
 b0e:	8082                	ret

0000000000000b10 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 b10:	1101                	addi	sp,sp,-32
 b12:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 b14:	862e                	mv	a2,a1
{
 b16:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 b18:	4581                	li	a1,0
{
 b1a:	e426                	sd	s1,8(sp)
 b1c:	ec06                	sd	ra,24(sp)
 b1e:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 b20:	f63ff0ef          	jal	ra,a82 <memchr>
    return p ? p - s : n;
 b24:	c519                	beqz	a0,b32 <strnlen+0x22>
}
 b26:	60e2                	ld	ra,24(sp)
 b28:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 b2a:	8d05                	sub	a0,a0,s1
}
 b2c:	64a2                	ld	s1,8(sp)
 b2e:	6105                	addi	sp,sp,32
 b30:	8082                	ret
 b32:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 b34:	8522                	mv	a0,s0
}
 b36:	6442                	ld	s0,16(sp)
 b38:	64a2                	ld	s1,8(sp)
 b3a:	6105                	addi	sp,sp,32
 b3c:	8082                	ret

0000000000000b3e <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 b3e:	00b547b3          	xor	a5,a0,a1
 b42:	8b9d                	andi	a5,a5,7
 b44:	eb95                	bnez	a5,b78 <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 b46:	0075f793          	andi	a5,a1,7
 b4a:	e7b1                	bnez	a5,b96 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 b4c:	6198                	ld	a4,0(a1)
 b4e:	00000617          	auipc	a2,0x0
 b52:	47a63603          	ld	a2,1146(a2) # fc8 <STACK_SIZE+0x8>
 b56:	00000817          	auipc	a6,0x0
 b5a:	47a83803          	ld	a6,1146(a6) # fd0 <STACK_SIZE+0x10>
 b5e:	a029                	j	b68 <stpcpy+0x2a>
 b60:	e118                	sd	a4,0(a0)
 b62:	6598                	ld	a4,8(a1)
 b64:	05a1                	addi	a1,a1,8
 b66:	0521                	addi	a0,a0,8
 b68:	00c707b3          	add	a5,a4,a2
 b6c:	fff74693          	not	a3,a4
 b70:	8ff5                	and	a5,a5,a3
 b72:	0107f7b3          	and	a5,a5,a6
 b76:	d7ed                	beqz	a5,b60 <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 b78:	0005c783          	lbu	a5,0(a1)
 b7c:	00f50023          	sb	a5,0(a0)
 b80:	c785                	beqz	a5,ba8 <stpcpy+0x6a>
 b82:	0015c783          	lbu	a5,1(a1)
 b86:	0505                	addi	a0,a0,1
 b88:	0585                	addi	a1,a1,1
 b8a:	00f50023          	sb	a5,0(a0)
 b8e:	fbf5                	bnez	a5,b82 <stpcpy+0x44>
        ;
    return d;
}
 b90:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 b92:	0505                	addi	a0,a0,1
 b94:	df45                	beqz	a4,b4c <stpcpy+0xe>
            if (!(*d = *s))
 b96:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 b9a:	0585                	addi	a1,a1,1
 b9c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 ba0:	00f50023          	sb	a5,0(a0)
 ba4:	f7fd                	bnez	a5,b92 <stpcpy+0x54>
}
 ba6:	8082                	ret
 ba8:	8082                	ret

0000000000000baa <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 baa:	00b547b3          	xor	a5,a0,a1
 bae:	8b9d                	andi	a5,a5,7
 bb0:	1a079863          	bnez	a5,d60 <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 bb4:	0075f793          	andi	a5,a1,7
 bb8:	16078463          	beqz	a5,d20 <stpncpy+0x176>
 bbc:	ea01                	bnez	a2,bcc <stpncpy+0x22>
 bbe:	a421                	j	dc6 <stpncpy+0x21c>
 bc0:	167d                	addi	a2,a2,-1
 bc2:	0505                	addi	a0,a0,1
 bc4:	14070e63          	beqz	a4,d20 <stpncpy+0x176>
 bc8:	1a060863          	beqz	a2,d78 <stpncpy+0x1ce>
 bcc:	0005c783          	lbu	a5,0(a1)
 bd0:	0585                	addi	a1,a1,1
 bd2:	0075f713          	andi	a4,a1,7
 bd6:	00f50023          	sb	a5,0(a0)
 bda:	f3fd                	bnez	a5,bc0 <stpncpy+0x16>
 bdc:	4805                	li	a6,1
 bde:	1a061863          	bnez	a2,d8e <stpncpy+0x1e4>
 be2:	40a007b3          	neg	a5,a0
 be6:	8b9d                	andi	a5,a5,7
 be8:	4681                	li	a3,0
 bea:	18061a63          	bnez	a2,d7e <stpncpy+0x1d4>
 bee:	00778713          	addi	a4,a5,7
 bf2:	45ad                	li	a1,11
 bf4:	18b76363          	bltu	a4,a1,d7a <stpncpy+0x1d0>
 bf8:	1ae6eb63          	bltu	a3,a4,dae <stpncpy+0x204>
 bfc:	1a078363          	beqz	a5,da2 <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 c00:	00050023          	sb	zero,0(a0)
 c04:	4685                	li	a3,1
 c06:	00150713          	addi	a4,a0,1
 c0a:	18d78f63          	beq	a5,a3,da8 <stpncpy+0x1fe>
 c0e:	000500a3          	sb	zero,1(a0)
 c12:	4689                	li	a3,2
 c14:	00250713          	addi	a4,a0,2
 c18:	18d78e63          	beq	a5,a3,db4 <stpncpy+0x20a>
 c1c:	00050123          	sb	zero,2(a0)
 c20:	468d                	li	a3,3
 c22:	00350713          	addi	a4,a0,3
 c26:	16d78c63          	beq	a5,a3,d9e <stpncpy+0x1f4>
 c2a:	000501a3          	sb	zero,3(a0)
 c2e:	4691                	li	a3,4
 c30:	00450713          	addi	a4,a0,4
 c34:	18d78263          	beq	a5,a3,db8 <stpncpy+0x20e>
 c38:	00050223          	sb	zero,4(a0)
 c3c:	4695                	li	a3,5
 c3e:	00550713          	addi	a4,a0,5
 c42:	16d78d63          	beq	a5,a3,dbc <stpncpy+0x212>
 c46:	000502a3          	sb	zero,5(a0)
 c4a:	469d                	li	a3,7
 c4c:	00650713          	addi	a4,a0,6
 c50:	16d79863          	bne	a5,a3,dc0 <stpncpy+0x216>
 c54:	00750713          	addi	a4,a0,7
 c58:	00050323          	sb	zero,6(a0)
 c5c:	40f80833          	sub	a6,a6,a5
 c60:	ff887593          	andi	a1,a6,-8
 c64:	97aa                	add	a5,a5,a0
 c66:	95be                	add	a1,a1,a5
 c68:	0007b023          	sd	zero,0(a5)
 c6c:	07a1                	addi	a5,a5,8
 c6e:	feb79de3          	bne	a5,a1,c68 <stpncpy+0xbe>
 c72:	ff887593          	andi	a1,a6,-8
 c76:	9ead                	addw	a3,a3,a1
 c78:	00b707b3          	add	a5,a4,a1
 c7c:	12b80863          	beq	a6,a1,dac <stpncpy+0x202>
 c80:	00078023          	sb	zero,0(a5)
 c84:	0016871b          	addiw	a4,a3,1
 c88:	0ec77863          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 c8c:	000780a3          	sb	zero,1(a5)
 c90:	0026871b          	addiw	a4,a3,2
 c94:	0ec77263          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 c98:	00078123          	sb	zero,2(a5)
 c9c:	0036871b          	addiw	a4,a3,3
 ca0:	0cc77c63          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 ca4:	000781a3          	sb	zero,3(a5)
 ca8:	0046871b          	addiw	a4,a3,4
 cac:	0cc77663          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 cb0:	00078223          	sb	zero,4(a5)
 cb4:	0056871b          	addiw	a4,a3,5
 cb8:	0cc77063          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 cbc:	000782a3          	sb	zero,5(a5)
 cc0:	0066871b          	addiw	a4,a3,6
 cc4:	0ac77a63          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 cc8:	00078323          	sb	zero,6(a5)
 ccc:	0076871b          	addiw	a4,a3,7
 cd0:	0ac77463          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 cd4:	000783a3          	sb	zero,7(a5)
 cd8:	0086871b          	addiw	a4,a3,8
 cdc:	08c77e63          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 ce0:	00078423          	sb	zero,8(a5)
 ce4:	0096871b          	addiw	a4,a3,9
 ce8:	08c77863          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 cec:	000784a3          	sb	zero,9(a5)
 cf0:	00a6871b          	addiw	a4,a3,10
 cf4:	08c77263          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 cf8:	00078523          	sb	zero,10(a5)
 cfc:	00b6871b          	addiw	a4,a3,11
 d00:	06c77c63          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 d04:	000785a3          	sb	zero,11(a5)
 d08:	00c6871b          	addiw	a4,a3,12
 d0c:	06c77663          	bgeu	a4,a2,d78 <stpncpy+0x1ce>
 d10:	00078623          	sb	zero,12(a5)
 d14:	26b5                	addiw	a3,a3,13
 d16:	06c6f163          	bgeu	a3,a2,d78 <stpncpy+0x1ce>
 d1a:	000786a3          	sb	zero,13(a5)
 d1e:	8082                	ret
            ;
        if (!n || !*s)
 d20:	c645                	beqz	a2,dc8 <stpncpy+0x21e>
 d22:	0005c783          	lbu	a5,0(a1)
 d26:	ea078be3          	beqz	a5,bdc <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d2a:	479d                	li	a5,7
 d2c:	02c7ff63          	bgeu	a5,a2,d6a <stpncpy+0x1c0>
 d30:	00000897          	auipc	a7,0x0
 d34:	2988b883          	ld	a7,664(a7) # fc8 <STACK_SIZE+0x8>
 d38:	00000817          	auipc	a6,0x0
 d3c:	29883803          	ld	a6,664(a6) # fd0 <STACK_SIZE+0x10>
 d40:	431d                	li	t1,7
 d42:	6198                	ld	a4,0(a1)
 d44:	011707b3          	add	a5,a4,a7
 d48:	fff74693          	not	a3,a4
 d4c:	8ff5                	and	a5,a5,a3
 d4e:	0107f7b3          	and	a5,a5,a6
 d52:	ef81                	bnez	a5,d6a <stpncpy+0x1c0>
            *wd = *ws;
 d54:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d56:	1661                	addi	a2,a2,-8
 d58:	05a1                	addi	a1,a1,8
 d5a:	0521                	addi	a0,a0,8
 d5c:	fec363e3          	bltu	t1,a2,d42 <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 d60:	e609                	bnez	a2,d6a <stpncpy+0x1c0>
 d62:	a08d                	j	dc4 <stpncpy+0x21a>
 d64:	167d                	addi	a2,a2,-1
 d66:	0505                	addi	a0,a0,1
 d68:	ca01                	beqz	a2,d78 <stpncpy+0x1ce>
 d6a:	0005c783          	lbu	a5,0(a1)
 d6e:	0585                	addi	a1,a1,1
 d70:	00f50023          	sb	a5,0(a0)
 d74:	fbe5                	bnez	a5,d64 <stpncpy+0x1ba>
        ;
tail:
 d76:	b59d                	j	bdc <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 d78:	8082                	ret
 d7a:	472d                	li	a4,11
 d7c:	bdb5                	j	bf8 <stpncpy+0x4e>
 d7e:	00778713          	addi	a4,a5,7
 d82:	45ad                	li	a1,11
 d84:	fff60693          	addi	a3,a2,-1
 d88:	e6b778e3          	bgeu	a4,a1,bf8 <stpncpy+0x4e>
 d8c:	b7fd                	j	d7a <stpncpy+0x1d0>
 d8e:	40a007b3          	neg	a5,a0
 d92:	8832                	mv	a6,a2
 d94:	8b9d                	andi	a5,a5,7
 d96:	4681                	li	a3,0
 d98:	e4060be3          	beqz	a2,bee <stpncpy+0x44>
 d9c:	b7cd                	j	d7e <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 d9e:	468d                	li	a3,3
 da0:	bd75                	j	c5c <stpncpy+0xb2>
 da2:	872a                	mv	a4,a0
 da4:	4681                	li	a3,0
 da6:	bd5d                	j	c5c <stpncpy+0xb2>
 da8:	4685                	li	a3,1
 daa:	bd4d                	j	c5c <stpncpy+0xb2>
 dac:	8082                	ret
 dae:	87aa                	mv	a5,a0
 db0:	4681                	li	a3,0
 db2:	b5f9                	j	c80 <stpncpy+0xd6>
 db4:	4689                	li	a3,2
 db6:	b55d                	j	c5c <stpncpy+0xb2>
 db8:	4691                	li	a3,4
 dba:	b54d                	j	c5c <stpncpy+0xb2>
 dbc:	4695                	li	a3,5
 dbe:	bd79                	j	c5c <stpncpy+0xb2>
 dc0:	4699                	li	a3,6
 dc2:	bd69                	j	c5c <stpncpy+0xb2>
 dc4:	8082                	ret
 dc6:	8082                	ret
 dc8:	8082                	ret

0000000000000dca <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 dca:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 dce:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dd0:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 dd4:	2501                	sext.w	a0,a0
 dd6:	8082                	ret

0000000000000dd8 <close>:
    register long a7 __asm__("a7") = n;
 dd8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 ddc:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 de0:	2501                	sext.w	a0,a0
 de2:	8082                	ret

0000000000000de4 <read>:
    register long a7 __asm__("a7") = n;
 de4:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 de8:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 dec:	8082                	ret

0000000000000dee <write>:
    register long a7 __asm__("a7") = n;
 dee:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 df2:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 df6:	8082                	ret

0000000000000df8 <getpid>:
    register long a7 __asm__("a7") = n;
 df8:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 dfc:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 e00:	2501                	sext.w	a0,a0
 e02:	8082                	ret

0000000000000e04 <sched_yield>:
    register long a7 __asm__("a7") = n;
 e04:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 e08:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 e0c:	2501                	sext.w	a0,a0
 e0e:	8082                	ret

0000000000000e10 <fork>:
    register long a7 __asm__("a7") = n;
 e10:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 e14:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 e18:	2501                	sext.w	a0,a0
 e1a:	8082                	ret

0000000000000e1c <exit>:
    register long a7 __asm__("a7") = n;
 e1c:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 e20:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 e24:	8082                	ret

0000000000000e26 <waitpid>:
    register long a7 __asm__("a7") = n;
 e26:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e2a:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 e2e:	2501                	sext.w	a0,a0
 e30:	8082                	ret

0000000000000e32 <exec>:
    register long a7 __asm__("a7") = n;
 e32:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 e36:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 e3a:	2501                	sext.w	a0,a0
 e3c:	8082                	ret

0000000000000e3e <get_time>:

int64 get_time()
{
 e3e:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 e40:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e44:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e46:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e48:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 e4c:	2501                	sext.w	a0,a0
 e4e:	ed09                	bnez	a0,e68 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e50:	67a2                	ld	a5,8(sp)
 e52:	3e800713          	li	a4,1000
 e56:	00015503          	lhu	a0,0(sp)
 e5a:	02e7d7b3          	divu	a5,a5,a4
 e5e:	02e50533          	mul	a0,a0,a4
 e62:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 e64:	0141                	addi	sp,sp,16
 e66:	8082                	ret
        return -1;
 e68:	557d                	li	a0,-1
 e6a:	bfed                	j	e64 <get_time+0x26>

0000000000000e6c <sys_get_time>:
    register long a7 __asm__("a7") = n;
 e6c:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e70:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 e74:	2501                	sext.w	a0,a0
 e76:	8082                	ret

0000000000000e78 <sleep>:

int sleep(unsigned long long time)
{
 e78:	1141                	addi	sp,sp,-16
 e7a:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 e7c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e80:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e82:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e84:	00000073          	ecall
    if (err == 0)
 e88:	2501                	sext.w	a0,a0
 e8a:	e13d                	bnez	a0,ef0 <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e8c:	6722                	ld	a4,8(sp)
 e8e:	3e800693          	li	a3,1000
 e92:	00015783          	lhu	a5,0(sp)
 e96:	02d75733          	divu	a4,a4,a3
 e9a:	02d787b3          	mul	a5,a5,a3
 e9e:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 ea0:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 ea4:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 ea6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ea8:	00000073          	ecall
    if (err == 0)
 eac:	2501                	sext.w	a0,a0
 eae:	ed15                	bnez	a0,eea <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 eb0:	6841                	lui	a6,0x10
 eb2:	963e                	add	a2,a2,a5
 eb4:	187d                	addi	a6,a6,-1
 eb6:	3e800693          	li	a3,1000
 eba:	a819                	j	ed0 <sleep+0x58>
    __asm_syscall("r"(a7))
 ebc:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 ec0:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 ec4:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 ec6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ec8:	00000073          	ecall
    if (err == 0)
 ecc:	2501                	sext.w	a0,a0
 ece:	ed11                	bnez	a0,eea <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 ed0:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 ed2:	07c00893          	li	a7,124
 ed6:	02d7d733          	divu	a4,a5,a3
 eda:	6782                	ld	a5,0(sp)
 edc:	0107f7b3          	and	a5,a5,a6
 ee0:	02d787b3          	mul	a5,a5,a3
 ee4:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 ee6:	fcc7ebe3          	bltu	a5,a2,ebc <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 eea:	4501                	li	a0,0
 eec:	0141                	addi	sp,sp,16
 eee:	8082                	ret
 ef0:	57fd                	li	a5,-1
 ef2:	b77d                	j	ea0 <sleep+0x28>

0000000000000ef4 <set_priority>:
    register long a7 __asm__("a7") = n;
 ef4:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 ef8:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 efc:	2501                	sext.w	a0,a0
 efe:	8082                	ret

0000000000000f00 <mmap>:
    register long a7 __asm__("a7") = n;
 f00:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f04:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 f08:	2501                	sext.w	a0,a0
 f0a:	8082                	ret

0000000000000f0c <munmap>:
    register long a7 __asm__("a7") = n;
 f0c:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f10:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 f14:	2501                	sext.w	a0,a0
 f16:	8082                	ret

0000000000000f18 <wait>:

int wait(int *code)
{
 f18:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f1a:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 f1e:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f20:	00000073          	ecall
    return waitpid(-1, code);
}
 f24:	2501                	sext.w	a0,a0
 f26:	8082                	ret

0000000000000f28 <spawn>:
    register long a7 __asm__("a7") = n;
 f28:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 f2c:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 f30:	2501                	sext.w	a0,a0
 f32:	8082                	ret

0000000000000f34 <mailread>:
    register long a7 __asm__("a7") = n;
 f34:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f38:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 f3c:	2501                	sext.w	a0,a0
 f3e:	8082                	ret

0000000000000f40 <mailwrite>:
    register long a7 __asm__("a7") = n;
 f40:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f44:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 f48:	2501                	sext.w	a0,a0
 f4a:	8082                	ret

0000000000000f4c <fstat>:
    register long a7 __asm__("a7") = n;
 f4c:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f50:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 f54:	2501                	sext.w	a0,a0
 f56:	8082                	ret

0000000000000f58 <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 f58:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 f5a:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 f5e:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f60:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 f64:	2501                	sext.w	a0,a0
 f66:	8082                	ret

0000000000000f68 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 f68:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 f6a:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 f6e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f70:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 f74:	2501                	sext.w	a0,a0
 f76:	8082                	ret

0000000000000f78 <link>:

int link(char *old_path, char *new_path)
{
 f78:	87aa                	mv	a5,a0
 f7a:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 f7c:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 f80:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 f84:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 f86:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 f8a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f8c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 f90:	2501                	sext.w	a0,a0
 f92:	8082                	ret

0000000000000f94 <unlink>:

int unlink(char *path)
{
 f94:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f96:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 f9a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 f9e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 fa0:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 fa4:	2501                	sext.w	a0,a0
 fa6:	8082                	ret
