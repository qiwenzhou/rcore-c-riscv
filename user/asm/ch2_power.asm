
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch2_power:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0720006f          	j	74 <__start_main>

0000000000000006 <main>:
/// 3^90000=2621
/// 3^100000=2749
/// Test power OK!

int main(void)
{
   6:	7139                	addi	sp,sp,-64
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
    pow[index] = 1;
    for (i = 1; i <= STEP; ++i)
    {
        last = pow[index];
        index = (index + 1) % SIZE;
        pow[index] = (last * P) % MOD;
   c:	6909                	lui	s2,0x2
    for (i = 1; i <= STEP; ++i)
   e:	69e1                	lui	s3,0x18
{
  10:	f822                	sd	s0,48(sp)
  12:	f426                	sd	s1,40(sp)
  14:	e852                	sd	s4,16(sp)
  16:	e456                	sd	s5,8(sp)
        pow[index] = (last * P) % MOD;
  18:	71790a1b          	addiw	s4,s2,1815
{
  1c:	fc06                	sd	ra,56(sp)
  1e:	440d                	li	s0,3
    for (i = 1; i <= STEP; ++i)
  20:	4489                	li	s1,2
        pow[index] = (last * P) % MOD;
  22:	7109091b          	addiw	s2,s2,1808
        if ((i % 10000) == 0)
        {
            printf("%d^%d=%d\n", P, i, pow[index]);
  26:	00001a97          	auipc	s5,0x1
  2a:	f72a8a93          	addi	s5,s5,-142 # f98 <unlink+0x18>
    for (i = 1; i <= STEP; ++i)
  2e:	6a198993          	addi	s3,s3,1697 # 186a1 <digits+0x176b9>
        if ((i % 10000) == 0)
  32:	0324e7bb          	remw	a5,s1,s2
        pow[index] = (last * P) % MOD;
  36:	0014169b          	slliw	a3,s0,0x1
  3a:	9c35                	addw	s0,s0,a3
  3c:	0344643b          	remw	s0,s0,s4
        if ((i % 10000) == 0)
  40:	e799                	bnez	a5,4e <main+0x48>
            printf("%d^%d=%d\n", P, i, pow[index]);
  42:	8626                	mv	a2,s1
  44:	458d                	li	a1,3
  46:	8556                	mv	a0,s5
  48:	86a2                	mv	a3,s0
  4a:	0bc000ef          	jal	ra,106 <printf>
    for (i = 1; i <= STEP; ++i)
  4e:	2485                	addiw	s1,s1,1
  50:	ff3491e3          	bne	s1,s3,32 <main+0x2c>
        }
    }
    puts("Test power OK!");
  54:	00001517          	auipc	a0,0x1
  58:	f5450513          	addi	a0,a0,-172 # fa8 <unlink+0x28>
  5c:	068000ef          	jal	ra,c4 <puts>
    return 0;
}
  60:	70e2                	ld	ra,56(sp)
  62:	7442                	ld	s0,48(sp)
  64:	74a2                	ld	s1,40(sp)
  66:	7902                	ld	s2,32(sp)
  68:	69e2                	ld	s3,24(sp)
  6a:	6a42                	ld	s4,16(sp)
  6c:	6aa2                	ld	s5,8(sp)
  6e:	4501                	li	a0,0
  70:	6121                	addi	sp,sp,64
  72:	8082                	ret

0000000000000074 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  74:	1141                	addi	sp,sp,-16
  76:	e406                	sd	ra,8(sp)
    exit(main());
  78:	f8fff0ef          	jal	ra,6 <main>
  7c:	58d000ef          	jal	ra,e08 <exit>
    return 0;
}
  80:	60a2                	ld	ra,8(sp)
  82:	4501                	li	a0,0
  84:	0141                	addi	sp,sp,16
  86:	8082                	ret

0000000000000088 <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  88:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  8a:	00f10593          	addi	a1,sp,15
  8e:	4605                	li	a2,1
  90:	4501                	li	a0,0
{
  92:	ec06                	sd	ra,24(sp)
    char byte = 0;
  94:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  98:	539000ef          	jal	ra,dd0 <read>
    return byte;
}
  9c:	60e2                	ld	ra,24(sp)
  9e:	00f14503          	lbu	a0,15(sp)
  a2:	6105                	addi	sp,sp,32
  a4:	8082                	ret

00000000000000a6 <putchar>:

int putchar(int c)
{
  a6:	1101                	addi	sp,sp,-32
  a8:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  aa:	00f10593          	addi	a1,sp,15
  ae:	4605                	li	a2,1
  b0:	4505                	li	a0,1
{
  b2:	ec06                	sd	ra,24(sp)
    char byte = c;
  b4:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  b8:	523000ef          	jal	ra,dda <write>
}
  bc:	60e2                	ld	ra,24(sp)
  be:	2501                	sext.w	a0,a0
  c0:	6105                	addi	sp,sp,32
  c2:	8082                	ret

00000000000000c4 <puts>:

int puts(const char *s)
{
  c4:	1101                	addi	sp,sp,-32
  c6:	e822                	sd	s0,16(sp)
  c8:	ec06                	sd	ra,24(sp)
  ca:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
  cc:	145000ef          	jal	ra,a10 <strlen>
  d0:	862a                	mv	a2,a0
  d2:	85a2                	mv	a1,s0
  d4:	4505                	li	a0,1
  d6:	505000ef          	jal	ra,dda <write>
  da:	00055763          	bgez	a0,e8 <puts+0x24>
    return r;
}
  de:	60e2                	ld	ra,24(sp)
  e0:	6442                	ld	s0,16(sp)
  e2:	557d                	li	a0,-1
  e4:	6105                	addi	sp,sp,32
  e6:	8082                	ret
    return write(stdout, &byte, 1);
  e8:	00f10593          	addi	a1,sp,15
    char byte = c;
  ec:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
  ee:	4605                	li	a2,1
  f0:	4505                	li	a0,1
    char byte = c;
  f2:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  f6:	4e5000ef          	jal	ra,dda <write>
}
  fa:	60e2                	ld	ra,24(sp)
  fc:	6442                	ld	s0,16(sp)
  fe:	41f5551b          	sraiw	a0,a0,0x1f
 102:	6105                	addi	sp,sp,32
 104:	8082                	ret

0000000000000106 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
 106:	7131                	addi	sp,sp,-192
 108:	ecce                	sd	s3,88(sp)
 10a:	e8d2                	sd	s4,80(sp)
 10c:	e4d6                	sd	s5,72(sp)
 10e:	e0da                	sd	s6,64(sp)
 110:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
 112:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
 114:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
 116:	6ae1                	lui	s5,0x18
 118:	000f4a37          	lui	s4,0xf4
 11c:	00989b37          	lui	s6,0x989
{
 120:	fc86                	sd	ra,120(sp)
 122:	f8a2                	sd	s0,112(sp)
 124:	f4a6                	sd	s1,104(sp)
 126:	f0ca                	sd	s2,96(sp)
 128:	fc5e                	sd	s7,56(sp)
 12a:	e52e                	sd	a1,136(sp)
 12c:	e932                	sd	a2,144(sp)
 12e:	ed36                	sd	a3,152(sp)
 130:	f13a                	sd	a4,160(sp)
 132:	f942                	sd	a6,176(sp)
 134:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
 136:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
 138:	70f98993          	addi	s3,s3,1807 # 270f <digits+0x1727>
 13c:	69fa8a93          	addi	s5,s5,1695 # 1869f <digits+0x176b7>
 140:	23fa0a13          	addi	s4,s4,575 # f423f <digits+0xf3257>
 144:	67fb0b13          	addi	s6,s6,1663 # 98967f <digits+0x988697>
    for (;;)
    {
        if (!*s)
 148:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
 14c:	02500913          	li	s2,37
        if (!*s)
 150:	1a078f63          	beqz	a5,30e <printf+0x208>
 154:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 156:	17278e63          	beq	a5,s2,2d2 <printf+0x1cc>
 15a:	00164783          	lbu	a5,1(a2)
 15e:	0605                	addi	a2,a2,1
 160:	fbfd                	bnez	a5,156 <printf+0x50>
 162:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 164:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 168:	85aa                	mv	a1,a0
 16a:	8622                	mv	a2,s0
 16c:	4505                	li	a0,1
 16e:	46d000ef          	jal	ra,dda <write>
        out(f, a, l);
        if (l)
 172:	18041963          	bnez	s0,304 <printf+0x1fe>
            continue;
        if (s[1] == 0)
 176:	0014c783          	lbu	a5,1(s1)
 17a:	18078a63          	beqz	a5,30e <printf+0x208>
            break;
        switch (s[1])
 17e:	07300713          	li	a4,115
 182:	28e78e63          	beq	a5,a4,41e <printf+0x318>
 186:	18f76f63          	bltu	a4,a5,324 <printf+0x21e>
 18a:	06400713          	li	a4,100
 18e:	2ae78c63          	beq	a5,a4,446 <printf+0x340>
 192:	07000713          	li	a4,112
 196:	3ce79c63          	bne	a5,a4,56e <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 19a:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 19c:	00001797          	auipc	a5,0x1
 1a0:	e4c78793          	addi	a5,a5,-436 # fe8 <digits>
            printptr(va_arg(ap, uint64));
 1a4:	6298                	ld	a4,0(a3)
 1a6:	00868093          	addi	ra,a3,8
 1aa:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 1ac:	00471293          	slli	t0,a4,0x4
 1b0:	00c71f13          	slli	t5,a4,0xc
 1b4:	01471e13          	slli	t3,a4,0x14
 1b8:	01c71893          	slli	a7,a4,0x1c
 1bc:	02471813          	slli	a6,a4,0x24
 1c0:	02871513          	slli	a0,a4,0x28
 1c4:	02c71593          	slli	a1,a4,0x2c
 1c8:	03071693          	slli	a3,a4,0x30
 1cc:	00871f93          	slli	t6,a4,0x8
 1d0:	01071e93          	slli	t4,a4,0x10
 1d4:	01871313          	slli	t1,a4,0x18
 1d8:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1dc:	03c2d293          	srli	t0,t0,0x3c
 1e0:	03cf5f13          	srli	t5,t5,0x3c
 1e4:	03ce5e13          	srli	t3,t3,0x3c
 1e8:	03c8d893          	srli	a7,a7,0x3c
 1ec:	03c85813          	srli	a6,a6,0x3c
 1f0:	9171                	srli	a0,a0,0x3c
 1f2:	91f1                	srli	a1,a1,0x3c
 1f4:	92f1                	srli	a3,a3,0x3c
 1f6:	92be                	add	t0,t0,a5
 1f8:	9f3e                	add	t5,t5,a5
 1fa:	9e3e                	add	t3,t3,a5
 1fc:	98be                	add	a7,a7,a5
 1fe:	983e                	add	a6,a6,a5
 200:	953e                	add	a0,a0,a5
 202:	95be                	add	a1,a1,a5
 204:	96be                	add	a3,a3,a5
 206:	03c75393          	srli	t2,a4,0x3c
 20a:	01c75b9b          	srliw	s7,a4,0x1c
 20e:	03cfdf93          	srli	t6,t6,0x3c
 212:	03cede93          	srli	t4,t4,0x3c
 216:	03c35313          	srli	t1,t1,0x3c
 21a:	9271                	srli	a2,a2,0x3c
 21c:	0002c403          	lbu	s0,0(t0)
 220:	93be                	add	t2,t2,a5
 222:	000f4283          	lbu	t0,0(t5)
 226:	9fbe                	add	t6,t6,a5
 228:	000e4f03          	lbu	t5,0(t3)
 22c:	9ebe                	add	t4,t4,a5
 22e:	0008ce03          	lbu	t3,0(a7)
 232:	933e                	add	t1,t1,a5
 234:	00084883          	lbu	a7,0(a6)
 238:	9bbe                	add	s7,s7,a5
 23a:	00054803          	lbu	a6,0(a0)
 23e:	963e                	add	a2,a2,a5
 240:	0005c503          	lbu	a0,0(a1)
 244:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 248:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 24c:	0003c903          	lbu	s2,0(t2)
 250:	00064603          	lbu	a2,0(a2)
 254:	000fc383          	lbu	t2,0(t6)
 258:	8b3d                	andi	a4,a4,15
 25a:	000ecf83          	lbu	t6,0(t4)
 25e:	92f1                	srli	a3,a3,0x3c
 260:	00034e83          	lbu	t4,0(t1)
 264:	000bc303          	lbu	t1,0(s7)
 268:	96be                	add	a3,a3,a5
 26a:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 26c:	7761                	lui	a4,0xffff8
 26e:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 272:	00710623          	sb	t2,12(sp)
 276:	005106a3          	sb	t0,13(sp)
 27a:	01f10723          	sb	t6,14(sp)
 27e:	01e107a3          	sb	t5,15(sp)
 282:	01d10823          	sb	t4,16(sp)
 286:	01c108a3          	sb	t3,17(sp)
 28a:	00610923          	sb	t1,18(sp)
 28e:	011109a3          	sb	a7,19(sp)
 292:	01010a23          	sb	a6,20(sp)
 296:	00a10aa3          	sb	a0,21(sp)
 29a:	00b10b23          	sb	a1,22(sp)
 29e:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 2a2:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2a6:	01210523          	sb	s2,10(sp)
 2aa:	008105a3          	sb	s0,11(sp)
 2ae:	0006c703          	lbu	a4,0(a3)
 2b2:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 2b6:	4649                	li	a2,18
 2b8:	002c                	addi	a1,sp,8
 2ba:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2bc:	00e10c23          	sb	a4,24(sp)
 2c0:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 2c4:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 2c8:	313000ef          	jal	ra,dda <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 2cc:	00248513          	addi	a0,s1,2
 2d0:	bda5                	j	148 <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 2d2:	00064783          	lbu	a5,0(a2)
 2d6:	84b2                	mv	s1,a2
 2d8:	01278963          	beq	a5,s2,2ea <printf+0x1e4>
 2dc:	b561                	j	164 <printf+0x5e>
 2de:	0024c783          	lbu	a5,2(s1)
 2e2:	0605                	addi	a2,a2,1
 2e4:	0489                	addi	s1,s1,2
 2e6:	e7279fe3          	bne	a5,s2,164 <printf+0x5e>
 2ea:	0014c783          	lbu	a5,1(s1)
 2ee:	ff2788e3          	beq	a5,s2,2de <printf+0x1d8>
        l = z - a;
 2f2:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 2f6:	85aa                	mv	a1,a0
 2f8:	8622                	mv	a2,s0
 2fa:	4505                	li	a0,1
 2fc:	2df000ef          	jal	ra,dda <write>
        if (l)
 300:	e6040be3          	beqz	s0,176 <printf+0x70>
 304:	8526                	mv	a0,s1
        if (!*s)
 306:	00054783          	lbu	a5,0(a0)
 30a:	e40795e3          	bnez	a5,154 <printf+0x4e>
    }
    va_end(ap);
 30e:	70e6                	ld	ra,120(sp)
 310:	7446                	ld	s0,112(sp)
 312:	74a6                	ld	s1,104(sp)
 314:	7906                	ld	s2,96(sp)
 316:	69e6                	ld	s3,88(sp)
 318:	6a46                	ld	s4,80(sp)
 31a:	6aa6                	ld	s5,72(sp)
 31c:	6b06                	ld	s6,64(sp)
 31e:	7be2                	ld	s7,56(sp)
 320:	6129                	addi	sp,sp,192
 322:	8082                	ret
        switch (s[1])
 324:	07800713          	li	a4,120
 328:	24e79363          	bne	a5,a4,56e <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 32c:	6782                	ld	a5,0(sp)
 32e:	4394                	lw	a3,0(a5)
 330:	07a1                	addi	a5,a5,8
 332:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 334:	2606c263          	bltz	a3,598 <printf+0x492>
        buf[i--] = digits[x % base];
 338:	00001797          	auipc	a5,0x1
 33c:	cb078793          	addi	a5,a5,-848 # fe8 <digits>
 340:	00f6f713          	andi	a4,a3,15
 344:	973e                	add	a4,a4,a5
 346:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <digits+0xffffffffffff7018>
    buf[16] = 0;
 34a:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 34e:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 350:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 354:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 358:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 35c:	0046d51b          	srliw	a0,a3,0x4
 360:	0ad5d563          	bge	a1,a3,40a <printf+0x304>
        buf[i--] = digits[x % base];
 364:	8a3d                	andi	a2,a2,15
 366:	963e                	add	a2,a2,a5
 368:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 36c:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 370:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 374:	30a5fe63          	bgeu	a1,a0,690 <printf+0x58a>
        buf[i--] = digits[x % base];
 378:	00f77613          	andi	a2,a4,15
 37c:	963e                	add	a2,a2,a5
 37e:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 382:	45bd                	li	a1,15
 384:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 388:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 38c:	00475513          	srli	a0,a4,0x4
 390:	30e5f963          	bgeu	a1,a4,6a2 <printf+0x59c>
        buf[i--] = digits[x % base];
 394:	8a3d                	andi	a2,a2,15
 396:	963e                	add	a2,a2,a5
 398:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 39c:	00875893          	srli	a7,a4,0x8
 3a0:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 3a4:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 3a8:	30a5fd63          	bgeu	a1,a0,6c2 <printf+0x5bc>
        buf[i--] = digits[x % base];
 3ac:	8a3d                	andi	a2,a2,15
 3ae:	963e                	add	a2,a2,a5
 3b0:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3b4:	00c75813          	srli	a6,a4,0xc
 3b8:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 3bc:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 3c0:	3315fe63          	bgeu	a1,a7,6fc <printf+0x5f6>
        buf[i--] = digits[x % base];
 3c4:	8a3d                	andi	a2,a2,15
 3c6:	963e                	add	a2,a2,a5
 3c8:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3cc:	01075893          	srli	a7,a4,0x10
 3d0:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 3d4:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 3d8:	3305ff63          	bgeu	a1,a6,716 <printf+0x610>
        buf[i--] = digits[x % base];
 3dc:	8a3d                	andi	a2,a2,15
 3de:	963e                	add	a2,a2,a5
 3e0:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 3e4:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 3e8:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 3ec:	3515f863          	bgeu	a1,a7,73c <printf+0x636>
        buf[i--] = digits[x % base];
 3f0:	97ba                	add	a5,a5,a4
 3f2:	0007c783          	lbu	a5,0(a5)
 3f6:	45a1                	li	a1,8
 3f8:	00f10823          	sb	a5,16(sp)
    if (sign)
 3fc:	0006d763          	bgez	a3,40a <printf+0x304>
        buf[i--] = '-';
 400:	02d00793          	li	a5,45
 404:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 408:	459d                	li	a1,7
    write(f, s, l);
 40a:	4641                	li	a2,16
 40c:	003c                	addi	a5,sp,8
 40e:	9e0d                	subw	a2,a2,a1
 410:	4505                	li	a0,1
 412:	95be                	add	a1,a1,a5
 414:	1c7000ef          	jal	ra,dda <write>
        s += 2;
 418:	00248513          	addi	a0,s1,2
 41c:	b335                	j	148 <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 41e:	6782                	ld	a5,0(sp)
 420:	6380                	ld	s0,0(a5)
 422:	07a1                	addi	a5,a5,8
 424:	e03e                	sd	a5,0(sp)
 426:	22040a63          	beqz	s0,65a <printf+0x554>
            l = strnlen(a, 200);
 42a:	0c800593          	li	a1,200
 42e:	8522                	mv	a0,s0
 430:	6cc000ef          	jal	ra,afc <strnlen>
    write(f, s, l);
 434:	0005061b          	sext.w	a2,a0
 438:	85a2                	mv	a1,s0
 43a:	4505                	li	a0,1
 43c:	19f000ef          	jal	ra,dda <write>
        s += 2;
 440:	00248513          	addi	a0,s1,2
 444:	b311                	j	148 <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 446:	6782                	ld	a5,0(sp)
 448:	4390                	lw	a2,0(a5)
 44a:	07a1                	addi	a5,a5,8
 44c:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 44e:	1a064363          	bltz	a2,5f4 <printf+0x4ee>
        buf[i--] = digits[x % base];
 452:	46a9                	li	a3,10
 454:	02d6773b          	remuw	a4,a2,a3
 458:	00001797          	auipc	a5,0x1
 45c:	b9078793          	addi	a5,a5,-1136 # fe8 <digits>
    buf[16] = 0;
 460:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 464:	4525                	li	a0,9
        x = xx;
 466:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 46a:	973e                	add	a4,a4,a5
 46c:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 470:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 474:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 478:	2cc55063          	bge	a0,a2,738 <printf+0x632>
 47c:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 480:	02d5f73b          	remuw	a4,a1,a3
 484:	1702                	slli	a4,a4,0x20
 486:	9301                	srli	a4,a4,0x20
 488:	973e                	add	a4,a4,a5
 48a:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 48e:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 492:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 496:	1f057d63          	bgeu	a0,a6,690 <printf+0x58a>
        buf[i--] = digits[x % base];
 49a:	4529                	li	a0,10
    } while ((x /= base) != 0);
 49c:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 49e:	02a5f73b          	remuw	a4,a1,a0
 4a2:	973e                	add	a4,a4,a5
 4a4:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 4a8:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 4ac:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 4b0:	1ab6f163          	bgeu	a3,a1,652 <printf+0x54c>
 4b4:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 4b8:	02a776bb          	remuw	a3,a4,a0
 4bc:	96be                	add	a3,a3,a5
 4be:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4c2:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4c6:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 4ca:	20b87c63          	bgeu	a6,a1,6e2 <printf+0x5dc>
 4ce:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 4d2:	02a776bb          	remuw	a3,a4,a0
 4d6:	96be                	add	a3,a3,a5
 4d8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4dc:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4e0:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 4e4:	20b87363          	bgeu	a6,a1,6ea <printf+0x5e4>
        buf[i--] = digits[x % base];
 4e8:	02a776bb          	remuw	a3,a4,a0
 4ec:	96be                	add	a3,a3,a5
 4ee:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4f2:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4f6:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 4fa:	20b9f563          	bgeu	s3,a1,704 <printf+0x5fe>
        buf[i--] = digits[x % base];
 4fe:	02a776bb          	remuw	a3,a4,a0
 502:	96be                	add	a3,a3,a5
 504:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 508:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 50c:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 510:	20bafb63          	bgeu	s5,a1,726 <printf+0x620>
        buf[i--] = digits[x % base];
 514:	02a776bb          	remuw	a3,a4,a0
 518:	96be                	add	a3,a3,a5
 51a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 51e:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 522:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 526:	1eba7c63          	bgeu	s4,a1,71e <printf+0x618>
        buf[i--] = digits[x % base];
 52a:	02a776bb          	remuw	a3,a4,a0
 52e:	96be                	add	a3,a3,a5
 530:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 534:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 538:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 53c:	14bb7163          	bgeu	s6,a1,67e <printf+0x578>
        buf[i--] = digits[x % base];
 540:	1702                	slli	a4,a4,0x20
 542:	9301                	srli	a4,a4,0x20
 544:	97ba                	add	a5,a5,a4
 546:	0007c783          	lbu	a5,0(a5)
 54a:	4599                	li	a1,6
 54c:	00f10723          	sb	a5,14(sp)
    if (sign)
 550:	ea065de3          	bgez	a2,40a <printf+0x304>
        buf[i--] = '-';
 554:	02d00793          	li	a5,45
 558:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 55c:	4595                	li	a1,5
    write(f, s, l);
 55e:	003c                	addi	a5,sp,8
 560:	4641                	li	a2,16
 562:	9e0d                	subw	a2,a2,a1
 564:	4505                	li	a0,1
 566:	95be                	add	a1,a1,a5
 568:	073000ef          	jal	ra,dda <write>
 56c:	b575                	j	418 <printf+0x312>
    char byte = c;
 56e:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 572:	4605                	li	a2,1
 574:	002c                	addi	a1,sp,8
 576:	4505                	li	a0,1
    char byte = c;
 578:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 57c:	05f000ef          	jal	ra,dda <write>
    char byte = c;
 580:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 584:	4605                	li	a2,1
 586:	002c                	addi	a1,sp,8
 588:	4505                	li	a0,1
    char byte = c;
 58a:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 58e:	04d000ef          	jal	ra,dda <write>
        s += 2;
 592:	00248513          	addi	a0,s1,2
 596:	be4d                	j	148 <printf+0x42>
        x = -xx;
 598:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 59c:	00001797          	auipc	a5,0x1
 5a0:	a4c78793          	addi	a5,a5,-1460 # fe8 <digits>
 5a4:	00f77613          	andi	a2,a4,15
 5a8:	963e                	add	a2,a2,a5
 5aa:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 5ae:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5b2:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 5b4:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 5b8:	0047551b          	srliw	a0,a4,0x4
 5bc:	0047561b          	srliw	a2,a4,0x4
 5c0:	0ab6d263          	bge	a3,a1,664 <printf+0x55e>
        buf[i--] = digits[x % base];
 5c4:	8a3d                	andi	a2,a2,15
 5c6:	963e                	add	a2,a2,a5
 5c8:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 5cc:	463d                	li	a2,15
 5ce:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 5d2:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 5d6:	daa661e3          	bltu	a2,a0,378 <printf+0x272>
        buf[i--] = '-';
 5da:	02d00793          	li	a5,45
 5de:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 5e2:	45b5                	li	a1,13
    write(f, s, l);
 5e4:	003c                	addi	a5,sp,8
 5e6:	4641                	li	a2,16
 5e8:	9e0d                	subw	a2,a2,a1
 5ea:	4505                	li	a0,1
 5ec:	95be                	add	a1,a1,a5
 5ee:	7ec000ef          	jal	ra,dda <write>
 5f2:	b51d                	j	418 <printf+0x312>
        x = -xx;
 5f4:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 5f8:	46a9                	li	a3,10
 5fa:	02d875bb          	remuw	a1,a6,a3
 5fe:	00001797          	auipc	a5,0x1
 602:	9ea78793          	addi	a5,a5,-1558 # fe8 <digits>
    buf[16] = 0;
 606:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 60a:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 60c:	95be                	add	a1,a1,a5
 60e:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 612:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 616:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 61a:	04a65563          	bge	a2,a0,664 <printf+0x55e>
 61e:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 622:	02d775bb          	remuw	a1,a4,a3
 626:	95be                	add	a1,a1,a5
 628:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 62c:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 630:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 634:	fb0573e3          	bgeu	a0,a6,5da <printf+0x4d4>
        buf[i--] = digits[x % base];
 638:	4529                	li	a0,10
    } while ((x /= base) != 0);
 63a:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 63c:	02a5f73b          	remuw	a4,a1,a0
 640:	973e                	add	a4,a4,a5
 642:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 646:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 64a:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 64e:	e6b6e3e3          	bltu	a3,a1,4b4 <printf+0x3ae>
        buf[i--] = digits[x % base];
 652:	45b5                	li	a1,13
    if (sign)
 654:	da065be3          	bgez	a2,40a <printf+0x304>
 658:	a881                	j	6a8 <printf+0x5a2>
                a = "(null)";
 65a:	00001417          	auipc	s0,0x1
 65e:	95e40413          	addi	s0,s0,-1698 # fb8 <unlink+0x38>
 662:	b3e1                	j	42a <printf+0x324>
        buf[i--] = '-';
 664:	02d00793          	li	a5,45
 668:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 66c:	45b9                	li	a1,14
    write(f, s, l);
 66e:	003c                	addi	a5,sp,8
 670:	4641                	li	a2,16
 672:	9e0d                	subw	a2,a2,a1
 674:	4505                	li	a0,1
 676:	95be                	add	a1,a1,a5
 678:	762000ef          	jal	ra,dda <write>
 67c:	bb71                	j	418 <printf+0x312>
        buf[i--] = digits[x % base];
 67e:	459d                	li	a1,7
    if (sign)
 680:	d80655e3          	bgez	a2,40a <printf+0x304>
        buf[i--] = '-';
 684:	02d00793          	li	a5,45
 688:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 68c:	4599                	li	a1,6
 68e:	bbb5                	j	40a <printf+0x304>
 690:	45b9                	li	a1,14
    write(f, s, l);
 692:	003c                	addi	a5,sp,8
 694:	4641                	li	a2,16
 696:	9e0d                	subw	a2,a2,a1
 698:	4505                	li	a0,1
 69a:	95be                	add	a1,a1,a5
 69c:	73e000ef          	jal	ra,dda <write>
 6a0:	bba5                	j	418 <printf+0x312>
        buf[i--] = digits[x % base];
 6a2:	45b5                	li	a1,13
    if (sign)
 6a4:	d606d3e3          	bgez	a3,40a <printf+0x304>
        buf[i--] = '-';
 6a8:	02d00793          	li	a5,45
 6ac:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 6b0:	45b1                	li	a1,12
    write(f, s, l);
 6b2:	003c                	addi	a5,sp,8
 6b4:	4641                	li	a2,16
 6b6:	9e0d                	subw	a2,a2,a1
 6b8:	4505                	li	a0,1
 6ba:	95be                	add	a1,a1,a5
 6bc:	71e000ef          	jal	ra,dda <write>
 6c0:	bba1                	j	418 <printf+0x312>
        buf[i--] = digits[x % base];
 6c2:	45b1                	li	a1,12
    if (sign)
 6c4:	d406d3e3          	bgez	a3,40a <printf+0x304>
        buf[i--] = '-';
 6c8:	02d00793          	li	a5,45
 6cc:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 6d0:	45ad                	li	a1,11
    write(f, s, l);
 6d2:	003c                	addi	a5,sp,8
 6d4:	4641                	li	a2,16
 6d6:	9e0d                	subw	a2,a2,a1
 6d8:	4505                	li	a0,1
 6da:	95be                	add	a1,a1,a5
 6dc:	6fe000ef          	jal	ra,dda <write>
 6e0:	bb25                	j	418 <printf+0x312>
        buf[i--] = digits[x % base];
 6e2:	45b1                	li	a1,12
    if (sign)
 6e4:	d20653e3          	bgez	a2,40a <printf+0x304>
 6e8:	b7c5                	j	6c8 <printf+0x5c2>
        buf[i--] = digits[x % base];
 6ea:	45ad                	li	a1,11
    if (sign)
 6ec:	d0065fe3          	bgez	a2,40a <printf+0x304>
        buf[i--] = '-';
 6f0:	02d00793          	li	a5,45
 6f4:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 6f8:	45a9                	li	a1,10
 6fa:	bb01                	j	40a <printf+0x304>
 6fc:	45ad                	li	a1,11
    if (sign)
 6fe:	d006d6e3          	bgez	a3,40a <printf+0x304>
 702:	b7fd                	j	6f0 <printf+0x5ea>
        buf[i--] = digits[x % base];
 704:	45a9                	li	a1,10
    if (sign)
 706:	d00652e3          	bgez	a2,40a <printf+0x304>
        buf[i--] = '-';
 70a:	02d00793          	li	a5,45
 70e:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 712:	45a5                	li	a1,9
 714:	b9dd                	j	40a <printf+0x304>
 716:	45a9                	li	a1,10
    if (sign)
 718:	ce06d9e3          	bgez	a3,40a <printf+0x304>
 71c:	b7fd                	j	70a <printf+0x604>
        buf[i--] = digits[x % base];
 71e:	45a1                	li	a1,8
    if (sign)
 720:	ce0655e3          	bgez	a2,40a <printf+0x304>
 724:	b9f1                	j	400 <printf+0x2fa>
        buf[i--] = digits[x % base];
 726:	45a5                	li	a1,9
    if (sign)
 728:	ce0651e3          	bgez	a2,40a <printf+0x304>
        buf[i--] = '-';
 72c:	02d00793          	li	a5,45
 730:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 734:	45a1                	li	a1,8
 736:	b9d1                	j	40a <printf+0x304>
    i = 15;
 738:	45bd                	li	a1,15
 73a:	b9c1                	j	40a <printf+0x304>
        buf[i--] = digits[x % base];
 73c:	45a5                	li	a1,9
    if (sign)
 73e:	cc06d6e3          	bgez	a3,40a <printf+0x304>
 742:	b7ed                	j	72c <printf+0x626>

