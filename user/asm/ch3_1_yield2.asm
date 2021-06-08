
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_1_yield2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0660006f          	j	68 <__start_main>

0000000000000006 <main>:
/*
理想结果：三个程序交替输出 ABC
*/

int main()
{
   6:	7139                	addi	sp,sp,-64
   8:	f426                	sd	s1,40(sp)
    for (int i = 0; i < HEIGHT; ++i)
    {
        char buf[WIDTH + 1];
        for (int j = 0; j < WIDTH; ++j)
            buf[j] = 'B';
   a:	6491                	lui	s1,0x4
{
   c:	f822                	sd	s0,48(sp)
   e:	f04a                	sd	s2,32(sp)
  10:	ec4e                	sd	s3,24(sp)
  12:	fc06                	sd	ra,56(sp)
    for (int i = 0; i < HEIGHT; ++i)
  14:	4401                	li	s0,0
            buf[j] = 'B';
  16:	00001997          	auipc	s3,0x1
  1a:	fa29b983          	ld	s3,-94(s3) # fb8 <unlink+0x44>
  1e:	2424849b          	addiw	s1,s1,578
        buf[WIDTH] = 0;
        printf("%s [%d/%d]\n", buf, i + 1, HEIGHT);
  22:	00001917          	auipc	s2,0x1
  26:	f6690913          	addi	s2,s2,-154 # f88 <unlink+0x14>
  2a:	2405                	addiw	s0,s0,1
  2c:	4695                	li	a3,5
  2e:	8622                	mv	a2,s0
  30:	858a                	mv	a1,sp
  32:	854a                	mv	a0,s2
            buf[j] = 'B';
  34:	e04e                	sd	s3,0(sp)
  36:	00911423          	sh	s1,8(sp)
        buf[WIDTH] = 0;
  3a:	00010523          	sb	zero,10(sp)
        printf("%s [%d/%d]\n", buf, i + 1, HEIGHT);
  3e:	0bc000ef          	jal	ra,fa <printf>
        sched_yield();
  42:	5a3000ef          	jal	ra,de4 <sched_yield>
    for (int i = 0; i < HEIGHT; ++i)
  46:	4795                	li	a5,5
  48:	fef411e3          	bne	s0,a5,2a <main+0x24>
    }
    puts("Test write B OK!");
  4c:	00001517          	auipc	a0,0x1
  50:	f4c50513          	addi	a0,a0,-180 # f98 <unlink+0x24>
  54:	064000ef          	jal	ra,b8 <puts>
    return 0;
  58:	70e2                	ld	ra,56(sp)
  5a:	7442                	ld	s0,48(sp)
  5c:	74a2                	ld	s1,40(sp)
  5e:	7902                	ld	s2,32(sp)
  60:	69e2                	ld	s3,24(sp)
  62:	4501                	li	a0,0
  64:	6121                	addi	sp,sp,64
  66:	8082                	ret

0000000000000068 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  68:	1141                	addi	sp,sp,-16
  6a:	e406                	sd	ra,8(sp)
    exit(main());
  6c:	f9bff0ef          	jal	ra,6 <main>
  70:	58d000ef          	jal	ra,dfc <exit>
    return 0;
}
  74:	60a2                	ld	ra,8(sp)
  76:	4501                	li	a0,0
  78:	0141                	addi	sp,sp,16
  7a:	8082                	ret

000000000000007c <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  7c:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  7e:	00f10593          	addi	a1,sp,15
  82:	4605                	li	a2,1
  84:	4501                	li	a0,0
{
  86:	ec06                	sd	ra,24(sp)
    char byte = 0;
  88:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  8c:	539000ef          	jal	ra,dc4 <read>
    return byte;
}
  90:	60e2                	ld	ra,24(sp)
  92:	00f14503          	lbu	a0,15(sp)
  96:	6105                	addi	sp,sp,32
  98:	8082                	ret

000000000000009a <putchar>:

int putchar(int c)
{
  9a:	1101                	addi	sp,sp,-32
  9c:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  9e:	00f10593          	addi	a1,sp,15
  a2:	4605                	li	a2,1
  a4:	4505                	li	a0,1
{
  a6:	ec06                	sd	ra,24(sp)
    char byte = c;
  a8:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  ac:	523000ef          	jal	ra,dce <write>
}
  b0:	60e2                	ld	ra,24(sp)
  b2:	2501                	sext.w	a0,a0
  b4:	6105                	addi	sp,sp,32
  b6:	8082                	ret

00000000000000b8 <puts>:

int puts(const char *s)
{
  b8:	1101                	addi	sp,sp,-32
  ba:	e822                	sd	s0,16(sp)
  bc:	ec06                	sd	ra,24(sp)
  be:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
  c0:	145000ef          	jal	ra,a04 <strlen>
  c4:	862a                	mv	a2,a0
  c6:	85a2                	mv	a1,s0
  c8:	4505                	li	a0,1
  ca:	505000ef          	jal	ra,dce <write>
  ce:	00055763          	bgez	a0,dc <puts+0x24>
    return r;
}
  d2:	60e2                	ld	ra,24(sp)
  d4:	6442                	ld	s0,16(sp)
  d6:	557d                	li	a0,-1
  d8:	6105                	addi	sp,sp,32
  da:	8082                	ret
    return write(stdout, &byte, 1);
  dc:	00f10593          	addi	a1,sp,15
    char byte = c;
  e0:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
  e2:	4605                	li	a2,1
  e4:	4505                	li	a0,1
    char byte = c;
  e6:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  ea:	4e5000ef          	jal	ra,dce <write>
}
  ee:	60e2                	ld	ra,24(sp)
  f0:	6442                	ld	s0,16(sp)
  f2:	41f5551b          	sraiw	a0,a0,0x1f
  f6:	6105                	addi	sp,sp,32
  f8:	8082                	ret

00000000000000fa <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
  fa:	7131                	addi	sp,sp,-192
  fc:	ecce                	sd	s3,88(sp)
  fe:	e8d2                	sd	s4,80(sp)
 100:	e4d6                	sd	s5,72(sp)
 102:	e0da                	sd	s6,64(sp)
 104:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
 106:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
 108:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
 10a:	6ae1                	lui	s5,0x18
 10c:	000f4a37          	lui	s4,0xf4
 110:	00989b37          	lui	s6,0x989
{
 114:	fc86                	sd	ra,120(sp)
 116:	f8a2                	sd	s0,112(sp)
 118:	f4a6                	sd	s1,104(sp)
 11a:	f0ca                	sd	s2,96(sp)
 11c:	fc5e                	sd	s7,56(sp)
 11e:	e52e                	sd	a1,136(sp)
 120:	e932                	sd	a2,144(sp)
 122:	ed36                	sd	a3,152(sp)
 124:	f13a                	sd	a4,160(sp)
 126:	f942                	sd	a6,176(sp)
 128:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
 12a:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
 12c:	70f98993          	addi	s3,s3,1807 # 270f <digits+0x172f>
 130:	69fa8a93          	addi	s5,s5,1695 # 1869f <digits+0x176bf>
 134:	23fa0a13          	addi	s4,s4,575 # f423f <digits+0xf325f>
 138:	67fb0b13          	addi	s6,s6,1663 # 98967f <digits+0x98869f>
    for (;;)
    {
        if (!*s)
 13c:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
 140:	02500913          	li	s2,37
        if (!*s)
 144:	1a078f63          	beqz	a5,302 <printf+0x208>
 148:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 14a:	17278e63          	beq	a5,s2,2c6 <printf+0x1cc>
 14e:	00164783          	lbu	a5,1(a2)
 152:	0605                	addi	a2,a2,1
 154:	fbfd                	bnez	a5,14a <printf+0x50>
 156:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 158:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 15c:	85aa                	mv	a1,a0
 15e:	8622                	mv	a2,s0
 160:	4505                	li	a0,1
 162:	46d000ef          	jal	ra,dce <write>
        out(f, a, l);
        if (l)
 166:	18041963          	bnez	s0,2f8 <printf+0x1fe>
            continue;
        if (s[1] == 0)
 16a:	0014c783          	lbu	a5,1(s1) # 4001 <digits+0x3021>
 16e:	18078a63          	beqz	a5,302 <printf+0x208>
            break;
        switch (s[1])
 172:	07300713          	li	a4,115
 176:	28e78e63          	beq	a5,a4,412 <printf+0x318>
 17a:	18f76f63          	bltu	a4,a5,318 <printf+0x21e>
 17e:	06400713          	li	a4,100
 182:	2ae78c63          	beq	a5,a4,43a <printf+0x340>
 186:	07000713          	li	a4,112
 18a:	3ce79c63          	bne	a5,a4,562 <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 18e:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 190:	00001797          	auipc	a5,0x1
 194:	e5078793          	addi	a5,a5,-432 # fe0 <digits>
            printptr(va_arg(ap, uint64));
 198:	6298                	ld	a4,0(a3)
 19a:	00868093          	addi	ra,a3,8
 19e:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 1a0:	00471293          	slli	t0,a4,0x4
 1a4:	00c71f13          	slli	t5,a4,0xc
 1a8:	01471e13          	slli	t3,a4,0x14
 1ac:	01c71893          	slli	a7,a4,0x1c
 1b0:	02471813          	slli	a6,a4,0x24
 1b4:	02871513          	slli	a0,a4,0x28
 1b8:	02c71593          	slli	a1,a4,0x2c
 1bc:	03071693          	slli	a3,a4,0x30
 1c0:	00871f93          	slli	t6,a4,0x8
 1c4:	01071e93          	slli	t4,a4,0x10
 1c8:	01871313          	slli	t1,a4,0x18
 1cc:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1d0:	03c2d293          	srli	t0,t0,0x3c
 1d4:	03cf5f13          	srli	t5,t5,0x3c
 1d8:	03ce5e13          	srli	t3,t3,0x3c
 1dc:	03c8d893          	srli	a7,a7,0x3c
 1e0:	03c85813          	srli	a6,a6,0x3c
 1e4:	9171                	srli	a0,a0,0x3c
 1e6:	91f1                	srli	a1,a1,0x3c
 1e8:	92f1                	srli	a3,a3,0x3c
 1ea:	92be                	add	t0,t0,a5
 1ec:	9f3e                	add	t5,t5,a5
 1ee:	9e3e                	add	t3,t3,a5
 1f0:	98be                	add	a7,a7,a5
 1f2:	983e                	add	a6,a6,a5
 1f4:	953e                	add	a0,a0,a5
 1f6:	95be                	add	a1,a1,a5
 1f8:	96be                	add	a3,a3,a5
 1fa:	03c75393          	srli	t2,a4,0x3c
 1fe:	01c75b9b          	srliw	s7,a4,0x1c
 202:	03cfdf93          	srli	t6,t6,0x3c
 206:	03cede93          	srli	t4,t4,0x3c
 20a:	03c35313          	srli	t1,t1,0x3c
 20e:	9271                	srli	a2,a2,0x3c
 210:	0002c403          	lbu	s0,0(t0)
 214:	93be                	add	t2,t2,a5
 216:	000f4283          	lbu	t0,0(t5)
 21a:	9fbe                	add	t6,t6,a5
 21c:	000e4f03          	lbu	t5,0(t3)
 220:	9ebe                	add	t4,t4,a5
 222:	0008ce03          	lbu	t3,0(a7)
 226:	933e                	add	t1,t1,a5
 228:	00084883          	lbu	a7,0(a6)
 22c:	9bbe                	add	s7,s7,a5
 22e:	00054803          	lbu	a6,0(a0)
 232:	963e                	add	a2,a2,a5
 234:	0005c503          	lbu	a0,0(a1)
 238:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 23c:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 240:	0003c903          	lbu	s2,0(t2)
 244:	00064603          	lbu	a2,0(a2)
 248:	000fc383          	lbu	t2,0(t6)
 24c:	8b3d                	andi	a4,a4,15
 24e:	000ecf83          	lbu	t6,0(t4)
 252:	92f1                	srli	a3,a3,0x3c
 254:	00034e83          	lbu	t4,0(t1)
 258:	000bc303          	lbu	t1,0(s7)
 25c:	96be                	add	a3,a3,a5
 25e:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 260:	7761                	lui	a4,0xffff8
 262:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 266:	00710623          	sb	t2,12(sp)
 26a:	005106a3          	sb	t0,13(sp)
 26e:	01f10723          	sb	t6,14(sp)
 272:	01e107a3          	sb	t5,15(sp)
 276:	01d10823          	sb	t4,16(sp)
 27a:	01c108a3          	sb	t3,17(sp)
 27e:	00610923          	sb	t1,18(sp)
 282:	011109a3          	sb	a7,19(sp)
 286:	01010a23          	sb	a6,20(sp)
 28a:	00a10aa3          	sb	a0,21(sp)
 28e:	00b10b23          	sb	a1,22(sp)
 292:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 296:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 29a:	01210523          	sb	s2,10(sp)
 29e:	008105a3          	sb	s0,11(sp)
 2a2:	0006c703          	lbu	a4,0(a3)
 2a6:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 2aa:	4649                	li	a2,18
 2ac:	002c                	addi	a1,sp,8
 2ae:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2b0:	00e10c23          	sb	a4,24(sp)
 2b4:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 2b8:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 2bc:	313000ef          	jal	ra,dce <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 2c0:	00248513          	addi	a0,s1,2
 2c4:	bda5                	j	13c <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 2c6:	00064783          	lbu	a5,0(a2)
 2ca:	84b2                	mv	s1,a2
 2cc:	01278963          	beq	a5,s2,2de <printf+0x1e4>
 2d0:	b561                	j	158 <printf+0x5e>
 2d2:	0024c783          	lbu	a5,2(s1)
 2d6:	0605                	addi	a2,a2,1
 2d8:	0489                	addi	s1,s1,2
 2da:	e7279fe3          	bne	a5,s2,158 <printf+0x5e>
 2de:	0014c783          	lbu	a5,1(s1)
 2e2:	ff2788e3          	beq	a5,s2,2d2 <printf+0x1d8>
        l = z - a;
 2e6:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 2ea:	85aa                	mv	a1,a0
 2ec:	8622                	mv	a2,s0
 2ee:	4505                	li	a0,1
 2f0:	2df000ef          	jal	ra,dce <write>
        if (l)
 2f4:	e6040be3          	beqz	s0,16a <printf+0x70>
 2f8:	8526                	mv	a0,s1
        if (!*s)
 2fa:	00054783          	lbu	a5,0(a0)
 2fe:	e40795e3          	bnez	a5,148 <printf+0x4e>
    }
    va_end(ap);
 302:	70e6                	ld	ra,120(sp)
 304:	7446                	ld	s0,112(sp)
 306:	74a6                	ld	s1,104(sp)
 308:	7906                	ld	s2,96(sp)
 30a:	69e6                	ld	s3,88(sp)
 30c:	6a46                	ld	s4,80(sp)
 30e:	6aa6                	ld	s5,72(sp)
 310:	6b06                	ld	s6,64(sp)
 312:	7be2                	ld	s7,56(sp)
 314:	6129                	addi	sp,sp,192
 316:	8082                	ret
        switch (s[1])
 318:	07800713          	li	a4,120
 31c:	24e79363          	bne	a5,a4,562 <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 320:	6782                	ld	a5,0(sp)
 322:	4394                	lw	a3,0(a5)
 324:	07a1                	addi	a5,a5,8
 326:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 328:	2606c263          	bltz	a3,58c <printf+0x492>
        buf[i--] = digits[x % base];
 32c:	00001797          	auipc	a5,0x1
 330:	cb478793          	addi	a5,a5,-844 # fe0 <digits>
 334:	00f6f713          	andi	a4,a3,15
 338:	973e                	add	a4,a4,a5
 33a:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <digits+0xffffffffffff7020>
    buf[16] = 0;
 33e:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 342:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 344:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 348:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 34c:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 350:	0046d51b          	srliw	a0,a3,0x4
 354:	0ad5d563          	bge	a1,a3,3fe <printf+0x304>
        buf[i--] = digits[x % base];
 358:	8a3d                	andi	a2,a2,15
 35a:	963e                	add	a2,a2,a5
 35c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 360:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 364:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 368:	30a5fe63          	bgeu	a1,a0,684 <printf+0x58a>
        buf[i--] = digits[x % base];
 36c:	00f77613          	andi	a2,a4,15
 370:	963e                	add	a2,a2,a5
 372:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 376:	45bd                	li	a1,15
 378:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 37c:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 380:	00475513          	srli	a0,a4,0x4
 384:	30e5f963          	bgeu	a1,a4,696 <printf+0x59c>
        buf[i--] = digits[x % base];
 388:	8a3d                	andi	a2,a2,15
 38a:	963e                	add	a2,a2,a5
 38c:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 390:	00875893          	srli	a7,a4,0x8
 394:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 398:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 39c:	30a5fd63          	bgeu	a1,a0,6b6 <printf+0x5bc>
        buf[i--] = digits[x % base];
 3a0:	8a3d                	andi	a2,a2,15
 3a2:	963e                	add	a2,a2,a5
 3a4:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3a8:	00c75813          	srli	a6,a4,0xc
 3ac:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 3b0:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 3b4:	3315fe63          	bgeu	a1,a7,6f0 <printf+0x5f6>
        buf[i--] = digits[x % base];
 3b8:	8a3d                	andi	a2,a2,15
 3ba:	963e                	add	a2,a2,a5
 3bc:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3c0:	01075893          	srli	a7,a4,0x10
 3c4:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 3c8:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 3cc:	3305ff63          	bgeu	a1,a6,70a <printf+0x610>
        buf[i--] = digits[x % base];
 3d0:	8a3d                	andi	a2,a2,15
 3d2:	963e                	add	a2,a2,a5
 3d4:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 3d8:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 3dc:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 3e0:	3515f863          	bgeu	a1,a7,730 <printf+0x636>
        buf[i--] = digits[x % base];
 3e4:	97ba                	add	a5,a5,a4
 3e6:	0007c783          	lbu	a5,0(a5)
 3ea:	45a1                	li	a1,8
 3ec:	00f10823          	sb	a5,16(sp)
    if (sign)
 3f0:	0006d763          	bgez	a3,3fe <printf+0x304>
        buf[i--] = '-';
 3f4:	02d00793          	li	a5,45
 3f8:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 3fc:	459d                	li	a1,7
    write(f, s, l);
 3fe:	4641                	li	a2,16
 400:	003c                	addi	a5,sp,8
 402:	9e0d                	subw	a2,a2,a1
 404:	4505                	li	a0,1
 406:	95be                	add	a1,a1,a5
 408:	1c7000ef          	jal	ra,dce <write>
        s += 2;
 40c:	00248513          	addi	a0,s1,2
 410:	b335                	j	13c <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 412:	6782                	ld	a5,0(sp)
 414:	6380                	ld	s0,0(a5)
 416:	07a1                	addi	a5,a5,8
 418:	e03e                	sd	a5,0(sp)
 41a:	22040a63          	beqz	s0,64e <printf+0x554>
            l = strnlen(a, 200);
 41e:	0c800593          	li	a1,200
 422:	8522                	mv	a0,s0
 424:	6cc000ef          	jal	ra,af0 <strnlen>
    write(f, s, l);
 428:	0005061b          	sext.w	a2,a0
 42c:	85a2                	mv	a1,s0
 42e:	4505                	li	a0,1
 430:	19f000ef          	jal	ra,dce <write>
        s += 2;
 434:	00248513          	addi	a0,s1,2
 438:	b311                	j	13c <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 43a:	6782                	ld	a5,0(sp)
 43c:	4390                	lw	a2,0(a5)
 43e:	07a1                	addi	a5,a5,8
 440:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 442:	1a064363          	bltz	a2,5e8 <printf+0x4ee>
        buf[i--] = digits[x % base];
 446:	46a9                	li	a3,10
 448:	02d6773b          	remuw	a4,a2,a3
 44c:	00001797          	auipc	a5,0x1
 450:	b9478793          	addi	a5,a5,-1132 # fe0 <digits>
    buf[16] = 0;
 454:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 458:	4525                	li	a0,9
        x = xx;
 45a:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 45e:	973e                	add	a4,a4,a5
 460:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 464:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 468:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 46c:	2cc55063          	bge	a0,a2,72c <printf+0x632>
 470:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 474:	02d5f73b          	remuw	a4,a1,a3
 478:	1702                	slli	a4,a4,0x20
 47a:	9301                	srli	a4,a4,0x20
 47c:	973e                	add	a4,a4,a5
 47e:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 482:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 486:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 48a:	1f057d63          	bgeu	a0,a6,684 <printf+0x58a>
        buf[i--] = digits[x % base];
 48e:	4529                	li	a0,10
    } while ((x /= base) != 0);
 490:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 492:	02a5f73b          	remuw	a4,a1,a0
 496:	973e                	add	a4,a4,a5
 498:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 49c:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 4a0:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 4a4:	1ab6f163          	bgeu	a3,a1,646 <printf+0x54c>
 4a8:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 4ac:	02a776bb          	remuw	a3,a4,a0
 4b0:	96be                	add	a3,a3,a5
 4b2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4b6:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4ba:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 4be:	20b87c63          	bgeu	a6,a1,6d6 <printf+0x5dc>
 4c2:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 4c6:	02a776bb          	remuw	a3,a4,a0
 4ca:	96be                	add	a3,a3,a5
 4cc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4d0:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4d4:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 4d8:	20b87363          	bgeu	a6,a1,6de <printf+0x5e4>
        buf[i--] = digits[x % base];
 4dc:	02a776bb          	remuw	a3,a4,a0
 4e0:	96be                	add	a3,a3,a5
 4e2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4e6:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4ea:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 4ee:	20b9f563          	bgeu	s3,a1,6f8 <printf+0x5fe>
        buf[i--] = digits[x % base];
 4f2:	02a776bb          	remuw	a3,a4,a0
 4f6:	96be                	add	a3,a3,a5
 4f8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4fc:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 500:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 504:	20bafb63          	bgeu	s5,a1,71a <printf+0x620>
        buf[i--] = digits[x % base];
 508:	02a776bb          	remuw	a3,a4,a0
 50c:	96be                	add	a3,a3,a5
 50e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 512:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 516:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 51a:	1eba7c63          	bgeu	s4,a1,712 <printf+0x618>
        buf[i--] = digits[x % base];
 51e:	02a776bb          	remuw	a3,a4,a0
 522:	96be                	add	a3,a3,a5
 524:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 528:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 52c:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 530:	14bb7163          	bgeu	s6,a1,672 <printf+0x578>
        buf[i--] = digits[x % base];
 534:	1702                	slli	a4,a4,0x20
 536:	9301                	srli	a4,a4,0x20
 538:	97ba                	add	a5,a5,a4
 53a:	0007c783          	lbu	a5,0(a5)
 53e:	4599                	li	a1,6
 540:	00f10723          	sb	a5,14(sp)
    if (sign)
 544:	ea065de3          	bgez	a2,3fe <printf+0x304>
        buf[i--] = '-';
 548:	02d00793          	li	a5,45
 54c:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 550:	4595                	li	a1,5
    write(f, s, l);
 552:	003c                	addi	a5,sp,8
 554:	4641                	li	a2,16
 556:	9e0d                	subw	a2,a2,a1
 558:	4505                	li	a0,1
 55a:	95be                	add	a1,a1,a5
 55c:	073000ef          	jal	ra,dce <write>
 560:	b575                	j	40c <printf+0x312>
    char byte = c;
 562:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 566:	4605                	li	a2,1
 568:	002c                	addi	a1,sp,8
 56a:	4505                	li	a0,1
    char byte = c;
 56c:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 570:	05f000ef          	jal	ra,dce <write>
    char byte = c;
 574:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 578:	4605                	li	a2,1
 57a:	002c                	addi	a1,sp,8
 57c:	4505                	li	a0,1
    char byte = c;
 57e:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 582:	04d000ef          	jal	ra,dce <write>
        s += 2;
 586:	00248513          	addi	a0,s1,2
 58a:	be4d                	j	13c <printf+0x42>
        x = -xx;
 58c:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 590:	00001797          	auipc	a5,0x1
 594:	a5078793          	addi	a5,a5,-1456 # fe0 <digits>
 598:	00f77613          	andi	a2,a4,15
 59c:	963e                	add	a2,a2,a5
 59e:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 5a2:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5a6:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 5a8:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 5ac:	0047551b          	srliw	a0,a4,0x4
 5b0:	0047561b          	srliw	a2,a4,0x4
 5b4:	0ab6d263          	bge	a3,a1,658 <printf+0x55e>
        buf[i--] = digits[x % base];
 5b8:	8a3d                	andi	a2,a2,15
 5ba:	963e                	add	a2,a2,a5
 5bc:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 5c0:	463d                	li	a2,15
 5c2:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 5c6:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 5ca:	daa661e3          	bltu	a2,a0,36c <printf+0x272>
        buf[i--] = '-';
 5ce:	02d00793          	li	a5,45
 5d2:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 5d6:	45b5                	li	a1,13
    write(f, s, l);
 5d8:	003c                	addi	a5,sp,8
 5da:	4641                	li	a2,16
 5dc:	9e0d                	subw	a2,a2,a1
 5de:	4505                	li	a0,1
 5e0:	95be                	add	a1,a1,a5
 5e2:	7ec000ef          	jal	ra,dce <write>
 5e6:	b51d                	j	40c <printf+0x312>
        x = -xx;
 5e8:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 5ec:	46a9                	li	a3,10
 5ee:	02d875bb          	remuw	a1,a6,a3
 5f2:	00001797          	auipc	a5,0x1
 5f6:	9ee78793          	addi	a5,a5,-1554 # fe0 <digits>
    buf[16] = 0;
 5fa:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5fe:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 600:	95be                	add	a1,a1,a5
 602:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 606:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 60a:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 60e:	04a65563          	bge	a2,a0,658 <printf+0x55e>
 612:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 616:	02d775bb          	remuw	a1,a4,a3
 61a:	95be                	add	a1,a1,a5
 61c:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 620:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 624:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 628:	fb0573e3          	bgeu	a0,a6,5ce <printf+0x4d4>
        buf[i--] = digits[x % base];
 62c:	4529                	li	a0,10
    } while ((x /= base) != 0);
 62e:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 630:	02a5f73b          	remuw	a4,a1,a0
 634:	973e                	add	a4,a4,a5
 636:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 63a:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 63e:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 642:	e6b6e3e3          	bltu	a3,a1,4a8 <printf+0x3ae>
        buf[i--] = digits[x % base];
 646:	45b5                	li	a1,13
    if (sign)
 648:	da065be3          	bgez	a2,3fe <printf+0x304>
 64c:	a881                	j	69c <printf+0x5a2>
                a = "(null)";
 64e:	00001417          	auipc	s0,0x1
 652:	96240413          	addi	s0,s0,-1694 # fb0 <unlink+0x3c>
 656:	b3e1                	j	41e <printf+0x324>
        buf[i--] = '-';
 658:	02d00793          	li	a5,45
 65c:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 660:	45b9                	li	a1,14
    write(f, s, l);
 662:	003c                	addi	a5,sp,8
 664:	4641                	li	a2,16
 666:	9e0d                	subw	a2,a2,a1
 668:	4505                	li	a0,1
 66a:	95be                	add	a1,a1,a5
 66c:	762000ef          	jal	ra,dce <write>
 670:	bb71                	j	40c <printf+0x312>
        buf[i--] = digits[x % base];
 672:	459d                	li	a1,7
    if (sign)
 674:	d80655e3          	bgez	a2,3fe <printf+0x304>
        buf[i--] = '-';
 678:	02d00793          	li	a5,45
 67c:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 680:	4599                	li	a1,6
 682:	bbb5                	j	3fe <printf+0x304>
 684:	45b9                	li	a1,14
    write(f, s, l);
 686:	003c                	addi	a5,sp,8
 688:	4641                	li	a2,16
 68a:	9e0d                	subw	a2,a2,a1
 68c:	4505                	li	a0,1
 68e:	95be                	add	a1,a1,a5
 690:	73e000ef          	jal	ra,dce <write>
 694:	bba5                	j	40c <printf+0x312>
        buf[i--] = digits[x % base];
 696:	45b5                	li	a1,13
    if (sign)
 698:	d606d3e3          	bgez	a3,3fe <printf+0x304>
        buf[i--] = '-';
 69c:	02d00793          	li	a5,45
 6a0:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 6a4:	45b1                	li	a1,12
    write(f, s, l);
 6a6:	003c                	addi	a5,sp,8
 6a8:	4641                	li	a2,16
 6aa:	9e0d                	subw	a2,a2,a1
 6ac:	4505                	li	a0,1
 6ae:	95be                	add	a1,a1,a5
 6b0:	71e000ef          	jal	ra,dce <write>
 6b4:	bba1                	j	40c <printf+0x312>
        buf[i--] = digits[x % base];
 6b6:	45b1                	li	a1,12
    if (sign)
 6b8:	d406d3e3          	bgez	a3,3fe <printf+0x304>
        buf[i--] = '-';
 6bc:	02d00793          	li	a5,45
 6c0:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 6c4:	45ad                	li	a1,11
    write(f, s, l);
 6c6:	003c                	addi	a5,sp,8
 6c8:	4641                	li	a2,16
 6ca:	9e0d                	subw	a2,a2,a1
 6cc:	4505                	li	a0,1
 6ce:	95be                	add	a1,a1,a5
 6d0:	6fe000ef          	jal	ra,dce <write>
 6d4:	bb25                	j	40c <printf+0x312>
        buf[i--] = digits[x % base];
 6d6:	45b1                	li	a1,12
    if (sign)
 6d8:	d20653e3          	bgez	a2,3fe <printf+0x304>
 6dc:	b7c5                	j	6bc <printf+0x5c2>
        buf[i--] = digits[x % base];
 6de:	45ad                	li	a1,11
    if (sign)
 6e0:	d0065fe3          	bgez	a2,3fe <printf+0x304>
        buf[i--] = '-';
 6e4:	02d00793          	li	a5,45
 6e8:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 6ec:	45a9                	li	a1,10
 6ee:	bb01                	j	3fe <printf+0x304>
 6f0:	45ad                	li	a1,11
    if (sign)
 6f2:	d006d6e3          	bgez	a3,3fe <printf+0x304>
 6f6:	b7fd                	j	6e4 <printf+0x5ea>
        buf[i--] = digits[x % base];
 6f8:	45a9                	li	a1,10
    if (sign)
 6fa:	d00652e3          	bgez	a2,3fe <printf+0x304>
        buf[i--] = '-';
 6fe:	02d00793          	li	a5,45
 702:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 706:	45a5                	li	a1,9
 708:	b9dd                	j	3fe <printf+0x304>
 70a:	45a9                	li	a1,10
    if (sign)
 70c:	ce06d9e3          	bgez	a3,3fe <printf+0x304>
 710:	b7fd                	j	6fe <printf+0x604>
        buf[i--] = digits[x % base];
 712:	45a1                	li	a1,8
    if (sign)
 714:	ce0655e3          	bgez	a2,3fe <printf+0x304>
 718:	b9f1                	j	3f4 <printf+0x2fa>
        buf[i--] = digits[x % base];
 71a:	45a5                	li	a1,9
    if (sign)
 71c:	ce0651e3          	bgez	a2,3fe <printf+0x304>
        buf[i--] = '-';
 720:	02d00793          	li	a5,45
 724:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 728:	45a1                	li	a1,8
 72a:	b9d1                	j	3fe <printf+0x304>
    i = 15;
 72c:	45bd                	li	a1,15
 72e:	b9c1                	j	3fe <printf+0x304>
        buf[i--] = digits[x % base];
 730:	45a5                	li	a1,9
    if (sign)
 732:	cc06d6e3          	bgez	a3,3fe <printf+0x304>
 736:	b7ed                	j	720 <printf+0x626>

