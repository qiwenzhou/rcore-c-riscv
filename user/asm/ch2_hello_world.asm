
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch2_hello_world:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	01c0006f          	j	1e <__start_main>

0000000000000006 <main>:
/// 正确输出：
/// Hello world from user mode program!
/// Test hello_world OK!

int main(void)
{
   6:	1141                	addi	sp,sp,-16
    puts("Hello world from user mode program!\nTest hello_world OK!");
   8:	00001517          	auipc	a0,0x1
   c:	f3850513          	addi	a0,a0,-200 # f40 <unlink+0x16>
{
  10:	e406                	sd	ra,8(sp)
    puts("Hello world from user mode program!\nTest hello_world OK!");
  12:	05c000ef          	jal	ra,6e <puts>
    return 0;
  16:	60a2                	ld	ra,8(sp)
  18:	4501                	li	a0,0
  1a:	0141                	addi	sp,sp,16
  1c:	8082                	ret

000000000000001e <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  1e:	1141                	addi	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
    exit(main());
  22:	fe5ff0ef          	jal	ra,6 <main>
  26:	58d000ef          	jal	ra,db2 <exit>
    return 0;
}
  2a:	60a2                	ld	ra,8(sp)
  2c:	4501                	li	a0,0
  2e:	0141                	addi	sp,sp,16
  30:	8082                	ret

0000000000000032 <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  32:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  34:	00f10593          	addi	a1,sp,15
  38:	4605                	li	a2,1
  3a:	4501                	li	a0,0
{
  3c:	ec06                	sd	ra,24(sp)
    char byte = 0;
  3e:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  42:	539000ef          	jal	ra,d7a <read>
    return byte;
}
  46:	60e2                	ld	ra,24(sp)
  48:	00f14503          	lbu	a0,15(sp)
  4c:	6105                	addi	sp,sp,32
  4e:	8082                	ret

0000000000000050 <putchar>:

int putchar(int c)
{
  50:	1101                	addi	sp,sp,-32
  52:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  54:	00f10593          	addi	a1,sp,15
  58:	4605                	li	a2,1
  5a:	4505                	li	a0,1
{
  5c:	ec06                	sd	ra,24(sp)
    char byte = c;
  5e:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  62:	523000ef          	jal	ra,d84 <write>
}
  66:	60e2                	ld	ra,24(sp)
  68:	2501                	sext.w	a0,a0
  6a:	6105                	addi	sp,sp,32
  6c:	8082                	ret

000000000000006e <puts>:

int puts(const char *s)
{
  6e:	1101                	addi	sp,sp,-32
  70:	e822                	sd	s0,16(sp)
  72:	ec06                	sd	ra,24(sp)
  74:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
  76:	145000ef          	jal	ra,9ba <strlen>
  7a:	862a                	mv	a2,a0
  7c:	85a2                	mv	a1,s0
  7e:	4505                	li	a0,1
  80:	505000ef          	jal	ra,d84 <write>
  84:	00055763          	bgez	a0,92 <puts+0x24>
    return r;
}
  88:	60e2                	ld	ra,24(sp)
  8a:	6442                	ld	s0,16(sp)
  8c:	557d                	li	a0,-1
  8e:	6105                	addi	sp,sp,32
  90:	8082                	ret
    return write(stdout, &byte, 1);
  92:	00f10593          	addi	a1,sp,15
    char byte = c;
  96:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
  98:	4605                	li	a2,1
  9a:	4505                	li	a0,1
    char byte = c;
  9c:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  a0:	4e5000ef          	jal	ra,d84 <write>
}
  a4:	60e2                	ld	ra,24(sp)
  a6:	6442                	ld	s0,16(sp)
  a8:	41f5551b          	sraiw	a0,a0,0x1f
  ac:	6105                	addi	sp,sp,32
  ae:	8082                	ret

00000000000000b0 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
  b0:	7131                	addi	sp,sp,-192
  b2:	ecce                	sd	s3,88(sp)
  b4:	e8d2                	sd	s4,80(sp)
  b6:	e4d6                	sd	s5,72(sp)
  b8:	e0da                	sd	s6,64(sp)
  ba:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
  bc:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
  be:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
  c0:	6ae1                	lui	s5,0x18
  c2:	000f4a37          	lui	s4,0xf4
  c6:	00989b37          	lui	s6,0x989
{
  ca:	fc86                	sd	ra,120(sp)
  cc:	f8a2                	sd	s0,112(sp)
  ce:	f4a6                	sd	s1,104(sp)
  d0:	f0ca                	sd	s2,96(sp)
  d2:	fc5e                	sd	s7,56(sp)
  d4:	e52e                	sd	a1,136(sp)
  d6:	e932                	sd	a2,144(sp)
  d8:	ed36                	sd	a3,152(sp)
  da:	f13a                	sd	a4,160(sp)
  dc:	f942                	sd	a6,176(sp)
  de:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
  e0:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
  e2:	70f98993          	addi	s3,s3,1807 # 270f <digits+0x176f>
  e6:	69fa8a93          	addi	s5,s5,1695 # 1869f <digits+0x176ff>
  ea:	23fa0a13          	addi	s4,s4,575 # f423f <digits+0xf329f>
  ee:	67fb0b13          	addi	s6,s6,1663 # 98967f <digits+0x9886df>
    for (;;)
    {
        if (!*s)
  f2:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
  f6:	02500913          	li	s2,37
        if (!*s)
  fa:	1a078f63          	beqz	a5,2b8 <printf+0x208>
  fe:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 100:	17278e63          	beq	a5,s2,27c <printf+0x1cc>
 104:	00164783          	lbu	a5,1(a2)
 108:	0605                	addi	a2,a2,1
 10a:	fbfd                	bnez	a5,100 <printf+0x50>
 10c:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 10e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 112:	85aa                	mv	a1,a0
 114:	8622                	mv	a2,s0
 116:	4505                	li	a0,1
 118:	46d000ef          	jal	ra,d84 <write>
        out(f, a, l);
        if (l)
 11c:	18041963          	bnez	s0,2ae <printf+0x1fe>
            continue;
        if (s[1] == 0)
 120:	0014c783          	lbu	a5,1(s1)
 124:	18078a63          	beqz	a5,2b8 <printf+0x208>
            break;
        switch (s[1])
 128:	07300713          	li	a4,115
 12c:	28e78e63          	beq	a5,a4,3c8 <printf+0x318>
 130:	18f76f63          	bltu	a4,a5,2ce <printf+0x21e>
 134:	06400713          	li	a4,100
 138:	2ae78c63          	beq	a5,a4,3f0 <printf+0x340>
 13c:	07000713          	li	a4,112
 140:	3ce79c63          	bne	a5,a4,518 <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 144:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 146:	00001797          	auipc	a5,0x1
 14a:	e5a78793          	addi	a5,a5,-422 # fa0 <digits>
            printptr(va_arg(ap, uint64));
 14e:	6298                	ld	a4,0(a3)
 150:	00868093          	addi	ra,a3,8
 154:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 156:	00471293          	slli	t0,a4,0x4
 15a:	00c71f13          	slli	t5,a4,0xc
 15e:	01471e13          	slli	t3,a4,0x14
 162:	01c71893          	slli	a7,a4,0x1c
 166:	02471813          	slli	a6,a4,0x24
 16a:	02871513          	slli	a0,a4,0x28
 16e:	02c71593          	slli	a1,a4,0x2c
 172:	03071693          	slli	a3,a4,0x30
 176:	00871f93          	slli	t6,a4,0x8
 17a:	01071e93          	slli	t4,a4,0x10
 17e:	01871313          	slli	t1,a4,0x18
 182:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 186:	03c2d293          	srli	t0,t0,0x3c
 18a:	03cf5f13          	srli	t5,t5,0x3c
 18e:	03ce5e13          	srli	t3,t3,0x3c
 192:	03c8d893          	srli	a7,a7,0x3c
 196:	03c85813          	srli	a6,a6,0x3c
 19a:	9171                	srli	a0,a0,0x3c
 19c:	91f1                	srli	a1,a1,0x3c
 19e:	92f1                	srli	a3,a3,0x3c
 1a0:	92be                	add	t0,t0,a5
 1a2:	9f3e                	add	t5,t5,a5
 1a4:	9e3e                	add	t3,t3,a5
 1a6:	98be                	add	a7,a7,a5
 1a8:	983e                	add	a6,a6,a5
 1aa:	953e                	add	a0,a0,a5
 1ac:	95be                	add	a1,a1,a5
 1ae:	96be                	add	a3,a3,a5
 1b0:	03c75393          	srli	t2,a4,0x3c
 1b4:	01c75b9b          	srliw	s7,a4,0x1c
 1b8:	03cfdf93          	srli	t6,t6,0x3c
 1bc:	03cede93          	srli	t4,t4,0x3c
 1c0:	03c35313          	srli	t1,t1,0x3c
 1c4:	9271                	srli	a2,a2,0x3c
 1c6:	0002c403          	lbu	s0,0(t0)
 1ca:	93be                	add	t2,t2,a5
 1cc:	000f4283          	lbu	t0,0(t5)
 1d0:	9fbe                	add	t6,t6,a5
 1d2:	000e4f03          	lbu	t5,0(t3)
 1d6:	9ebe                	add	t4,t4,a5
 1d8:	0008ce03          	lbu	t3,0(a7)
 1dc:	933e                	add	t1,t1,a5
 1de:	00084883          	lbu	a7,0(a6)
 1e2:	9bbe                	add	s7,s7,a5
 1e4:	00054803          	lbu	a6,0(a0)
 1e8:	963e                	add	a2,a2,a5
 1ea:	0005c503          	lbu	a0,0(a1)
 1ee:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 1f2:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1f6:	0003c903          	lbu	s2,0(t2)
 1fa:	00064603          	lbu	a2,0(a2)
 1fe:	000fc383          	lbu	t2,0(t6)
 202:	8b3d                	andi	a4,a4,15
 204:	000ecf83          	lbu	t6,0(t4)
 208:	92f1                	srli	a3,a3,0x3c
 20a:	00034e83          	lbu	t4,0(t1)
 20e:	000bc303          	lbu	t1,0(s7)
 212:	96be                	add	a3,a3,a5
 214:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 216:	7761                	lui	a4,0xffff8
 218:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 21c:	00710623          	sb	t2,12(sp)
 220:	005106a3          	sb	t0,13(sp)
 224:	01f10723          	sb	t6,14(sp)
 228:	01e107a3          	sb	t5,15(sp)
 22c:	01d10823          	sb	t4,16(sp)
 230:	01c108a3          	sb	t3,17(sp)
 234:	00610923          	sb	t1,18(sp)
 238:	011109a3          	sb	a7,19(sp)
 23c:	01010a23          	sb	a6,20(sp)
 240:	00a10aa3          	sb	a0,21(sp)
 244:	00b10b23          	sb	a1,22(sp)
 248:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 24c:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 250:	01210523          	sb	s2,10(sp)
 254:	008105a3          	sb	s0,11(sp)
 258:	0006c703          	lbu	a4,0(a3)
 25c:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 260:	4649                	li	a2,18
 262:	002c                	addi	a1,sp,8
 264:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 266:	00e10c23          	sb	a4,24(sp)
 26a:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 26e:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 272:	313000ef          	jal	ra,d84 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 276:	00248513          	addi	a0,s1,2
 27a:	bda5                	j	f2 <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 27c:	00064783          	lbu	a5,0(a2)
 280:	84b2                	mv	s1,a2
 282:	01278963          	beq	a5,s2,294 <printf+0x1e4>
 286:	b561                	j	10e <printf+0x5e>
 288:	0024c783          	lbu	a5,2(s1)
 28c:	0605                	addi	a2,a2,1
 28e:	0489                	addi	s1,s1,2
 290:	e7279fe3          	bne	a5,s2,10e <printf+0x5e>
 294:	0014c783          	lbu	a5,1(s1)
 298:	ff2788e3          	beq	a5,s2,288 <printf+0x1d8>
        l = z - a;
 29c:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 2a0:	85aa                	mv	a1,a0
 2a2:	8622                	mv	a2,s0
 2a4:	4505                	li	a0,1
 2a6:	2df000ef          	jal	ra,d84 <write>
        if (l)
 2aa:	e6040be3          	beqz	s0,120 <printf+0x70>
 2ae:	8526                	mv	a0,s1
        if (!*s)
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	e40795e3          	bnez	a5,fe <printf+0x4e>
    }
    va_end(ap);
 2b8:	70e6                	ld	ra,120(sp)
 2ba:	7446                	ld	s0,112(sp)
 2bc:	74a6                	ld	s1,104(sp)
 2be:	7906                	ld	s2,96(sp)
 2c0:	69e6                	ld	s3,88(sp)
 2c2:	6a46                	ld	s4,80(sp)
 2c4:	6aa6                	ld	s5,72(sp)
 2c6:	6b06                	ld	s6,64(sp)
 2c8:	7be2                	ld	s7,56(sp)
 2ca:	6129                	addi	sp,sp,192
 2cc:	8082                	ret
        switch (s[1])
 2ce:	07800713          	li	a4,120
 2d2:	24e79363          	bne	a5,a4,518 <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 2d6:	6782                	ld	a5,0(sp)
 2d8:	4394                	lw	a3,0(a5)
 2da:	07a1                	addi	a5,a5,8
 2dc:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 2de:	2606c263          	bltz	a3,542 <printf+0x492>
        buf[i--] = digits[x % base];
 2e2:	00001797          	auipc	a5,0x1
 2e6:	cbe78793          	addi	a5,a5,-834 # fa0 <digits>
 2ea:	00f6f713          	andi	a4,a3,15
 2ee:	973e                	add	a4,a4,a5
 2f0:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <digits+0xffffffffffff7060>
    buf[16] = 0;
 2f4:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 2f8:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 2fa:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 2fe:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 302:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 306:	0046d51b          	srliw	a0,a3,0x4
 30a:	0ad5d563          	bge	a1,a3,3b4 <printf+0x304>
        buf[i--] = digits[x % base];
 30e:	8a3d                	andi	a2,a2,15
 310:	963e                	add	a2,a2,a5
 312:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 316:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 31a:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 31e:	30a5fe63          	bgeu	a1,a0,63a <printf+0x58a>
        buf[i--] = digits[x % base];
 322:	00f77613          	andi	a2,a4,15
 326:	963e                	add	a2,a2,a5
 328:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 32c:	45bd                	li	a1,15
 32e:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 332:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 336:	00475513          	srli	a0,a4,0x4
 33a:	30e5f963          	bgeu	a1,a4,64c <printf+0x59c>
        buf[i--] = digits[x % base];
 33e:	8a3d                	andi	a2,a2,15
 340:	963e                	add	a2,a2,a5
 342:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 346:	00875893          	srli	a7,a4,0x8
 34a:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 34e:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 352:	30a5fd63          	bgeu	a1,a0,66c <printf+0x5bc>
        buf[i--] = digits[x % base];
 356:	8a3d                	andi	a2,a2,15
 358:	963e                	add	a2,a2,a5
 35a:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 35e:	00c75813          	srli	a6,a4,0xc
 362:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 366:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 36a:	3315fe63          	bgeu	a1,a7,6a6 <printf+0x5f6>
        buf[i--] = digits[x % base];
 36e:	8a3d                	andi	a2,a2,15
 370:	963e                	add	a2,a2,a5
 372:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 376:	01075893          	srli	a7,a4,0x10
 37a:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 37e:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 382:	3305ff63          	bgeu	a1,a6,6c0 <printf+0x610>
        buf[i--] = digits[x % base];
 386:	8a3d                	andi	a2,a2,15
 388:	963e                	add	a2,a2,a5
 38a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 38e:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 392:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 396:	3515f863          	bgeu	a1,a7,6e6 <printf+0x636>
        buf[i--] = digits[x % base];
 39a:	97ba                	add	a5,a5,a4
 39c:	0007c783          	lbu	a5,0(a5)
 3a0:	45a1                	li	a1,8
 3a2:	00f10823          	sb	a5,16(sp)
    if (sign)
 3a6:	0006d763          	bgez	a3,3b4 <printf+0x304>
        buf[i--] = '-';
 3aa:	02d00793          	li	a5,45
 3ae:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 3b2:	459d                	li	a1,7
    write(f, s, l);
 3b4:	4641                	li	a2,16
 3b6:	003c                	addi	a5,sp,8
 3b8:	9e0d                	subw	a2,a2,a1
 3ba:	4505                	li	a0,1
 3bc:	95be                	add	a1,a1,a5
 3be:	1c7000ef          	jal	ra,d84 <write>
        s += 2;
 3c2:	00248513          	addi	a0,s1,2
 3c6:	b335                	j	f2 <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 3c8:	6782                	ld	a5,0(sp)
 3ca:	6380                	ld	s0,0(a5)
 3cc:	07a1                	addi	a5,a5,8
 3ce:	e03e                	sd	a5,0(sp)
 3d0:	22040a63          	beqz	s0,604 <printf+0x554>
            l = strnlen(a, 200);
 3d4:	0c800593          	li	a1,200
 3d8:	8522                	mv	a0,s0
 3da:	6cc000ef          	jal	ra,aa6 <strnlen>
    write(f, s, l);
 3de:	0005061b          	sext.w	a2,a0
 3e2:	85a2                	mv	a1,s0
 3e4:	4505                	li	a0,1
 3e6:	19f000ef          	jal	ra,d84 <write>
        s += 2;
 3ea:	00248513          	addi	a0,s1,2
 3ee:	b311                	j	f2 <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 3f0:	6782                	ld	a5,0(sp)
 3f2:	4390                	lw	a2,0(a5)
 3f4:	07a1                	addi	a5,a5,8
 3f6:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 3f8:	1a064363          	bltz	a2,59e <printf+0x4ee>
        buf[i--] = digits[x % base];
 3fc:	46a9                	li	a3,10
 3fe:	02d6773b          	remuw	a4,a2,a3
 402:	00001797          	auipc	a5,0x1
 406:	b9e78793          	addi	a5,a5,-1122 # fa0 <digits>
    buf[16] = 0;
 40a:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 40e:	4525                	li	a0,9
        x = xx;
 410:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 414:	973e                	add	a4,a4,a5
 416:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 41a:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 41e:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 422:	2cc55063          	bge	a0,a2,6e2 <printf+0x632>
 426:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 42a:	02d5f73b          	remuw	a4,a1,a3
 42e:	1702                	slli	a4,a4,0x20
 430:	9301                	srli	a4,a4,0x20
 432:	973e                	add	a4,a4,a5
 434:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 438:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 43c:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 440:	1f057d63          	bgeu	a0,a6,63a <printf+0x58a>
        buf[i--] = digits[x % base];
 444:	4529                	li	a0,10
    } while ((x /= base) != 0);
 446:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 448:	02a5f73b          	remuw	a4,a1,a0
 44c:	973e                	add	a4,a4,a5
 44e:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 452:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 456:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 45a:	1ab6f163          	bgeu	a3,a1,5fc <printf+0x54c>
 45e:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 462:	02a776bb          	remuw	a3,a4,a0
 466:	96be                	add	a3,a3,a5
 468:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 46c:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 470:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 474:	20b87c63          	bgeu	a6,a1,68c <printf+0x5dc>
 478:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 47c:	02a776bb          	remuw	a3,a4,a0
 480:	96be                	add	a3,a3,a5
 482:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 486:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 48a:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 48e:	20b87363          	bgeu	a6,a1,694 <printf+0x5e4>
        buf[i--] = digits[x % base];
 492:	02a776bb          	remuw	a3,a4,a0
 496:	96be                	add	a3,a3,a5
 498:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 49c:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4a0:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 4a4:	20b9f563          	bgeu	s3,a1,6ae <printf+0x5fe>
        buf[i--] = digits[x % base];
 4a8:	02a776bb          	remuw	a3,a4,a0
 4ac:	96be                	add	a3,a3,a5
 4ae:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4b2:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4b6:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 4ba:	20bafb63          	bgeu	s5,a1,6d0 <printf+0x620>
        buf[i--] = digits[x % base];
 4be:	02a776bb          	remuw	a3,a4,a0
 4c2:	96be                	add	a3,a3,a5
 4c4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4c8:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4cc:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 4d0:	1eba7c63          	bgeu	s4,a1,6c8 <printf+0x618>
        buf[i--] = digits[x % base];
 4d4:	02a776bb          	remuw	a3,a4,a0
 4d8:	96be                	add	a3,a3,a5
 4da:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4de:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4e2:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 4e6:	14bb7163          	bgeu	s6,a1,628 <printf+0x578>
        buf[i--] = digits[x % base];
 4ea:	1702                	slli	a4,a4,0x20
 4ec:	9301                	srli	a4,a4,0x20
 4ee:	97ba                	add	a5,a5,a4
 4f0:	0007c783          	lbu	a5,0(a5)
 4f4:	4599                	li	a1,6
 4f6:	00f10723          	sb	a5,14(sp)
    if (sign)
 4fa:	ea065de3          	bgez	a2,3b4 <printf+0x304>
        buf[i--] = '-';
 4fe:	02d00793          	li	a5,45
 502:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 506:	4595                	li	a1,5
    write(f, s, l);
 508:	003c                	addi	a5,sp,8
 50a:	4641                	li	a2,16
 50c:	9e0d                	subw	a2,a2,a1
 50e:	4505                	li	a0,1
 510:	95be                	add	a1,a1,a5
 512:	073000ef          	jal	ra,d84 <write>
 516:	b575                	j	3c2 <printf+0x312>
    char byte = c;
 518:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 51c:	4605                	li	a2,1
 51e:	002c                	addi	a1,sp,8
 520:	4505                	li	a0,1
    char byte = c;
 522:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 526:	05f000ef          	jal	ra,d84 <write>
    char byte = c;
 52a:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 52e:	4605                	li	a2,1
 530:	002c                	addi	a1,sp,8
 532:	4505                	li	a0,1
    char byte = c;
 534:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 538:	04d000ef          	jal	ra,d84 <write>
        s += 2;
 53c:	00248513          	addi	a0,s1,2
 540:	be4d                	j	f2 <printf+0x42>
        x = -xx;
 542:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 546:	00001797          	auipc	a5,0x1
 54a:	a5a78793          	addi	a5,a5,-1446 # fa0 <digits>
 54e:	00f77613          	andi	a2,a4,15
 552:	963e                	add	a2,a2,a5
 554:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 558:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 55c:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 55e:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 562:	0047551b          	srliw	a0,a4,0x4
 566:	0047561b          	srliw	a2,a4,0x4
 56a:	0ab6d263          	bge	a3,a1,60e <printf+0x55e>
        buf[i--] = digits[x % base];
 56e:	8a3d                	andi	a2,a2,15
 570:	963e                	add	a2,a2,a5
 572:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 576:	463d                	li	a2,15
 578:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 57c:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 580:	daa661e3          	bltu	a2,a0,322 <printf+0x272>
        buf[i--] = '-';
 584:	02d00793          	li	a5,45
 588:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 58c:	45b5                	li	a1,13
    write(f, s, l);
 58e:	003c                	addi	a5,sp,8
 590:	4641                	li	a2,16
 592:	9e0d                	subw	a2,a2,a1
 594:	4505                	li	a0,1
 596:	95be                	add	a1,a1,a5
 598:	7ec000ef          	jal	ra,d84 <write>
 59c:	b51d                	j	3c2 <printf+0x312>
        x = -xx;
 59e:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 5a2:	46a9                	li	a3,10
 5a4:	02d875bb          	remuw	a1,a6,a3
 5a8:	00001797          	auipc	a5,0x1
 5ac:	9f878793          	addi	a5,a5,-1544 # fa0 <digits>
    buf[16] = 0;
 5b0:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5b4:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 5b6:	95be                	add	a1,a1,a5
 5b8:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 5bc:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 5c0:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 5c4:	04a65563          	bge	a2,a0,60e <printf+0x55e>
 5c8:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 5cc:	02d775bb          	remuw	a1,a4,a3
 5d0:	95be                	add	a1,a1,a5
 5d2:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 5d6:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 5da:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 5de:	fb0573e3          	bgeu	a0,a6,584 <printf+0x4d4>
        buf[i--] = digits[x % base];
 5e2:	4529                	li	a0,10
    } while ((x /= base) != 0);
 5e4:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 5e6:	02a5f73b          	remuw	a4,a1,a0
 5ea:	973e                	add	a4,a4,a5
 5ec:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 5f0:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 5f4:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 5f8:	e6b6e3e3          	bltu	a3,a1,45e <printf+0x3ae>
        buf[i--] = digits[x % base];
 5fc:	45b5                	li	a1,13
    if (sign)
 5fe:	da065be3          	bgez	a2,3b4 <printf+0x304>
 602:	a881                	j	652 <printf+0x5a2>
                a = "(null)";
 604:	00001417          	auipc	s0,0x1
 608:	97c40413          	addi	s0,s0,-1668 # f80 <unlink+0x56>
 60c:	b3e1                	j	3d4 <printf+0x324>
        buf[i--] = '-';
 60e:	02d00793          	li	a5,45
 612:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 616:	45b9                	li	a1,14
    write(f, s, l);
 618:	003c                	addi	a5,sp,8
 61a:	4641                	li	a2,16
 61c:	9e0d                	subw	a2,a2,a1
 61e:	4505                	li	a0,1
 620:	95be                	add	a1,a1,a5
 622:	762000ef          	jal	ra,d84 <write>
 626:	bb71                	j	3c2 <printf+0x312>
        buf[i--] = digits[x % base];
 628:	459d                	li	a1,7
    if (sign)
 62a:	d80655e3          	bgez	a2,3b4 <printf+0x304>
        buf[i--] = '-';
 62e:	02d00793          	li	a5,45
 632:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 636:	4599                	li	a1,6
 638:	bbb5                	j	3b4 <printf+0x304>
 63a:	45b9                	li	a1,14
    write(f, s, l);
 63c:	003c                	addi	a5,sp,8
 63e:	4641                	li	a2,16
 640:	9e0d                	subw	a2,a2,a1
 642:	4505                	li	a0,1
 644:	95be                	add	a1,a1,a5
 646:	73e000ef          	jal	ra,d84 <write>
 64a:	bba5                	j	3c2 <printf+0x312>
        buf[i--] = digits[x % base];
 64c:	45b5                	li	a1,13
    if (sign)
 64e:	d606d3e3          	bgez	a3,3b4 <printf+0x304>
        buf[i--] = '-';
 652:	02d00793          	li	a5,45
 656:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 65a:	45b1                	li	a1,12
    write(f, s, l);
 65c:	003c                	addi	a5,sp,8
 65e:	4641                	li	a2,16
 660:	9e0d                	subw	a2,a2,a1
 662:	4505                	li	a0,1
 664:	95be                	add	a1,a1,a5
 666:	71e000ef          	jal	ra,d84 <write>
 66a:	bba1                	j	3c2 <printf+0x312>
        buf[i--] = digits[x % base];
 66c:	45b1                	li	a1,12
    if (sign)
 66e:	d406d3e3          	bgez	a3,3b4 <printf+0x304>
        buf[i--] = '-';
 672:	02d00793          	li	a5,45
 676:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 67a:	45ad                	li	a1,11
    write(f, s, l);
 67c:	003c                	addi	a5,sp,8
 67e:	4641                	li	a2,16
 680:	9e0d                	subw	a2,a2,a1
 682:	4505                	li	a0,1
 684:	95be                	add	a1,a1,a5
 686:	6fe000ef          	jal	ra,d84 <write>
 68a:	bb25                	j	3c2 <printf+0x312>
        buf[i--] = digits[x % base];
 68c:	45b1                	li	a1,12
    if (sign)
 68e:	d20653e3          	bgez	a2,3b4 <printf+0x304>
 692:	b7c5                	j	672 <printf+0x5c2>
        buf[i--] = digits[x % base];
 694:	45ad                	li	a1,11
    if (sign)
 696:	d0065fe3          	bgez	a2,3b4 <printf+0x304>
        buf[i--] = '-';
 69a:	02d00793          	li	a5,45
 69e:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 6a2:	45a9                	li	a1,10
 6a4:	bb01                	j	3b4 <printf+0x304>
 6a6:	45ad                	li	a1,11
    if (sign)
 6a8:	d006d6e3          	bgez	a3,3b4 <printf+0x304>
 6ac:	b7fd                	j	69a <printf+0x5ea>
        buf[i--] = digits[x % base];
 6ae:	45a9                	li	a1,10
    if (sign)
 6b0:	d00652e3          	bgez	a2,3b4 <printf+0x304>
        buf[i--] = '-';
 6b4:	02d00793          	li	a5,45
 6b8:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 6bc:	45a5                	li	a1,9
 6be:	b9dd                	j	3b4 <printf+0x304>
 6c0:	45a9                	li	a1,10
    if (sign)
 6c2:	ce06d9e3          	bgez	a3,3b4 <printf+0x304>
 6c6:	b7fd                	j	6b4 <printf+0x604>
        buf[i--] = digits[x % base];
 6c8:	45a1                	li	a1,8
    if (sign)
 6ca:	ce0655e3          	bgez	a2,3b4 <printf+0x304>
 6ce:	b9f1                	j	3aa <printf+0x2fa>
        buf[i--] = digits[x % base];
 6d0:	45a5                	li	a1,9
    if (sign)
 6d2:	ce0651e3          	bgez	a2,3b4 <printf+0x304>
        buf[i--] = '-';
 6d6:	02d00793          	li	a5,45
 6da:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 6de:	45a1                	li	a1,8
 6e0:	b9d1                	j	3b4 <printf+0x304>
    i = 15;
 6e2:	45bd                	li	a1,15
 6e4:	b9c1                	j	3b4 <printf+0x304>
        buf[i--] = digits[x % base];
 6e6:	45a5                	li	a1,9
    if (sign)
 6e8:	cc06d6e3          	bgez	a3,3b4 <printf+0x304>
 6ec:	b7ed                	j	6d6 <printf+0x626>