0000000000000744 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 744:	02000793          	li	a5,32
 748:	00f50663          	beq	a0,a5,754 <isspace+0x10>
 74c:	355d                	addiw	a0,a0,-9
 74e:	00553513          	sltiu	a0,a0,5
 752:	8082                	ret
 754:	4505                	li	a0,1
}
 756:	8082                	ret

0000000000000758 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 758:	fd05051b          	addiw	a0,a0,-48
}
 75c:	00a53513          	sltiu	a0,a0,10
 760:	8082                	ret

0000000000000762 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 762:	02000613          	li	a2,32
 766:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 768:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 76c:	ff77069b          	addiw	a3,a4,-9
 770:	04c70d63          	beq	a4,a2,7ca <atoi+0x68>
 774:	0007079b          	sext.w	a5,a4
 778:	04d5f963          	bgeu	a1,a3,7ca <atoi+0x68>
        s++;
    switch (*s)
 77c:	02b00693          	li	a3,43
 780:	04d70a63          	beq	a4,a3,7d4 <atoi+0x72>
 784:	02d00693          	li	a3,45
 788:	06d70463          	beq	a4,a3,7f0 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 78c:	fd07859b          	addiw	a1,a5,-48
 790:	4625                	li	a2,9
 792:	873e                	mv	a4,a5
 794:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 796:	4e01                	li	t3,0
    while (isdigit(*s))
 798:	04b66a63          	bltu	a2,a1,7ec <atoi+0x8a>
    int n = 0, neg = 0;
 79c:	4501                	li	a0,0
    while (isdigit(*s))
 79e:	4825                	li	a6,9
 7a0:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 7a4:	0025179b          	slliw	a5,a0,0x2
 7a8:	9d3d                	addw	a0,a0,a5
 7aa:	fd07031b          	addiw	t1,a4,-48
 7ae:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 7b2:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 7b6:	0685                	addi	a3,a3,1
 7b8:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 7bc:	0006071b          	sext.w	a4,a2
 7c0:	feb870e3          	bgeu	a6,a1,7a0 <atoi+0x3e>
    return neg ? n : -n;
 7c4:	000e0563          	beqz	t3,7ce <atoi+0x6c>
}
 7c8:	8082                	ret
        s++;
 7ca:	0505                	addi	a0,a0,1
 7cc:	bf71                	j	768 <atoi+0x6>
 7ce:	4113053b          	subw	a0,t1,a7
 7d2:	8082                	ret
    while (isdigit(*s))
 7d4:	00154783          	lbu	a5,1(a0)
 7d8:	4625                	li	a2,9
        s++;
 7da:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7de:	fd07859b          	addiw	a1,a5,-48
 7e2:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 7e6:	4e01                	li	t3,0
    while (isdigit(*s))
 7e8:	fab67ae3          	bgeu	a2,a1,79c <atoi+0x3a>
 7ec:	4501                	li	a0,0
}
 7ee:	8082                	ret
    while (isdigit(*s))
 7f0:	00154783          	lbu	a5,1(a0)
 7f4:	4625                	li	a2,9
        s++;
 7f6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7fa:	fd07859b          	addiw	a1,a5,-48
 7fe:	0007871b          	sext.w	a4,a5
 802:	feb665e3          	bltu	a2,a1,7ec <atoi+0x8a>
        neg = 1;
 806:	4e05                	li	t3,1
 808:	bf51                	j	79c <atoi+0x3a>

