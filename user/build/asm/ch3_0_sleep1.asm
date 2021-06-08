
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_0_sleep1:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0520006f          	j	54 <__start_main>

0000000000000006 <main>:
/// Test sleep1 passed!

/// 注意不要单纯以 passed! 作为判断，还要注意时间间隔是否真的在 100 附近，误差要不超过 20%。

int main()
{
   6:	1141                	addi	sp,sp,-16
   8:	e406                	sd	ra,8(sp)
   a:	e022                	sd	s0,0(sp)
    int64 start = get_time();
   c:	5ff000ef          	jal	ra,e0a <get_time>
    printf("current time_msec = %d\n", start);
  10:	85aa                	mv	a1,a0
    int64 start = get_time();
  12:	842a                	mv	s0,a0
    printf("current time_msec = %d\n", start);
  14:	00001517          	auipc	a0,0x1
  18:	f6450513          	addi	a0,a0,-156 # f78 <unlink+0x18>
  1c:	0ca000ef          	jal	ra,e6 <printf>
    sleep(100);
  20:	06400513          	li	a0,100
  24:	621000ef          	jal	ra,e44 <sleep>
    int64 end = get_time();
  28:	5e3000ef          	jal	ra,e0a <get_time>
    printf("time_msec = %d after sleeping 100 ticks, delta = %dms!\n", end, end - start);
  2c:	40850633          	sub	a2,a0,s0
    int64 end = get_time();
  30:	85aa                	mv	a1,a0
    printf("time_msec = %d after sleeping 100 ticks, delta = %dms!\n", end, end - start);
  32:	00001517          	auipc	a0,0x1
  36:	f5e50513          	addi	a0,a0,-162 # f90 <unlink+0x30>
  3a:	0ac000ef          	jal	ra,e6 <printf>
    puts("Test sleep1 passed!");
  3e:	00001517          	auipc	a0,0x1
  42:	f8a50513          	addi	a0,a0,-118 # fc8 <unlink+0x68>
  46:	05e000ef          	jal	ra,a4 <puts>
    return 0;
  4a:	60a2                	ld	ra,8(sp)
  4c:	6402                	ld	s0,0(sp)
  4e:	4501                	li	a0,0
  50:	0141                	addi	sp,sp,16
  52:	8082                	ret

0000000000000054 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
    exit(main());
  58:	fafff0ef          	jal	ra,6 <main>
  5c:	58d000ef          	jal	ra,de8 <exit>
    return 0;
}
  60:	60a2                	ld	ra,8(sp)
  62:	4501                	li	a0,0
  64:	0141                	addi	sp,sp,16
  66:	8082                	ret

0000000000000068 <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  68:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  6a:	00f10593          	addi	a1,sp,15
  6e:	4605                	li	a2,1
  70:	4501                	li	a0,0
{
  72:	ec06                	sd	ra,24(sp)
    char byte = 0;
  74:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  78:	539000ef          	jal	ra,db0 <read>
    return byte;
}
  7c:	60e2                	ld	ra,24(sp)
  7e:	00f14503          	lbu	a0,15(sp)
  82:	6105                	addi	sp,sp,32
  84:	8082                	ret

0000000000000086 <putchar>:

int putchar(int c)
{
  86:	1101                	addi	sp,sp,-32
  88:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  8a:	00f10593          	addi	a1,sp,15
  8e:	4605                	li	a2,1
  90:	4505                	li	a0,1
{
  92:	ec06                	sd	ra,24(sp)
    char byte = c;
  94:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  98:	523000ef          	jal	ra,dba <write>
}
  9c:	60e2                	ld	ra,24(sp)
  9e:	2501                	sext.w	a0,a0
  a0:	6105                	addi	sp,sp,32
  a2:	8082                	ret

00000000000000a4 <puts>:

int puts(const char *s)
{
  a4:	1101                	addi	sp,sp,-32
  a6:	e822                	sd	s0,16(sp)
  a8:	ec06                	sd	ra,24(sp)
  aa:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
  ac:	145000ef          	jal	ra,9f0 <strlen>
  b0:	862a                	mv	a2,a0
  b2:	85a2                	mv	a1,s0
  b4:	4505                	li	a0,1
  b6:	505000ef          	jal	ra,dba <write>
  ba:	00055763          	bgez	a0,c8 <puts+0x24>
    return r;
}
  be:	60e2                	ld	ra,24(sp)
  c0:	6442                	ld	s0,16(sp)
  c2:	557d                	li	a0,-1
  c4:	6105                	addi	sp,sp,32
  c6:	8082                	ret
    return write(stdout, &byte, 1);
  c8:	00f10593          	addi	a1,sp,15
    char byte = c;
  cc:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
  ce:	4605                	li	a2,1
  d0:	4505                	li	a0,1
    char byte = c;
  d2:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  d6:	4e5000ef          	jal	ra,dba <write>
}
  da:	60e2                	ld	ra,24(sp)
  dc:	6442                	ld	s0,16(sp)
  de:	41f5551b          	sraiw	a0,a0,0x1f
  e2:	6105                	addi	sp,sp,32
  e4:	8082                	ret

