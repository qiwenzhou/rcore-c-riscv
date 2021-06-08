
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_0_setprio:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0820006f          	j	84 <__start_main>

0000000000000006 <main>:

/// 正确输出：（无报错信息）
/// Test set_priority OK!

int main()
{
   6:	1141                	addi	sp,sp,-16
    assert(set_priority(10) == 10);
   8:	4529                	li	a0,10
{
   a:	e406                	sd	ra,8(sp)
   c:	e022                	sd	s0,0(sp)
    assert(set_priority(10) == 10);
   e:	6e3000ef          	jal	ra,ef0 <set_priority>
  12:	47a9                	li	a5,10
  14:	00f50563          	beq	a0,a5,1e <main+0x18>
  18:	557d                	li	a0,-1
  1a:	5ff000ef          	jal	ra,e18 <exit>
    assert(set_priority(INT_MAX) == INT_MAX);
  1e:	80000437          	lui	s0,0x80000
  22:	fff44513          	not	a0,s0
  26:	6cb000ef          	jal	ra,ef0 <set_priority>
  2a:	fff44413          	not	s0,s0
  2e:	00850563          	beq	a0,s0,38 <main+0x32>
  32:	557d                	li	a0,-1
  34:	5e5000ef          	jal	ra,e18 <exit>
    assert(set_priority(0) == -1);
  38:	4501                	li	a0,0
  3a:	6b7000ef          	jal	ra,ef0 <set_priority>
  3e:	57fd                	li	a5,-1
  40:	00f50563          	beq	a0,a5,4a <main+0x44>
  44:	557d                	li	a0,-1
  46:	5d3000ef          	jal	ra,e18 <exit>
    assert(set_priority(1) == -1);
  4a:	4505                	li	a0,1
  4c:	6a5000ef          	jal	ra,ef0 <set_priority>
  50:	57fd                	li	a5,-1
  52:	00f50563          	beq	a0,a5,5c <main+0x56>
  56:	557d                	li	a0,-1
  58:	5c1000ef          	jal	ra,e18 <exit>
    assert(set_priority(-10) == -1);
  5c:	5559                	li	a0,-10
  5e:	693000ef          	jal	ra,ef0 <set_priority>
  62:	57fd                	li	a5,-1
  64:	00f50563          	beq	a0,a5,6e <main+0x68>
  68:	557d                	li	a0,-1
  6a:	5af000ef          	jal	ra,e18 <exit>
    puts("Test set_priority OK!");
  6e:	00001517          	auipc	a0,0x1
  72:	f3a50513          	addi	a0,a0,-198 # fa8 <unlink+0x18>
  76:	05e000ef          	jal	ra,d4 <puts>
    return 0;
}
  7a:	60a2                	ld	ra,8(sp)
  7c:	6402                	ld	s0,0(sp)
  7e:	4501                	li	a0,0
  80:	0141                	addi	sp,sp,16
  82:	8082                	ret

0000000000000084 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  84:	1141                	addi	sp,sp,-16
  86:	e406                	sd	ra,8(sp)
    exit(main());
  88:	f7fff0ef          	jal	ra,6 <main>
  8c:	58d000ef          	jal	ra,e18 <exit>
    return 0;
}
  90:	60a2                	ld	ra,8(sp)
  92:	4501                	li	a0,0
  94:	0141                	addi	sp,sp,16
  96:	8082                	ret

0000000000000098 <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  98:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  9a:	00f10593          	addi	a1,sp,15
  9e:	4605                	li	a2,1
  a0:	4501                	li	a0,0
{
  a2:	ec06                	sd	ra,24(sp)
    char byte = 0;
  a4:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  a8:	539000ef          	jal	ra,de0 <read>
    return byte;
}
  ac:	60e2                	ld	ra,24(sp)
  ae:	00f14503          	lbu	a0,15(sp)
  b2:	6105                	addi	sp,sp,32
  b4:	8082                	ret

00000000000000b6 <putchar>:

int putchar(int c)
{
  b6:	1101                	addi	sp,sp,-32
  b8:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  ba:	00f10593          	addi	a1,sp,15
  be:	4605                	li	a2,1
  c0:	4505                	li	a0,1
{
  c2:	ec06                	sd	ra,24(sp)
    char byte = c;
  c4:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  c8:	523000ef          	jal	ra,dea <write>
}
  cc:	60e2                	ld	ra,24(sp)
  ce:	2501                	sext.w	a0,a0
  d0:	6105                	addi	sp,sp,32
  d2:	8082                	ret

00000000000000d4 <puts>:

int puts(const char *s)
{
  d4:	1101                	addi	sp,sp,-32
  d6:	e822                	sd	s0,16(sp)
  d8:	ec06                	sd	ra,24(sp)
  da:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
  dc:	145000ef          	jal	ra,a20 <strlen>
  e0:	862a                	mv	a2,a0
  e2:	85a2                	mv	a1,s0
  e4:	4505                	li	a0,1
  e6:	505000ef          	jal	ra,dea <write>
  ea:	00055763          	bgez	a0,f8 <puts+0x24>
    return r;
}
  ee:	60e2                	ld	ra,24(sp)
  f0:	6442                	ld	s0,16(sp)
  f2:	557d                	li	a0,-1
  f4:	6105                	addi	sp,sp,32
  f6:	8082                	ret
    return write(stdout, &byte, 1);
  f8:	00f10593          	addi	a1,sp,15
    char byte = c;
  fc:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
  fe:	4605                	li	a2,1
 100:	4505                	li	a0,1
    char byte = c;
 102:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
 106:	4e5000ef          	jal	ra,dea <write>
}
 10a:	60e2                	ld	ra,24(sp)
 10c:	6442                	ld	s0,16(sp)
 10e:	41f5551b          	sraiw	a0,a0,0x1f
 112:	6105                	addi	sp,sp,32
 114:	8082                	ret