000000000000080a <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 80a:	16060d63          	beqz	a2,984 <memset+0x17a>
 80e:	40a007b3          	neg	a5,a0
 812:	8b9d                	andi	a5,a5,7
 814:	00778713          	addi	a4,a5,7
 818:	482d                	li	a6,11
 81a:	0ff5f593          	andi	a1,a1,255
 81e:	fff60693          	addi	a3,a2,-1
 822:	17076263          	bltu	a4,a6,986 <memset+0x17c>
 826:	16e6ea63          	bltu	a3,a4,99a <memset+0x190>
 82a:	16078563          	beqz	a5,994 <memset+0x18a>
 82e:	00b50023          	sb	a1,0(a0)
 832:	4705                	li	a4,1
 834:	00150e93          	addi	t4,a0,1
 838:	14e78c63          	beq	a5,a4,990 <memset+0x186>
 83c:	00b500a3          	sb	a1,1(a0)
 840:	4709                	li	a4,2
 842:	00250e93          	addi	t4,a0,2
 846:	14e78d63          	beq	a5,a4,9a0 <memset+0x196>
 84a:	00b50123          	sb	a1,2(a0)
 84e:	470d                	li	a4,3
 850:	00350e93          	addi	t4,a0,3
 854:	12e78b63          	beq	a5,a4,98a <memset+0x180>
 858:	00b501a3          	sb	a1,3(a0)
 85c:	4711                	li	a4,4
 85e:	00450e93          	addi	t4,a0,4
 862:	14e78163          	beq	a5,a4,9a4 <memset+0x19a>
 866:	00b50223          	sb	a1,4(a0)
 86a:	4715                	li	a4,5
 86c:	00550e93          	addi	t4,a0,5
 870:	12e78c63          	beq	a5,a4,9a8 <memset+0x19e>
 874:	00b502a3          	sb	a1,5(a0)
 878:	471d                	li	a4,7
 87a:	00650e93          	addi	t4,a0,6
 87e:	12e79763          	bne	a5,a4,9ac <memset+0x1a2>
 882:	00750e93          	addi	t4,a0,7
 886:	00b50323          	sb	a1,6(a0)
 88a:	4f1d                	li	t5,7
 88c:	00859713          	slli	a4,a1,0x8
 890:	8f4d                	or	a4,a4,a1
 892:	01059e13          	slli	t3,a1,0x10
 896:	01c76e33          	or	t3,a4,t3
 89a:	01859313          	slli	t1,a1,0x18
 89e:	006e6333          	or	t1,t3,t1
 8a2:	02059893          	slli	a7,a1,0x20
 8a6:	011368b3          	or	a7,t1,a7
 8aa:	02859813          	slli	a6,a1,0x28
 8ae:	40f60333          	sub	t1,a2,a5
 8b2:	0108e833          	or	a6,a7,a6
 8b6:	03059693          	slli	a3,a1,0x30
 8ba:	00d866b3          	or	a3,a6,a3
 8be:	03859713          	slli	a4,a1,0x38
 8c2:	97aa                	add	a5,a5,a0
 8c4:	ff837813          	andi	a6,t1,-8
 8c8:	8f55                	or	a4,a4,a3
 8ca:	00f806b3          	add	a3,a6,a5
 8ce:	e398                	sd	a4,0(a5)
 8d0:	07a1                	addi	a5,a5,8
 8d2:	fed79ee3          	bne	a5,a3,8ce <memset+0xc4>
 8d6:	ff837693          	andi	a3,t1,-8
 8da:	00de87b3          	add	a5,t4,a3
 8de:	01e6873b          	addw	a4,a3,t5
 8e2:	0ad30663          	beq	t1,a3,98e <memset+0x184>
 8e6:	00b78023          	sb	a1,0(a5)
 8ea:	0017069b          	addiw	a3,a4,1
 8ee:	08c6fb63          	bgeu	a3,a2,984 <memset+0x17a>
 8f2:	00b780a3          	sb	a1,1(a5)
 8f6:	0027069b          	addiw	a3,a4,2
 8fa:	08c6f563          	bgeu	a3,a2,984 <memset+0x17a>
 8fe:	00b78123          	sb	a1,2(a5)
 902:	0037069b          	addiw	a3,a4,3
 906:	06c6ff63          	bgeu	a3,a2,984 <memset+0x17a>
 90a:	00b781a3          	sb	a1,3(a5)
 90e:	0047069b          	addiw	a3,a4,4
 912:	06c6f963          	bgeu	a3,a2,984 <memset+0x17a>
 916:	00b78223          	sb	a1,4(a5)
 91a:	0057069b          	addiw	a3,a4,5
 91e:	06c6f363          	bgeu	a3,a2,984 <memset+0x17a>
 922:	00b782a3          	sb	a1,5(a5)
 926:	0067069b          	addiw	a3,a4,6
 92a:	04c6fd63          	bgeu	a3,a2,984 <memset+0x17a>
 92e:	00b78323          	sb	a1,6(a5)
 932:	0077069b          	addiw	a3,a4,7
 936:	04c6f763          	bgeu	a3,a2,984 <memset+0x17a>
 93a:	00b783a3          	sb	a1,7(a5)
 93e:	0087069b          	addiw	a3,a4,8
 942:	04c6f163          	bgeu	a3,a2,984 <memset+0x17a>
 946:	00b78423          	sb	a1,8(a5)
 94a:	0097069b          	addiw	a3,a4,9
 94e:	02c6fb63          	bgeu	a3,a2,984 <memset+0x17a>
 952:	00b784a3          	sb	a1,9(a5)
 956:	00a7069b          	addiw	a3,a4,10
 95a:	02c6f563          	bgeu	a3,a2,984 <memset+0x17a>
 95e:	00b78523          	sb	a1,10(a5)
 962:	00b7069b          	addiw	a3,a4,11
 966:	00c6ff63          	bgeu	a3,a2,984 <memset+0x17a>
 96a:	00b785a3          	sb	a1,11(a5)
 96e:	00c7069b          	addiw	a3,a4,12
 972:	00c6f963          	bgeu	a3,a2,984 <memset+0x17a>
 976:	00b78623          	sb	a1,12(a5)
 97a:	2735                	addiw	a4,a4,13
 97c:	00c77463          	bgeu	a4,a2,984 <memset+0x17a>
 980:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 984:	8082                	ret
 986:	472d                	li	a4,11
 988:	bd79                	j	826 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 98a:	4f0d                	li	t5,3
 98c:	b701                	j	88c <memset+0x82>
 98e:	8082                	ret
 990:	4f05                	li	t5,1
 992:	bded                	j	88c <memset+0x82>
 994:	8eaa                	mv	t4,a0
 996:	4f01                	li	t5,0
 998:	bdd5                	j	88c <memset+0x82>
 99a:	87aa                	mv	a5,a0
 99c:	4701                	li	a4,0
 99e:	b7a1                	j	8e6 <memset+0xdc>
 9a0:	4f09                	li	t5,2
 9a2:	b5ed                	j	88c <memset+0x82>
 9a4:	4f11                	li	t5,4
 9a6:	b5dd                	j	88c <memset+0x82>
 9a8:	4f15                	li	t5,5
 9aa:	b5cd                	j	88c <memset+0x82>
 9ac:	4f19                	li	t5,6
 9ae:	bdf9                	j	88c <memset+0x82>