0000000000000738 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 738:	02000793          	li	a5,32
 73c:	00f50663          	beq	a0,a5,748 <isspace+0x10>
 740:	355d                	addiw	a0,a0,-9
 742:	00553513          	sltiu	a0,a0,5
 746:	8082                	ret
 748:	4505                	li	a0,1
}
 74a:	8082                	ret

000000000000074c <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 74c:	fd05051b          	addiw	a0,a0,-48
}
 750:	00a53513          	sltiu	a0,a0,10
 754:	8082                	ret

0000000000000756 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 756:	02000613          	li	a2,32
 75a:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 75c:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 760:	ff77069b          	addiw	a3,a4,-9
 764:	04c70d63          	beq	a4,a2,7be <atoi+0x68>
 768:	0007079b          	sext.w	a5,a4
 76c:	04d5f963          	bgeu	a1,a3,7be <atoi+0x68>
        s++;
    switch (*s)
 770:	02b00693          	li	a3,43
 774:	04d70a63          	beq	a4,a3,7c8 <atoi+0x72>
 778:	02d00693          	li	a3,45
 77c:	06d70463          	beq	a4,a3,7e4 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 780:	fd07859b          	addiw	a1,a5,-48
 784:	4625                	li	a2,9
 786:	873e                	mv	a4,a5
 788:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 78a:	4e01                	li	t3,0
    while (isdigit(*s))
 78c:	04b66a63          	bltu	a2,a1,7e0 <atoi+0x8a>
    int n = 0, neg = 0;
 790:	4501                	li	a0,0
    while (isdigit(*s))
 792:	4825                	li	a6,9
 794:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 798:	0025179b          	slliw	a5,a0,0x2
 79c:	9d3d                	addw	a0,a0,a5
 79e:	fd07031b          	addiw	t1,a4,-48
 7a2:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 7a6:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 7aa:	0685                	addi	a3,a3,1
 7ac:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 7b0:	0006071b          	sext.w	a4,a2
 7b4:	feb870e3          	bgeu	a6,a1,794 <atoi+0x3e>
    return neg ? n : -n;
 7b8:	000e0563          	beqz	t3,7c2 <atoi+0x6c>
}
 7bc:	8082                	ret
        s++;
 7be:	0505                	addi	a0,a0,1
 7c0:	bf71                	j	75c <atoi+0x6>
 7c2:	4113053b          	subw	a0,t1,a7
 7c6:	8082                	ret
    while (isdigit(*s))
 7c8:	00154783          	lbu	a5,1(a0)
 7cc:	4625                	li	a2,9
        s++;
 7ce:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7d2:	fd07859b          	addiw	a1,a5,-48
 7d6:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 7da:	4e01                	li	t3,0
    while (isdigit(*s))
 7dc:	fab67ae3          	bgeu	a2,a1,790 <atoi+0x3a>
 7e0:	4501                	li	a0,0
}
 7e2:	8082                	ret
    while (isdigit(*s))
 7e4:	00154783          	lbu	a5,1(a0)
 7e8:	4625                	li	a2,9
        s++;
 7ea:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7ee:	fd07859b          	addiw	a1,a5,-48
 7f2:	0007871b          	sext.w	a4,a5
 7f6:	feb665e3          	bltu	a2,a1,7e0 <atoi+0x8a>
        neg = 1;
 7fa:	4e05                	li	t3,1
 7fc:	bf51                	j	790 <atoi+0x3a>