0000000000000116 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
 116:	7131                	addi	sp,sp,-192
 118:	ecce                	sd	s3,88(sp)
 11a:	e8d2                	sd	s4,80(sp)
 11c:	e4d6                	sd	s5,72(sp)
 11e:	e0da                	sd	s6,64(sp)
 120:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
 122:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
 124:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
 126:	6ae1                	lui	s5,0x18
 128:	000f4a37          	lui	s4,0xf4
 12c:	00989b37          	lui	s6,0x989
{
 130:	fc86                	sd	ra,120(sp)
 132:	f8a2                	sd	s0,112(sp)
 134:	f4a6                	sd	s1,104(sp)
 136:	f0ca                	sd	s2,96(sp)
 138:	fc5e                	sd	s7,56(sp)
 13a:	e52e                	sd	a1,136(sp)
 13c:	e932                	sd	a2,144(sp)
 13e:	ed36                	sd	a3,152(sp)
 140:	f13a                	sd	a4,160(sp)
 142:	f942                	sd	a6,176(sp)
 144:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
 146:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
 148:	70f98993          	addi	s3,s3,1807 # 270f <digits+0x172f>
 14c:	69fa8a93          	addi	s5,s5,1695 # 1869f <digits+0x176bf>
 150:	23fa0a13          	addi	s4,s4,575 # f423f <digits+0xf325f>
 154:	67fb0b13          	addi	s6,s6,1663 # 98967f <digits+0x98869f>
    for (;;)
    {
        if (!*s)
 158:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
 15c:	02500913          	li	s2,37
        if (!*s)
 160:	1a078f63          	beqz	a5,31e <printf+0x208>
 164:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 166:	17278e63          	beq	a5,s2,2e2 <printf+0x1cc>
 16a:	00164783          	lbu	a5,1(a2)
 16e:	0605                	addi	a2,a2,1
 170:	fbfd                	bnez	a5,166 <printf+0x50>
 172:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 174:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 178:	85aa                	mv	a1,a0
 17a:	8622                	mv	a2,s0
 17c:	4505                	li	a0,1
 17e:	46d000ef          	jal	ra,dea <write>
        out(f, a, l);
        if (l)
 182:	18041963          	bnez	s0,314 <printf+0x1fe>
            continue;
        if (s[1] == 0)
 186:	0014c783          	lbu	a5,1(s1)
 18a:	18078a63          	beqz	a5,31e <printf+0x208>
            break;
        switch (s[1])
 18e:	07300713          	li	a4,115
 192:	28e78e63          	beq	a5,a4,42e <printf+0x318>
 196:	18f76f63          	bltu	a4,a5,334 <printf+0x21e>
 19a:	06400713          	li	a4,100
 19e:	2ae78c63          	beq	a5,a4,456 <printf+0x340>
 1a2:	07000713          	li	a4,112
 1a6:	3ce79c63          	bne	a5,a4,57e <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 1aa:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1ac:	00001797          	auipc	a5,0x1
 1b0:	e3478793          	addi	a5,a5,-460 # fe0 <digits>
            printptr(va_arg(ap, uint64));
 1b4:	6298                	ld	a4,0(a3)
 1b6:	00868093          	addi	ra,a3,8
 1ba:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 1bc:	00471293          	slli	t0,a4,0x4
 1c0:	00c71f13          	slli	t5,a4,0xc
 1c4:	01471e13          	slli	t3,a4,0x14
 1c8:	01c71893          	slli	a7,a4,0x1c
 1cc:	02471813          	slli	a6,a4,0x24
 1d0:	02871513          	slli	a0,a4,0x28
 1d4:	02c71593          	slli	a1,a4,0x2c
 1d8:	03071693          	slli	a3,a4,0x30
 1dc:	00871f93          	slli	t6,a4,0x8
 1e0:	01071e93          	slli	t4,a4,0x10
 1e4:	01871313          	slli	t1,a4,0x18
 1e8:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1ec:	03c2d293          	srli	t0,t0,0x3c
 1f0:	03cf5f13          	srli	t5,t5,0x3c
 1f4:	03ce5e13          	srli	t3,t3,0x3c
 1f8:	03c8d893          	srli	a7,a7,0x3c
 1fc:	03c85813          	srli	a6,a6,0x3c
 200:	9171                	srli	a0,a0,0x3c
 202:	91f1                	srli	a1,a1,0x3c
 204:	92f1                	srli	a3,a3,0x3c
 206:	92be                	add	t0,t0,a5
 208:	9f3e                	add	t5,t5,a5
 20a:	9e3e                	add	t3,t3,a5
 20c:	98be                	add	a7,a7,a5
 20e:	983e                	add	a6,a6,a5
 210:	953e                	add	a0,a0,a5
 212:	95be                	add	a1,a1,a5
 214:	96be                	add	a3,a3,a5
 216:	03c75393          	srli	t2,a4,0x3c
 21a:	01c75b9b          	srliw	s7,a4,0x1c
 21e:	03cfdf93          	srli	t6,t6,0x3c
 222:	03cede93          	srli	t4,t4,0x3c
 226:	03c35313          	srli	t1,t1,0x3c
 22a:	9271                	srli	a2,a2,0x3c
 22c:	0002c403          	lbu	s0,0(t0)
 230:	93be                	add	t2,t2,a5
 232:	000f4283          	lbu	t0,0(t5)
 236:	9fbe                	add	t6,t6,a5
 238:	000e4f03          	lbu	t5,0(t3)
 23c:	9ebe                	add	t4,t4,a5
 23e:	0008ce03          	lbu	t3,0(a7)
 242:	933e                	add	t1,t1,a5
 244:	00084883          	lbu	a7,0(a6)
 248:	9bbe                	add	s7,s7,a5
 24a:	00054803          	lbu	a6,0(a0)
 24e:	963e                	add	a2,a2,a5
 250:	0005c503          	lbu	a0,0(a1)
 254:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 258:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 25c:	0003c903          	lbu	s2,0(t2)
 260:	00064603          	lbu	a2,0(a2)
 264:	000fc383          	lbu	t2,0(t6)
 268:	8b3d                	andi	a4,a4,15
 26a:	000ecf83          	lbu	t6,0(t4)
 26e:	92f1                	srli	a3,a3,0x3c
 270:	00034e83          	lbu	t4,0(t1)
 274:	000bc303          	lbu	t1,0(s7)
 278:	96be                	add	a3,a3,a5
 27a:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 27c:	7761                	lui	a4,0xffff8
 27e:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 282:	00710623          	sb	t2,12(sp)
 286:	005106a3          	sb	t0,13(sp)
 28a:	01f10723          	sb	t6,14(sp)
 28e:	01e107a3          	sb	t5,15(sp)
 292:	01d10823          	sb	t4,16(sp)
 296:	01c108a3          	sb	t3,17(sp)
 29a:	00610923          	sb	t1,18(sp)
 29e:	011109a3          	sb	a7,19(sp)
 2a2:	01010a23          	sb	a6,20(sp)
 2a6:	00a10aa3          	sb	a0,21(sp)
 2aa:	00b10b23          	sb	a1,22(sp)
 2ae:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 2b2:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2b6:	01210523          	sb	s2,10(sp)
 2ba:	008105a3          	sb	s0,11(sp)
 2be:	0006c703          	lbu	a4,0(a3)
 2c2:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 2c6:	4649                	li	a2,18
 2c8:	002c                	addi	a1,sp,8
 2ca:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2cc:	00e10c23          	sb	a4,24(sp)
 2d0:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 2d4:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 2d8:	313000ef          	jal	ra,dea <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 2dc:	00248513          	addi	a0,s1,2
 2e0:	bda5                	j	158 <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 2e2:	00064783          	lbu	a5,0(a2)
 2e6:	84b2                	mv	s1,a2
 2e8:	01278963          	beq	a5,s2,2fa <printf+0x1e4>
 2ec:	b561                	j	174 <printf+0x5e>
 2ee:	0024c783          	lbu	a5,2(s1)
 2f2:	0605                	addi	a2,a2,1
 2f4:	0489                	addi	s1,s1,2
 2f6:	e7279fe3          	bne	a5,s2,174 <printf+0x5e>
 2fa:	0014c783          	lbu	a5,1(s1)
 2fe:	ff2788e3          	beq	a5,s2,2ee <printf+0x1d8>
        l = z - a;
 302:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 306:	85aa                	mv	a1,a0
 308:	8622                	mv	a2,s0
 30a:	4505                	li	a0,1
 30c:	2df000ef          	jal	ra,dea <write>
        if (l)
 310:	e6040be3          	beqz	s0,186 <printf+0x70>
 314:	8526                	mv	a0,s1
        if (!*s)
 316:	00054783          	lbu	a5,0(a0)
 31a:	e40795e3          	bnez	a5,164 <printf+0x4e>
    }
    va_end(ap);
 31e:	70e6                	ld	ra,120(sp)
 320:	7446                	ld	s0,112(sp)
 322:	74a6                	ld	s1,104(sp)
 324:	7906                	ld	s2,96(sp)
 326:	69e6                	ld	s3,88(sp)
 328:	6a46                	ld	s4,80(sp)
 32a:	6aa6                	ld	s5,72(sp)
 32c:	6b06                	ld	s6,64(sp)
 32e:	7be2                	ld	s7,56(sp)
 330:	6129                	addi	sp,sp,192
 332:	8082                	ret
        switch (s[1])
 334:	07800713          	li	a4,120
 338:	24e79363          	bne	a5,a4,57e <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 33c:	6782                	ld	a5,0(sp)
 33e:	4394                	lw	a3,0(a5)
 340:	07a1                	addi	a5,a5,8
 342:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 344:	2606c263          	bltz	a3,5a8 <printf+0x492>
        buf[i--] = digits[x % base];
 348:	00001797          	auipc	a5,0x1
 34c:	c9878793          	addi	a5,a5,-872 # fe0 <digits>
 350:	00f6f713          	andi	a4,a3,15
 354:	973e                	add	a4,a4,a5
 356:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <digits+0xffffffffffff7020>
    buf[16] = 0;
 35a:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 35e:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 360:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 364:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 368:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 36c:	0046d51b          	srliw	a0,a3,0x4
 370:	0ad5d563          	bge	a1,a3,41a <printf+0x304>
        buf[i--] = digits[x % base];
 374:	8a3d                	andi	a2,a2,15
 376:	963e                	add	a2,a2,a5
 378:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 37c:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 380:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 384:	30a5fe63          	bgeu	a1,a0,6a0 <printf+0x58a>
        buf[i--] = digits[x % base];
 388:	00f77613          	andi	a2,a4,15
 38c:	963e                	add	a2,a2,a5
 38e:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 392:	45bd                	li	a1,15
 394:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 398:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 39c:	00475513          	srli	a0,a4,0x4
 3a0:	30e5f963          	bgeu	a1,a4,6b2 <printf+0x59c>
        buf[i--] = digits[x % base];
 3a4:	8a3d                	andi	a2,a2,15
 3a6:	963e                	add	a2,a2,a5
 3a8:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 3ac:	00875893          	srli	a7,a4,0x8
 3b0:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 3b4:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 3b8:	30a5fd63          	bgeu	a1,a0,6d2 <printf+0x5bc>
        buf[i--] = digits[x % base];
 3bc:	8a3d                	andi	a2,a2,15
 3be:	963e                	add	a2,a2,a5
 3c0:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3c4:	00c75813          	srli	a6,a4,0xc
 3c8:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 3cc:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 3d0:	3315fe63          	bgeu	a1,a7,70c <printf+0x5f6>
        buf[i--] = digits[x % base];
 3d4:	8a3d                	andi	a2,a2,15
 3d6:	963e                	add	a2,a2,a5
 3d8:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3dc:	01075893          	srli	a7,a4,0x10
 3e0:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 3e4:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 3e8:	3305ff63          	bgeu	a1,a6,726 <printf+0x610>
        buf[i--] = digits[x % base];
 3ec:	8a3d                	andi	a2,a2,15
 3ee:	963e                	add	a2,a2,a5
 3f0:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 3f4:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 3f8:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 3fc:	3515f863          	bgeu	a1,a7,74c <printf+0x636>
        buf[i--] = digits[x % base];
 400:	97ba                	add	a5,a5,a4
 402:	0007c783          	lbu	a5,0(a5)
 406:	45a1                	li	a1,8
 408:	00f10823          	sb	a5,16(sp)
    if (sign)
 40c:	0006d763          	bgez	a3,41a <printf+0x304>
        buf[i--] = '-';
 410:	02d00793          	li	a5,45
 414:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 418:	459d                	li	a1,7
    write(f, s, l);
 41a:	4641                	li	a2,16
 41c:	003c                	addi	a5,sp,8
 41e:	9e0d                	subw	a2,a2,a1
 420:	4505                	li	a0,1
 422:	95be                	add	a1,a1,a5
 424:	1c7000ef          	jal	ra,dea <write>
        s += 2;
 428:	00248513          	addi	a0,s1,2
 42c:	b335                	j	158 <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 42e:	6782                	ld	a5,0(sp)
 430:	6380                	ld	s0,0(a5)
 432:	07a1                	addi	a5,a5,8
 434:	e03e                	sd	a5,0(sp)
 436:	22040a63          	beqz	s0,66a <printf+0x554>
            l = strnlen(a, 200);
 43a:	0c800593          	li	a1,200
 43e:	8522                	mv	a0,s0
 440:	6cc000ef          	jal	ra,b0c <strnlen>
    write(f, s, l);
 444:	0005061b          	sext.w	a2,a0
 448:	85a2                	mv	a1,s0
 44a:	4505                	li	a0,1
 44c:	19f000ef          	jal	ra,dea <write>
        s += 2;
 450:	00248513          	addi	a0,s1,2
 454:	b311                	j	158 <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 456:	6782                	ld	a5,0(sp)
 458:	4390                	lw	a2,0(a5)
 45a:	07a1                	addi	a5,a5,8
 45c:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 45e:	1a064363          	bltz	a2,604 <printf+0x4ee>
        buf[i--] = digits[x % base];
 462:	46a9                	li	a3,10
 464:	02d6773b          	remuw	a4,a2,a3
 468:	00001797          	auipc	a5,0x1
 46c:	b7878793          	addi	a5,a5,-1160 # fe0 <digits>
    buf[16] = 0;
 470:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 474:	4525                	li	a0,9
        x = xx;
 476:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 47a:	973e                	add	a4,a4,a5
 47c:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 480:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 484:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 488:	2cc55063          	bge	a0,a2,748 <printf+0x632>
 48c:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 490:	02d5f73b          	remuw	a4,a1,a3
 494:	1702                	slli	a4,a4,0x20
 496:	9301                	srli	a4,a4,0x20
 498:	973e                	add	a4,a4,a5
 49a:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 49e:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 4a2:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 4a6:	1f057d63          	bgeu	a0,a6,6a0 <printf+0x58a>
        buf[i--] = digits[x % base];
 4aa:	4529                	li	a0,10
    } while ((x /= base) != 0);
 4ac:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 4ae:	02a5f73b          	remuw	a4,a1,a0
 4b2:	973e                	add	a4,a4,a5
 4b4:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 4b8:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 4bc:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 4c0:	1ab6f163          	bgeu	a3,a1,662 <printf+0x54c>
 4c4:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 4c8:	02a776bb          	remuw	a3,a4,a0
 4cc:	96be                	add	a3,a3,a5
 4ce:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4d2:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4d6:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 4da:	20b87c63          	bgeu	a6,a1,6f2 <printf+0x5dc>
 4de:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 4e2:	02a776bb          	remuw	a3,a4,a0
 4e6:	96be                	add	a3,a3,a5
 4e8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4ec:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4f0:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 4f4:	20b87363          	bgeu	a6,a1,6fa <printf+0x5e4>
        buf[i--] = digits[x % base];
 4f8:	02a776bb          	remuw	a3,a4,a0
 4fc:	96be                	add	a3,a3,a5
 4fe:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 502:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 506:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 50a:	20b9f563          	bgeu	s3,a1,714 <printf+0x5fe>
        buf[i--] = digits[x % base];
 50e:	02a776bb          	remuw	a3,a4,a0
 512:	96be                	add	a3,a3,a5
 514:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 518:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 51c:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 520:	20bafb63          	bgeu	s5,a1,736 <printf+0x620>
        buf[i--] = digits[x % base];
 524:	02a776bb          	remuw	a3,a4,a0
 528:	96be                	add	a3,a3,a5
 52a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 52e:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 532:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 536:	1eba7c63          	bgeu	s4,a1,72e <printf+0x618>
        buf[i--] = digits[x % base];
 53a:	02a776bb          	remuw	a3,a4,a0
 53e:	96be                	add	a3,a3,a5
 540:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 544:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 548:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 54c:	14bb7163          	bgeu	s6,a1,68e <printf+0x578>
        buf[i--] = digits[x % base];
 550:	1702                	slli	a4,a4,0x20
 552:	9301                	srli	a4,a4,0x20
 554:	97ba                	add	a5,a5,a4
 556:	0007c783          	lbu	a5,0(a5)
 55a:	4599                	li	a1,6
 55c:	00f10723          	sb	a5,14(sp)
    if (sign)
 560:	ea065de3          	bgez	a2,41a <printf+0x304>
        buf[i--] = '-';
 564:	02d00793          	li	a5,45
 568:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 56c:	4595                	li	a1,5
    write(f, s, l);
 56e:	003c                	addi	a5,sp,8
 570:	4641                	li	a2,16
 572:	9e0d                	subw	a2,a2,a1
 574:	4505                	li	a0,1
 576:	95be                	add	a1,a1,a5
 578:	073000ef          	jal	ra,dea <write>
 57c:	b575                	j	428 <printf+0x312>
    char byte = c;
 57e:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 582:	4605                	li	a2,1
 584:	002c                	addi	a1,sp,8
 586:	4505                	li	a0,1
    char byte = c;
 588:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 58c:	05f000ef          	jal	ra,dea <write>
    char byte = c;
 590:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 594:	4605                	li	a2,1
 596:	002c                	addi	a1,sp,8
 598:	4505                	li	a0,1
    char byte = c;
 59a:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 59e:	04d000ef          	jal	ra,dea <write>
        s += 2;
 5a2:	00248513          	addi	a0,s1,2
 5a6:	be4d                	j	158 <printf+0x42>
        x = -xx;
 5a8:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 5ac:	00001797          	auipc	a5,0x1
 5b0:	a3478793          	addi	a5,a5,-1484 # fe0 <digits>
 5b4:	00f77613          	andi	a2,a4,15
 5b8:	963e                	add	a2,a2,a5
 5ba:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 5be:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5c2:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 5c4:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 5c8:	0047551b          	srliw	a0,a4,0x4
 5cc:	0047561b          	srliw	a2,a4,0x4
 5d0:	0ab6d263          	bge	a3,a1,674 <printf+0x55e>
        buf[i--] = digits[x % base];
 5d4:	8a3d                	andi	a2,a2,15
 5d6:	963e                	add	a2,a2,a5
 5d8:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 5dc:	463d                	li	a2,15
 5de:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 5e2:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 5e6:	daa661e3          	bltu	a2,a0,388 <printf+0x272>
        buf[i--] = '-';
 5ea:	02d00793          	li	a5,45
 5ee:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 5f2:	45b5                	li	a1,13
    write(f, s, l);
 5f4:	003c                	addi	a5,sp,8
 5f6:	4641                	li	a2,16
 5f8:	9e0d                	subw	a2,a2,a1
 5fa:	4505                	li	a0,1
 5fc:	95be                	add	a1,a1,a5
 5fe:	7ec000ef          	jal	ra,dea <write>
 602:	b51d                	j	428 <printf+0x312>
        x = -xx;
 604:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 608:	46a9                	li	a3,10
 60a:	02d875bb          	remuw	a1,a6,a3
 60e:	00001797          	auipc	a5,0x1
 612:	9d278793          	addi	a5,a5,-1582 # fe0 <digits>
    buf[16] = 0;
 616:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 61a:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 61c:	95be                	add	a1,a1,a5
 61e:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 622:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 626:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 62a:	04a65563          	bge	a2,a0,674 <printf+0x55e>
 62e:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 632:	02d775bb          	remuw	a1,a4,a3
 636:	95be                	add	a1,a1,a5
 638:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 63c:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 640:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 644:	fb0573e3          	bgeu	a0,a6,5ea <printf+0x4d4>
        buf[i--] = digits[x % base];
 648:	4529                	li	a0,10
    } while ((x /= base) != 0);
 64a:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 64c:	02a5f73b          	remuw	a4,a1,a0
 650:	973e                	add	a4,a4,a5
 652:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 656:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 65a:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 65e:	e6b6e3e3          	bltu	a3,a1,4c4 <printf+0x3ae>
        buf[i--] = digits[x % base];
 662:	45b5                	li	a1,13
    if (sign)
 664:	da065be3          	bgez	a2,41a <printf+0x304>
 668:	a881                	j	6b8 <printf+0x5a2>
                a = "(null)";
 66a:	00001417          	auipc	s0,0x1
 66e:	95640413          	addi	s0,s0,-1706 # fc0 <unlink+0x30>
 672:	b3e1                	j	43a <printf+0x324>
        buf[i--] = '-';
 674:	02d00793          	li	a5,45
 678:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 67c:	45b9                	li	a1,14
    write(f, s, l);
 67e:	003c                	addi	a5,sp,8
 680:	4641                	li	a2,16
 682:	9e0d                	subw	a2,a2,a1
 684:	4505                	li	a0,1
 686:	95be                	add	a1,a1,a5
 688:	762000ef          	jal	ra,dea <write>
 68c:	bb71                	j	428 <printf+0x312>
        buf[i--] = digits[x % base];
 68e:	459d                	li	a1,7
    if (sign)
 690:	d80655e3          	bgez	a2,41a <printf+0x304>
        buf[i--] = '-';
 694:	02d00793          	li	a5,45
 698:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 69c:	4599                	li	a1,6
 69e:	bbb5                	j	41a <printf+0x304>
 6a0:	45b9                	li	a1,14
    write(f, s, l);
 6a2:	003c                	addi	a5,sp,8
 6a4:	4641                	li	a2,16
 6a6:	9e0d                	subw	a2,a2,a1
 6a8:	4505                	li	a0,1
 6aa:	95be                	add	a1,a1,a5
 6ac:	73e000ef          	jal	ra,dea <write>
 6b0:	bba5                	j	428 <printf+0x312>
        buf[i--] = digits[x % base];
 6b2:	45b5                	li	a1,13
    if (sign)
 6b4:	d606d3e3          	bgez	a3,41a <printf+0x304>
        buf[i--] = '-';
 6b8:	02d00793          	li	a5,45
 6bc:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 6c0:	45b1                	li	a1,12
    write(f, s, l);
 6c2:	003c                	addi	a5,sp,8
 6c4:	4641                	li	a2,16
 6c6:	9e0d                	subw	a2,a2,a1
 6c8:	4505                	li	a0,1
 6ca:	95be                	add	a1,a1,a5
 6cc:	71e000ef          	jal	ra,dea <write>
 6d0:	bba1                	j	428 <printf+0x312>
        buf[i--] = digits[x % base];
 6d2:	45b1                	li	a1,12
    if (sign)
 6d4:	d406d3e3          	bgez	a3,41a <printf+0x304>
        buf[i--] = '-';
 6d8:	02d00793          	li	a5,45
 6dc:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 6e0:	45ad                	li	a1,11
    write(f, s, l);
 6e2:	003c                	addi	a5,sp,8
 6e4:	4641                	li	a2,16
 6e6:	9e0d                	subw	a2,a2,a1
 6e8:	4505                	li	a0,1
 6ea:	95be                	add	a1,a1,a5
 6ec:	6fe000ef          	jal	ra,dea <write>
 6f0:	bb25                	j	428 <printf+0x312>
        buf[i--] = digits[x % base];
 6f2:	45b1                	li	a1,12
    if (sign)
 6f4:	d20653e3          	bgez	a2,41a <printf+0x304>
 6f8:	b7c5                	j	6d8 <printf+0x5c2>
        buf[i--] = digits[x % base];
 6fa:	45ad                	li	a1,11
    if (sign)
 6fc:	d0065fe3          	bgez	a2,41a <printf+0x304>
        buf[i--] = '-';
 700:	02d00793          	li	a5,45
 704:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 708:	45a9                	li	a1,10
 70a:	bb01                	j	41a <printf+0x304>
 70c:	45ad                	li	a1,11
    if (sign)
 70e:	d006d6e3          	bgez	a3,41a <printf+0x304>
 712:	b7fd                	j	700 <printf+0x5ea>
        buf[i--] = digits[x % base];
 714:	45a9                	li	a1,10
    if (sign)
 716:	d00652e3          	bgez	a2,41a <printf+0x304>
        buf[i--] = '-';
 71a:	02d00793          	li	a5,45
 71e:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 722:	45a5                	li	a1,9
 724:	b9dd                	j	41a <printf+0x304>
 726:	45a9                	li	a1,10
    if (sign)
 728:	ce06d9e3          	bgez	a3,41a <printf+0x304>
 72c:	b7fd                	j	71a <printf+0x604>
        buf[i--] = digits[x % base];
 72e:	45a1                	li	a1,8
    if (sign)
 730:	ce0655e3          	bgez	a2,41a <printf+0x304>
 734:	b9f1                	j	410 <printf+0x2fa>
        buf[i--] = digits[x % base];
 736:	45a5                	li	a1,9
    if (sign)
 738:	ce0651e3          	bgez	a2,41a <printf+0x304>
        buf[i--] = '-';
 73c:	02d00793          	li	a5,45
 740:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 744:	45a1                	li	a1,8
 746:	b9d1                	j	41a <printf+0x304>
    i = 15;
 748:	45bd                	li	a1,15
 74a:	b9c1                	j	41a <printf+0x304>
        buf[i--] = digits[x % base];
 74c:	45a5                	li	a1,9
    if (sign)
 74e:	cc06d6e3          	bgez	a3,41a <printf+0x304>
 752:	b7ed                	j	73c <printf+0x626>