00000000000006ee <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 6ee:	02000793          	li	a5,32
 6f2:	00f50663          	beq	a0,a5,6fe <isspace+0x10>
 6f6:	355d                	addiw	a0,a0,-9
 6f8:	00553513          	sltiu	a0,a0,5
 6fc:	8082                	ret
 6fe:	4505                	li	a0,1
}
 700:	8082                	ret

0000000000000702 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 702:	fd05051b          	addiw	a0,a0,-48
}
 706:	00a53513          	sltiu	a0,a0,10
 70a:	8082                	ret

000000000000070c <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 70c:	02000613          	li	a2,32
 710:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 712:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 716:	ff77069b          	addiw	a3,a4,-9
 71a:	04c70d63          	beq	a4,a2,774 <atoi+0x68>
 71e:	0007079b          	sext.w	a5,a4
 722:	04d5f963          	bgeu	a1,a3,774 <atoi+0x68>
        s++;
    switch (*s)
 726:	02b00693          	li	a3,43
 72a:	04d70a63          	beq	a4,a3,77e <atoi+0x72>
 72e:	02d00693          	li	a3,45
 732:	06d70463          	beq	a4,a3,79a <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 736:	fd07859b          	addiw	a1,a5,-48
 73a:	4625                	li	a2,9
 73c:	873e                	mv	a4,a5
 73e:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 740:	4e01                	li	t3,0
    while (isdigit(*s))
 742:	04b66a63          	bltu	a2,a1,796 <atoi+0x8a>
    int n = 0, neg = 0;
 746:	4501                	li	a0,0
    while (isdigit(*s))
 748:	4825                	li	a6,9
 74a:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 74e:	0025179b          	slliw	a5,a0,0x2
 752:	9d3d                	addw	a0,a0,a5
 754:	fd07031b          	addiw	t1,a4,-48
 758:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 75c:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 760:	0685                	addi	a3,a3,1
 762:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 766:	0006071b          	sext.w	a4,a2
 76a:	feb870e3          	bgeu	a6,a1,74a <atoi+0x3e>
    return neg ? n : -n;
 76e:	000e0563          	beqz	t3,778 <atoi+0x6c>
}
 772:	8082                	ret
        s++;
 774:	0505                	addi	a0,a0,1
 776:	bf71                	j	712 <atoi+0x6>
 778:	4113053b          	subw	a0,t1,a7
 77c:	8082                	ret
    while (isdigit(*s))
 77e:	00154783          	lbu	a5,1(a0)
 782:	4625                	li	a2,9
        s++;
 784:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 788:	fd07859b          	addiw	a1,a5,-48
 78c:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 790:	4e01                	li	t3,0
    while (isdigit(*s))
 792:	fab67ae3          	bgeu	a2,a1,746 <atoi+0x3a>
 796:	4501                	li	a0,0
}
 798:	8082                	ret
    while (isdigit(*s))
 79a:	00154783          	lbu	a5,1(a0)
 79e:	4625                	li	a2,9
        s++;
 7a0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7a4:	fd07859b          	addiw	a1,a5,-48
 7a8:	0007871b          	sext.w	a4,a5
 7ac:	feb665e3          	bltu	a2,a1,796 <atoi+0x8a>
        neg = 1;
 7b0:	4e05                	li	t3,1
 7b2:	bf51                	j	746 <atoi+0x3a>