00000000000009b0 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 9b0:	00054783          	lbu	a5,0(a0)
 9b4:	0005c703          	lbu	a4,0(a1)
 9b8:	00e79863          	bne	a5,a4,9c8 <strcmp+0x18>
 9bc:	0505                	addi	a0,a0,1
 9be:	0585                	addi	a1,a1,1
 9c0:	fbe5                	bnez	a5,9b0 <strcmp>
 9c2:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 9c4:	9d19                	subw	a0,a0,a4
 9c6:	8082                	ret
 9c8:	0007851b          	sext.w	a0,a5
 9cc:	bfe5                	j	9c4 <strcmp+0x14>

00000000000009ce <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 9ce:	ce05                	beqz	a2,a06 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9d0:	00054703          	lbu	a4,0(a0)
 9d4:	0005c783          	lbu	a5,0(a1)
 9d8:	cb0d                	beqz	a4,a0a <strncmp+0x3c>
    if (!n--)
 9da:	167d                	addi	a2,a2,-1
 9dc:	00c506b3          	add	a3,a0,a2
 9e0:	a819                	j	9f6 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9e2:	00a68e63          	beq	a3,a0,9fe <strncmp+0x30>
 9e6:	0505                	addi	a0,a0,1
 9e8:	00e79b63          	bne	a5,a4,9fe <strncmp+0x30>
 9ec:	00054703          	lbu	a4,0(a0)
 9f0:	0005c783          	lbu	a5,0(a1)
 9f4:	cb19                	beqz	a4,a0a <strncmp+0x3c>
 9f6:	0005c783          	lbu	a5,0(a1)
 9fa:	0585                	addi	a1,a1,1
 9fc:	f3fd                	bnez	a5,9e2 <strncmp+0x14>
        ;
    return *l - *r;
 9fe:	0007051b          	sext.w	a0,a4
 a02:	9d1d                	subw	a0,a0,a5
 a04:	8082                	ret
        return 0;
 a06:	4501                	li	a0,0
}
 a08:	8082                	ret
 a0a:	4501                	li	a0,0
    return *l - *r;
 a0c:	9d1d                	subw	a0,a0,a5
 a0e:	8082                	ret