0000000000000754 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 754:	02000793          	li	a5,32
 758:	00f50663          	beq	a0,a5,764 <isspace+0x10>
 75c:	355d                	addiw	a0,a0,-9
 75e:	00553513          	sltiu	a0,a0,5
 762:	8082                	ret
 764:	4505                	li	a0,1
}
 766:	8082                	ret

0000000000000768 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 768:	fd05051b          	addiw	a0,a0,-48
}
 76c:	00a53513          	sltiu	a0,a0,10
 770:	8082                	ret

0000000000000772 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 772:	02000613          	li	a2,32
 776:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 778:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 77c:	ff77069b          	addiw	a3,a4,-9
 780:	04c70d63          	beq	a4,a2,7da <atoi+0x68>
 784:	0007079b          	sext.w	a5,a4
 788:	04d5f963          	bgeu	a1,a3,7da <atoi+0x68>
        s++;
    switch (*s)
 78c:	02b00693          	li	a3,43
 790:	04d70a63          	beq	a4,a3,7e4 <atoi+0x72>
 794:	02d00693          	li	a3,45
 798:	06d70463          	beq	a4,a3,800 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 79c:	fd07859b          	addiw	a1,a5,-48
 7a0:	4625                	li	a2,9
 7a2:	873e                	mv	a4,a5
 7a4:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 7a6:	4e01                	li	t3,0
    while (isdigit(*s))
 7a8:	04b66a63          	bltu	a2,a1,7fc <atoi+0x8a>
    int n = 0, neg = 0;
 7ac:	4501                	li	a0,0
    while (isdigit(*s))
 7ae:	4825                	li	a6,9
 7b0:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 7b4:	0025179b          	slliw	a5,a0,0x2
 7b8:	9d3d                	addw	a0,a0,a5
 7ba:	fd07031b          	addiw	t1,a4,-48
 7be:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 7c2:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 7c6:	0685                	addi	a3,a3,1
 7c8:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 7cc:	0006071b          	sext.w	a4,a2
 7d0:	feb870e3          	bgeu	a6,a1,7b0 <atoi+0x3e>
    return neg ? n : -n;
 7d4:	000e0563          	beqz	t3,7de <atoi+0x6c>
}
 7d8:	8082                	ret
        s++;
 7da:	0505                	addi	a0,a0,1
 7dc:	bf71                	j	778 <atoi+0x6>
 7de:	4113053b          	subw	a0,t1,a7
 7e2:	8082                	ret
    while (isdigit(*s))
 7e4:	00154783          	lbu	a5,1(a0)
 7e8:	4625                	li	a2,9
        s++;
 7ea:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7ee:	fd07859b          	addiw	a1,a5,-48
 7f2:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 7f6:	4e01                	li	t3,0
    while (isdigit(*s))
 7f8:	fab67ae3          	bgeu	a2,a1,7ac <atoi+0x3a>
 7fc:	4501                	li	a0,0
}
 7fe:	8082                	ret
    while (isdigit(*s))
 800:	00154783          	lbu	a5,1(a0)
 804:	4625                	li	a2,9
        s++;
 806:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 80a:	fd07859b          	addiw	a1,a5,-48
 80e:	0007871b          	sext.w	a4,a5
 812:	feb665e3          	bltu	a2,a1,7fc <atoi+0x8a>
        neg = 1;
 816:	4e05                	li	t3,1
 818:	bf51                	j	7ac <atoi+0x3a>