00000000000007b4 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 7b4:	16060d63          	beqz	a2,92e <memset+0x17a>
 7b8:	40a007b3          	neg	a5,a0
 7bc:	8b9d                	andi	a5,a5,7
 7be:	00778713          	addi	a4,a5,7
 7c2:	482d                	li	a6,11
 7c4:	0ff5f593          	andi	a1,a1,255
 7c8:	fff60693          	addi	a3,a2,-1
 7cc:	17076263          	bltu	a4,a6,930 <memset+0x17c>
 7d0:	16e6ea63          	bltu	a3,a4,944 <memset+0x190>
 7d4:	16078563          	beqz	a5,93e <memset+0x18a>
 7d8:	00b50023          	sb	a1,0(a0)
 7dc:	4705                	li	a4,1
 7de:	00150e93          	addi	t4,a0,1
 7e2:	14e78c63          	beq	a5,a4,93a <memset+0x186>
 7e6:	00b500a3          	sb	a1,1(a0)
 7ea:	4709                	li	a4,2
 7ec:	00250e93          	addi	t4,a0,2
 7f0:	14e78d63          	beq	a5,a4,94a <memset+0x196>
 7f4:	00b50123          	sb	a1,2(a0)
 7f8:	470d                	li	a4,3
 7fa:	00350e93          	addi	t4,a0,3
 7fe:	12e78b63          	beq	a5,a4,934 <memset+0x180>
 802:	00b501a3          	sb	a1,3(a0)
 806:	4711                	li	a4,4
 808:	00450e93          	addi	t4,a0,4
 80c:	14e78163          	beq	a5,a4,94e <memset+0x19a>
 810:	00b50223          	sb	a1,4(a0)
 814:	4715                	li	a4,5
 816:	00550e93          	addi	t4,a0,5
 81a:	12e78c63          	beq	a5,a4,952 <memset+0x19e>
 81e:	00b502a3          	sb	a1,5(a0)
 822:	471d                	li	a4,7
 824:	00650e93          	addi	t4,a0,6
 828:	12e79763          	bne	a5,a4,956 <memset+0x1a2>
 82c:	00750e93          	addi	t4,a0,7
 830:	00b50323          	sb	a1,6(a0)
 834:	4f1d                	li	t5,7
 836:	00859713          	slli	a4,a1,0x8
 83a:	8f4d                	or	a4,a4,a1
 83c:	01059e13          	slli	t3,a1,0x10
 840:	01c76e33          	or	t3,a4,t3
 844:	01859313          	slli	t1,a1,0x18
 848:	006e6333          	or	t1,t3,t1
 84c:	02059893          	slli	a7,a1,0x20
 850:	011368b3          	or	a7,t1,a7
 854:	02859813          	slli	a6,a1,0x28
 858:	40f60333          	sub	t1,a2,a5
 85c:	0108e833          	or	a6,a7,a6
 860:	03059693          	slli	a3,a1,0x30
 864:	00d866b3          	or	a3,a6,a3
 868:	03859713          	slli	a4,a1,0x38
 86c:	97aa                	add	a5,a5,a0
 86e:	ff837813          	andi	a6,t1,-8
 872:	8f55                	or	a4,a4,a3
 874:	00f806b3          	add	a3,a6,a5
 878:	e398                	sd	a4,0(a5)
 87a:	07a1                	addi	a5,a5,8
 87c:	fed79ee3          	bne	a5,a3,878 <memset+0xc4>
 880:	ff837693          	andi	a3,t1,-8
 884:	00de87b3          	add	a5,t4,a3
 888:	01e6873b          	addw	a4,a3,t5
 88c:	0ad30663          	beq	t1,a3,938 <memset+0x184>
 890:	00b78023          	sb	a1,0(a5)
 894:	0017069b          	addiw	a3,a4,1
 898:	08c6fb63          	bgeu	a3,a2,92e <memset+0x17a>
 89c:	00b780a3          	sb	a1,1(a5)
 8a0:	0027069b          	addiw	a3,a4,2
 8a4:	08c6f563          	bgeu	a3,a2,92e <memset+0x17a>
 8a8:	00b78123          	sb	a1,2(a5)
 8ac:	0037069b          	addiw	a3,a4,3
 8b0:	06c6ff63          	bgeu	a3,a2,92e <memset+0x17a>
 8b4:	00b781a3          	sb	a1,3(a5)
 8b8:	0047069b          	addiw	a3,a4,4
 8bc:	06c6f963          	bgeu	a3,a2,92e <memset+0x17a>
 8c0:	00b78223          	sb	a1,4(a5)
 8c4:	0057069b          	addiw	a3,a4,5
 8c8:	06c6f363          	bgeu	a3,a2,92e <memset+0x17a>
 8cc:	00b782a3          	sb	a1,5(a5)
 8d0:	0067069b          	addiw	a3,a4,6
 8d4:	04c6fd63          	bgeu	a3,a2,92e <memset+0x17a>
 8d8:	00b78323          	sb	a1,6(a5)
 8dc:	0077069b          	addiw	a3,a4,7
 8e0:	04c6f763          	bgeu	a3,a2,92e <memset+0x17a>
 8e4:	00b783a3          	sb	a1,7(a5)
 8e8:	0087069b          	addiw	a3,a4,8
 8ec:	04c6f163          	bgeu	a3,a2,92e <memset+0x17a>
 8f0:	00b78423          	sb	a1,8(a5)
 8f4:	0097069b          	addiw	a3,a4,9
 8f8:	02c6fb63          	bgeu	a3,a2,92e <memset+0x17a>
 8fc:	00b784a3          	sb	a1,9(a5)
 900:	00a7069b          	addiw	a3,a4,10
 904:	02c6f563          	bgeu	a3,a2,92e <memset+0x17a>
 908:	00b78523          	sb	a1,10(a5)
 90c:	00b7069b          	addiw	a3,a4,11
 910:	00c6ff63          	bgeu	a3,a2,92e <memset+0x17a>
 914:	00b785a3          	sb	a1,11(a5)
 918:	00c7069b          	addiw	a3,a4,12
 91c:	00c6f963          	bgeu	a3,a2,92e <memset+0x17a>
 920:	00b78623          	sb	a1,12(a5)
 924:	2735                	addiw	a4,a4,13
 926:	00c77463          	bgeu	a4,a2,92e <memset+0x17a>
 92a:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 92e:	8082                	ret
 930:	472d                	li	a4,11
 932:	bd79                	j	7d0 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 934:	4f0d                	li	t5,3
 936:	b701                	j	836 <memset+0x82>
 938:	8082                	ret
 93a:	4f05                	li	t5,1
 93c:	bded                	j	836 <memset+0x82>
 93e:	8eaa                	mv	t4,a0
 940:	4f01                	li	t5,0
 942:	bdd5                	j	836 <memset+0x82>
 944:	87aa                	mv	a5,a0
 946:	4701                	li	a4,0
 948:	b7a1                	j	890 <memset+0xdc>
 94a:	4f09                	li	t5,2
 94c:	b5ed                	j	836 <memset+0x82>
 94e:	4f11                	li	t5,4
 950:	b5dd                	j	836 <memset+0x82>
 952:	4f15                	li	t5,5
 954:	b5cd                	j	836 <memset+0x82>
 956:	4f19                	li	t5,6
 958:	bdf9                	j	836 <memset+0x82>