0000000000000a10 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 a10:	00757793          	andi	a5,a0,7
 a14:	cf89                	beqz	a5,a2e <strlen+0x1e>
 a16:	87aa                	mv	a5,a0
 a18:	a029                	j	a22 <strlen+0x12>
 a1a:	0785                	addi	a5,a5,1
 a1c:	0077f713          	andi	a4,a5,7
 a20:	cb01                	beqz	a4,a30 <strlen+0x20>
        if (!*s)
 a22:	0007c703          	lbu	a4,0(a5)
 a26:	fb75                	bnez	a4,a1a <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 a28:	40a78533          	sub	a0,a5,a0
}
 a2c:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 a2e:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 a30:	6394                	ld	a3,0(a5)
 a32:	00000597          	auipc	a1,0x0
 a36:	59e5b583          	ld	a1,1438(a1) # fd0 <SIZE+0x4>
 a3a:	00000617          	auipc	a2,0x0
 a3e:	59e63603          	ld	a2,1438(a2) # fd8 <SIZE+0xc>
 a42:	a019                	j	a48 <strlen+0x38>
 a44:	6794                	ld	a3,8(a5)
 a46:	07a1                	addi	a5,a5,8
 a48:	00b68733          	add	a4,a3,a1
 a4c:	fff6c693          	not	a3,a3
 a50:	8f75                	and	a4,a4,a3
 a52:	8f71                	and	a4,a4,a2
 a54:	db65                	beqz	a4,a44 <strlen+0x34>
    for (; *s; s++)
 a56:	0007c703          	lbu	a4,0(a5)
 a5a:	d779                	beqz	a4,a28 <strlen+0x18>
 a5c:	0017c703          	lbu	a4,1(a5)
 a60:	0785                	addi	a5,a5,1
 a62:	d379                	beqz	a4,a28 <strlen+0x18>
 a64:	0017c703          	lbu	a4,1(a5)
 a68:	0785                	addi	a5,a5,1
 a6a:	fb6d                	bnez	a4,a5c <strlen+0x4c>
 a6c:	bf75                	j	a28 <strlen+0x18>