00000000000000e6 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
  e6:	7131                	addi	sp,sp,-192
  e8:	ecce                	sd	s3,88(sp)
  ea:	e8d2                	sd	s4,80(sp)
  ec:	e4d6                	sd	s5,72(sp)
  ee:	e0da                	sd	s6,64(sp)
  f0:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
  f2:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
  f4:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
  f6:	6ae1                	lui	s5,0x18
  f8:	000f4a37          	lui	s4,0xf4
  fc:	00989b37          	lui	s6,0x989
{
 100:	fc86                	sd	ra,120(sp)
 102:	f8a2                	sd	s0,112(sp)
 104:	f4a6                	sd	s1,104(sp)
 106:	f0ca                	sd	s2,96(sp)
 108:	fc5e                	sd	s7,56(sp)
 10a:	e52e                	sd	a1,136(sp)
 10c:	e932                	sd	a2,144(sp)
 10e:	ed36                	sd	a3,152(sp)
 110:	f13a                	sd	a4,160(sp)
 112:	f942                	sd	a6,176(sp)
 114:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
 116:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
 118:	70f98993          	addi	s3,s3,1807 # 270f <digits+0x170f>
 11c:	69fa8a93          	addi	s5,s5,1695 # 1869f <digits+0x1769f>
 120:	23fa0a13          	addi	s4,s4,575 # f423f <digits+0xf323f>
 124:	67fb0b13          	addi	s6,s6,1663 # 98967f <digits+0x98867f>
    for (;;)
    {
        if (!*s)
 128:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
 12c:	02500913          	li	s2,37
        if (!*s)
 130:	1a078f63          	beqz	a5,2ee <printf+0x208>
 134:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 136:	17278e63          	beq	a5,s2,2b2 <printf+0x1cc>
 13a:	00164783          	lbu	a5,1(a2)
 13e:	0605                	addi	a2,a2,1
 140:	fbfd                	bnez	a5,136 <printf+0x50>
 142:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 144:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 148:	85aa                	mv	a1,a0
 14a:	8622                	mv	a2,s0
 14c:	4505                	li	a0,1
 14e:	46d000ef          	jal	ra,dba <write>
        out(f, a, l);
        if (l)
 152:	18041963          	bnez	s0,2e4 <printf+0x1fe>
            continue;
        if (s[1] == 0)
 156:	0014c783          	lbu	a5,1(s1)
 15a:	18078a63          	beqz	a5,2ee <printf+0x208>
            break;
        switch (s[1])
 15e:	07300713          	li	a4,115
 162:	28e78e63          	beq	a5,a4,3fe <printf+0x318>
 166:	18f76f63          	bltu	a4,a5,304 <printf+0x21e>
 16a:	06400713          	li	a4,100
 16e:	2ae78c63          	beq	a5,a4,426 <printf+0x340>
 172:	07000713          	li	a4,112
 176:	3ce79c63          	bne	a5,a4,54e <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 17a:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 17c:	00001797          	auipc	a5,0x1
 180:	e8478793          	addi	a5,a5,-380 # 1000 <digits>
            printptr(va_arg(ap, uint64));
 184:	6298                	ld	a4,0(a3)
 186:	00868093          	addi	ra,a3,8
 18a:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 18c:	00471293          	slli	t0,a4,0x4
 190:	00c71f13          	slli	t5,a4,0xc
 194:	01471e13          	slli	t3,a4,0x14
 198:	01c71893          	slli	a7,a4,0x1c
 19c:	02471813          	slli	a6,a4,0x24
 1a0:	02871513          	slli	a0,a4,0x28
 1a4:	02c71593          	slli	a1,a4,0x2c
 1a8:	03071693          	slli	a3,a4,0x30
 1ac:	00871f93          	slli	t6,a4,0x8
 1b0:	01071e93          	slli	t4,a4,0x10
 1b4:	01871313          	slli	t1,a4,0x18
 1b8:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1bc:	03c2d293          	srli	t0,t0,0x3c
 1c0:	03cf5f13          	srli	t5,t5,0x3c
 1c4:	03ce5e13          	srli	t3,t3,0x3c
 1c8:	03c8d893          	srli	a7,a7,0x3c
 1cc:	03c85813          	srli	a6,a6,0x3c
 1d0:	9171                	srli	a0,a0,0x3c
 1d2:	91f1                	srli	a1,a1,0x3c
 1d4:	92f1                	srli	a3,a3,0x3c
 1d6:	92be                	add	t0,t0,a5
 1d8:	9f3e                	add	t5,t5,a5
 1da:	9e3e                	add	t3,t3,a5
 1dc:	98be                	add	a7,a7,a5
 1de:	983e                	add	a6,a6,a5
 1e0:	953e                	add	a0,a0,a5
 1e2:	95be                	add	a1,a1,a5
 1e4:	96be                	add	a3,a3,a5
 1e6:	03c75393          	srli	t2,a4,0x3c
 1ea:	01c75b9b          	srliw	s7,a4,0x1c
 1ee:	03cfdf93          	srli	t6,t6,0x3c
 1f2:	03cede93          	srli	t4,t4,0x3c
 1f6:	03c35313          	srli	t1,t1,0x3c
 1fa:	9271                	srli	a2,a2,0x3c
 1fc:	0002c403          	lbu	s0,0(t0)
 200:	93be                	add	t2,t2,a5
 202:	000f4283          	lbu	t0,0(t5)
 206:	9fbe                	add	t6,t6,a5
 208:	000e4f03          	lbu	t5,0(t3)
 20c:	9ebe                	add	t4,t4,a5
 20e:	0008ce03          	lbu	t3,0(a7)
 212:	933e                	add	t1,t1,a5
 214:	00084883          	lbu	a7,0(a6)
 218:	9bbe                	add	s7,s7,a5
 21a:	00054803          	lbu	a6,0(a0)
 21e:	963e                	add	a2,a2,a5
 220:	0005c503          	lbu	a0,0(a1)
 224:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 228:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 22c:	0003c903          	lbu	s2,0(t2)
 230:	00064603          	lbu	a2,0(a2)
 234:	000fc383          	lbu	t2,0(t6)
 238:	8b3d                	andi	a4,a4,15
 23a:	000ecf83          	lbu	t6,0(t4)
 23e:	92f1                	srli	a3,a3,0x3c
 240:	00034e83          	lbu	t4,0(t1)
 244:	000bc303          	lbu	t1,0(s7)
 248:	96be                	add	a3,a3,a5
 24a:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 24c:	7761                	lui	a4,0xffff8
 24e:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 252:	00710623          	sb	t2,12(sp)
 256:	005106a3          	sb	t0,13(sp)
 25a:	01f10723          	sb	t6,14(sp)
 25e:	01e107a3          	sb	t5,15(sp)
 262:	01d10823          	sb	t4,16(sp)
 266:	01c108a3          	sb	t3,17(sp)
 26a:	00610923          	sb	t1,18(sp)
 26e:	011109a3          	sb	a7,19(sp)
 272:	01010a23          	sb	a6,20(sp)
 276:	00a10aa3          	sb	a0,21(sp)
 27a:	00b10b23          	sb	a1,22(sp)
 27e:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 282:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 286:	01210523          	sb	s2,10(sp)
 28a:	008105a3          	sb	s0,11(sp)
 28e:	0006c703          	lbu	a4,0(a3)
 292:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 296:	4649                	li	a2,18
 298:	002c                	addi	a1,sp,8
 29a:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 29c:	00e10c23          	sb	a4,24(sp)
 2a0:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 2a4:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 2a8:	313000ef          	jal	ra,dba <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 2ac:	00248513          	addi	a0,s1,2
 2b0:	bda5                	j	128 <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 2b2:	00064783          	lbu	a5,0(a2)
 2b6:	84b2                	mv	s1,a2
 2b8:	01278963          	beq	a5,s2,2ca <printf+0x1e4>
 2bc:	b561                	j	144 <printf+0x5e>
 2be:	0024c783          	lbu	a5,2(s1)
 2c2:	0605                	addi	a2,a2,1
 2c4:	0489                	addi	s1,s1,2
 2c6:	e7279fe3          	bne	a5,s2,144 <printf+0x5e>
 2ca:	0014c783          	lbu	a5,1(s1)
 2ce:	ff2788e3          	beq	a5,s2,2be <printf+0x1d8>
        l = z - a;
 2d2:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 2d6:	85aa                	mv	a1,a0
 2d8:	8622                	mv	a2,s0
 2da:	4505                	li	a0,1
 2dc:	2df000ef          	jal	ra,dba <write>
        if (l)
 2e0:	e6040be3          	beqz	s0,156 <printf+0x70>
 2e4:	8526                	mv	a0,s1
        if (!*s)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	e40795e3          	bnez	a5,134 <printf+0x4e>
    }
    va_end(ap);
 2ee:	70e6                	ld	ra,120(sp)
 2f0:	7446                	ld	s0,112(sp)
 2f2:	74a6                	ld	s1,104(sp)
 2f4:	7906                	ld	s2,96(sp)
 2f6:	69e6                	ld	s3,88(sp)
 2f8:	6a46                	ld	s4,80(sp)
 2fa:	6aa6                	ld	s5,72(sp)
 2fc:	6b06                	ld	s6,64(sp)
 2fe:	7be2                	ld	s7,56(sp)
 300:	6129                	addi	sp,sp,192
 302:	8082                	ret
        switch (s[1])
 304:	07800713          	li	a4,120
 308:	24e79363          	bne	a5,a4,54e <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 30c:	6782                	ld	a5,0(sp)
 30e:	4394                	lw	a3,0(a5)
 310:	07a1                	addi	a5,a5,8
 312:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 314:	2606c263          	bltz	a3,578 <printf+0x492>
        buf[i--] = digits[x % base];
 318:	00001797          	auipc	a5,0x1
 31c:	ce878793          	addi	a5,a5,-792 # 1000 <digits>
 320:	00f6f713          	andi	a4,a3,15
 324:	973e                	add	a4,a4,a5
 326:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <digits+0xffffffffffff7000>
    buf[16] = 0;
 32a:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 32e:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 330:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 334:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 338:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 33c:	0046d51b          	srliw	a0,a3,0x4
 340:	0ad5d563          	bge	a1,a3,3ea <printf+0x304>
        buf[i--] = digits[x % base];
 344:	8a3d                	andi	a2,a2,15
 346:	963e                	add	a2,a2,a5
 348:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 34c:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 350:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 354:	30a5fe63          	bgeu	a1,a0,670 <printf+0x58a>
        buf[i--] = digits[x % base];
 358:	00f77613          	andi	a2,a4,15
 35c:	963e                	add	a2,a2,a5
 35e:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 362:	45bd                	li	a1,15
 364:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 368:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 36c:	00475513          	srli	a0,a4,0x4
 370:	30e5f963          	bgeu	a1,a4,682 <printf+0x59c>
        buf[i--] = digits[x % base];
 374:	8a3d                	andi	a2,a2,15
 376:	963e                	add	a2,a2,a5
 378:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 37c:	00875893          	srli	a7,a4,0x8
 380:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 384:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 388:	30a5fd63          	bgeu	a1,a0,6a2 <printf+0x5bc>
        buf[i--] = digits[x % base];
 38c:	8a3d                	andi	a2,a2,15
 38e:	963e                	add	a2,a2,a5
 390:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 394:	00c75813          	srli	a6,a4,0xc
 398:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 39c:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 3a0:	3315fe63          	bgeu	a1,a7,6dc <printf+0x5f6>
        buf[i--] = digits[x % base];
 3a4:	8a3d                	andi	a2,a2,15
 3a6:	963e                	add	a2,a2,a5
 3a8:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3ac:	01075893          	srli	a7,a4,0x10
 3b0:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 3b4:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 3b8:	3305ff63          	bgeu	a1,a6,6f6 <printf+0x610>
        buf[i--] = digits[x % base];
 3bc:	8a3d                	andi	a2,a2,15
 3be:	963e                	add	a2,a2,a5
 3c0:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 3c4:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 3c8:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 3cc:	3515f863          	bgeu	a1,a7,71c <printf+0x636>
        buf[i--] = digits[x % base];
 3d0:	97ba                	add	a5,a5,a4
 3d2:	0007c783          	lbu	a5,0(a5)
 3d6:	45a1                	li	a1,8
 3d8:	00f10823          	sb	a5,16(sp)
    if (sign)
 3dc:	0006d763          	bgez	a3,3ea <printf+0x304>
        buf[i--] = '-';
 3e0:	02d00793          	li	a5,45
 3e4:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 3e8:	459d                	li	a1,7
    write(f, s, l);
 3ea:	4641                	li	a2,16
 3ec:	003c                	addi	a5,sp,8
 3ee:	9e0d                	subw	a2,a2,a1
 3f0:	4505                	li	a0,1
 3f2:	95be                	add	a1,a1,a5
 3f4:	1c7000ef          	jal	ra,dba <write>
        s += 2;
 3f8:	00248513          	addi	a0,s1,2
 3fc:	b335                	j	128 <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 3fe:	6782                	ld	a5,0(sp)
 400:	6380                	ld	s0,0(a5)
 402:	07a1                	addi	a5,a5,8
 404:	e03e                	sd	a5,0(sp)
 406:	22040a63          	beqz	s0,63a <printf+0x554>
            l = strnlen(a, 200);
 40a:	0c800593          	li	a1,200
 40e:	8522                	mv	a0,s0
 410:	6cc000ef          	jal	ra,adc <strnlen>
    write(f, s, l);
 414:	0005061b          	sext.w	a2,a0
 418:	85a2                	mv	a1,s0
 41a:	4505                	li	a0,1
 41c:	19f000ef          	jal	ra,dba <write>
        s += 2;
 420:	00248513          	addi	a0,s1,2
 424:	b311                	j	128 <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 426:	6782                	ld	a5,0(sp)
 428:	4390                	lw	a2,0(a5)
 42a:	07a1                	addi	a5,a5,8
 42c:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 42e:	1a064363          	bltz	a2,5d4 <printf+0x4ee>
        buf[i--] = digits[x % base];
 432:	46a9                	li	a3,10
 434:	02d6773b          	remuw	a4,a2,a3
 438:	00001797          	auipc	a5,0x1
 43c:	bc878793          	addi	a5,a5,-1080 # 1000 <digits>
    buf[16] = 0;
 440:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 444:	4525                	li	a0,9
        x = xx;
 446:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 44a:	973e                	add	a4,a4,a5
 44c:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 450:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 454:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 458:	2cc55063          	bge	a0,a2,718 <printf+0x632>
 45c:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 460:	02d5f73b          	remuw	a4,a1,a3
 464:	1702                	slli	a4,a4,0x20
 466:	9301                	srli	a4,a4,0x20
 468:	973e                	add	a4,a4,a5
 46a:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 46e:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 472:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 476:	1f057d63          	bgeu	a0,a6,670 <printf+0x58a>
        buf[i--] = digits[x % base];
 47a:	4529                	li	a0,10
    } while ((x /= base) != 0);
 47c:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 47e:	02a5f73b          	remuw	a4,a1,a0
 482:	973e                	add	a4,a4,a5
 484:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 488:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 48c:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 490:	1ab6f163          	bgeu	a3,a1,632 <printf+0x54c>
 494:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 498:	02a776bb          	remuw	a3,a4,a0
 49c:	96be                	add	a3,a3,a5
 49e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4a2:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4a6:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 4aa:	20b87c63          	bgeu	a6,a1,6c2 <printf+0x5dc>
 4ae:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 4b2:	02a776bb          	remuw	a3,a4,a0
 4b6:	96be                	add	a3,a3,a5
 4b8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4bc:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4c0:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 4c4:	20b87363          	bgeu	a6,a1,6ca <printf+0x5e4>
        buf[i--] = digits[x % base];
 4c8:	02a776bb          	remuw	a3,a4,a0
 4cc:	96be                	add	a3,a3,a5
 4ce:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4d2:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4d6:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 4da:	20b9f563          	bgeu	s3,a1,6e4 <printf+0x5fe>
        buf[i--] = digits[x % base];
 4de:	02a776bb          	remuw	a3,a4,a0
 4e2:	96be                	add	a3,a3,a5
 4e4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4e8:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4ec:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 4f0:	20bafb63          	bgeu	s5,a1,706 <printf+0x620>
        buf[i--] = digits[x % base];
 4f4:	02a776bb          	remuw	a3,a4,a0
 4f8:	96be                	add	a3,a3,a5
 4fa:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4fe:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 502:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 506:	1eba7c63          	bgeu	s4,a1,6fe <printf+0x618>
        buf[i--] = digits[x % base];
 50a:	02a776bb          	remuw	a3,a4,a0
 50e:	96be                	add	a3,a3,a5
 510:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 514:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 518:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 51c:	14bb7163          	bgeu	s6,a1,65e <printf+0x578>
        buf[i--] = digits[x % base];
 520:	1702                	slli	a4,a4,0x20
 522:	9301                	srli	a4,a4,0x20
 524:	97ba                	add	a5,a5,a4
 526:	0007c783          	lbu	a5,0(a5)
 52a:	4599                	li	a1,6
 52c:	00f10723          	sb	a5,14(sp)
    if (sign)
 530:	ea065de3          	bgez	a2,3ea <printf+0x304>
        buf[i--] = '-';
 534:	02d00793          	li	a5,45
 538:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 53c:	4595                	li	a1,5
    write(f, s, l);
 53e:	003c                	addi	a5,sp,8
 540:	4641                	li	a2,16
 542:	9e0d                	subw	a2,a2,a1
 544:	4505                	li	a0,1
 546:	95be                	add	a1,a1,a5
 548:	073000ef          	jal	ra,dba <write>
 54c:	b575                	j	3f8 <printf+0x312>
    char byte = c;
 54e:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 552:	4605                	li	a2,1
 554:	002c                	addi	a1,sp,8
 556:	4505                	li	a0,1
    char byte = c;
 558:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 55c:	05f000ef          	jal	ra,dba <write>
    char byte = c;
 560:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 564:	4605                	li	a2,1
 566:	002c                	addi	a1,sp,8
 568:	4505                	li	a0,1
    char byte = c;
 56a:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 56e:	04d000ef          	jal	ra,dba <write>
        s += 2;
 572:	00248513          	addi	a0,s1,2
 576:	be4d                	j	128 <printf+0x42>
        x = -xx;
 578:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 57c:	00001797          	auipc	a5,0x1
 580:	a8478793          	addi	a5,a5,-1404 # 1000 <digits>
 584:	00f77613          	andi	a2,a4,15
 588:	963e                	add	a2,a2,a5
 58a:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 58e:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 592:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 594:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 598:	0047551b          	srliw	a0,a4,0x4
 59c:	0047561b          	srliw	a2,a4,0x4
 5a0:	0ab6d263          	bge	a3,a1,644 <printf+0x55e>
        buf[i--] = digits[x % base];
 5a4:	8a3d                	andi	a2,a2,15
 5a6:	963e                	add	a2,a2,a5
 5a8:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 5ac:	463d                	li	a2,15
 5ae:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 5b2:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 5b6:	daa661e3          	bltu	a2,a0,358 <printf+0x272>
        buf[i--] = '-';
 5ba:	02d00793          	li	a5,45
 5be:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 5c2:	45b5                	li	a1,13
    write(f, s, l);
 5c4:	003c                	addi	a5,sp,8
 5c6:	4641                	li	a2,16
 5c8:	9e0d                	subw	a2,a2,a1
 5ca:	4505                	li	a0,1
 5cc:	95be                	add	a1,a1,a5
 5ce:	7ec000ef          	jal	ra,dba <write>
 5d2:	b51d                	j	3f8 <printf+0x312>
        x = -xx;
 5d4:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 5d8:	46a9                	li	a3,10
 5da:	02d875bb          	remuw	a1,a6,a3
 5de:	00001797          	auipc	a5,0x1
 5e2:	a2278793          	addi	a5,a5,-1502 # 1000 <digits>
    buf[16] = 0;
 5e6:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5ea:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 5ec:	95be                	add	a1,a1,a5
 5ee:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 5f2:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 5f6:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 5fa:	04a65563          	bge	a2,a0,644 <printf+0x55e>
 5fe:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 602:	02d775bb          	remuw	a1,a4,a3
 606:	95be                	add	a1,a1,a5
 608:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 60c:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 610:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 614:	fb0573e3          	bgeu	a0,a6,5ba <printf+0x4d4>
        buf[i--] = digits[x % base];
 618:	4529                	li	a0,10
    } while ((x /= base) != 0);
 61a:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 61c:	02a5f73b          	remuw	a4,a1,a0
 620:	973e                	add	a4,a4,a5
 622:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 626:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 62a:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 62e:	e6b6e3e3          	bltu	a3,a1,494 <printf+0x3ae>
        buf[i--] = digits[x % base];
 632:	45b5                	li	a1,13
    if (sign)
 634:	da065be3          	bgez	a2,3ea <printf+0x304>
 638:	a881                	j	688 <printf+0x5a2>
                a = "(null)";
 63a:	00001417          	auipc	s0,0x1
 63e:	9a640413          	addi	s0,s0,-1626 # fe0 <unlink+0x80>
 642:	b3e1                	j	40a <printf+0x324>
        buf[i--] = '-';
 644:	02d00793          	li	a5,45
 648:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 64c:	45b9                	li	a1,14
    write(f, s, l);
 64e:	003c                	addi	a5,sp,8
 650:	4641                	li	a2,16
 652:	9e0d                	subw	a2,a2,a1
 654:	4505                	li	a0,1
 656:	95be                	add	a1,a1,a5
 658:	762000ef          	jal	ra,dba <write>
 65c:	bb71                	j	3f8 <printf+0x312>
        buf[i--] = digits[x % base];
 65e:	459d                	li	a1,7
    if (sign)
 660:	d80655e3          	bgez	a2,3ea <printf+0x304>
        buf[i--] = '-';
 664:	02d00793          	li	a5,45
 668:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 66c:	4599                	li	a1,6
 66e:	bbb5                	j	3ea <printf+0x304>
 670:	45b9                	li	a1,14
    write(f, s, l);
 672:	003c                	addi	a5,sp,8
 674:	4641                	li	a2,16
 676:	9e0d                	subw	a2,a2,a1
 678:	4505                	li	a0,1
 67a:	95be                	add	a1,a1,a5
 67c:	73e000ef          	jal	ra,dba <write>
 680:	bba5                	j	3f8 <printf+0x312>
        buf[i--] = digits[x % base];
 682:	45b5                	li	a1,13
    if (sign)
 684:	d606d3e3          	bgez	a3,3ea <printf+0x304>
        buf[i--] = '-';
 688:	02d00793          	li	a5,45
 68c:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 690:	45b1                	li	a1,12
    write(f, s, l);
 692:	003c                	addi	a5,sp,8
 694:	4641                	li	a2,16
 696:	9e0d                	subw	a2,a2,a1
 698:	4505                	li	a0,1
 69a:	95be                	add	a1,a1,a5
 69c:	71e000ef          	jal	ra,dba <write>
 6a0:	bba1                	j	3f8 <printf+0x312>
        buf[i--] = digits[x % base];
 6a2:	45b1                	li	a1,12
    if (sign)
 6a4:	d406d3e3          	bgez	a3,3ea <printf+0x304>
        buf[i--] = '-';
 6a8:	02d00793          	li	a5,45
 6ac:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 6b0:	45ad                	li	a1,11
    write(f, s, l);
 6b2:	003c                	addi	a5,sp,8
 6b4:	4641                	li	a2,16
 6b6:	9e0d                	subw	a2,a2,a1
 6b8:	4505                	li	a0,1
 6ba:	95be                	add	a1,a1,a5
 6bc:	6fe000ef          	jal	ra,dba <write>
 6c0:	bb25                	j	3f8 <printf+0x312>
        buf[i--] = digits[x % base];
 6c2:	45b1                	li	a1,12
    if (sign)
 6c4:	d20653e3          	bgez	a2,3ea <printf+0x304>
 6c8:	b7c5                	j	6a8 <printf+0x5c2>
        buf[i--] = digits[x % base];
 6ca:	45ad                	li	a1,11
    if (sign)
 6cc:	d0065fe3          	bgez	a2,3ea <printf+0x304>
        buf[i--] = '-';
 6d0:	02d00793          	li	a5,45
 6d4:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 6d8:	45a9                	li	a1,10
 6da:	bb01                	j	3ea <printf+0x304>
 6dc:	45ad                	li	a1,11
    if (sign)
 6de:	d006d6e3          	bgez	a3,3ea <printf+0x304>
 6e2:	b7fd                	j	6d0 <printf+0x5ea>
        buf[i--] = digits[x % base];
 6e4:	45a9                	li	a1,10
    if (sign)
 6e6:	d00652e3          	bgez	a2,3ea <printf+0x304>
        buf[i--] = '-';
 6ea:	02d00793          	li	a5,45
 6ee:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 6f2:	45a5                	li	a1,9
 6f4:	b9dd                	j	3ea <printf+0x304>
 6f6:	45a9                	li	a1,10
    if (sign)
 6f8:	ce06d9e3          	bgez	a3,3ea <printf+0x304>
 6fc:	b7fd                	j	6ea <printf+0x604>
        buf[i--] = digits[x % base];
 6fe:	45a1                	li	a1,8
    if (sign)
 700:	ce0655e3          	bgez	a2,3ea <printf+0x304>
 704:	b9f1                	j	3e0 <printf+0x2fa>
        buf[i--] = digits[x % base];
 706:	45a5                	li	a1,9
    if (sign)
 708:	ce0651e3          	bgez	a2,3ea <printf+0x304>
        buf[i--] = '-';
 70c:	02d00793          	li	a5,45
 710:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 714:	45a1                	li	a1,8
 716:	b9d1                	j	3ea <printf+0x304>
    i = 15;
 718:	45bd                	li	a1,15
 71a:	b9c1                	j	3ea <printf+0x304>
        buf[i--] = digits[x % base];
 71c:	45a5                	li	a1,9
    if (sign)
 71e:	cc06d6e3          	bgez	a3,3ea <printf+0x304>
 722:	b7ed                	j	70c <printf+0x626>