000000000000081a <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 81a:	16060d63          	beqz	a2,994 <memset+0x17a>
 81e:	40a007b3          	neg	a5,a0
 822:	8b9d                	andi	a5,a5,7
 824:	00778713          	addi	a4,a5,7
 828:	482d                	li	a6,11
 82a:	0ff5f593          	andi	a1,a1,255
 82e:	fff60693          	addi	a3,a2,-1
 832:	17076263          	bltu	a4,a6,996 <memset+0x17c>
 836:	16e6ea63          	bltu	a3,a4,9aa <memset+0x190>
 83a:	16078563          	beqz	a5,9a4 <memset+0x18a>
 83e:	00b50023          	sb	a1,0(a0)
 842:	4705                	li	a4,1
 844:	00150e93          	addi	t4,a0,1
 848:	14e78c63          	beq	a5,a4,9a0 <memset+0x186>
 84c:	00b500a3          	sb	a1,1(a0)
 850:	4709                	li	a4,2
 852:	00250e93          	addi	t4,a0,2
 856:	14e78d63          	beq	a5,a4,9b0 <memset+0x196>
 85a:	00b50123          	sb	a1,2(a0)
 85e:	470d                	li	a4,3
 860:	00350e93          	addi	t4,a0,3
 864:	12e78b63          	beq	a5,a4,99a <memset+0x180>
 868:	00b501a3          	sb	a1,3(a0)
 86c:	4711                	li	a4,4
 86e:	00450e93          	addi	t4,a0,4
 872:	14e78163          	beq	a5,a4,9b4 <memset+0x19a>
 876:	00b50223          	sb	a1,4(a0)
 87a:	4715                	li	a4,5
 87c:	00550e93          	addi	t4,a0,5
 880:	12e78c63          	beq	a5,a4,9b8 <memset+0x19e>
 884:	00b502a3          	sb	a1,5(a0)
 888:	471d                	li	a4,7
 88a:	00650e93          	addi	t4,a0,6
 88e:	12e79763          	bne	a5,a4,9bc <memset+0x1a2>
 892:	00750e93          	addi	t4,a0,7
 896:	00b50323          	sb	a1,6(a0)
 89a:	4f1d                	li	t5,7
 89c:	00859713          	slli	a4,a1,0x8
 8a0:	8f4d                	or	a4,a4,a1
 8a2:	01059e13          	slli	t3,a1,0x10
 8a6:	01c76e33          	or	t3,a4,t3
 8aa:	01859313          	slli	t1,a1,0x18
 8ae:	006e6333          	or	t1,t3,t1
 8b2:	02059893          	slli	a7,a1,0x20
 8b6:	011368b3          	or	a7,t1,a7
 8ba:	02859813          	slli	a6,a1,0x28
 8be:	40f60333          	sub	t1,a2,a5
 8c2:	0108e833          	or	a6,a7,a6
 8c6:	03059693          	slli	a3,a1,0x30
 8ca:	00d866b3          	or	a3,a6,a3
 8ce:	03859713          	slli	a4,a1,0x38
 8d2:	97aa                	add	a5,a5,a0
 8d4:	ff837813          	andi	a6,t1,-8
 8d8:	8f55                	or	a4,a4,a3
 8da:	00f806b3          	add	a3,a6,a5
 8de:	e398                	sd	a4,0(a5)
 8e0:	07a1                	addi	a5,a5,8
 8e2:	fed79ee3          	bne	a5,a3,8de <memset+0xc4>
 8e6:	ff837693          	andi	a3,t1,-8
 8ea:	00de87b3          	add	a5,t4,a3
 8ee:	01e6873b          	addw	a4,a3,t5
 8f2:	0ad30663          	beq	t1,a3,99e <memset+0x184>
 8f6:	00b78023          	sb	a1,0(a5)
 8fa:	0017069b          	addiw	a3,a4,1
 8fe:	08c6fb63          	bgeu	a3,a2,994 <memset+0x17a>
 902:	00b780a3          	sb	a1,1(a5)
 906:	0027069b          	addiw	a3,a4,2
 90a:	08c6f563          	bgeu	a3,a2,994 <memset+0x17a>
 90e:	00b78123          	sb	a1,2(a5)
 912:	0037069b          	addiw	a3,a4,3
 916:	06c6ff63          	bgeu	a3,a2,994 <memset+0x17a>
 91a:	00b781a3          	sb	a1,3(a5)
 91e:	0047069b          	addiw	a3,a4,4
 922:	06c6f963          	bgeu	a3,a2,994 <memset+0x17a>
 926:	00b78223          	sb	a1,4(a5)
 92a:	0057069b          	addiw	a3,a4,5
 92e:	06c6f363          	bgeu	a3,a2,994 <memset+0x17a>
 932:	00b782a3          	sb	a1,5(a5)
 936:	0067069b          	addiw	a3,a4,6
 93a:	04c6fd63          	bgeu	a3,a2,994 <memset+0x17a>
 93e:	00b78323          	sb	a1,6(a5)
 942:	0077069b          	addiw	a3,a4,7
 946:	04c6f763          	bgeu	a3,a2,994 <memset+0x17a>
 94a:	00b783a3          	sb	a1,7(a5)
 94e:	0087069b          	addiw	a3,a4,8
 952:	04c6f163          	bgeu	a3,a2,994 <memset+0x17a>
 956:	00b78423          	sb	a1,8(a5)
 95a:	0097069b          	addiw	a3,a4,9
 95e:	02c6fb63          	bgeu	a3,a2,994 <memset+0x17a>
 962:	00b784a3          	sb	a1,9(a5)
 966:	00a7069b          	addiw	a3,a4,10
 96a:	02c6f563          	bgeu	a3,a2,994 <memset+0x17a>
 96e:	00b78523          	sb	a1,10(a5)
 972:	00b7069b          	addiw	a3,a4,11
 976:	00c6ff63          	bgeu	a3,a2,994 <memset+0x17a>
 97a:	00b785a3          	sb	a1,11(a5)
 97e:	00c7069b          	addiw	a3,a4,12
 982:	00c6f963          	bgeu	a3,a2,994 <memset+0x17a>
 986:	00b78623          	sb	a1,12(a5)
 98a:	2735                	addiw	a4,a4,13
 98c:	00c77463          	bgeu	a4,a2,994 <memset+0x17a>
 990:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 994:	8082                	ret
 996:	472d                	li	a4,11
 998:	bd79                	j	836 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 99a:	4f0d                	li	t5,3
 99c:	b701                	j	89c <memset+0x82>
 99e:	8082                	ret
 9a0:	4f05                	li	t5,1
 9a2:	bded                	j	89c <memset+0x82>
 9a4:	8eaa                	mv	t4,a0
 9a6:	4f01                	li	t5,0
 9a8:	bdd5                	j	89c <memset+0x82>
 9aa:	87aa                	mv	a5,a0
 9ac:	4701                	li	a4,0
 9ae:	b7a1                	j	8f6 <memset+0xdc>
 9b0:	4f09                	li	t5,2
 9b2:	b5ed                	j	89c <memset+0x82>
 9b4:	4f11                	li	t5,4
 9b6:	b5dd                	j	89c <memset+0x82>
 9b8:	4f15                	li	t5,5
 9ba:	b5cd                	j	89c <memset+0x82>
 9bc:	4f19                	li	t5,6
 9be:	bdf9                	j	89c <memset+0x82>