00000000000007fe <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 7fe:	16060d63          	beqz	a2,978 <memset+0x17a>
 802:	40a007b3          	neg	a5,a0
 806:	8b9d                	andi	a5,a5,7
 808:	00778713          	addi	a4,a5,7
 80c:	482d                	li	a6,11
 80e:	0ff5f593          	andi	a1,a1,255
 812:	fff60693          	addi	a3,a2,-1
 816:	17076263          	bltu	a4,a6,97a <memset+0x17c>
 81a:	16e6ea63          	bltu	a3,a4,98e <memset+0x190>
 81e:	16078563          	beqz	a5,988 <memset+0x18a>
 822:	00b50023          	sb	a1,0(a0)
 826:	4705                	li	a4,1
 828:	00150e93          	addi	t4,a0,1
 82c:	14e78c63          	beq	a5,a4,984 <memset+0x186>
 830:	00b500a3          	sb	a1,1(a0)
 834:	4709                	li	a4,2
 836:	00250e93          	addi	t4,a0,2
 83a:	14e78d63          	beq	a5,a4,994 <memset+0x196>
 83e:	00b50123          	sb	a1,2(a0)
 842:	470d                	li	a4,3
 844:	00350e93          	addi	t4,a0,3
 848:	12e78b63          	beq	a5,a4,97e <memset+0x180>
 84c:	00b501a3          	sb	a1,3(a0)
 850:	4711                	li	a4,4
 852:	00450e93          	addi	t4,a0,4
 856:	14e78163          	beq	a5,a4,998 <memset+0x19a>
 85a:	00b50223          	sb	a1,4(a0)
 85e:	4715                	li	a4,5
 860:	00550e93          	addi	t4,a0,5
 864:	12e78c63          	beq	a5,a4,99c <memset+0x19e>
 868:	00b502a3          	sb	a1,5(a0)
 86c:	471d                	li	a4,7
 86e:	00650e93          	addi	t4,a0,6
 872:	12e79763          	bne	a5,a4,9a0 <memset+0x1a2>
 876:	00750e93          	addi	t4,a0,7
 87a:	00b50323          	sb	a1,6(a0)
 87e:	4f1d                	li	t5,7
 880:	00859713          	slli	a4,a1,0x8
 884:	8f4d                	or	a4,a4,a1
 886:	01059e13          	slli	t3,a1,0x10
 88a:	01c76e33          	or	t3,a4,t3
 88e:	01859313          	slli	t1,a1,0x18
 892:	006e6333          	or	t1,t3,t1
 896:	02059893          	slli	a7,a1,0x20
 89a:	011368b3          	or	a7,t1,a7
 89e:	02859813          	slli	a6,a1,0x28
 8a2:	40f60333          	sub	t1,a2,a5
 8a6:	0108e833          	or	a6,a7,a6
 8aa:	03059693          	slli	a3,a1,0x30
 8ae:	00d866b3          	or	a3,a6,a3
 8b2:	03859713          	slli	a4,a1,0x38
 8b6:	97aa                	add	a5,a5,a0
 8b8:	ff837813          	andi	a6,t1,-8
 8bc:	8f55                	or	a4,a4,a3
 8be:	00f806b3          	add	a3,a6,a5
 8c2:	e398                	sd	a4,0(a5)
 8c4:	07a1                	addi	a5,a5,8
 8c6:	fed79ee3          	bne	a5,a3,8c2 <memset+0xc4>
 8ca:	ff837693          	andi	a3,t1,-8
 8ce:	00de87b3          	add	a5,t4,a3
 8d2:	01e6873b          	addw	a4,a3,t5
 8d6:	0ad30663          	beq	t1,a3,982 <memset+0x184>
 8da:	00b78023          	sb	a1,0(a5)
 8de:	0017069b          	addiw	a3,a4,1
 8e2:	08c6fb63          	bgeu	a3,a2,978 <memset+0x17a>
 8e6:	00b780a3          	sb	a1,1(a5)
 8ea:	0027069b          	addiw	a3,a4,2
 8ee:	08c6f563          	bgeu	a3,a2,978 <memset+0x17a>
 8f2:	00b78123          	sb	a1,2(a5)
 8f6:	0037069b          	addiw	a3,a4,3
 8fa:	06c6ff63          	bgeu	a3,a2,978 <memset+0x17a>
 8fe:	00b781a3          	sb	a1,3(a5)
 902:	0047069b          	addiw	a3,a4,4
 906:	06c6f963          	bgeu	a3,a2,978 <memset+0x17a>
 90a:	00b78223          	sb	a1,4(a5)
 90e:	0057069b          	addiw	a3,a4,5
 912:	06c6f363          	bgeu	a3,a2,978 <memset+0x17a>
 916:	00b782a3          	sb	a1,5(a5)
 91a:	0067069b          	addiw	a3,a4,6
 91e:	04c6fd63          	bgeu	a3,a2,978 <memset+0x17a>
 922:	00b78323          	sb	a1,6(a5)
 926:	0077069b          	addiw	a3,a4,7
 92a:	04c6f763          	bgeu	a3,a2,978 <memset+0x17a>
 92e:	00b783a3          	sb	a1,7(a5)
 932:	0087069b          	addiw	a3,a4,8
 936:	04c6f163          	bgeu	a3,a2,978 <memset+0x17a>
 93a:	00b78423          	sb	a1,8(a5)
 93e:	0097069b          	addiw	a3,a4,9
 942:	02c6fb63          	bgeu	a3,a2,978 <memset+0x17a>
 946:	00b784a3          	sb	a1,9(a5)
 94a:	00a7069b          	addiw	a3,a4,10
 94e:	02c6f563          	bgeu	a3,a2,978 <memset+0x17a>
 952:	00b78523          	sb	a1,10(a5)
 956:	00b7069b          	addiw	a3,a4,11
 95a:	00c6ff63          	bgeu	a3,a2,978 <memset+0x17a>
 95e:	00b785a3          	sb	a1,11(a5)
 962:	00c7069b          	addiw	a3,a4,12
 966:	00c6f963          	bgeu	a3,a2,978 <memset+0x17a>
 96a:	00b78623          	sb	a1,12(a5)
 96e:	2735                	addiw	a4,a4,13
 970:	00c77463          	bgeu	a4,a2,978 <memset+0x17a>
 974:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 978:	8082                	ret
 97a:	472d                	li	a4,11
 97c:	bd79                	j	81a <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 97e:	4f0d                	li	t5,3
 980:	b701                	j	880 <memset+0x82>
 982:	8082                	ret
 984:	4f05                	li	t5,1
 986:	bded                	j	880 <memset+0x82>
 988:	8eaa                	mv	t4,a0
 98a:	4f01                	li	t5,0
 98c:	bdd5                	j	880 <memset+0x82>
 98e:	87aa                	mv	a5,a0
 990:	4701                	li	a4,0
 992:	b7a1                	j	8da <memset+0xdc>
 994:	4f09                	li	t5,2
 996:	b5ed                	j	880 <memset+0x82>
 998:	4f11                	li	t5,4
 99a:	b5dd                	j	880 <memset+0x82>
 99c:	4f15                	li	t5,5
 99e:	b5cd                	j	880 <memset+0x82>
 9a0:	4f19                	li	t5,6
 9a2:	bdf9                	j	880 <memset+0x82>