0000000000000724 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 724:	02000793          	li	a5,32
 728:	00f50663          	beq	a0,a5,734 <isspace+0x10>
 72c:	355d                	addiw	a0,a0,-9
 72e:	00553513          	sltiu	a0,a0,5
 732:	8082                	ret
 734:	4505                	li	a0,1
}
 736:	8082                	ret

0000000000000738 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 738:	fd05051b          	addiw	a0,a0,-48
}
 73c:	00a53513          	sltiu	a0,a0,10
 740:	8082                	ret

0000000000000742 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 742:	02000613          	li	a2,32
 746:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 748:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 74c:	ff77069b          	addiw	a3,a4,-9
 750:	04c70d63          	beq	a4,a2,7aa <atoi+0x68>
 754:	0007079b          	sext.w	a5,a4
 758:	04d5f963          	bgeu	a1,a3,7aa <atoi+0x68>
        s++;
    switch (*s)
 75c:	02b00693          	li	a3,43
 760:	04d70a63          	beq	a4,a3,7b4 <atoi+0x72>
 764:	02d00693          	li	a3,45
 768:	06d70463          	beq	a4,a3,7d0 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 76c:	fd07859b          	addiw	a1,a5,-48
 770:	4625                	li	a2,9
 772:	873e                	mv	a4,a5
 774:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 776:	4e01                	li	t3,0
    while (isdigit(*s))
 778:	04b66a63          	bltu	a2,a1,7cc <atoi+0x8a>
    int n = 0, neg = 0;
 77c:	4501                	li	a0,0
    while (isdigit(*s))
 77e:	4825                	li	a6,9
 780:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 784:	0025179b          	slliw	a5,a0,0x2
 788:	9d3d                	addw	a0,a0,a5
 78a:	fd07031b          	addiw	t1,a4,-48
 78e:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 792:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 796:	0685                	addi	a3,a3,1
 798:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 79c:	0006071b          	sext.w	a4,a2
 7a0:	feb870e3          	bgeu	a6,a1,780 <atoi+0x3e>
    return neg ? n : -n;
 7a4:	000e0563          	beqz	t3,7ae <atoi+0x6c>
}
 7a8:	8082                	ret
        s++;
 7aa:	0505                	addi	a0,a0,1
 7ac:	bf71                	j	748 <atoi+0x6>
 7ae:	4113053b          	subw	a0,t1,a7
 7b2:	8082                	ret
    while (isdigit(*s))
 7b4:	00154783          	lbu	a5,1(a0)
 7b8:	4625                	li	a2,9
        s++;
 7ba:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7be:	fd07859b          	addiw	a1,a5,-48
 7c2:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 7c6:	4e01                	li	t3,0
    while (isdigit(*s))
 7c8:	fab67ae3          	bgeu	a2,a1,77c <atoi+0x3a>
 7cc:	4501                	li	a0,0
}
 7ce:	8082                	ret
    while (isdigit(*s))
 7d0:	00154783          	lbu	a5,1(a0)
 7d4:	4625                	li	a2,9
        s++;
 7d6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7da:	fd07859b          	addiw	a1,a5,-48
 7de:	0007871b          	sext.w	a4,a5
 7e2:	feb665e3          	bltu	a2,a1,7cc <atoi+0x8a>
        neg = 1;
 7e6:	4e05                	li	t3,1
 7e8:	bf51                	j	77c <atoi+0x3a>