000000000000095a <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 95a:	00054783          	lbu	a5,0(a0)
 95e:	0005c703          	lbu	a4,0(a1)
 962:	00e79863          	bne	a5,a4,972 <strcmp+0x18>
 966:	0505                	addi	a0,a0,1
 968:	0585                	addi	a1,a1,1
 96a:	fbe5                	bnez	a5,95a <strcmp>
 96c:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 96e:	9d19                	subw	a0,a0,a4
 970:	8082                	ret
 972:	0007851b          	sext.w	a0,a5
 976:	bfe5                	j	96e <strcmp+0x14>

0000000000000978 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 978:	ce05                	beqz	a2,9b0 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 97a:	00054703          	lbu	a4,0(a0)
 97e:	0005c783          	lbu	a5,0(a1)
 982:	cb0d                	beqz	a4,9b4 <strncmp+0x3c>
    if (!n--)
 984:	167d                	addi	a2,a2,-1
 986:	00c506b3          	add	a3,a0,a2
 98a:	a819                	j	9a0 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 98c:	00a68e63          	beq	a3,a0,9a8 <strncmp+0x30>
 990:	0505                	addi	a0,a0,1
 992:	00e79b63          	bne	a5,a4,9a8 <strncmp+0x30>
 996:	00054703          	lbu	a4,0(a0)
 99a:	0005c783          	lbu	a5,0(a1)
 99e:	cb19                	beqz	a4,9b4 <strncmp+0x3c>
 9a0:	0005c783          	lbu	a5,0(a1)
 9a4:	0585                	addi	a1,a1,1
 9a6:	f3fd                	bnez	a5,98c <strncmp+0x14>
        ;
    return *l - *r;
 9a8:	0007051b          	sext.w	a0,a4
 9ac:	9d1d                	subw	a0,a0,a5
 9ae:	8082                	ret
        return 0;
 9b0:	4501                	li	a0,0
}
 9b2:	8082                	ret
 9b4:	4501                	li	a0,0
    return *l - *r;
 9b6:	9d1d                	subw	a0,a0,a5
 9b8:	8082                	ret