00000000000009a4 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 9a4:	00054783          	lbu	a5,0(a0)
 9a8:	0005c703          	lbu	a4,0(a1)
 9ac:	00e79863          	bne	a5,a4,9bc <strcmp+0x18>
 9b0:	0505                	addi	a0,a0,1
 9b2:	0585                	addi	a1,a1,1
 9b4:	fbe5                	bnez	a5,9a4 <strcmp>
 9b6:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 9b8:	9d19                	subw	a0,a0,a4
 9ba:	8082                	ret
 9bc:	0007851b          	sext.w	a0,a5
 9c0:	bfe5                	j	9b8 <strcmp+0x14>

00000000000009c2 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 9c2:	ce05                	beqz	a2,9fa <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9c4:	00054703          	lbu	a4,0(a0)
 9c8:	0005c783          	lbu	a5,0(a1)
 9cc:	cb0d                	beqz	a4,9fe <strncmp+0x3c>
    if (!n--)
 9ce:	167d                	addi	a2,a2,-1
 9d0:	00c506b3          	add	a3,a0,a2
 9d4:	a819                	j	9ea <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9d6:	00a68e63          	beq	a3,a0,9f2 <strncmp+0x30>
 9da:	0505                	addi	a0,a0,1
 9dc:	00e79b63          	bne	a5,a4,9f2 <strncmp+0x30>
 9e0:	00054703          	lbu	a4,0(a0)
 9e4:	0005c783          	lbu	a5,0(a1)
 9e8:	cb19                	beqz	a4,9fe <strncmp+0x3c>
 9ea:	0005c783          	lbu	a5,0(a1)
 9ee:	0585                	addi	a1,a1,1
 9f0:	f3fd                	bnez	a5,9d6 <strncmp+0x14>
        ;
    return *l - *r;
 9f2:	0007051b          	sext.w	a0,a4
 9f6:	9d1d                	subw	a0,a0,a5
 9f8:	8082                	ret
        return 0;
 9fa:	4501                	li	a0,0
}
 9fc:	8082                	ret
 9fe:	4501                	li	a0,0
    return *l - *r;
 a00:	9d1d                	subw	a0,a0,a5
 a02:	8082                	ret