00000000000007ea <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 7ea:	16060d63          	beqz	a2,964 <memset+0x17a>
 7ee:	40a007b3          	neg	a5,a0
 7f2:	8b9d                	andi	a5,a5,7
 7f4:	00778713          	addi	a4,a5,7
 7f8:	482d                	li	a6,11
 7fa:	0ff5f593          	andi	a1,a1,255
 7fe:	fff60693          	addi	a3,a2,-1
 802:	17076263          	bltu	a4,a6,966 <memset+0x17c>
 806:	16e6ea63          	bltu	a3,a4,97a <memset+0x190>
 80a:	16078563          	beqz	a5,974 <memset+0x18a>
 80e:	00b50023          	sb	a1,0(a0)
 812:	4705                	li	a4,1
 814:	00150e93          	addi	t4,a0,1
 818:	14e78c63          	beq	a5,a4,970 <memset+0x186>
 81c:	00b500a3          	sb	a1,1(a0)
 820:	4709                	li	a4,2
 822:	00250e93          	addi	t4,a0,2
 826:	14e78d63          	beq	a5,a4,980 <memset+0x196>
 82a:	00b50123          	sb	a1,2(a0)
 82e:	470d                	li	a4,3
 830:	00350e93          	addi	t4,a0,3
 834:	12e78b63          	beq	a5,a4,96a <memset+0x180>
 838:	00b501a3          	sb	a1,3(a0)
 83c:	4711                	li	a4,4
 83e:	00450e93          	addi	t4,a0,4
 842:	14e78163          	beq	a5,a4,984 <memset+0x19a>
 846:	00b50223          	sb	a1,4(a0)
 84a:	4715                	li	a4,5
 84c:	00550e93          	addi	t4,a0,5
 850:	12e78c63          	beq	a5,a4,988 <memset+0x19e>
 854:	00b502a3          	sb	a1,5(a0)
 858:	471d                	li	a4,7
 85a:	00650e93          	addi	t4,a0,6
 85e:	12e79763          	bne	a5,a4,98c <memset+0x1a2>
 862:	00750e93          	addi	t4,a0,7
 866:	00b50323          	sb	a1,6(a0)
 86a:	4f1d                	li	t5,7
 86c:	00859713          	slli	a4,a1,0x8
 870:	8f4d                	or	a4,a4,a1
 872:	01059e13          	slli	t3,a1,0x10
 876:	01c76e33          	or	t3,a4,t3
 87a:	01859313          	slli	t1,a1,0x18
 87e:	006e6333          	or	t1,t3,t1
 882:	02059893          	slli	a7,a1,0x20
 886:	011368b3          	or	a7,t1,a7
 88a:	02859813          	slli	a6,a1,0x28
 88e:	40f60333          	sub	t1,a2,a5
 892:	0108e833          	or	a6,a7,a6
 896:	03059693          	slli	a3,a1,0x30
 89a:	00d866b3          	or	a3,a6,a3
 89e:	03859713          	slli	a4,a1,0x38
 8a2:	97aa                	add	a5,a5,a0
 8a4:	ff837813          	andi	a6,t1,-8
 8a8:	8f55                	or	a4,a4,a3
 8aa:	00f806b3          	add	a3,a6,a5
 8ae:	e398                	sd	a4,0(a5)
 8b0:	07a1                	addi	a5,a5,8
 8b2:	fed79ee3          	bne	a5,a3,8ae <memset+0xc4>
 8b6:	ff837693          	andi	a3,t1,-8
 8ba:	00de87b3          	add	a5,t4,a3
 8be:	01e6873b          	addw	a4,a3,t5
 8c2:	0ad30663          	beq	t1,a3,96e <memset+0x184>
 8c6:	00b78023          	sb	a1,0(a5)
 8ca:	0017069b          	addiw	a3,a4,1
 8ce:	08c6fb63          	bgeu	a3,a2,964 <memset+0x17a>
 8d2:	00b780a3          	sb	a1,1(a5)
 8d6:	0027069b          	addiw	a3,a4,2
 8da:	08c6f563          	bgeu	a3,a2,964 <memset+0x17a>
 8de:	00b78123          	sb	a1,2(a5)
 8e2:	0037069b          	addiw	a3,a4,3
 8e6:	06c6ff63          	bgeu	a3,a2,964 <memset+0x17a>
 8ea:	00b781a3          	sb	a1,3(a5)
 8ee:	0047069b          	addiw	a3,a4,4
 8f2:	06c6f963          	bgeu	a3,a2,964 <memset+0x17a>
 8f6:	00b78223          	sb	a1,4(a5)
 8fa:	0057069b          	addiw	a3,a4,5
 8fe:	06c6f363          	bgeu	a3,a2,964 <memset+0x17a>
 902:	00b782a3          	sb	a1,5(a5)
 906:	0067069b          	addiw	a3,a4,6
 90a:	04c6fd63          	bgeu	a3,a2,964 <memset+0x17a>
 90e:	00b78323          	sb	a1,6(a5)
 912:	0077069b          	addiw	a3,a4,7
 916:	04c6f763          	bgeu	a3,a2,964 <memset+0x17a>
 91a:	00b783a3          	sb	a1,7(a5)
 91e:	0087069b          	addiw	a3,a4,8
 922:	04c6f163          	bgeu	a3,a2,964 <memset+0x17a>
 926:	00b78423          	sb	a1,8(a5)
 92a:	0097069b          	addiw	a3,a4,9
 92e:	02c6fb63          	bgeu	a3,a2,964 <memset+0x17a>
 932:	00b784a3          	sb	a1,9(a5)
 936:	00a7069b          	addiw	a3,a4,10
 93a:	02c6f563          	bgeu	a3,a2,964 <memset+0x17a>
 93e:	00b78523          	sb	a1,10(a5)
 942:	00b7069b          	addiw	a3,a4,11
 946:	00c6ff63          	bgeu	a3,a2,964 <memset+0x17a>
 94a:	00b785a3          	sb	a1,11(a5)
 94e:	00c7069b          	addiw	a3,a4,12
 952:	00c6f963          	bgeu	a3,a2,964 <memset+0x17a>
 956:	00b78623          	sb	a1,12(a5)
 95a:	2735                	addiw	a4,a4,13
 95c:	00c77463          	bgeu	a4,a2,964 <memset+0x17a>
 960:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 964:	8082                	ret
 966:	472d                	li	a4,11
 968:	bd79                	j	806 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 96a:	4f0d                	li	t5,3
 96c:	b701                	j	86c <memset+0x82>
 96e:	8082                	ret
 970:	4f05                	li	t5,1
 972:	bded                	j	86c <memset+0x82>
 974:	8eaa                	mv	t4,a0
 976:	4f01                	li	t5,0
 978:	bdd5                	j	86c <memset+0x82>
 97a:	87aa                	mv	a5,a0
 97c:	4701                	li	a4,0
 97e:	b7a1                	j	8c6 <memset+0xdc>
 980:	4f09                	li	t5,2
 982:	b5ed                	j	86c <memset+0x82>
 984:	4f11                	li	t5,4
 986:	b5dd                	j	86c <memset+0x82>
 988:	4f15                	li	t5,5
 98a:	b5cd                	j	86c <memset+0x82>
 98c:	4f19                	li	t5,6
 98e:	bdf9                	j	86c <memset+0x82>