00000000000009ba <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 9ba:	00757793          	andi	a5,a0,7
 9be:	cf89                	beqz	a5,9d8 <strlen+0x1e>
 9c0:	87aa                	mv	a5,a0
 9c2:	a029                	j	9cc <strlen+0x12>
 9c4:	0785                	addi	a5,a5,1
 9c6:	0077f713          	andi	a4,a5,7
 9ca:	cb01                	beqz	a4,9da <strlen+0x20>
        if (!*s)
 9cc:	0007c703          	lbu	a4,0(a5)
 9d0:	fb75                	bnez	a4,9c4 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 9d2:	40a78533          	sub	a0,a5,a0
}
 9d6:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 9d8:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 9da:	6394                	ld	a3,0(a5)
 9dc:	00000597          	auipc	a1,0x0
 9e0:	5ac5b583          	ld	a1,1452(a1) # f88 <unlink+0x5e>
 9e4:	00000617          	auipc	a2,0x0
 9e8:	5ac63603          	ld	a2,1452(a2) # f90 <unlink+0x66>
 9ec:	a019                	j	9f2 <strlen+0x38>
 9ee:	6794                	ld	a3,8(a5)
 9f0:	07a1                	addi	a5,a5,8
 9f2:	00b68733          	add	a4,a3,a1
 9f6:	fff6c693          	not	a3,a3
 9fa:	8f75                	and	a4,a4,a3
 9fc:	8f71                	and	a4,a4,a2
 9fe:	db65                	beqz	a4,9ee <strlen+0x34>
    for (; *s; s++)
 a00:	0007c703          	lbu	a4,0(a5)
 a04:	d779                	beqz	a4,9d2 <strlen+0x18>
 a06:	0017c703          	lbu	a4,1(a5)
 a0a:	0785                	addi	a5,a5,1
 a0c:	d379                	beqz	a4,9d2 <strlen+0x18>
 a0e:	0017c703          	lbu	a4,1(a5)
 a12:	0785                	addi	a5,a5,1
 a14:	fb6d                	bnez	a4,a06 <strlen+0x4c>
 a16:	bf75                	j	9d2 <strlen+0x18>