0000000000000a04 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 a04:	00757793          	andi	a5,a0,7
 a08:	cf89                	beqz	a5,a22 <strlen+0x1e>
 a0a:	87aa                	mv	a5,a0
 a0c:	a029                	j	a16 <strlen+0x12>
 a0e:	0785                	addi	a5,a5,1
 a10:	0077f713          	andi	a4,a5,7
 a14:	cb01                	beqz	a4,a24 <strlen+0x20>
        if (!*s)
 a16:	0007c703          	lbu	a4,0(a5)
 a1a:	fb75                	bnez	a4,a0e <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 a1c:	40a78533          	sub	a0,a5,a0
}
 a20:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 a22:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 a24:	6394                	ld	a3,0(a5)
 a26:	00000597          	auipc	a1,0x0
 a2a:	59a5b583          	ld	a1,1434(a1) # fc0 <unlink+0x4c>
 a2e:	00000617          	auipc	a2,0x0
 a32:	59a63603          	ld	a2,1434(a2) # fc8 <unlink+0x54>
 a36:	a019                	j	a3c <strlen+0x38>
 a38:	6794                	ld	a3,8(a5)
 a3a:	07a1                	addi	a5,a5,8
 a3c:	00b68733          	add	a4,a3,a1
 a40:	fff6c693          	not	a3,a3
 a44:	8f75                	and	a4,a4,a3
 a46:	8f71                	and	a4,a4,a2
 a48:	db65                	beqz	a4,a38 <strlen+0x34>
    for (; *s; s++)
 a4a:	0007c703          	lbu	a4,0(a5)
 a4e:	d779                	beqz	a4,a1c <strlen+0x18>
 a50:	0017c703          	lbu	a4,1(a5)
 a54:	0785                	addi	a5,a5,1
 a56:	d379                	beqz	a4,a1c <strlen+0x18>
 a58:	0017c703          	lbu	a4,1(a5)
 a5c:	0785                	addi	a5,a5,1
 a5e:	fb6d                	bnez	a4,a50 <strlen+0x4c>
 a60:	bf75                	j	a1c <strlen+0x18>