0000000000000990 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 990:	00054783          	lbu	a5,0(a0)
 994:	0005c703          	lbu	a4,0(a1)
 998:	00e79863          	bne	a5,a4,9a8 <strcmp+0x18>
 99c:	0505                	addi	a0,a0,1
 99e:	0585                	addi	a1,a1,1
 9a0:	fbe5                	bnez	a5,990 <strcmp>
 9a2:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 9a4:	9d19                	subw	a0,a0,a4
 9a6:	8082                	ret
 9a8:	0007851b          	sext.w	a0,a5
 9ac:	bfe5                	j	9a4 <strcmp+0x14>

00000000000009ae <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 9ae:	ce05                	beqz	a2,9e6 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9b0:	00054703          	lbu	a4,0(a0)
 9b4:	0005c783          	lbu	a5,0(a1)
 9b8:	cb0d                	beqz	a4,9ea <strncmp+0x3c>
    if (!n--)
 9ba:	167d                	addi	a2,a2,-1
 9bc:	00c506b3          	add	a3,a0,a2
 9c0:	a819                	j	9d6 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9c2:	00a68e63          	beq	a3,a0,9de <strncmp+0x30>
 9c6:	0505                	addi	a0,a0,1
 9c8:	00e79b63          	bne	a5,a4,9de <strncmp+0x30>
 9cc:	00054703          	lbu	a4,0(a0)
 9d0:	0005c783          	lbu	a5,0(a1)
 9d4:	cb19                	beqz	a4,9ea <strncmp+0x3c>
 9d6:	0005c783          	lbu	a5,0(a1)
 9da:	0585                	addi	a1,a1,1
 9dc:	f3fd                	bnez	a5,9c2 <strncmp+0x14>
        ;
    return *l - *r;
 9de:	0007051b          	sext.w	a0,a4
 9e2:	9d1d                	subw	a0,a0,a5
 9e4:	8082                	ret
        return 0;
 9e6:	4501                	li	a0,0
}
 9e8:	8082                	ret
 9ea:	4501                	li	a0,0
    return *l - *r;
 9ec:	9d1d                	subw	a0,a0,a5
 9ee:	8082                	ret