0000000000000a18 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a18:	00757713          	andi	a4,a0,7
{
 a1c:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 a1e:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a22:	cb19                	beqz	a4,a38 <memchr+0x20>
 a24:	ce25                	beqz	a2,a9c <memchr+0x84>
 a26:	0007c703          	lbu	a4,0(a5)
 a2a:	04b70e63          	beq	a4,a1,a86 <memchr+0x6e>
 a2e:	0785                	addi	a5,a5,1
 a30:	0077f713          	andi	a4,a5,7
 a34:	167d                	addi	a2,a2,-1
 a36:	f77d                	bnez	a4,a24 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 a38:	4501                	li	a0,0
    if (n && *s != c)
 a3a:	c235                	beqz	a2,a9e <memchr+0x86>
 a3c:	0007c703          	lbu	a4,0(a5)
 a40:	04b70363          	beq	a4,a1,a86 <memchr+0x6e>
        size_t k = ONES * c;
 a44:	00000517          	auipc	a0,0x0
 a48:	55453503          	ld	a0,1364(a0) # f98 <unlink+0x6e>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 a4c:	471d                	li	a4,7
        size_t k = ONES * c;
 a4e:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 a52:	02c77a63          	bgeu	a4,a2,a86 <memchr+0x6e>
 a56:	00000897          	auipc	a7,0x0
 a5a:	5328b883          	ld	a7,1330(a7) # f88 <unlink+0x5e>
 a5e:	00000817          	auipc	a6,0x0
 a62:	53283803          	ld	a6,1330(a6) # f90 <unlink+0x66>
 a66:	431d                	li	t1,7
 a68:	a029                	j	a72 <memchr+0x5a>
 a6a:	1661                	addi	a2,a2,-8
 a6c:	07a1                	addi	a5,a5,8
 a6e:	02c37963          	bgeu	t1,a2,aa0 <memchr+0x88>
 a72:	6398                	ld	a4,0(a5)
 a74:	8f29                	xor	a4,a4,a0
 a76:	011706b3          	add	a3,a4,a7
 a7a:	fff74713          	not	a4,a4
 a7e:	8f75                	and	a4,a4,a3
 a80:	01077733          	and	a4,a4,a6
 a84:	d37d                	beqz	a4,a6a <memchr+0x52>
 a86:	853e                	mv	a0,a5
 a88:	97b2                	add	a5,a5,a2
 a8a:	a021                	j	a92 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 a8c:	0505                	addi	a0,a0,1
 a8e:	00f50763          	beq	a0,a5,a9c <memchr+0x84>
 a92:	00054703          	lbu	a4,0(a0)
 a96:	feb71be3          	bne	a4,a1,a8c <memchr+0x74>
 a9a:	8082                	ret
    return n ? (void *)s : 0;
 a9c:	4501                	li	a0,0
}
 a9e:	8082                	ret
    return n ? (void *)s : 0;
 aa0:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 aa2:	f275                	bnez	a2,a86 <memchr+0x6e>
}
 aa4:	8082                	ret

0000000000000aa6 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 aa6:	1101                	addi	sp,sp,-32
 aa8:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 aaa:	862e                	mv	a2,a1
{
 aac:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 aae:	4581                	li	a1,0
{
 ab0:	e426                	sd	s1,8(sp)
 ab2:	ec06                	sd	ra,24(sp)
 ab4:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 ab6:	f63ff0ef          	jal	ra,a18 <memchr>
    return p ? p - s : n;
 aba:	c519                	beqz	a0,ac8 <strnlen+0x22>
}
 abc:	60e2                	ld	ra,24(sp)
 abe:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 ac0:	8d05                	sub	a0,a0,s1
}
 ac2:	64a2                	ld	s1,8(sp)
 ac4:	6105                	addi	sp,sp,32
 ac6:	8082                	ret
 ac8:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 aca:	8522                	mv	a0,s0
}
 acc:	6442                	ld	s0,16(sp)
 ace:	64a2                	ld	s1,8(sp)
 ad0:	6105                	addi	sp,sp,32
 ad2:	8082                	ret

0000000000000ad4 <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 ad4:	00b547b3          	xor	a5,a0,a1
 ad8:	8b9d                	andi	a5,a5,7
 ada:	eb95                	bnez	a5,b0e <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 adc:	0075f793          	andi	a5,a1,7
 ae0:	e7b1                	bnez	a5,b2c <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 ae2:	6198                	ld	a4,0(a1)
 ae4:	00000617          	auipc	a2,0x0
 ae8:	4a463603          	ld	a2,1188(a2) # f88 <unlink+0x5e>
 aec:	00000817          	auipc	a6,0x0
 af0:	4a483803          	ld	a6,1188(a6) # f90 <unlink+0x66>
 af4:	a029                	j	afe <stpcpy+0x2a>
 af6:	e118                	sd	a4,0(a0)
 af8:	6598                	ld	a4,8(a1)
 afa:	05a1                	addi	a1,a1,8
 afc:	0521                	addi	a0,a0,8
 afe:	00c707b3          	add	a5,a4,a2
 b02:	fff74693          	not	a3,a4
 b06:	8ff5                	and	a5,a5,a3
 b08:	0107f7b3          	and	a5,a5,a6
 b0c:	d7ed                	beqz	a5,af6 <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 b0e:	0005c783          	lbu	a5,0(a1)
 b12:	00f50023          	sb	a5,0(a0)
 b16:	c785                	beqz	a5,b3e <stpcpy+0x6a>
 b18:	0015c783          	lbu	a5,1(a1)
 b1c:	0505                	addi	a0,a0,1
 b1e:	0585                	addi	a1,a1,1
 b20:	00f50023          	sb	a5,0(a0)
 b24:	fbf5                	bnez	a5,b18 <stpcpy+0x44>
        ;
    return d;
}
 b26:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 b28:	0505                	addi	a0,a0,1
 b2a:	df45                	beqz	a4,ae2 <stpcpy+0xe>
            if (!(*d = *s))
 b2c:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 b30:	0585                	addi	a1,a1,1
 b32:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 b36:	00f50023          	sb	a5,0(a0)
 b3a:	f7fd                	bnez	a5,b28 <stpcpy+0x54>
}
 b3c:	8082                	ret
 b3e:	8082                	ret