0000000000000a62 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a62:	00757713          	andi	a4,a0,7
{
 a66:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 a68:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a6c:	cb19                	beqz	a4,a82 <memchr+0x20>
 a6e:	ce25                	beqz	a2,ae6 <memchr+0x84>
 a70:	0007c703          	lbu	a4,0(a5)
 a74:	04b70e63          	beq	a4,a1,ad0 <memchr+0x6e>
 a78:	0785                	addi	a5,a5,1
 a7a:	0077f713          	andi	a4,a5,7
 a7e:	167d                	addi	a2,a2,-1
 a80:	f77d                	bnez	a4,a6e <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 a82:	4501                	li	a0,0
    if (n && *s != c)
 a84:	c235                	beqz	a2,ae8 <memchr+0x86>
 a86:	0007c703          	lbu	a4,0(a5)
 a8a:	04b70363          	beq	a4,a1,ad0 <memchr+0x6e>
        size_t k = ONES * c;
 a8e:	00000517          	auipc	a0,0x0
 a92:	54253503          	ld	a0,1346(a0) # fd0 <unlink+0x5c>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 a96:	471d                	li	a4,7
        size_t k = ONES * c;
 a98:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 a9c:	02c77a63          	bgeu	a4,a2,ad0 <memchr+0x6e>
 aa0:	00000897          	auipc	a7,0x0
 aa4:	5208b883          	ld	a7,1312(a7) # fc0 <unlink+0x4c>
 aa8:	00000817          	auipc	a6,0x0
 aac:	52083803          	ld	a6,1312(a6) # fc8 <unlink+0x54>
 ab0:	431d                	li	t1,7
 ab2:	a029                	j	abc <memchr+0x5a>
 ab4:	1661                	addi	a2,a2,-8
 ab6:	07a1                	addi	a5,a5,8
 ab8:	02c37963          	bgeu	t1,a2,aea <memchr+0x88>
 abc:	6398                	ld	a4,0(a5)
 abe:	8f29                	xor	a4,a4,a0
 ac0:	011706b3          	add	a3,a4,a7
 ac4:	fff74713          	not	a4,a4
 ac8:	8f75                	and	a4,a4,a3
 aca:	01077733          	and	a4,a4,a6
 ace:	d37d                	beqz	a4,ab4 <memchr+0x52>
 ad0:	853e                	mv	a0,a5
 ad2:	97b2                	add	a5,a5,a2
 ad4:	a021                	j	adc <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 ad6:	0505                	addi	a0,a0,1
 ad8:	00f50763          	beq	a0,a5,ae6 <memchr+0x84>
 adc:	00054703          	lbu	a4,0(a0)
 ae0:	feb71be3          	bne	a4,a1,ad6 <memchr+0x74>
 ae4:	8082                	ret
    return n ? (void *)s : 0;
 ae6:	4501                	li	a0,0
}
 ae8:	8082                	ret
    return n ? (void *)s : 0;
 aea:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 aec:	f275                	bnez	a2,ad0 <memchr+0x6e>
}
 aee:	8082                	ret

0000000000000af0 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 af0:	1101                	addi	sp,sp,-32
 af2:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 af4:	862e                	mv	a2,a1
{
 af6:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 af8:	4581                	li	a1,0
{
 afa:	e426                	sd	s1,8(sp)
 afc:	ec06                	sd	ra,24(sp)
 afe:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 b00:	f63ff0ef          	jal	ra,a62 <memchr>
    return p ? p - s : n;
 b04:	c519                	beqz	a0,b12 <strnlen+0x22>
}
 b06:	60e2                	ld	ra,24(sp)
 b08:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 b0a:	8d05                	sub	a0,a0,s1
}
 b0c:	64a2                	ld	s1,8(sp)
 b0e:	6105                	addi	sp,sp,32
 b10:	8082                	ret
 b12:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 b14:	8522                	mv	a0,s0
}
 b16:	6442                	ld	s0,16(sp)
 b18:	64a2                	ld	s1,8(sp)
 b1a:	6105                	addi	sp,sp,32
 b1c:	8082                	ret

0000000000000b1e <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 b1e:	00b547b3          	xor	a5,a0,a1
 b22:	8b9d                	andi	a5,a5,7
 b24:	eb95                	bnez	a5,b58 <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 b26:	0075f793          	andi	a5,a1,7
 b2a:	e7b1                	bnez	a5,b76 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 b2c:	6198                	ld	a4,0(a1)
 b2e:	00000617          	auipc	a2,0x0
 b32:	49263603          	ld	a2,1170(a2) # fc0 <unlink+0x4c>
 b36:	00000817          	auipc	a6,0x0
 b3a:	49283803          	ld	a6,1170(a6) # fc8 <unlink+0x54>
 b3e:	a029                	j	b48 <stpcpy+0x2a>
 b40:	e118                	sd	a4,0(a0)
 b42:	6598                	ld	a4,8(a1)
 b44:	05a1                	addi	a1,a1,8
 b46:	0521                	addi	a0,a0,8
 b48:	00c707b3          	add	a5,a4,a2
 b4c:	fff74693          	not	a3,a4
 b50:	8ff5                	and	a5,a5,a3
 b52:	0107f7b3          	and	a5,a5,a6
 b56:	d7ed                	beqz	a5,b40 <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 b58:	0005c783          	lbu	a5,0(a1)
 b5c:	00f50023          	sb	a5,0(a0)
 b60:	c785                	beqz	a5,b88 <stpcpy+0x6a>
 b62:	0015c783          	lbu	a5,1(a1)
 b66:	0505                	addi	a0,a0,1
 b68:	0585                	addi	a1,a1,1
 b6a:	00f50023          	sb	a5,0(a0)
 b6e:	fbf5                	bnez	a5,b62 <stpcpy+0x44>
        ;
    return d;
}
 b70:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 b72:	0505                	addi	a0,a0,1
 b74:	df45                	beqz	a4,b2c <stpcpy+0xe>
            if (!(*d = *s))
 b76:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 b7a:	0585                	addi	a1,a1,1
 b7c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 b80:	00f50023          	sb	a5,0(a0)
 b84:	f7fd                	bnez	a5,b72 <stpcpy+0x54>
}
 b86:	8082                	ret
 b88:	8082                	ret