00000000000009c0 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 9c0:	00054783          	lbu	a5,0(a0)
 9c4:	0005c703          	lbu	a4,0(a1)
 9c8:	00e79863          	bne	a5,a4,9d8 <strcmp+0x18>
 9cc:	0505                	addi	a0,a0,1
 9ce:	0585                	addi	a1,a1,1
 9d0:	fbe5                	bnez	a5,9c0 <strcmp>
 9d2:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 9d4:	9d19                	subw	a0,a0,a4
 9d6:	8082                	ret
 9d8:	0007851b          	sext.w	a0,a5
 9dc:	bfe5                	j	9d4 <strcmp+0x14>

00000000000009de <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 9de:	ce05                	beqz	a2,a16 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9e0:	00054703          	lbu	a4,0(a0)
 9e4:	0005c783          	lbu	a5,0(a1)
 9e8:	cb0d                	beqz	a4,a1a <strncmp+0x3c>
    if (!n--)
 9ea:	167d                	addi	a2,a2,-1
 9ec:	00c506b3          	add	a3,a0,a2
 9f0:	a819                	j	a06 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9f2:	00a68e63          	beq	a3,a0,a0e <strncmp+0x30>
 9f6:	0505                	addi	a0,a0,1
 9f8:	00e79b63          	bne	a5,a4,a0e <strncmp+0x30>
 9fc:	00054703          	lbu	a4,0(a0)
 a00:	0005c783          	lbu	a5,0(a1)
 a04:	cb19                	beqz	a4,a1a <strncmp+0x3c>
 a06:	0005c783          	lbu	a5,0(a1)
 a0a:	0585                	addi	a1,a1,1
 a0c:	f3fd                	bnez	a5,9f2 <strncmp+0x14>
        ;
    return *l - *r;
 a0e:	0007051b          	sext.w	a0,a4
 a12:	9d1d                	subw	a0,a0,a5
 a14:	8082                	ret
        return 0;
 a16:	4501                	li	a0,0
}
 a18:	8082                	ret
 a1a:	4501                	li	a0,0
    return *l - *r;
 a1c:	9d1d                	subw	a0,a0,a5
 a1e:	8082                	ret