00000000000009f0 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 9f0:	00757793          	andi	a5,a0,7
 9f4:	cf89                	beqz	a5,a0e <strlen+0x1e>
 9f6:	87aa                	mv	a5,a0
 9f8:	a029                	j	a02 <strlen+0x12>
 9fa:	0785                	addi	a5,a5,1
 9fc:	0077f713          	andi	a4,a5,7
 a00:	cb01                	beqz	a4,a10 <strlen+0x20>
        if (!*s)
 a02:	0007c703          	lbu	a4,0(a5)
 a06:	fb75                	bnez	a4,9fa <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 a08:	40a78533          	sub	a0,a5,a0
}
 a0c:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 a0e:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 a10:	6394                	ld	a3,0(a5)
 a12:	00000597          	auipc	a1,0x0
 a16:	5d65b583          	ld	a1,1494(a1) # fe8 <unlink+0x88>
 a1a:	00000617          	auipc	a2,0x0
 a1e:	5d663603          	ld	a2,1494(a2) # ff0 <unlink+0x90>
 a22:	a019                	j	a28 <strlen+0x38>
 a24:	6794                	ld	a3,8(a5)
 a26:	07a1                	addi	a5,a5,8
 a28:	00b68733          	add	a4,a3,a1
 a2c:	fff6c693          	not	a3,a3
 a30:	8f75                	and	a4,a4,a3
 a32:	8f71                	and	a4,a4,a2
 a34:	db65                	beqz	a4,a24 <strlen+0x34>
    for (; *s; s++)
 a36:	0007c703          	lbu	a4,0(a5)
 a3a:	d779                	beqz	a4,a08 <strlen+0x18>
 a3c:	0017c703          	lbu	a4,1(a5)
 a40:	0785                	addi	a5,a5,1
 a42:	d379                	beqz	a4,a08 <strlen+0x18>
 a44:	0017c703          	lbu	a4,1(a5)
 a48:	0785                	addi	a5,a5,1
 a4a:	fb6d                	bnez	a4,a3c <strlen+0x4c>
 a4c:	bf75                	j	a08 <strlen+0x18>

0000000000000a4e <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a4e:	00757713          	andi	a4,a0,7
{
 a52:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 a54:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a58:	cb19                	beqz	a4,a6e <memchr+0x20>
 a5a:	ce25                	beqz	a2,ad2 <memchr+0x84>
 a5c:	0007c703          	lbu	a4,0(a5)
 a60:	04b70e63          	beq	a4,a1,abc <memchr+0x6e>
 a64:	0785                	addi	a5,a5,1
 a66:	0077f713          	andi	a4,a5,7
 a6a:	167d                	addi	a2,a2,-1
 a6c:	f77d                	bnez	a4,a5a <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 a6e:	4501                	li	a0,0
    if (n && *s != c)
 a70:	c235                	beqz	a2,ad4 <memchr+0x86>
 a72:	0007c703          	lbu	a4,0(a5)
 a76:	04b70363          	beq	a4,a1,abc <memchr+0x6e>
        size_t k = ONES * c;
 a7a:	00000517          	auipc	a0,0x0
 a7e:	57e53503          	ld	a0,1406(a0) # ff8 <unlink+0x98>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 a82:	471d                	li	a4,7
        size_t k = ONES * c;
 a84:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 a88:	02c77a63          	bgeu	a4,a2,abc <memchr+0x6e>
 a8c:	00000897          	auipc	a7,0x0
 a90:	55c8b883          	ld	a7,1372(a7) # fe8 <unlink+0x88>
 a94:	00000817          	auipc	a6,0x0
 a98:	55c83803          	ld	a6,1372(a6) # ff0 <unlink+0x90>
 a9c:	431d                	li	t1,7
 a9e:	a029                	j	aa8 <memchr+0x5a>
 aa0:	1661                	addi	a2,a2,-8
 aa2:	07a1                	addi	a5,a5,8
 aa4:	02c37963          	bgeu	t1,a2,ad6 <memchr+0x88>
 aa8:	6398                	ld	a4,0(a5)
 aaa:	8f29                	xor	a4,a4,a0
 aac:	011706b3          	add	a3,a4,a7
 ab0:	fff74713          	not	a4,a4
 ab4:	8f75                	and	a4,a4,a3
 ab6:	01077733          	and	a4,a4,a6
 aba:	d37d                	beqz	a4,aa0 <memchr+0x52>
 abc:	853e                	mv	a0,a5
 abe:	97b2                	add	a5,a5,a2
 ac0:	a021                	j	ac8 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 ac2:	0505                	addi	a0,a0,1
 ac4:	00f50763          	beq	a0,a5,ad2 <memchr+0x84>
 ac8:	00054703          	lbu	a4,0(a0)
 acc:	feb71be3          	bne	a4,a1,ac2 <memchr+0x74>
 ad0:	8082                	ret
    return n ? (void *)s : 0;
 ad2:	4501                	li	a0,0
}
 ad4:	8082                	ret
    return n ? (void *)s : 0;
 ad6:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 ad8:	f275                	bnez	a2,abc <memchr+0x6e>
}
 ada:	8082                	ret

0000000000000adc <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 adc:	1101                	addi	sp,sp,-32
 ade:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 ae0:	862e                	mv	a2,a1
{
 ae2:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 ae4:	4581                	li	a1,0
{
 ae6:	e426                	sd	s1,8(sp)
 ae8:	ec06                	sd	ra,24(sp)
 aea:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 aec:	f63ff0ef          	jal	ra,a4e <memchr>
    return p ? p - s : n;
 af0:	c519                	beqz	a0,afe <strnlen+0x22>
}
 af2:	60e2                	ld	ra,24(sp)
 af4:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 af6:	8d05                	sub	a0,a0,s1
}
 af8:	64a2                	ld	s1,8(sp)
 afa:	6105                	addi	sp,sp,32
 afc:	8082                	ret
 afe:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 b00:	8522                	mv	a0,s0
}
 b02:	6442                	ld	s0,16(sp)
 b04:	64a2                	ld	s1,8(sp)
 b06:	6105                	addi	sp,sp,32
 b08:	8082                	ret

0000000000000b0a <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 b0a:	00b547b3          	xor	a5,a0,a1
 b0e:	8b9d                	andi	a5,a5,7
 b10:	eb95                	bnez	a5,b44 <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 b12:	0075f793          	andi	a5,a1,7
 b16:	e7b1                	bnez	a5,b62 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 b18:	6198                	ld	a4,0(a1)
 b1a:	00000617          	auipc	a2,0x0
 b1e:	4ce63603          	ld	a2,1230(a2) # fe8 <unlink+0x88>
 b22:	00000817          	auipc	a6,0x0
 b26:	4ce83803          	ld	a6,1230(a6) # ff0 <unlink+0x90>
 b2a:	a029                	j	b34 <stpcpy+0x2a>
 b2c:	e118                	sd	a4,0(a0)
 b2e:	6598                	ld	a4,8(a1)
 b30:	05a1                	addi	a1,a1,8
 b32:	0521                	addi	a0,a0,8
 b34:	00c707b3          	add	a5,a4,a2
 b38:	fff74693          	not	a3,a4
 b3c:	8ff5                	and	a5,a5,a3
 b3e:	0107f7b3          	and	a5,a5,a6
 b42:	d7ed                	beqz	a5,b2c <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 b44:	0005c783          	lbu	a5,0(a1)
 b48:	00f50023          	sb	a5,0(a0)
 b4c:	c785                	beqz	a5,b74 <stpcpy+0x6a>
 b4e:	0015c783          	lbu	a5,1(a1)
 b52:	0505                	addi	a0,a0,1
 b54:	0585                	addi	a1,a1,1
 b56:	00f50023          	sb	a5,0(a0)
 b5a:	fbf5                	bnez	a5,b4e <stpcpy+0x44>
        ;
    return d;
}
 b5c:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 b5e:	0505                	addi	a0,a0,1
 b60:	df45                	beqz	a4,b18 <stpcpy+0xe>
            if (!(*d = *s))
 b62:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 b66:	0585                	addi	a1,a1,1
 b68:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 b6c:	00f50023          	sb	a5,0(a0)
 b70:	f7fd                	bnez	a5,b5e <stpcpy+0x54>
}
 b72:	8082                	ret
 b74:	8082                	ret