0000000000000b8a <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 b8a:	00b547b3          	xor	a5,a0,a1
 b8e:	8b9d                	andi	a5,a5,7
 b90:	1a079863          	bnez	a5,d40 <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 b94:	0075f793          	andi	a5,a1,7
 b98:	16078463          	beqz	a5,d00 <stpncpy+0x176>
 b9c:	ea01                	bnez	a2,bac <stpncpy+0x22>
 b9e:	a421                	j	da6 <stpncpy+0x21c>
 ba0:	167d                	addi	a2,a2,-1
 ba2:	0505                	addi	a0,a0,1
 ba4:	14070e63          	beqz	a4,d00 <stpncpy+0x176>
 ba8:	1a060863          	beqz	a2,d58 <stpncpy+0x1ce>
 bac:	0005c783          	lbu	a5,0(a1)
 bb0:	0585                	addi	a1,a1,1
 bb2:	0075f713          	andi	a4,a1,7
 bb6:	00f50023          	sb	a5,0(a0)
 bba:	f3fd                	bnez	a5,ba0 <stpncpy+0x16>
 bbc:	4805                	li	a6,1
 bbe:	1a061863          	bnez	a2,d6e <stpncpy+0x1e4>
 bc2:	40a007b3          	neg	a5,a0
 bc6:	8b9d                	andi	a5,a5,7
 bc8:	4681                	li	a3,0
 bca:	18061a63          	bnez	a2,d5e <stpncpy+0x1d4>
 bce:	00778713          	addi	a4,a5,7
 bd2:	45ad                	li	a1,11
 bd4:	18b76363          	bltu	a4,a1,d5a <stpncpy+0x1d0>
 bd8:	1ae6eb63          	bltu	a3,a4,d8e <stpncpy+0x204>
 bdc:	1a078363          	beqz	a5,d82 <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 be0:	00050023          	sb	zero,0(a0)
 be4:	4685                	li	a3,1
 be6:	00150713          	addi	a4,a0,1
 bea:	18d78f63          	beq	a5,a3,d88 <stpncpy+0x1fe>
 bee:	000500a3          	sb	zero,1(a0)
 bf2:	4689                	li	a3,2
 bf4:	00250713          	addi	a4,a0,2
 bf8:	18d78e63          	beq	a5,a3,d94 <stpncpy+0x20a>
 bfc:	00050123          	sb	zero,2(a0)
 c00:	468d                	li	a3,3
 c02:	00350713          	addi	a4,a0,3
 c06:	16d78c63          	beq	a5,a3,d7e <stpncpy+0x1f4>
 c0a:	000501a3          	sb	zero,3(a0)
 c0e:	4691                	li	a3,4
 c10:	00450713          	addi	a4,a0,4
 c14:	18d78263          	beq	a5,a3,d98 <stpncpy+0x20e>
 c18:	00050223          	sb	zero,4(a0)
 c1c:	4695                	li	a3,5
 c1e:	00550713          	addi	a4,a0,5
 c22:	16d78d63          	beq	a5,a3,d9c <stpncpy+0x212>
 c26:	000502a3          	sb	zero,5(a0)
 c2a:	469d                	li	a3,7
 c2c:	00650713          	addi	a4,a0,6
 c30:	16d79863          	bne	a5,a3,da0 <stpncpy+0x216>
 c34:	00750713          	addi	a4,a0,7
 c38:	00050323          	sb	zero,6(a0)
 c3c:	40f80833          	sub	a6,a6,a5
 c40:	ff887593          	andi	a1,a6,-8
 c44:	97aa                	add	a5,a5,a0
 c46:	95be                	add	a1,a1,a5
 c48:	0007b023          	sd	zero,0(a5)
 c4c:	07a1                	addi	a5,a5,8
 c4e:	feb79de3          	bne	a5,a1,c48 <stpncpy+0xbe>
 c52:	ff887593          	andi	a1,a6,-8
 c56:	9ead                	addw	a3,a3,a1
 c58:	00b707b3          	add	a5,a4,a1
 c5c:	12b80863          	beq	a6,a1,d8c <stpncpy+0x202>
 c60:	00078023          	sb	zero,0(a5)
 c64:	0016871b          	addiw	a4,a3,1
 c68:	0ec77863          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 c6c:	000780a3          	sb	zero,1(a5)
 c70:	0026871b          	addiw	a4,a3,2
 c74:	0ec77263          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 c78:	00078123          	sb	zero,2(a5)
 c7c:	0036871b          	addiw	a4,a3,3
 c80:	0cc77c63          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 c84:	000781a3          	sb	zero,3(a5)
 c88:	0046871b          	addiw	a4,a3,4
 c8c:	0cc77663          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 c90:	00078223          	sb	zero,4(a5)
 c94:	0056871b          	addiw	a4,a3,5
 c98:	0cc77063          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 c9c:	000782a3          	sb	zero,5(a5)
 ca0:	0066871b          	addiw	a4,a3,6
 ca4:	0ac77a63          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 ca8:	00078323          	sb	zero,6(a5)
 cac:	0076871b          	addiw	a4,a3,7
 cb0:	0ac77463          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 cb4:	000783a3          	sb	zero,7(a5)
 cb8:	0086871b          	addiw	a4,a3,8
 cbc:	08c77e63          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 cc0:	00078423          	sb	zero,8(a5)
 cc4:	0096871b          	addiw	a4,a3,9
 cc8:	08c77863          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 ccc:	000784a3          	sb	zero,9(a5)
 cd0:	00a6871b          	addiw	a4,a3,10
 cd4:	08c77263          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 cd8:	00078523          	sb	zero,10(a5)
 cdc:	00b6871b          	addiw	a4,a3,11
 ce0:	06c77c63          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 ce4:	000785a3          	sb	zero,11(a5)
 ce8:	00c6871b          	addiw	a4,a3,12
 cec:	06c77663          	bgeu	a4,a2,d58 <stpncpy+0x1ce>
 cf0:	00078623          	sb	zero,12(a5)
 cf4:	26b5                	addiw	a3,a3,13
 cf6:	06c6f163          	bgeu	a3,a2,d58 <stpncpy+0x1ce>
 cfa:	000786a3          	sb	zero,13(a5)
 cfe:	8082                	ret
            ;
        if (!n || !*s)
 d00:	c645                	beqz	a2,da8 <stpncpy+0x21e>
 d02:	0005c783          	lbu	a5,0(a1)
 d06:	ea078be3          	beqz	a5,bbc <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d0a:	479d                	li	a5,7
 d0c:	02c7ff63          	bgeu	a5,a2,d4a <stpncpy+0x1c0>
 d10:	00000897          	auipc	a7,0x0
 d14:	2b08b883          	ld	a7,688(a7) # fc0 <unlink+0x4c>
 d18:	00000817          	auipc	a6,0x0
 d1c:	2b083803          	ld	a6,688(a6) # fc8 <unlink+0x54>
 d20:	431d                	li	t1,7
 d22:	6198                	ld	a4,0(a1)
 d24:	011707b3          	add	a5,a4,a7
 d28:	fff74693          	not	a3,a4
 d2c:	8ff5                	and	a5,a5,a3
 d2e:	0107f7b3          	and	a5,a5,a6
 d32:	ef81                	bnez	a5,d4a <stpncpy+0x1c0>
            *wd = *ws;
 d34:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d36:	1661                	addi	a2,a2,-8
 d38:	05a1                	addi	a1,a1,8
 d3a:	0521                	addi	a0,a0,8
 d3c:	fec363e3          	bltu	t1,a2,d22 <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 d40:	e609                	bnez	a2,d4a <stpncpy+0x1c0>
 d42:	a08d                	j	da4 <stpncpy+0x21a>
 d44:	167d                	addi	a2,a2,-1
 d46:	0505                	addi	a0,a0,1
 d48:	ca01                	beqz	a2,d58 <stpncpy+0x1ce>
 d4a:	0005c783          	lbu	a5,0(a1)
 d4e:	0585                	addi	a1,a1,1
 d50:	00f50023          	sb	a5,0(a0)
 d54:	fbe5                	bnez	a5,d44 <stpncpy+0x1ba>
        ;