0000000000000a20 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 a20:	00757793          	andi	a5,a0,7
 a24:	cf89                	beqz	a5,a3e <strlen+0x1e>
 a26:	87aa                	mv	a5,a0
 a28:	a029                	j	a32 <strlen+0x12>
 a2a:	0785                	addi	a5,a5,1
 a2c:	0077f713          	andi	a4,a5,7
 a30:	cb01                	beqz	a4,a40 <strlen+0x20>
        if (!*s)
 a32:	0007c703          	lbu	a4,0(a5)
 a36:	fb75                	bnez	a4,a2a <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 a38:	40a78533          	sub	a0,a5,a0
}
 a3c:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 a3e:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 a40:	6394                	ld	a3,0(a5)
 a42:	00000597          	auipc	a1,0x0
 a46:	5865b583          	ld	a1,1414(a1) # fc8 <unlink+0x38>
 a4a:	00000617          	auipc	a2,0x0
 a4e:	58663603          	ld	a2,1414(a2) # fd0 <unlink+0x40>
 a52:	a019                	j	a58 <strlen+0x38>
 a54:	6794                	ld	a3,8(a5)
 a56:	07a1                	addi	a5,a5,8
 a58:	00b68733          	add	a4,a3,a1
 a5c:	fff6c693          	not	a3,a3
 a60:	8f75                	and	a4,a4,a3
 a62:	8f71                	and	a4,a4,a2
 a64:	db65                	beqz	a4,a54 <strlen+0x34>
    for (; *s; s++)
 a66:	0007c703          	lbu	a4,0(a5)
 a6a:	d779                	beqz	a4,a38 <strlen+0x18>
 a6c:	0017c703          	lbu	a4,1(a5)
 a70:	0785                	addi	a5,a5,1
 a72:	d379                	beqz	a4,a38 <strlen+0x18>
 a74:	0017c703          	lbu	a4,1(a5)
 a78:	0785                	addi	a5,a5,1
 a7a:	fb6d                	bnez	a4,a6c <strlen+0x4c>
 a7c:	bf75                	j	a38 <strlen+0x18>

0000000000000a7e <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a7e:	00757713          	andi	a4,a0,7
{
 a82:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 a84:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a88:	cb19                	beqz	a4,a9e <memchr+0x20>
 a8a:	ce25                	beqz	a2,b02 <memchr+0x84>
 a8c:	0007c703          	lbu	a4,0(a5)
 a90:	04b70e63          	beq	a4,a1,aec <memchr+0x6e>
 a94:	0785                	addi	a5,a5,1
 a96:	0077f713          	andi	a4,a5,7
 a9a:	167d                	addi	a2,a2,-1
 a9c:	f77d                	bnez	a4,a8a <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 a9e:	4501                	li	a0,0
    if (n && *s != c)
 aa0:	c235                	beqz	a2,b04 <memchr+0x86>
 aa2:	0007c703          	lbu	a4,0(a5)
 aa6:	04b70363          	beq	a4,a1,aec <memchr+0x6e>
        size_t k = ONES * c;
 aaa:	00000517          	auipc	a0,0x0
 aae:	52e53503          	ld	a0,1326(a0) # fd8 <unlink+0x48>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 ab2:	471d                	li	a4,7
        size_t k = ONES * c;
 ab4:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 ab8:	02c77a63          	bgeu	a4,a2,aec <memchr+0x6e>
 abc:	00000897          	auipc	a7,0x0
 ac0:	50c8b883          	ld	a7,1292(a7) # fc8 <unlink+0x38>
 ac4:	00000817          	auipc	a6,0x0
 ac8:	50c83803          	ld	a6,1292(a6) # fd0 <unlink+0x40>
 acc:	431d                	li	t1,7
 ace:	a029                	j	ad8 <memchr+0x5a>
 ad0:	1661                	addi	a2,a2,-8
 ad2:	07a1                	addi	a5,a5,8
 ad4:	02c37963          	bgeu	t1,a2,b06 <memchr+0x88>
 ad8:	6398                	ld	a4,0(a5)
 ada:	8f29                	xor	a4,a4,a0
 adc:	011706b3          	add	a3,a4,a7
 ae0:	fff74713          	not	a4,a4
 ae4:	8f75                	and	a4,a4,a3
 ae6:	01077733          	and	a4,a4,a6
 aea:	d37d                	beqz	a4,ad0 <memchr+0x52>
 aec:	853e                	mv	a0,a5
 aee:	97b2                	add	a5,a5,a2
 af0:	a021                	j	af8 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 af2:	0505                	addi	a0,a0,1
 af4:	00f50763          	beq	a0,a5,b02 <memchr+0x84>
 af8:	00054703          	lbu	a4,0(a0)
 afc:	feb71be3          	bne	a4,a1,af2 <memchr+0x74>
 b00:	8082                	ret
    return n ? (void *)s : 0;
 b02:	4501                	li	a0,0
}
 b04:	8082                	ret
    return n ? (void *)s : 0;
 b06:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 b08:	f275                	bnez	a2,aec <memchr+0x6e>
}
 b0a:	8082                	ret

0000000000000b0c <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 b0c:	1101                	addi	sp,sp,-32
 b0e:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 b10:	862e                	mv	a2,a1
{
 b12:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 b14:	4581                	li	a1,0
{
 b16:	e426                	sd	s1,8(sp)
 b18:	ec06                	sd	ra,24(sp)
 b1a:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 b1c:	f63ff0ef          	jal	ra,a7e <memchr>
    return p ? p - s : n;
 b20:	c519                	beqz	a0,b2e <strnlen+0x22>
}
 b22:	60e2                	ld	ra,24(sp)
 b24:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 b26:	8d05                	sub	a0,a0,s1
}
 b28:	64a2                	ld	s1,8(sp)
 b2a:	6105                	addi	sp,sp,32
 b2c:	8082                	ret
 b2e:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 b30:	8522                	mv	a0,s0
}
 b32:	6442                	ld	s0,16(sp)
 b34:	64a2                	ld	s1,8(sp)
 b36:	6105                	addi	sp,sp,32
 b38:	8082                	ret

0000000000000b3a <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 b3a:	00b547b3          	xor	a5,a0,a1
 b3e:	8b9d                	andi	a5,a5,7
 b40:	eb95                	bnez	a5,b74 <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 b42:	0075f793          	andi	a5,a1,7
 b46:	e7b1                	bnez	a5,b92 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 b48:	6198                	ld	a4,0(a1)
 b4a:	00000617          	auipc	a2,0x0
 b4e:	47e63603          	ld	a2,1150(a2) # fc8 <unlink+0x38>
 b52:	00000817          	auipc	a6,0x0
 b56:	47e83803          	ld	a6,1150(a6) # fd0 <unlink+0x40>
 b5a:	a029                	j	b64 <stpcpy+0x2a>
 b5c:	e118                	sd	a4,0(a0)
 b5e:	6598                	ld	a4,8(a1)
 b60:	05a1                	addi	a1,a1,8
 b62:	0521                	addi	a0,a0,8
 b64:	00c707b3          	add	a5,a4,a2
 b68:	fff74693          	not	a3,a4
 b6c:	8ff5                	and	a5,a5,a3
 b6e:	0107f7b3          	and	a5,a5,a6
 b72:	d7ed                	beqz	a5,b5c <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 b74:	0005c783          	lbu	a5,0(a1)
 b78:	00f50023          	sb	a5,0(a0)
 b7c:	c785                	beqz	a5,ba4 <stpcpy+0x6a>
 b7e:	0015c783          	lbu	a5,1(a1)
 b82:	0505                	addi	a0,a0,1
 b84:	0585                	addi	a1,a1,1
 b86:	00f50023          	sb	a5,0(a0)
 b8a:	fbf5                	bnez	a5,b7e <stpcpy+0x44>
        ;
    return d;
}
 b8c:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 b8e:	0505                	addi	a0,a0,1
 b90:	df45                	beqz	a4,b48 <stpcpy+0xe>
            if (!(*d = *s))
 b92:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 b96:	0585                	addi	a1,a1,1
 b98:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 b9c:	00f50023          	sb	a5,0(a0)
 ba0:	f7fd                	bnez	a5,b8e <stpcpy+0x54>
}
 ba2:	8082                	ret
 ba4:	8082                	ret