0000000000000b76 <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 b76:	00b547b3          	xor	a5,a0,a1
 b7a:	8b9d                	andi	a5,a5,7
 b7c:	1a079863          	bnez	a5,d2c <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 b80:	0075f793          	andi	a5,a1,7
 b84:	16078463          	beqz	a5,cec <stpncpy+0x176>
 b88:	ea01                	bnez	a2,b98 <stpncpy+0x22>
 b8a:	a421                	j	d92 <stpncpy+0x21c>
 b8c:	167d                	addi	a2,a2,-1
 b8e:	0505                	addi	a0,a0,1
 b90:	14070e63          	beqz	a4,cec <stpncpy+0x176>
 b94:	1a060863          	beqz	a2,d44 <stpncpy+0x1ce>
 b98:	0005c783          	lbu	a5,0(a1)
 b9c:	0585                	addi	a1,a1,1
 b9e:	0075f713          	andi	a4,a1,7
 ba2:	00f50023          	sb	a5,0(a0)
 ba6:	f3fd                	bnez	a5,b8c <stpncpy+0x16>
 ba8:	4805                	li	a6,1
 baa:	1a061863          	bnez	a2,d5a <stpncpy+0x1e4>
 bae:	40a007b3          	neg	a5,a0
 bb2:	8b9d                	andi	a5,a5,7
 bb4:	4681                	li	a3,0
 bb6:	18061a63          	bnez	a2,d4a <stpncpy+0x1d4>
 bba:	00778713          	addi	a4,a5,7
 bbe:	45ad                	li	a1,11
 bc0:	18b76363          	bltu	a4,a1,d46 <stpncpy+0x1d0>
 bc4:	1ae6eb63          	bltu	a3,a4,d7a <stpncpy+0x204>
 bc8:	1a078363          	beqz	a5,d6e <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 bcc:	00050023          	sb	zero,0(a0)
 bd0:	4685                	li	a3,1
 bd2:	00150713          	addi	a4,a0,1
 bd6:	18d78f63          	beq	a5,a3,d74 <stpncpy+0x1fe>
 bda:	000500a3          	sb	zero,1(a0)
 bde:	4689                	li	a3,2
 be0:	00250713          	addi	a4,a0,2
 be4:	18d78e63          	beq	a5,a3,d80 <stpncpy+0x20a>
 be8:	00050123          	sb	zero,2(a0)
 bec:	468d                	li	a3,3
 bee:	00350713          	addi	a4,a0,3
 bf2:	16d78c63          	beq	a5,a3,d6a <stpncpy+0x1f4>
 bf6:	000501a3          	sb	zero,3(a0)
 bfa:	4691                	li	a3,4
 bfc:	00450713          	addi	a4,a0,4
 c00:	18d78263          	beq	a5,a3,d84 <stpncpy+0x20e>
 c04:	00050223          	sb	zero,4(a0)
 c08:	4695                	li	a3,5
 c0a:	00550713          	addi	a4,a0,5
 c0e:	16d78d63          	beq	a5,a3,d88 <stpncpy+0x212>
 c12:	000502a3          	sb	zero,5(a0)
 c16:	469d                	li	a3,7
 c18:	00650713          	addi	a4,a0,6
 c1c:	16d79863          	bne	a5,a3,d8c <stpncpy+0x216>
 c20:	00750713          	addi	a4,a0,7
 c24:	00050323          	sb	zero,6(a0)
 c28:	40f80833          	sub	a6,a6,a5
 c2c:	ff887593          	andi	a1,a6,-8
 c30:	97aa                	add	a5,a5,a0
 c32:	95be                	add	a1,a1,a5
 c34:	0007b023          	sd	zero,0(a5)
 c38:	07a1                	addi	a5,a5,8
 c3a:	feb79de3          	bne	a5,a1,c34 <stpncpy+0xbe>
 c3e:	ff887593          	andi	a1,a6,-8
 c42:	9ead                	addw	a3,a3,a1
 c44:	00b707b3          	add	a5,a4,a1
 c48:	12b80863          	beq	a6,a1,d78 <stpncpy+0x202>
 c4c:	00078023          	sb	zero,0(a5)
 c50:	0016871b          	addiw	a4,a3,1
 c54:	0ec77863          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 c58:	000780a3          	sb	zero,1(a5)
 c5c:	0026871b          	addiw	a4,a3,2
 c60:	0ec77263          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 c64:	00078123          	sb	zero,2(a5)
 c68:	0036871b          	addiw	a4,a3,3
 c6c:	0cc77c63          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 c70:	000781a3          	sb	zero,3(a5)
 c74:	0046871b          	addiw	a4,a3,4
 c78:	0cc77663          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 c7c:	00078223          	sb	zero,4(a5)
 c80:	0056871b          	addiw	a4,a3,5
 c84:	0cc77063          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 c88:	000782a3          	sb	zero,5(a5)
 c8c:	0066871b          	addiw	a4,a3,6
 c90:	0ac77a63          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 c94:	00078323          	sb	zero,6(a5)
 c98:	0076871b          	addiw	a4,a3,7
 c9c:	0ac77463          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 ca0:	000783a3          	sb	zero,7(a5)
 ca4:	0086871b          	addiw	a4,a3,8
 ca8:	08c77e63          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 cac:	00078423          	sb	zero,8(a5)
 cb0:	0096871b          	addiw	a4,a3,9
 cb4:	08c77863          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 cb8:	000784a3          	sb	zero,9(a5)
 cbc:	00a6871b          	addiw	a4,a3,10
 cc0:	08c77263          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 cc4:	00078523          	sb	zero,10(a5)
 cc8:	00b6871b          	addiw	a4,a3,11
 ccc:	06c77c63          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 cd0:	000785a3          	sb	zero,11(a5)
 cd4:	00c6871b          	addiw	a4,a3,12
 cd8:	06c77663          	bgeu	a4,a2,d44 <stpncpy+0x1ce>
 cdc:	00078623          	sb	zero,12(a5)
 ce0:	26b5                	addiw	a3,a3,13
 ce2:	06c6f163          	bgeu	a3,a2,d44 <stpncpy+0x1ce>
 ce6:	000786a3          	sb	zero,13(a5)
 cea:	8082                	ret
            ;
        if (!n || !*s)
 cec:	c645                	beqz	a2,d94 <stpncpy+0x21e>
 cee:	0005c783          	lbu	a5,0(a1)
 cf2:	ea078be3          	beqz	a5,ba8 <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 cf6:	479d                	li	a5,7
 cf8:	02c7ff63          	bgeu	a5,a2,d36 <stpncpy+0x1c0>
 cfc:	00000897          	auipc	a7,0x0
 d00:	2ec8b883          	ld	a7,748(a7) # fe8 <unlink+0x88>
 d04:	00000817          	auipc	a6,0x0
 d08:	2ec83803          	ld	a6,748(a6) # ff0 <unlink+0x90>
 d0c:	431d                	li	t1,7
 d0e:	6198                	ld	a4,0(a1)
 d10:	011707b3          	add	a5,a4,a7
 d14:	fff74693          	not	a3,a4
 d18:	8ff5                	and	a5,a5,a3
 d1a:	0107f7b3          	and	a5,a5,a6
 d1e:	ef81                	bnez	a5,d36 <stpncpy+0x1c0>
            *wd = *ws;
 d20:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d22:	1661                	addi	a2,a2,-8
 d24:	05a1                	addi	a1,a1,8
 d26:	0521                	addi	a0,a0,8
 d28:	fec363e3          	bltu	t1,a2,d0e <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 d2c:	e609                	bnez	a2,d36 <stpncpy+0x1c0>
 d2e:	a08d                	j	d90 <stpncpy+0x21a>
 d30:	167d                	addi	a2,a2,-1
 d32:	0505                	addi	a0,a0,1
 d34:	ca01                	beqz	a2,d44 <stpncpy+0x1ce>
 d36:	0005c783          	lbu	a5,0(a1)
 d3a:	0585                	addi	a1,a1,1
 d3c:	00f50023          	sb	a5,0(a0)
 d40:	fbe5                	bnez	a5,d30 <stpncpy+0x1ba>
        ;