tail:
 d56:	b59d                	j	bbc <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 d58:	8082                	ret
 d5a:	472d                	li	a4,11
 d5c:	bdb5                	j	bd8 <stpncpy+0x4e>
 d5e:	00778713          	addi	a4,a5,7
 d62:	45ad                	li	a1,11
 d64:	fff60693          	addi	a3,a2,-1
 d68:	e6b778e3          	bgeu	a4,a1,bd8 <stpncpy+0x4e>
 d6c:	b7fd                	j	d5a <stpncpy+0x1d0>
 d6e:	40a007b3          	neg	a5,a0
 d72:	8832                	mv	a6,a2
 d74:	8b9d                	andi	a5,a5,7
 d76:	4681                	li	a3,0
 d78:	e4060be3          	beqz	a2,bce <stpncpy+0x44>
 d7c:	b7cd                	j	d5e <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 d7e:	468d                	li	a3,3
 d80:	bd75                	j	c3c <stpncpy+0xb2>
 d82:	872a                	mv	a4,a0
 d84:	4681                	li	a3,0
 d86:	bd5d                	j	c3c <stpncpy+0xb2>
 d88:	4685                	li	a3,1
 d8a:	bd4d                	j	c3c <stpncpy+0xb2>
 d8c:	8082                	ret
 d8e:	87aa                	mv	a5,a0
 d90:	4681                	li	a3,0
 d92:	b5f9                	j	c60 <stpncpy+0xd6>
 d94:	4689                	li	a3,2
 d96:	b55d                	j	c3c <stpncpy+0xb2>
 d98:	4691                	li	a3,4
 d9a:	b54d                	j	c3c <stpncpy+0xb2>
 d9c:	4695                	li	a3,5
 d9e:	bd79                	j	c3c <stpncpy+0xb2>
 da0:	4699                	li	a3,6
 da2:	bd69                	j	c3c <stpncpy+0xb2>
 da4:	8082                	ret
 da6:	8082                	ret
 da8:	8082                	ret

0000000000000daa <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 daa:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 dae:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 db0:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 db4:	2501                	sext.w	a0,a0
 db6:	8082                	ret

0000000000000db8 <close>:
    register long a7 __asm__("a7") = n;
 db8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 dbc:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 dc0:	2501                	sext.w	a0,a0
 dc2:	8082                	ret

0000000000000dc4 <read>:
    register long a7 __asm__("a7") = n;
 dc4:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dc8:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 dcc:	8082                	ret

0000000000000dce <write>:
    register long a7 __asm__("a7") = n;
 dce:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dd2:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 dd6:	8082                	ret

0000000000000dd8 <getpid>:
    register long a7 __asm__("a7") = n;
 dd8:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 ddc:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 de0:	2501                	sext.w	a0,a0
 de2:	8082                	ret

0000000000000de4 <sched_yield>:
    register long a7 __asm__("a7") = n;
 de4:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 de8:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 dec:	2501                	sext.w	a0,a0
 dee:	8082                	ret

0000000000000df0 <fork>:
    register long a7 __asm__("a7") = n;
 df0:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 df4:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 df8:	2501                	sext.w	a0,a0
 dfa:	8082                	ret

0000000000000dfc <exit>:
    register long a7 __asm__("a7") = n;
 dfc:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 e00:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 e04:	8082                	ret

0000000000000e06 <waitpid>:
    register long a7 __asm__("a7") = n;
 e06:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e0a:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 e0e:	2501                	sext.w	a0,a0
 e10:	8082                	ret

0000000000000e12 <exec>:
    register long a7 __asm__("a7") = n;
 e12:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 e16:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 e1a:	2501                	sext.w	a0,a0
 e1c:	8082                	ret

0000000000000e1e <get_time>:

int64 get_time()
{
 e1e:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 e20:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e24:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e26:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e28:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 e2c:	2501                	sext.w	a0,a0
 e2e:	ed09                	bnez	a0,e48 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e30:	67a2                	ld	a5,8(sp)
 e32:	3e800713          	li	a4,1000
 e36:	00015503          	lhu	a0,0(sp)
 e3a:	02e7d7b3          	divu	a5,a5,a4
 e3e:	02e50533          	mul	a0,a0,a4
 e42:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 e44:	0141                	addi	sp,sp,16
 e46:	8082                	ret
        return -1;
 e48:	557d                	li	a0,-1
 e4a:	bfed                	j	e44 <get_time+0x26>

0000000000000e4c <sys_get_time>:
    register long a7 __asm__("a7") = n;
 e4c:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e50:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 e54:	2501                	sext.w	a0,a0
 e56:	8082                	ret

0000000000000e58 <sleep>:

int sleep(unsigned long long time)
{
 e58:	1141                	addi	sp,sp,-16
 e5a:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 e5c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e60:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e62:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e64:	00000073          	ecall
    if (err == 0)
 e68:	2501                	sext.w	a0,a0
 e6a:	e13d                	bnez	a0,ed0 <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e6c:	6722                	ld	a4,8(sp)
 e6e:	3e800693          	li	a3,1000
 e72:	00015783          	lhu	a5,0(sp)
 e76:	02d75733          	divu	a4,a4,a3
 e7a:	02d787b3          	mul	a5,a5,a3
 e7e:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 e80:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e84:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e86:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e88:	00000073          	ecall
    if (err == 0)
 e8c:	2501                	sext.w	a0,a0
 e8e:	ed15                	bnez	a0,eca <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e90:	6841                	lui	a6,0x10
 e92:	963e                	add	a2,a2,a5
 e94:	187d                	addi	a6,a6,-1
 e96:	3e800693          	li	a3,1000
 e9a:	a819                	j	eb0 <sleep+0x58>
    __asm_syscall("r"(a7))
 e9c:	00000073          	ecall
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
 eae:	ed11                	bnez	a0,eca <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 eb0:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 eb2:	07c00893          	li	a7,124
 eb6:	02d7d733          	divu	a4,a5,a3
 eba:	6782                	ld	a5,0(sp)
 ebc:	0107f7b3          	and	a5,a5,a6
 ec0:	02d787b3          	mul	a5,a5,a3
 ec4:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 ec6:	fcc7ebe3          	bltu	a5,a2,e9c <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 eca:	4501                	li	a0,0
 ecc:	0141                	addi	sp,sp,16
 ece:	8082                	ret
 ed0:	57fd                	li	a5,-1
 ed2:	b77d                	j	e80 <sleep+0x28>

0000000000000ed4 <set_priority>:
    register long a7 __asm__("a7") = n;
 ed4:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 ed8:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 edc:	2501                	sext.w	a0,a0
 ede:	8082                	ret

0000000000000ee0 <mmap>:
    register long a7 __asm__("a7") = n;
 ee0:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 ee4:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 ee8:	2501                	sext.w	a0,a0
 eea:	8082                	ret

0000000000000eec <munmap>:
    register long a7 __asm__("a7") = n;
 eec:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ef0:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 ef4:	2501                	sext.w	a0,a0
 ef6:	8082                	ret

0000000000000ef8 <wait>:

int wait(int *code)
{
 ef8:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 efa:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 efe:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f00:	00000073          	ecall
    return waitpid(-1, code);
}
 f04:	2501                	sext.w	a0,a0
 f06:	8082                	ret

0000000000000f08 <spawn>:
    register long a7 __asm__("a7") = n;
 f08:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 f0c:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 f10:	2501                	sext.w	a0,a0
 f12:	8082                	ret

0000000000000f14 <mailread>:
    register long a7 __asm__("a7") = n;
 f14:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f18:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 f1c:	2501                	sext.w	a0,a0
 f1e:	8082                	ret

0000000000000f20 <mailwrite>:
    register long a7 __asm__("a7") = n;
 f20:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f24:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 f28:	2501                	sext.w	a0,a0
 f2a:	8082                	ret

0000000000000f2c <fstat>:
    register long a7 __asm__("a7") = n;
 f2c:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f30:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 f34:	2501                	sext.w	a0,a0
 f36:	8082                	ret

0000000000000f38 <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 f38:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 f3a:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 f3e:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f40:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 f44:	2501                	sext.w	a0,a0
 f46:	8082                	ret

0000000000000f48 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 f48:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 f4a:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 f4e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f50:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 f54:	2501                	sext.w	a0,a0
 f56:	8082                	ret

0000000000000f58 <link>:

int link(char *old_path, char *new_path)
{
 f58:	87aa                	mv	a5,a0
 f5a:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 f5c:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 f60:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 f64:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 f66:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 f6a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f6c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 f70:	2501                	sext.w	a0,a0
 f72:	8082                	ret

0000000000000f74 <unlink>:

int unlink(char *path)
{
 f74:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f76:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 f7a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 f7e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f80:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 f84:	2501                	sext.w	a0,a0
 f86:	8082                	ret