0000000000000ba6 <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 ba6:	00b547b3          	xor	a5,a0,a1
 baa:	8b9d                	andi	a5,a5,7
 bac:	1a079863          	bnez	a5,d5c <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 bb0:	0075f793          	andi	a5,a1,7
 bb4:	16078463          	beqz	a5,d1c <stpncpy+0x176>
 bb8:	ea01                	bnez	a2,bc8 <stpncpy+0x22>
 bba:	a421                	j	dc2 <stpncpy+0x21c>
 bbc:	167d                	addi	a2,a2,-1
 bbe:	0505                	addi	a0,a0,1
 bc0:	14070e63          	beqz	a4,d1c <stpncpy+0x176>
 bc4:	1a060863          	beqz	a2,d74 <stpncpy+0x1ce>
 bc8:	0005c783          	lbu	a5,0(a1)
 bcc:	0585                	addi	a1,a1,1
 bce:	0075f713          	andi	a4,a1,7
 bd2:	00f50023          	sb	a5,0(a0)
 bd6:	f3fd                	bnez	a5,bbc <stpncpy+0x16>
 bd8:	4805                	li	a6,1
 bda:	1a061863          	bnez	a2,d8a <stpncpy+0x1e4>
 bde:	40a007b3          	neg	a5,a0
 be2:	8b9d                	andi	a5,a5,7
 be4:	4681                	li	a3,0
 be6:	18061a63          	bnez	a2,d7a <stpncpy+0x1d4>
 bea:	00778713          	addi	a4,a5,7
 bee:	45ad                	li	a1,11
 bf0:	18b76363          	bltu	a4,a1,d76 <stpncpy+0x1d0>
 bf4:	1ae6eb63          	bltu	a3,a4,daa <stpncpy+0x204>
 bf8:	1a078363          	beqz	a5,d9e <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 bfc:	00050023          	sb	zero,0(a0)
 c00:	4685                	li	a3,1
 c02:	00150713          	addi	a4,a0,1
 c06:	18d78f63          	beq	a5,a3,da4 <stpncpy+0x1fe>
 c0a:	000500a3          	sb	zero,1(a0)
 c0e:	4689                	li	a3,2
 c10:	00250713          	addi	a4,a0,2
 c14:	18d78e63          	beq	a5,a3,db0 <stpncpy+0x20a>
 c18:	00050123          	sb	zero,2(a0)
 c1c:	468d                	li	a3,3
 c1e:	00350713          	addi	a4,a0,3
 c22:	16d78c63          	beq	a5,a3,d9a <stpncpy+0x1f4>
 c26:	000501a3          	sb	zero,3(a0)
 c2a:	4691                	li	a3,4
 c2c:	00450713          	addi	a4,a0,4
 c30:	18d78263          	beq	a5,a3,db4 <stpncpy+0x20e>
 c34:	00050223          	sb	zero,4(a0)
 c38:	4695                	li	a3,5
 c3a:	00550713          	addi	a4,a0,5
 c3e:	16d78d63          	beq	a5,a3,db8 <stpncpy+0x212>
 c42:	000502a3          	sb	zero,5(a0)
 c46:	469d                	li	a3,7
 c48:	00650713          	addi	a4,a0,6
 c4c:	16d79863          	bne	a5,a3,dbc <stpncpy+0x216>
 c50:	00750713          	addi	a4,a0,7
 c54:	00050323          	sb	zero,6(a0)
 c58:	40f80833          	sub	a6,a6,a5
 c5c:	ff887593          	andi	a1,a6,-8
 c60:	97aa                	add	a5,a5,a0
 c62:	95be                	add	a1,a1,a5
 c64:	0007b023          	sd	zero,0(a5)
 c68:	07a1                	addi	a5,a5,8
 c6a:	feb79de3          	bne	a5,a1,c64 <stpncpy+0xbe>
 c6e:	ff887593          	andi	a1,a6,-8
 c72:	9ead                	addw	a3,a3,a1
 c74:	00b707b3          	add	a5,a4,a1
 c78:	12b80863          	beq	a6,a1,da8 <stpncpy+0x202>
 c7c:	00078023          	sb	zero,0(a5)
 c80:	0016871b          	addiw	a4,a3,1
 c84:	0ec77863          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 c88:	000780a3          	sb	zero,1(a5)
 c8c:	0026871b          	addiw	a4,a3,2
 c90:	0ec77263          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 c94:	00078123          	sb	zero,2(a5)
 c98:	0036871b          	addiw	a4,a3,3
 c9c:	0cc77c63          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 ca0:	000781a3          	sb	zero,3(a5)
 ca4:	0046871b          	addiw	a4,a3,4
 ca8:	0cc77663          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 cac:	00078223          	sb	zero,4(a5)
 cb0:	0056871b          	addiw	a4,a3,5
 cb4:	0cc77063          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 cb8:	000782a3          	sb	zero,5(a5)
 cbc:	0066871b          	addiw	a4,a3,6
 cc0:	0ac77a63          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 cc4:	00078323          	sb	zero,6(a5)
 cc8:	0076871b          	addiw	a4,a3,7
 ccc:	0ac77463          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 cd0:	000783a3          	sb	zero,7(a5)
 cd4:	0086871b          	addiw	a4,a3,8
 cd8:	08c77e63          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 cdc:	00078423          	sb	zero,8(a5)
 ce0:	0096871b          	addiw	a4,a3,9
 ce4:	08c77863          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 ce8:	000784a3          	sb	zero,9(a5)
 cec:	00a6871b          	addiw	a4,a3,10
 cf0:	08c77263          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 cf4:	00078523          	sb	zero,10(a5)
 cf8:	00b6871b          	addiw	a4,a3,11
 cfc:	06c77c63          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 d00:	000785a3          	sb	zero,11(a5)
 d04:	00c6871b          	addiw	a4,a3,12
 d08:	06c77663          	bgeu	a4,a2,d74 <stpncpy+0x1ce>
 d0c:	00078623          	sb	zero,12(a5)
 d10:	26b5                	addiw	a3,a3,13
 d12:	06c6f163          	bgeu	a3,a2,d74 <stpncpy+0x1ce>
 d16:	000786a3          	sb	zero,13(a5)
 d1a:	8082                	ret
            ;
        if (!n || !*s)
 d1c:	c645                	beqz	a2,dc4 <stpncpy+0x21e>
 d1e:	0005c783          	lbu	a5,0(a1)
 d22:	ea078be3          	beqz	a5,bd8 <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d26:	479d                	li	a5,7
 d28:	02c7ff63          	bgeu	a5,a2,d66 <stpncpy+0x1c0>
 d2c:	00000897          	auipc	a7,0x0
 d30:	29c8b883          	ld	a7,668(a7) # fc8 <unlink+0x38>
 d34:	00000817          	auipc	a6,0x0
 d38:	29c83803          	ld	a6,668(a6) # fd0 <unlink+0x40>
 d3c:	431d                	li	t1,7
 d3e:	6198                	ld	a4,0(a1)
 d40:	011707b3          	add	a5,a4,a7
 d44:	fff74693          	not	a3,a4
 d48:	8ff5                	and	a5,a5,a3
 d4a:	0107f7b3          	and	a5,a5,a6
 d4e:	ef81                	bnez	a5,d66 <stpncpy+0x1c0>
            *wd = *ws;
 d50:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d52:	1661                	addi	a2,a2,-8
 d54:	05a1                	addi	a1,a1,8
 d56:	0521                	addi	a0,a0,8
 d58:	fec363e3          	bltu	t1,a2,d3e <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 d5c:	e609                	bnez	a2,d66 <stpncpy+0x1c0>
 d5e:	a08d                	j	dc0 <stpncpy+0x21a>
 d60:	167d                	addi	a2,a2,-1
 d62:	0505                	addi	a0,a0,1
 d64:	ca01                	beqz	a2,d74 <stpncpy+0x1ce>
 d66:	0005c783          	lbu	a5,0(a1)
 d6a:	0585                	addi	a1,a1,1
 d6c:	00f50023          	sb	a5,0(a0)
 d70:	fbe5                	bnez	a5,d60 <stpncpy+0x1ba>
        ;