0000000000000a6e <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a6e:	00757713          	andi	a4,a0,7
{
 a72:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 a74:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a78:	cb19                	beqz	a4,a8e <memchr+0x20>
 a7a:	ce25                	beqz	a2,af2 <memchr+0x84>
 a7c:	0007c703          	lbu	a4,0(a5)
 a80:	04b70e63          	beq	a4,a1,adc <memchr+0x6e>
 a84:	0785                	addi	a5,a5,1
 a86:	0077f713          	andi	a4,a5,7
 a8a:	167d                	addi	a2,a2,-1
 a8c:	f77d                	bnez	a4,a7a <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 a8e:	4501                	li	a0,0
    if (n && *s != c)
 a90:	c235                	beqz	a2,af4 <memchr+0x86>
 a92:	0007c703          	lbu	a4,0(a5)
 a96:	04b70363          	beq	a4,a1,adc <memchr+0x6e>
        size_t k = ONES * c;
 a9a:	00000517          	auipc	a0,0x0
 a9e:	54653503          	ld	a0,1350(a0) # fe0 <SIZE+0x14>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 aa2:	471d                	li	a4,7
        size_t k = ONES * c;
 aa4:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 aa8:	02c77a63          	bgeu	a4,a2,adc <memchr+0x6e>
 aac:	00000897          	auipc	a7,0x0
 ab0:	5248b883          	ld	a7,1316(a7) # fd0 <SIZE+0x4>
 ab4:	00000817          	auipc	a6,0x0
 ab8:	52483803          	ld	a6,1316(a6) # fd8 <SIZE+0xc>
 abc:	431d                	li	t1,7
 abe:	a029                	j	ac8 <memchr+0x5a>
 ac0:	1661                	addi	a2,a2,-8
 ac2:	07a1                	addi	a5,a5,8
 ac4:	02c37963          	bgeu	t1,a2,af6 <memchr+0x88>
 ac8:	6398                	ld	a4,0(a5)
 aca:	8f29                	xor	a4,a4,a0
 acc:	011706b3          	add	a3,a4,a7
 ad0:	fff74713          	not	a4,a4
 ad4:	8f75                	and	a4,a4,a3
 ad6:	01077733          	and	a4,a4,a6
 ada:	d37d                	beqz	a4,ac0 <memchr+0x52>
 adc:	853e                	mv	a0,a5
 ade:	97b2                	add	a5,a5,a2
 ae0:	a021                	j	ae8 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 ae2:	0505                	addi	a0,a0,1
 ae4:	00f50763          	beq	a0,a5,af2 <memchr+0x84>
 ae8:	00054703          	lbu	a4,0(a0)
 aec:	feb71be3          	bne	a4,a1,ae2 <memchr+0x74>
 af0:	8082                	ret
    return n ? (void *)s : 0;
 af2:	4501                	li	a0,0
}
 af4:	8082                	ret
    return n ? (void *)s : 0;
 af6:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 af8:	f275                	bnez	a2,adc <memchr+0x6e>
}
 afa:	8082                	ret

0000000000000afc <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 afc:	1101                	addi	sp,sp,-32
 afe:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 b00:	862e                	mv	a2,a1
{
 b02:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 b04:	4581                	li	a1,0
{
 b06:	e426                	sd	s1,8(sp)
 b08:	ec06                	sd	ra,24(sp)
 b0a:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 b0c:	f63ff0ef          	jal	ra,a6e <memchr>
    return p ? p - s : n;
 b10:	c519                	beqz	a0,b1e <strnlen+0x22>
}
 b12:	60e2                	ld	ra,24(sp)
 b14:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 b16:	8d05                	sub	a0,a0,s1
}
 b18:	64a2                	ld	s1,8(sp)
 b1a:	6105                	addi	sp,sp,32
 b1c:	8082                	ret
 b1e:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 b20:	8522                	mv	a0,s0
}
 b22:	6442                	ld	s0,16(sp)
 b24:	64a2                	ld	s1,8(sp)
 b26:	6105                	addi	sp,sp,32
 b28:	8082                	ret

0000000000000b2a <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 b2a:	00b547b3          	xor	a5,a0,a1
 b2e:	8b9d                	andi	a5,a5,7
 b30:	eb95                	bnez	a5,b64 <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 b32:	0075f793          	andi	a5,a1,7
 b36:	e7b1                	bnez	a5,b82 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 b38:	6198                	ld	a4,0(a1)
 b3a:	00000617          	auipc	a2,0x0
 b3e:	49663603          	ld	a2,1174(a2) # fd0 <SIZE+0x4>
 b42:	00000817          	auipc	a6,0x0
 b46:	49683803          	ld	a6,1174(a6) # fd8 <SIZE+0xc>
 b4a:	a029                	j	b54 <stpcpy+0x2a>
 b4c:	e118                	sd	a4,0(a0)
 b4e:	6598                	ld	a4,8(a1)
 b50:	05a1                	addi	a1,a1,8
 b52:	0521                	addi	a0,a0,8
 b54:	00c707b3          	add	a5,a4,a2
 b58:	fff74693          	not	a3,a4
 b5c:	8ff5                	and	a5,a5,a3
 b5e:	0107f7b3          	and	a5,a5,a6
 b62:	d7ed                	beqz	a5,b4c <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 b64:	0005c783          	lbu	a5,0(a1)
 b68:	00f50023          	sb	a5,0(a0)
 b6c:	c785                	beqz	a5,b94 <stpcpy+0x6a>
 b6e:	0015c783          	lbu	a5,1(a1)
 b72:	0505                	addi	a0,a0,1
 b74:	0585                	addi	a1,a1,1
 b76:	00f50023          	sb	a5,0(a0)
 b7a:	fbf5                	bnez	a5,b6e <stpcpy+0x44>
        ;
    return d;
}
 b7c:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 b7e:	0505                	addi	a0,a0,1
 b80:	df45                	beqz	a4,b38 <stpcpy+0xe>
            if (!(*d = *s))
 b82:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 b86:	0585                	addi	a1,a1,1
 b88:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 b8c:	00f50023          	sb	a5,0(a0)
 b90:	f7fd                	bnez	a5,b7e <stpcpy+0x54>
}
 b92:	8082                	ret
 b94:	8082                	ret