0000000000000b40 <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 b40:	00b547b3          	xor	a5,a0,a1
 b44:	8b9d                	andi	a5,a5,7
 b46:	1a079863          	bnez	a5,cf6 <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 b4a:	0075f793          	andi	a5,a1,7
 b4e:	16078463          	beqz	a5,cb6 <stpncpy+0x176>
 b52:	ea01                	bnez	a2,b62 <stpncpy+0x22>
 b54:	a421                	j	d5c <stpncpy+0x21c>
 b56:	167d                	addi	a2,a2,-1
 b58:	0505                	addi	a0,a0,1
 b5a:	14070e63          	beqz	a4,cb6 <stpncpy+0x176>
 b5e:	1a060863          	beqz	a2,d0e <stpncpy+0x1ce>
 b62:	0005c783          	lbu	a5,0(a1)
 b66:	0585                	addi	a1,a1,1
 b68:	0075f713          	andi	a4,a1,7
 b6c:	00f50023          	sb	a5,0(a0)
 b70:	f3fd                	bnez	a5,b56 <stpncpy+0x16>
 b72:	4805                	li	a6,1
 b74:	1a061863          	bnez	a2,d24 <stpncpy+0x1e4>
 b78:	40a007b3          	neg	a5,a0
 b7c:	8b9d                	andi	a5,a5,7
 b7e:	4681                	li	a3,0
 b80:	18061a63          	bnez	a2,d14 <stpncpy+0x1d4>
 b84:	00778713          	addi	a4,a5,7
 b88:	45ad                	li	a1,11
 b8a:	18b76363          	bltu	a4,a1,d10 <stpncpy+0x1d0>
 b8e:	1ae6eb63          	bltu	a3,a4,d44 <stpncpy+0x204>
 b92:	1a078363          	beqz	a5,d38 <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 b96:	00050023          	sb	zero,0(a0)
 b9a:	4685                	li	a3,1
 b9c:	00150713          	addi	a4,a0,1
 ba0:	18d78f63          	beq	a5,a3,d3e <stpncpy+0x1fe>
 ba4:	000500a3          	sb	zero,1(a0)
 ba8:	4689                	li	a3,2
 baa:	00250713          	addi	a4,a0,2
 bae:	18d78e63          	beq	a5,a3,d4a <stpncpy+0x20a>
 bb2:	00050123          	sb	zero,2(a0)
 bb6:	468d                	li	a3,3
 bb8:	00350713          	addi	a4,a0,3
 bbc:	16d78c63          	beq	a5,a3,d34 <stpncpy+0x1f4>
 bc0:	000501a3          	sb	zero,3(a0)
 bc4:	4691                	li	a3,4
 bc6:	00450713          	addi	a4,a0,4
 bca:	18d78263          	beq	a5,a3,d4e <stpncpy+0x20e>
 bce:	00050223          	sb	zero,4(a0)
 bd2:	4695                	li	a3,5
 bd4:	00550713          	addi	a4,a0,5
 bd8:	16d78d63          	beq	a5,a3,d52 <stpncpy+0x212>
 bdc:	000502a3          	sb	zero,5(a0)
 be0:	469d                	li	a3,7
 be2:	00650713          	addi	a4,a0,6
 be6:	16d79863          	bne	a5,a3,d56 <stpncpy+0x216>
 bea:	00750713          	addi	a4,a0,7
 bee:	00050323          	sb	zero,6(a0)
 bf2:	40f80833          	sub	a6,a6,a5
 bf6:	ff887593          	andi	a1,a6,-8
 bfa:	97aa                	add	a5,a5,a0
 bfc:	95be                	add	a1,a1,a5
 bfe:	0007b023          	sd	zero,0(a5)
 c02:	07a1                	addi	a5,a5,8
 c04:	feb79de3          	bne	a5,a1,bfe <stpncpy+0xbe>
 c08:	ff887593          	andi	a1,a6,-8
 c0c:	9ead                	addw	a3,a3,a1
 c0e:	00b707b3          	add	a5,a4,a1
 c12:	12b80863          	beq	a6,a1,d42 <stpncpy+0x202>
 c16:	00078023          	sb	zero,0(a5)
 c1a:	0016871b          	addiw	a4,a3,1
 c1e:	0ec77863          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c22:	000780a3          	sb	zero,1(a5)
 c26:	0026871b          	addiw	a4,a3,2
 c2a:	0ec77263          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c2e:	00078123          	sb	zero,2(a5)
 c32:	0036871b          	addiw	a4,a3,3
 c36:	0cc77c63          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c3a:	000781a3          	sb	zero,3(a5)
 c3e:	0046871b          	addiw	a4,a3,4
 c42:	0cc77663          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c46:	00078223          	sb	zero,4(a5)
 c4a:	0056871b          	addiw	a4,a3,5
 c4e:	0cc77063          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c52:	000782a3          	sb	zero,5(a5)
 c56:	0066871b          	addiw	a4,a3,6
 c5a:	0ac77a63          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c5e:	00078323          	sb	zero,6(a5)
 c62:	0076871b          	addiw	a4,a3,7
 c66:	0ac77463          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c6a:	000783a3          	sb	zero,7(a5)
 c6e:	0086871b          	addiw	a4,a3,8
 c72:	08c77e63          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c76:	00078423          	sb	zero,8(a5)
 c7a:	0096871b          	addiw	a4,a3,9
 c7e:	08c77863          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c82:	000784a3          	sb	zero,9(a5)
 c86:	00a6871b          	addiw	a4,a3,10
 c8a:	08c77263          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c8e:	00078523          	sb	zero,10(a5)
 c92:	00b6871b          	addiw	a4,a3,11
 c96:	06c77c63          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 c9a:	000785a3          	sb	zero,11(a5)
 c9e:	00c6871b          	addiw	a4,a3,12
 ca2:	06c77663          	bgeu	a4,a2,d0e <stpncpy+0x1ce>
 ca6:	00078623          	sb	zero,12(a5)
 caa:	26b5                	addiw	a3,a3,13
 cac:	06c6f163          	bgeu	a3,a2,d0e <stpncpy+0x1ce>
 cb0:	000786a3          	sb	zero,13(a5)
 cb4:	8082                	ret
            ;
        if (!n || !*s)
 cb6:	c645                	beqz	a2,d5e <stpncpy+0x21e>
 cb8:	0005c783          	lbu	a5,0(a1)
 cbc:	ea078be3          	beqz	a5,b72 <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 cc0:	479d                	li	a5,7
 cc2:	02c7ff63          	bgeu	a5,a2,d00 <stpncpy+0x1c0>
 cc6:	00000897          	auipc	a7,0x0
 cca:	2c28b883          	ld	a7,706(a7) # f88 <unlink+0x5e>
 cce:	00000817          	auipc	a6,0x0
 cd2:	2c283803          	ld	a6,706(a6) # f90 <unlink+0x66>
 cd6:	431d                	li	t1,7
 cd8:	6198                	ld	a4,0(a1)
 cda:	011707b3          	add	a5,a4,a7
 cde:	fff74693          	not	a3,a4
 ce2:	8ff5                	and	a5,a5,a3
 ce4:	0107f7b3          	and	a5,a5,a6
 ce8:	ef81                	bnez	a5,d00 <stpncpy+0x1c0>
            *wd = *ws;
 cea:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 cec:	1661                	addi	a2,a2,-8
 cee:	05a1                	addi	a1,a1,8
 cf0:	0521                	addi	a0,a0,8
 cf2:	fec363e3          	bltu	t1,a2,cd8 <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 cf6:	e609                	bnez	a2,d00 <stpncpy+0x1c0>
 cf8:	a08d                	j	d5a <stpncpy+0x21a>
 cfa:	167d                	addi	a2,a2,-1
 cfc:	0505                	addi	a0,a0,1
 cfe:	ca01                	beqz	a2,d0e <stpncpy+0x1ce>
 d00:	0005c783          	lbu	a5,0(a1)
 d04:	0585                	addi	a1,a1,1
 d06:	00f50023          	sb	a5,0(a0)
 d0a:	fbe5                	bnez	a5,cfa <stpncpy+0x1ba>
        ;