tail:
 d72:	b59d                	j	bd8 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 d74:	8082                	ret
 d76:	472d                	li	a4,11
 d78:	bdb5                	j	bf4 <stpncpy+0x4e>
 d7a:	00778713          	addi	a4,a5,7
 d7e:	45ad                	li	a1,11
 d80:	fff60693          	addi	a3,a2,-1
 d84:	e6b778e3          	bgeu	a4,a1,bf4 <stpncpy+0x4e>
 d88:	b7fd                	j	d76 <stpncpy+0x1d0>
 d8a:	40a007b3          	neg	a5,a0
 d8e:	8832                	mv	a6,a2
 d90:	8b9d                	andi	a5,a5,7
 d92:	4681                	li	a3,0
 d94:	e4060be3          	beqz	a2,bea <stpncpy+0x44>
 d98:	b7cd                	j	d7a <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 d9a:	468d                	li	a3,3
 d9c:	bd75                	j	c58 <stpncpy+0xb2>
 d9e:	872a                	mv	a4,a0
 da0:	4681                	li	a3,0
 da2:	bd5d                	j	c58 <stpncpy+0xb2>
 da4:	4685                	li	a3,1
 da6:	bd4d                	j	c58 <stpncpy+0xb2>
 da8:	8082                	ret
 daa:	87aa                	mv	a5,a0
 dac:	4681                	li	a3,0
 dae:	b5f9                	j	c7c <stpncpy+0xd6>
 db0:	4689                	li	a3,2
 db2:	b55d                	j	c58 <stpncpy+0xb2>
 db4:	4691                	li	a3,4
 db6:	b54d                	j	c58 <stpncpy+0xb2>
 db8:	4695                	li	a3,5
 dba:	bd79                	j	c58 <stpncpy+0xb2>
 dbc:	4699                	li	a3,6
 dbe:	bd69                	j	c58 <stpncpy+0xb2>
 dc0:	8082                	ret
 dc2:	8082                	ret
 dc4:	8082                	ret

0000000000000dc6 <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 dc6:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 dca:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dcc:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 dd0:	2501                	sext.w	a0,a0
 dd2:	8082                	ret

0000000000000dd4 <close>:
    register long a7 __asm__("a7") = n;
 dd4:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 dd8:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 ddc:	2501                	sext.w	a0,a0
 dde:	8082                	ret

0000000000000de0 <read>:
    register long a7 __asm__("a7") = n;
 de0:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 de4:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 de8:	8082                	ret

0000000000000dea <write>:
    register long a7 __asm__("a7") = n;
 dea:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dee:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 df2:	8082                	ret

0000000000000df4 <getpid>:
    register long a7 __asm__("a7") = n;
 df4:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 df8:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 dfc:	2501                	sext.w	a0,a0
 dfe:	8082                	ret

0000000000000e00 <sched_yield>:
    register long a7 __asm__("a7") = n;
 e00:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 e04:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 e08:	2501                	sext.w	a0,a0
 e0a:	8082                	ret

0000000000000e0c <fork>:
    register long a7 __asm__("a7") = n;
 e0c:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 e10:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 e14:	2501                	sext.w	a0,a0
 e16:	8082                	ret

0000000000000e18 <exit>:
    register long a7 __asm__("a7") = n;
 e18:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 e1c:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 e20:	8082                	ret

0000000000000e22 <waitpid>:
    register long a7 __asm__("a7") = n;
 e22:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e26:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 e2a:	2501                	sext.w	a0,a0
 e2c:	8082                	ret

0000000000000e2e <exec>:
    register long a7 __asm__("a7") = n;
 e2e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 e32:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 e36:	2501                	sext.w	a0,a0
 e38:	8082                	ret

0000000000000e3a <get_time>:

int64 get_time()
{
 e3a:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 e3c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e40:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e42:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e44:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 e48:	2501                	sext.w	a0,a0
 e4a:	ed09                	bnez	a0,e64 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e4c:	67a2                	ld	a5,8(sp)
 e4e:	3e800713          	li	a4,1000
 e52:	00015503          	lhu	a0,0(sp)
 e56:	02e7d7b3          	divu	a5,a5,a4
 e5a:	02e50533          	mul	a0,a0,a4
 e5e:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 e60:	0141                	addi	sp,sp,16
 e62:	8082                	ret
        return -1;
 e64:	557d                	li	a0,-1
 e66:	bfed                	j	e60 <get_time+0x26>

0000000000000e68 <sys_get_time>:
    register long a7 __asm__("a7") = n;
 e68:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e6c:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 e70:	2501                	sext.w	a0,a0
 e72:	8082                	ret

0000000000000e74 <sleep>:

int sleep(unsigned long long time)
{
 e74:	1141                	addi	sp,sp,-16
 e76:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 e78:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e7c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e7e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e80:	00000073          	ecall
    if (err == 0)
 e84:	2501                	sext.w	a0,a0
 e86:	e13d                	bnez	a0,eec <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e88:	6722                	ld	a4,8(sp)
 e8a:	3e800693          	li	a3,1000
 e8e:	00015783          	lhu	a5,0(sp)
 e92:	02d75733          	divu	a4,a4,a3
 e96:	02d787b3          	mul	a5,a5,a3
 e9a:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 e9c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 ea0:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 ea2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ea4:	00000073          	ecall
    if (err == 0)
 ea8:	2501                	sext.w	a0,a0
 eaa:	ed15                	bnez	a0,ee6 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 eac:	6841                	lui	a6,0x10
 eae:	963e                	add	a2,a2,a5
 eb0:	187d                	addi	a6,a6,-1
 eb2:	3e800693          	li	a3,1000
 eb6:	a819                	j	ecc <sleep+0x58>
    __asm_syscall("r"(a7))
 eb8:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 ebc:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 ec0:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 ec2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ec4:	00000073          	ecall
    if (err == 0)
 ec8:	2501                	sext.w	a0,a0
 eca:	ed11                	bnez	a0,ee6 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 ecc:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 ece:	07c00893          	li	a7,124
 ed2:	02d7d733          	divu	a4,a5,a3
 ed6:	6782                	ld	a5,0(sp)
 ed8:	0107f7b3          	and	a5,a5,a6
 edc:	02d787b3          	mul	a5,a5,a3
 ee0:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 ee2:	fcc7ebe3          	bltu	a5,a2,eb8 <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 ee6:	4501                	li	a0,0
 ee8:	0141                	addi	sp,sp,16
 eea:	8082                	ret
 eec:	57fd                	li	a5,-1
 eee:	b77d                	j	e9c <sleep+0x28>

0000000000000ef0 <set_priority>:
    register long a7 __asm__("a7") = n;
 ef0:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 ef4:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 ef8:	2501                	sext.w	a0,a0
 efa:	8082                	ret

0000000000000efc <mmap>:
    register long a7 __asm__("a7") = n;
 efc:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f00:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 f04:	2501                	sext.w	a0,a0
 f06:	8082                	ret

0000000000000f08 <munmap>:
    register long a7 __asm__("a7") = n;
 f08:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f0c:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 f10:	2501                	sext.w	a0,a0
 f12:	8082                	ret

0000000000000f14 <wait>:

int wait(int *code)
{
 f14:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f16:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 f1a:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f1c:	00000073          	ecall
    return waitpid(-1, code);
}
 f20:	2501                	sext.w	a0,a0
 f22:	8082                	ret

0000000000000f24 <spawn>:
    register long a7 __asm__("a7") = n;
 f24:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 f28:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 f2c:	2501                	sext.w	a0,a0
 f2e:	8082                	ret

0000000000000f30 <mailread>:
    register long a7 __asm__("a7") = n;
 f30:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f34:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 f38:	2501                	sext.w	a0,a0
 f3a:	8082                	ret

0000000000000f3c <mailwrite>:
    register long a7 __asm__("a7") = n;
 f3c:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f40:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 f44:	2501                	sext.w	a0,a0
 f46:	8082                	ret

0000000000000f48 <fstat>:
    register long a7 __asm__("a7") = n;
 f48:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f4c:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 f50:	2501                	sext.w	a0,a0
 f52:	8082                	ret

0000000000000f54 <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 f54:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 f56:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 f5a:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f5c:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 f60:	2501                	sext.w	a0,a0
 f62:	8082                	ret

0000000000000f64 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 f64:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 f66:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 f6a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f6c:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 f70:	2501                	sext.w	a0,a0
 f72:	8082                	ret

0000000000000f74 <link>:

int link(char *old_path, char *new_path)
{
 f74:	87aa                	mv	a5,a0
 f76:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 f78:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 f7c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 f80:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 f82:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 f86:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f88:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 f8c:	2501                	sext.w	a0,a0
 f8e:	8082                	ret

0000000000000f90 <unlink>:

int unlink(char *path)
{
 f90:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f92:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 f96:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 f9a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f9c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 fa0:	2501                	sext.w	a0,a0
 fa2:	8082                	ret