0000000000000b96 <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 b96:	00b547b3          	xor	a5,a0,a1
 b9a:	8b9d                	andi	a5,a5,7
 b9c:	1a079863          	bnez	a5,d4c <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 ba0:	0075f793          	andi	a5,a1,7
 ba4:	16078463          	beqz	a5,d0c <stpncpy+0x176>
 ba8:	ea01                	bnez	a2,bb8 <stpncpy+0x22>
 baa:	a421                	j	db2 <stpncpy+0x21c>
 bac:	167d                	addi	a2,a2,-1
 bae:	0505                	addi	a0,a0,1
 bb0:	14070e63          	beqz	a4,d0c <stpncpy+0x176>
 bb4:	1a060863          	beqz	a2,d64 <stpncpy+0x1ce>
 bb8:	0005c783          	lbu	a5,0(a1)
 bbc:	0585                	addi	a1,a1,1
 bbe:	0075f713          	andi	a4,a1,7
 bc2:	00f50023          	sb	a5,0(a0)
 bc6:	f3fd                	bnez	a5,bac <stpncpy+0x16>
 bc8:	4805                	li	a6,1
 bca:	1a061863          	bnez	a2,d7a <stpncpy+0x1e4>
 bce:	40a007b3          	neg	a5,a0
 bd2:	8b9d                	andi	a5,a5,7
 bd4:	4681                	li	a3,0
 bd6:	18061a63          	bnez	a2,d6a <stpncpy+0x1d4>
 bda:	00778713          	addi	a4,a5,7
 bde:	45ad                	li	a1,11
 be0:	18b76363          	bltu	a4,a1,d66 <stpncpy+0x1d0>
 be4:	1ae6eb63          	bltu	a3,a4,d9a <stpncpy+0x204>
 be8:	1a078363          	beqz	a5,d8e <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 bec:	00050023          	sb	zero,0(a0)
 bf0:	4685                	li	a3,1
 bf2:	00150713          	addi	a4,a0,1
 bf6:	18d78f63          	beq	a5,a3,d94 <stpncpy+0x1fe>
 bfa:	000500a3          	sb	zero,1(a0)
 bfe:	4689                	li	a3,2
 c00:	00250713          	addi	a4,a0,2
 c04:	18d78e63          	beq	a5,a3,da0 <stpncpy+0x20a>
 c08:	00050123          	sb	zero,2(a0)
 c0c:	468d                	li	a3,3
 c0e:	00350713          	addi	a4,a0,3
 c12:	16d78c63          	beq	a5,a3,d8a <stpncpy+0x1f4>
 c16:	000501a3          	sb	zero,3(a0)
 c1a:	4691                	li	a3,4
 c1c:	00450713          	addi	a4,a0,4
 c20:	18d78263          	beq	a5,a3,da4 <stpncpy+0x20e>
 c24:	00050223          	sb	zero,4(a0)
 c28:	4695                	li	a3,5
 c2a:	00550713          	addi	a4,a0,5
 c2e:	16d78d63          	beq	a5,a3,da8 <stpncpy+0x212>
 c32:	000502a3          	sb	zero,5(a0)
 c36:	469d                	li	a3,7
 c38:	00650713          	addi	a4,a0,6
 c3c:	16d79863          	bne	a5,a3,dac <stpncpy+0x216>
 c40:	00750713          	addi	a4,a0,7
 c44:	00050323          	sb	zero,6(a0)
 c48:	40f80833          	sub	a6,a6,a5
 c4c:	ff887593          	andi	a1,a6,-8
 c50:	97aa                	add	a5,a5,a0
 c52:	95be                	add	a1,a1,a5
 c54:	0007b023          	sd	zero,0(a5)
 c58:	07a1                	addi	a5,a5,8
 c5a:	feb79de3          	bne	a5,a1,c54 <stpncpy+0xbe>
 c5e:	ff887593          	andi	a1,a6,-8
 c62:	9ead                	addw	a3,a3,a1
 c64:	00b707b3          	add	a5,a4,a1
 c68:	12b80863          	beq	a6,a1,d98 <stpncpy+0x202>
 c6c:	00078023          	sb	zero,0(a5)
 c70:	0016871b          	addiw	a4,a3,1
 c74:	0ec77863          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 c78:	000780a3          	sb	zero,1(a5)
 c7c:	0026871b          	addiw	a4,a3,2
 c80:	0ec77263          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 c84:	00078123          	sb	zero,2(a5)
 c88:	0036871b          	addiw	a4,a3,3
 c8c:	0cc77c63          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 c90:	000781a3          	sb	zero,3(a5)
 c94:	0046871b          	addiw	a4,a3,4
 c98:	0cc77663          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 c9c:	00078223          	sb	zero,4(a5)
 ca0:	0056871b          	addiw	a4,a3,5
 ca4:	0cc77063          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 ca8:	000782a3          	sb	zero,5(a5)
 cac:	0066871b          	addiw	a4,a3,6
 cb0:	0ac77a63          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 cb4:	00078323          	sb	zero,6(a5)
 cb8:	0076871b          	addiw	a4,a3,7
 cbc:	0ac77463          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 cc0:	000783a3          	sb	zero,7(a5)
 cc4:	0086871b          	addiw	a4,a3,8
 cc8:	08c77e63          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 ccc:	00078423          	sb	zero,8(a5)
 cd0:	0096871b          	addiw	a4,a3,9
 cd4:	08c77863          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 cd8:	000784a3          	sb	zero,9(a5)
 cdc:	00a6871b          	addiw	a4,a3,10
 ce0:	08c77263          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 ce4:	00078523          	sb	zero,10(a5)
 ce8:	00b6871b          	addiw	a4,a3,11
 cec:	06c77c63          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 cf0:	000785a3          	sb	zero,11(a5)
 cf4:	00c6871b          	addiw	a4,a3,12
 cf8:	06c77663          	bgeu	a4,a2,d64 <stpncpy+0x1ce>
 cfc:	00078623          	sb	zero,12(a5)
 d00:	26b5                	addiw	a3,a3,13
 d02:	06c6f163          	bgeu	a3,a2,d64 <stpncpy+0x1ce>
 d06:	000786a3          	sb	zero,13(a5)
 d0a:	8082                	ret
            ;
        if (!n || !*s)
 d0c:	c645                	beqz	a2,db4 <stpncpy+0x21e>
 d0e:	0005c783          	lbu	a5,0(a1)
 d12:	ea078be3          	beqz	a5,bc8 <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d16:	479d                	li	a5,7
 d18:	02c7ff63          	bgeu	a5,a2,d56 <stpncpy+0x1c0>
 d1c:	00000897          	auipc	a7,0x0
 d20:	2b48b883          	ld	a7,692(a7) # fd0 <SIZE+0x4>
 d24:	00000817          	auipc	a6,0x0
 d28:	2b483803          	ld	a6,692(a6) # fd8 <SIZE+0xc>
 d2c:	431d                	li	t1,7
 d2e:	6198                	ld	a4,0(a1)
 d30:	011707b3          	add	a5,a4,a7
 d34:	fff74693          	not	a3,a4
 d38:	8ff5                	and	a5,a5,a3
 d3a:	0107f7b3          	and	a5,a5,a6
 d3e:	ef81                	bnez	a5,d56 <stpncpy+0x1c0>
            *wd = *ws;
 d40:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d42:	1661                	addi	a2,a2,-8
 d44:	05a1                	addi	a1,a1,8
 d46:	0521                	addi	a0,a0,8
 d48:	fec363e3          	bltu	t1,a2,d2e <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 d4c:	e609                	bnez	a2,d56 <stpncpy+0x1c0>
 d4e:	a08d                	j	db0 <stpncpy+0x21a>
 d50:	167d                	addi	a2,a2,-1
 d52:	0505                	addi	a0,a0,1
 d54:	ca01                	beqz	a2,d64 <stpncpy+0x1ce>
 d56:	0005c783          	lbu	a5,0(a1)
 d5a:	0585                	addi	a1,a1,1
 d5c:	00f50023          	sb	a5,0(a0)
 d60:	fbe5                	bnez	a5,d50 <stpncpy+0x1ba>
        ;