tail:
 d0c:	b59d                	j	b72 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 d0e:	8082                	ret
 d10:	472d                	li	a4,11
 d12:	bdb5                	j	b8e <stpncpy+0x4e>
 d14:	00778713          	addi	a4,a5,7
 d18:	45ad                	li	a1,11
 d1a:	fff60693          	addi	a3,a2,-1
 d1e:	e6b778e3          	bgeu	a4,a1,b8e <stpncpy+0x4e>
 d22:	b7fd                	j	d10 <stpncpy+0x1d0>
 d24:	40a007b3          	neg	a5,a0
 d28:	8832                	mv	a6,a2
 d2a:	8b9d                	andi	a5,a5,7
 d2c:	4681                	li	a3,0
 d2e:	e4060be3          	beqz	a2,b84 <stpncpy+0x44>
 d32:	b7cd                	j	d14 <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 d34:	468d                	li	a3,3
 d36:	bd75                	j	bf2 <stpncpy+0xb2>
 d38:	872a                	mv	a4,a0
 d3a:	4681                	li	a3,0
 d3c:	bd5d                	j	bf2 <stpncpy+0xb2>
 d3e:	4685                	li	a3,1
 d40:	bd4d                	j	bf2 <stpncpy+0xb2>
 d42:	8082                	ret
 d44:	87aa                	mv	a5,a0
 d46:	4681                	li	a3,0
 d48:	b5f9                	j	c16 <stpncpy+0xd6>
 d4a:	4689                	li	a3,2
 d4c:	b55d                	j	bf2 <stpncpy+0xb2>
 d4e:	4691                	li	a3,4
 d50:	b54d                	j	bf2 <stpncpy+0xb2>
 d52:	4695                	li	a3,5
 d54:	bd79                	j	bf2 <stpncpy+0xb2>
 d56:	4699                	li	a3,6
 d58:	bd69                	j	bf2 <stpncpy+0xb2>
 d5a:	8082                	ret
 d5c:	8082                	ret
 d5e:	8082                	ret

0000000000000d60 <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 d60:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 d64:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 d66:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 d6a:	2501                	sext.w	a0,a0
 d6c:	8082                	ret

0000000000000d6e <close>:
    register long a7 __asm__("a7") = n;
 d6e:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 d72:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 d76:	2501                	sext.w	a0,a0
 d78:	8082                	ret

0000000000000d7a <read>:
    register long a7 __asm__("a7") = n;
 d7a:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 d7e:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 d82:	8082                	ret

0000000000000d84 <write>:
    register long a7 __asm__("a7") = n;
 d84:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 d88:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 d8c:	8082                	ret

0000000000000d8e <getpid>:
    register long a7 __asm__("a7") = n;
 d8e:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 d92:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 d96:	2501                	sext.w	a0,a0
 d98:	8082                	ret

0000000000000d9a <sched_yield>:
    register long a7 __asm__("a7") = n;
 d9a:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 d9e:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 da2:	2501                	sext.w	a0,a0
 da4:	8082                	ret

0000000000000da6 <fork>:
    register long a7 __asm__("a7") = n;
 da6:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 daa:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 dae:	2501                	sext.w	a0,a0
 db0:	8082                	ret

0000000000000db2 <exit>:
    register long a7 __asm__("a7") = n;
 db2:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 db6:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 dba:	8082                	ret

0000000000000dbc <waitpid>:
    register long a7 __asm__("a7") = n;
 dbc:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 dc0:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 dc4:	2501                	sext.w	a0,a0
 dc6:	8082                	ret

0000000000000dc8 <exec>:
    register long a7 __asm__("a7") = n;
 dc8:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 dcc:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 dd0:	2501                	sext.w	a0,a0
 dd2:	8082                	ret

0000000000000dd4 <get_time>:

int64 get_time()
{
 dd4:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 dd6:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 dda:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 ddc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 dde:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 de2:	2501                	sext.w	a0,a0
 de4:	ed09                	bnez	a0,dfe <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 de6:	67a2                	ld	a5,8(sp)
 de8:	3e800713          	li	a4,1000
 dec:	00015503          	lhu	a0,0(sp)
 df0:	02e7d7b3          	divu	a5,a5,a4
 df4:	02e50533          	mul	a0,a0,a4
 df8:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 dfa:	0141                	addi	sp,sp,16
 dfc:	8082                	ret
        return -1;
 dfe:	557d                	li	a0,-1
 e00:	bfed                	j	dfa <get_time+0x26>

0000000000000e02 <sys_get_time>:
    register long a7 __asm__("a7") = n;
 e02:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e06:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 e0a:	2501                	sext.w	a0,a0
 e0c:	8082                	ret

0000000000000e0e <sleep>:

int sleep(unsigned long long time)
{
 e0e:	1141                	addi	sp,sp,-16
 e10:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 e12:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e16:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e18:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e1a:	00000073          	ecall
    if (err == 0)
 e1e:	2501                	sext.w	a0,a0
 e20:	e13d                	bnez	a0,e86 <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e22:	6722                	ld	a4,8(sp)
 e24:	3e800693          	li	a3,1000
 e28:	00015783          	lhu	a5,0(sp)
 e2c:	02d75733          	divu	a4,a4,a3
 e30:	02d787b3          	mul	a5,a5,a3
 e34:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 e36:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e3a:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e3c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e3e:	00000073          	ecall
    if (err == 0)
 e42:	2501                	sext.w	a0,a0
 e44:	ed15                	bnez	a0,e80 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e46:	6841                	lui	a6,0x10
 e48:	963e                	add	a2,a2,a5
 e4a:	187d                	addi	a6,a6,-1
 e4c:	3e800693          	li	a3,1000
 e50:	a819                	j	e66 <sleep+0x58>
    __asm_syscall("r"(a7))
 e52:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 e56:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e5a:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e5c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e5e:	00000073          	ecall
    if (err == 0)
 e62:	2501                	sext.w	a0,a0
 e64:	ed11                	bnez	a0,e80 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e66:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 e68:	07c00893          	li	a7,124
 e6c:	02d7d733          	divu	a4,a5,a3
 e70:	6782                	ld	a5,0(sp)
 e72:	0107f7b3          	and	a5,a5,a6
 e76:	02d787b3          	mul	a5,a5,a3
 e7a:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 e7c:	fcc7ebe3          	bltu	a5,a2,e52 <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 e80:	4501                	li	a0,0
 e82:	0141                	addi	sp,sp,16
 e84:	8082                	ret
 e86:	57fd                	li	a5,-1
 e88:	b77d                	j	e36 <sleep+0x28>

0000000000000e8a <set_priority>:
    register long a7 __asm__("a7") = n;
 e8a:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 e8e:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 e92:	2501                	sext.w	a0,a0
 e94:	8082                	ret

0000000000000e96 <mmap>:
    register long a7 __asm__("a7") = n;
 e96:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 e9a:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 e9e:	2501                	sext.w	a0,a0
 ea0:	8082                	ret

0000000000000ea2 <munmap>:
    register long a7 __asm__("a7") = n;
 ea2:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ea6:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 eaa:	2501                	sext.w	a0,a0
 eac:	8082                	ret

0000000000000eae <wait>:

int wait(int *code)
{
 eae:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 eb0:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 eb4:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 eb6:	00000073          	ecall
    return waitpid(-1, code);
}
 eba:	2501                	sext.w	a0,a0
 ebc:	8082                	ret

0000000000000ebe <spawn>:
    register long a7 __asm__("a7") = n;
 ebe:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 ec2:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 ec6:	2501                	sext.w	a0,a0
 ec8:	8082                	ret

0000000000000eca <mailread>:
    register long a7 __asm__("a7") = n;
 eca:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ece:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 ed2:	2501                	sext.w	a0,a0
 ed4:	8082                	ret

0000000000000ed6 <mailwrite>:
    register long a7 __asm__("a7") = n;
 ed6:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 eda:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 ede:	2501                	sext.w	a0,a0
 ee0:	8082                	ret

0000000000000ee2 <fstat>:
    register long a7 __asm__("a7") = n;
 ee2:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ee6:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 eea:	2501                	sext.w	a0,a0
 eec:	8082                	ret

0000000000000eee <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 eee:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 ef0:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 ef4:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 ef6:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 efa:	2501                	sext.w	a0,a0
 efc:	8082                	ret

0000000000000efe <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 efe:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 f00:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 f04:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f06:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 f0a:	2501                	sext.w	a0,a0
 f0c:	8082                	ret

0000000000000f0e <link>:

int link(char *old_path, char *new_path)
{
 f0e:	87aa                	mv	a5,a0
 f10:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 f12:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 f16:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 f1a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 f1c:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 f20:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f22:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 f26:	2501                	sext.w	a0,a0
 f28:	8082                	ret

0000000000000f2a <unlink>:

int unlink(char *path)
{
 f2a:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f2c:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 f30:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 f34:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f36:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 f3a:	2501                	sext.w	a0,a0
 f3c:	8082                	ret