tail:
 d42:	b59d                	j	ba8 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 d44:	8082                	ret
 d46:	472d                	li	a4,11
 d48:	bdb5                	j	bc4 <stpncpy+0x4e>
 d4a:	00778713          	addi	a4,a5,7
 d4e:	45ad                	li	a1,11
 d50:	fff60693          	addi	a3,a2,-1
 d54:	e6b778e3          	bgeu	a4,a1,bc4 <stpncpy+0x4e>
 d58:	b7fd                	j	d46 <stpncpy+0x1d0>
 d5a:	40a007b3          	neg	a5,a0
 d5e:	8832                	mv	a6,a2
 d60:	8b9d                	andi	a5,a5,7
 d62:	4681                	li	a3,0
 d64:	e4060be3          	beqz	a2,bba <stpncpy+0x44>
 d68:	b7cd                	j	d4a <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 d6a:	468d                	li	a3,3
 d6c:	bd75                	j	c28 <stpncpy+0xb2>
 d6e:	872a                	mv	a4,a0
 d70:	4681                	li	a3,0
 d72:	bd5d                	j	c28 <stpncpy+0xb2>
 d74:	4685                	li	a3,1
 d76:	bd4d                	j	c28 <stpncpy+0xb2>
 d78:	8082                	ret
 d7a:	87aa                	mv	a5,a0
 d7c:	4681                	li	a3,0
 d7e:	b5f9                	j	c4c <stpncpy+0xd6>
 d80:	4689                	li	a3,2
 d82:	b55d                	j	c28 <stpncpy+0xb2>
 d84:	4691                	li	a3,4
 d86:	b54d                	j	c28 <stpncpy+0xb2>
 d88:	4695                	li	a3,5
 d8a:	bd79                	j	c28 <stpncpy+0xb2>
 d8c:	4699                	li	a3,6
 d8e:	bd69                	j	c28 <stpncpy+0xb2>
 d90:	8082                	ret
 d92:	8082                	ret
 d94:	8082                	ret

0000000000000d96 <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 d96:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 d9a:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 d9c:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 da0:	2501                	sext.w	a0,a0
 da2:	8082                	ret

0000000000000da4 <close>:
    register long a7 __asm__("a7") = n;
 da4:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 da8:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 dac:	2501                	sext.w	a0,a0
 dae:	8082                	ret

0000000000000db0 <read>:
    register long a7 __asm__("a7") = n;
 db0:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 db4:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 db8:	8082                	ret

0000000000000dba <write>:
    register long a7 __asm__("a7") = n;
 dba:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dbe:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 dc2:	8082                	ret

0000000000000dc4 <getpid>:
    register long a7 __asm__("a7") = n;
 dc4:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 dc8:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 dcc:	2501                	sext.w	a0,a0
 dce:	8082                	ret

0000000000000dd0 <sched_yield>:
    register long a7 __asm__("a7") = n;
 dd0:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 dd4:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 dd8:	2501                	sext.w	a0,a0
 dda:	8082                	ret

0000000000000ddc <fork>:
    register long a7 __asm__("a7") = n;
 ddc:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 de0:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 de4:	2501                	sext.w	a0,a0
 de6:	8082                	ret

0000000000000de8 <exit>:
    register long a7 __asm__("a7") = n;
 de8:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 dec:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 df0:	8082                	ret

0000000000000df2 <waitpid>:
    register long a7 __asm__("a7") = n;
 df2:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 df6:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 dfa:	2501                	sext.w	a0,a0
 dfc:	8082                	ret

0000000000000dfe <exec>:
    register long a7 __asm__("a7") = n;
 dfe:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 e02:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 e06:	2501                	sext.w	a0,a0
 e08:	8082                	ret

0000000000000e0a <get_time>:

int64 get_time()
{
 e0a:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 e0c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e10:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e12:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e14:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 e18:	2501                	sext.w	a0,a0
 e1a:	ed09                	bnez	a0,e34 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e1c:	67a2                	ld	a5,8(sp)
 e1e:	3e800713          	li	a4,1000
 e22:	00015503          	lhu	a0,0(sp)
 e26:	02e7d7b3          	divu	a5,a5,a4
 e2a:	02e50533          	mul	a0,a0,a4
 e2e:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 e30:	0141                	addi	sp,sp,16
 e32:	8082                	ret
        return -1;
 e34:	557d                	li	a0,-1
 e36:	bfed                	j	e30 <get_time+0x26>

0000000000000e38 <sys_get_time>:
    register long a7 __asm__("a7") = n;
 e38:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e3c:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 e40:	2501                	sext.w	a0,a0
 e42:	8082                	ret

0000000000000e44 <sleep>:

int sleep(unsigned long long time)
{
 e44:	1141                	addi	sp,sp,-16
 e46:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 e48:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e4c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e4e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e50:	00000073          	ecall
    if (err == 0)
 e54:	2501                	sext.w	a0,a0
 e56:	e13d                	bnez	a0,ebc <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e58:	6722                	ld	a4,8(sp)
 e5a:	3e800693          	li	a3,1000
 e5e:	00015783          	lhu	a5,0(sp)
 e62:	02d75733          	divu	a4,a4,a3
 e66:	02d787b3          	mul	a5,a5,a3
 e6a:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 e6c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e70:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e72:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e74:	00000073          	ecall
    if (err == 0)
 e78:	2501                	sext.w	a0,a0
 e7a:	ed15                	bnez	a0,eb6 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e7c:	6841                	lui	a6,0x10
 e7e:	963e                	add	a2,a2,a5
 e80:	187d                	addi	a6,a6,-1
 e82:	3e800693          	li	a3,1000
 e86:	a819                	j	e9c <sleep+0x58>
    __asm_syscall("r"(a7))
 e88:	00000073          	ecall
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
 e9a:	ed11                	bnez	a0,eb6 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e9c:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 e9e:	07c00893          	li	a7,124
 ea2:	02d7d733          	divu	a4,a5,a3
 ea6:	6782                	ld	a5,0(sp)
 ea8:	0107f7b3          	and	a5,a5,a6
 eac:	02d787b3          	mul	a5,a5,a3
 eb0:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 eb2:	fcc7ebe3          	bltu	a5,a2,e88 <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 eb6:	4501                	li	a0,0
 eb8:	0141                	addi	sp,sp,16
 eba:	8082                	ret
 ebc:	57fd                	li	a5,-1
 ebe:	b77d                	j	e6c <sleep+0x28>

0000000000000ec0 <set_priority>:
    register long a7 __asm__("a7") = n;
 ec0:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 ec4:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 ec8:	2501                	sext.w	a0,a0
 eca:	8082                	ret

0000000000000ecc <mmap>:
    register long a7 __asm__("a7") = n;
 ecc:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 ed0:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 ed4:	2501                	sext.w	a0,a0
 ed6:	8082                	ret

0000000000000ed8 <munmap>:
    register long a7 __asm__("a7") = n;
 ed8:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 edc:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 ee0:	2501                	sext.w	a0,a0
 ee2:	8082                	ret

0000000000000ee4 <wait>:

int wait(int *code)
{
 ee4:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 ee6:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 eea:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 eec:	00000073          	ecall
    return waitpid(-1, code);
}
 ef0:	2501                	sext.w	a0,a0
 ef2:	8082                	ret

0000000000000ef4 <spawn>:
    register long a7 __asm__("a7") = n;
 ef4:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 ef8:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 efc:	2501                	sext.w	a0,a0
 efe:	8082                	ret

0000000000000f00 <mailread>:
    register long a7 __asm__("a7") = n;
 f00:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f04:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 f08:	2501                	sext.w	a0,a0
 f0a:	8082                	ret

0000000000000f0c <mailwrite>:
    register long a7 __asm__("a7") = n;
 f0c:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f10:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 f14:	2501                	sext.w	a0,a0
 f16:	8082                	ret

0000000000000f18 <fstat>:
    register long a7 __asm__("a7") = n;
 f18:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f1c:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 f20:	2501                	sext.w	a0,a0
 f22:	8082                	ret

0000000000000f24 <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 f24:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 f26:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 f2a:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f2c:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 f30:	2501                	sext.w	a0,a0
 f32:	8082                	ret

0000000000000f34 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 f34:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 f36:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 f3a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f3c:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 f40:	2501                	sext.w	a0,a0
 f42:	8082                	ret

0000000000000f44 <link>:

int link(char *old_path, char *new_path)
{
 f44:	87aa                	mv	a5,a0
 f46:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 f48:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 f4c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 f50:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 f52:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 f56:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f58:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 f5c:	2501                	sext.w	a0,a0
 f5e:	8082                	ret

0000000000000f60 <unlink>:

int unlink(char *path)
{
 f60:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f62:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 f66:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 f6a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f6c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 f70:	2501                	sext.w	a0,a0
 f72:	8082                	ret