tail:
 d62:	b59d                	j	bc8 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 d64:	8082                	ret
 d66:	472d                	li	a4,11
 d68:	bdb5                	j	be4 <stpncpy+0x4e>
 d6a:	00778713          	addi	a4,a5,7
 d6e:	45ad                	li	a1,11
 d70:	fff60693          	addi	a3,a2,-1
 d74:	e6b778e3          	bgeu	a4,a1,be4 <stpncpy+0x4e>
 d78:	b7fd                	j	d66 <stpncpy+0x1d0>
 d7a:	40a007b3          	neg	a5,a0
 d7e:	8832                	mv	a6,a2
 d80:	8b9d                	andi	a5,a5,7
 d82:	4681                	li	a3,0
 d84:	e4060be3          	beqz	a2,bda <stpncpy+0x44>
 d88:	b7cd                	j	d6a <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 d8a:	468d                	li	a3,3
 d8c:	bd75                	j	c48 <stpncpy+0xb2>
 d8e:	872a                	mv	a4,a0
 d90:	4681                	li	a3,0
 d92:	bd5d                	j	c48 <stpncpy+0xb2>
 d94:	4685                	li	a3,1
 d96:	bd4d                	j	c48 <stpncpy+0xb2>
 d98:	8082                	ret
 d9a:	87aa                	mv	a5,a0
 d9c:	4681                	li	a3,0
 d9e:	b5f9                	j	c6c <stpncpy+0xd6>
 da0:	4689                	li	a3,2
 da2:	b55d                	j	c48 <stpncpy+0xb2>
 da4:	4691                	li	a3,4
 da6:	b54d                	j	c48 <stpncpy+0xb2>
 da8:	4695                	li	a3,5
 daa:	bd79                	j	c48 <stpncpy+0xb2>
 dac:	4699                	li	a3,6
 dae:	bd69                	j	c48 <stpncpy+0xb2>
 db0:	8082                	ret
 db2:	8082                	ret
 db4:	8082                	ret

0000000000000db6 <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 db6:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 dba:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dbc:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 dc0:	2501                	sext.w	a0,a0
 dc2:	8082                	ret

0000000000000dc4 <close>:
    register long a7 __asm__("a7") = n;
 dc4:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 dc8:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 dcc:	2501                	sext.w	a0,a0
 dce:	8082                	ret

0000000000000dd0 <read>:
    register long a7 __asm__("a7") = n;
 dd0:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dd4:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 dd8:	8082                	ret

0000000000000dda <write>:
    register long a7 __asm__("a7") = n;
 dda:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dde:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 de2:	8082                	ret

0000000000000de4 <getpid>:
    register long a7 __asm__("a7") = n;
 de4:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 de8:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 dec:	2501                	sext.w	a0,a0
 dee:	8082                	ret

0000000000000df0 <sched_yield>:
    register long a7 __asm__("a7") = n;
 df0:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 df4:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 df8:	2501                	sext.w	a0,a0
 dfa:	8082                	ret

0000000000000dfc <fork>:
    register long a7 __asm__("a7") = n;
 dfc:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 e00:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 e04:	2501                	sext.w	a0,a0
 e06:	8082                	ret

0000000000000e08 <exit>:
    register long a7 __asm__("a7") = n;
 e08:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 e0c:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 e10:	8082                	ret

0000000000000e12 <waitpid>:
    register long a7 __asm__("a7") = n;
 e12:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e16:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 e1a:	2501                	sext.w	a0,a0
 e1c:	8082                	ret

0000000000000e1e <exec>:
    register long a7 __asm__("a7") = n;
 e1e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 e22:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 e26:	2501                	sext.w	a0,a0
 e28:	8082                	ret

0000000000000e2a <get_time>:

int64 get_time()
{
 e2a:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 e2c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e30:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e32:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e34:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 e38:	2501                	sext.w	a0,a0
 e3a:	ed09                	bnez	a0,e54 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e3c:	67a2                	ld	a5,8(sp)
 e3e:	3e800713          	li	a4,1000
 e42:	00015503          	lhu	a0,0(sp)
 e46:	02e7d7b3          	divu	a5,a5,a4
 e4a:	02e50533          	mul	a0,a0,a4
 e4e:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 e50:	0141                	addi	sp,sp,16
 e52:	8082                	ret
        return -1;
 e54:	557d                	li	a0,-1
 e56:	bfed                	j	e50 <get_time+0x26>

0000000000000e58 <sys_get_time>:
    register long a7 __asm__("a7") = n;
 e58:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e5c:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 e60:	2501                	sext.w	a0,a0
 e62:	8082                	ret

0000000000000e64 <sleep>:

int sleep(unsigned long long time)
{
 e64:	1141                	addi	sp,sp,-16
 e66:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 e68:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e6c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e6e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e70:	00000073          	ecall
    if (err == 0)
 e74:	2501                	sext.w	a0,a0
 e76:	e13d                	bnez	a0,edc <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e78:	6722                	ld	a4,8(sp)
 e7a:	3e800693          	li	a3,1000
 e7e:	00015783          	lhu	a5,0(sp)
 e82:	02d75733          	divu	a4,a4,a3
 e86:	02d787b3          	mul	a5,a5,a3
 e8a:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 e8c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e90:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e92:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e94:	00000073          	ecall
    if (err == 0)
 e98:	2501                	sext.w	a0,a0
 e9a:	ed15                	bnez	a0,ed6 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e9c:	6841                	lui	a6,0x10
 e9e:	963e                	add	a2,a2,a5
 ea0:	187d                	addi	a6,a6,-1
 ea2:	3e800693          	li	a3,1000
 ea6:	a819                	j	ebc <sleep+0x58>
    __asm_syscall("r"(a7))
 ea8:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 eac:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 eb0:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 eb2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 eb4:	00000073          	ecall
    if (err == 0)
 eb8:	2501                	sext.w	a0,a0
 eba:	ed11                	bnez	a0,ed6 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 ebc:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 ebe:	07c00893          	li	a7,124
 ec2:	02d7d733          	divu	a4,a5,a3
 ec6:	6782                	ld	a5,0(sp)
 ec8:	0107f7b3          	and	a5,a5,a6
 ecc:	02d787b3          	mul	a5,a5,a3
 ed0:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 ed2:	fcc7ebe3          	bltu	a5,a2,ea8 <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 ed6:	4501                	li	a0,0
 ed8:	0141                	addi	sp,sp,16
 eda:	8082                	ret
 edc:	57fd                	li	a5,-1
 ede:	b77d                	j	e8c <sleep+0x28>

0000000000000ee0 <set_priority>:
    register long a7 __asm__("a7") = n;
 ee0:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 ee4:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 ee8:	2501                	sext.w	a0,a0
 eea:	8082                	ret

0000000000000eec <mmap>:
    register long a7 __asm__("a7") = n;
 eec:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 ef0:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 ef4:	2501                	sext.w	a0,a0
 ef6:	8082                	ret

0000000000000ef8 <munmap>:
    register long a7 __asm__("a7") = n;
 ef8:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 efc:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 f00:	2501                	sext.w	a0,a0
 f02:	8082                	ret

0000000000000f04 <wait>:

int wait(int *code)
{
 f04:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f06:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 f0a:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f0c:	00000073          	ecall
    return waitpid(-1, code);
}
 f10:	2501                	sext.w	a0,a0
 f12:	8082                	ret

0000000000000f14 <spawn>:
    register long a7 __asm__("a7") = n;
 f14:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 f18:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 f1c:	2501                	sext.w	a0,a0
 f1e:	8082                	ret

0000000000000f20 <mailread>:
    register long a7 __asm__("a7") = n;
 f20:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f24:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 f28:	2501                	sext.w	a0,a0
 f2a:	8082                	ret

0000000000000f2c <mailwrite>:
    register long a7 __asm__("a7") = n;
 f2c:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f30:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 f34:	2501                	sext.w	a0,a0
 f36:	8082                	ret

0000000000000f38 <fstat>:
    register long a7 __asm__("a7") = n;
 f38:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f3c:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 f40:	2501                	sext.w	a0,a0
 f42:	8082                	ret

0000000000000f44 <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 f44:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 f46:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 f4a:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f4c:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 f50:	2501                	sext.w	a0,a0
 f52:	8082                	ret

0000000000000f54 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 f54:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 f56:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 f5a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f5c:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 f60:	2501                	sext.w	a0,a0
 f62:	8082                	ret

0000000000000f64 <link>:

int link(char *old_path, char *new_path)
{
 f64:	87aa                	mv	a5,a0
 f66:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 f68:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 f6c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 f70:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 f72:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 f76:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f78:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 f7c:	2501                	sext.w	a0,a0
 f7e:	8082                	ret

0000000000000f80 <unlink>:

int unlink(char *path)
{
 f80:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f82:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 f86:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 f8a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f8c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 f90:	2501                	sext.w	a0,a0
 f92:	8082                	ret
