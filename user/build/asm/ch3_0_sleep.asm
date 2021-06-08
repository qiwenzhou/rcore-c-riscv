
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_0_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0560006f          	j	58 <__start_main>

0000000000000006 <main>:
/// Test sleep OK!

/// 注意不要单纯以 OK! 作为判断，还要注意输出时间是否符合实际。

int main()
{
   6:	1141                	addi	sp,sp,-16
   8:	e022                	sd	s0,0(sp)
   a:	e406                	sd	ra,8(sp)
    int64 current_time = get_time();
   c:	603000ef          	jal	ra,e0e <get_time>
  10:	842a                	mv	s0,a0
    assert(current_time > 0);
  12:	02a05f63          	blez	a0,50 <main+0x4a>
    printf("get_time OK! %d\n", current_time);
  16:	85a2                	mv	a1,s0
  18:	00001517          	auipc	a0,0x1
  1c:	f6050513          	addi	a0,a0,-160 # f78 <unlink+0x14>
  20:	0ca000ef          	jal	ra,ea <printf>
    int64 wait_for = current_time + 3000;
  24:	6585                	lui	a1,0x1
  26:	bb858593          	addi	a1,a1,-1096 # bb8 <stpncpy+0x3e>
  2a:	942e                	add	s0,s0,a1
    while (get_time() < wait_for)
  2c:	a019                	j	32 <main+0x2c>
    {
        sched_yield();
  2e:	5a7000ef          	jal	ra,dd4 <sched_yield>
    while (get_time() < wait_for)
  32:	5dd000ef          	jal	ra,e0e <get_time>
  36:	fe854ce3          	blt	a0,s0,2e <main+0x28>
    }
    puts("Test sleep OK!");
  3a:	00001517          	auipc	a0,0x1
  3e:	f5650513          	addi	a0,a0,-170 # f90 <unlink+0x2c>
  42:	066000ef          	jal	ra,a8 <puts>
    return 0;
  46:	60a2                	ld	ra,8(sp)
  48:	6402                	ld	s0,0(sp)
  4a:	4501                	li	a0,0
  4c:	0141                	addi	sp,sp,16
  4e:	8082                	ret
    assert(current_time > 0);
  50:	557d                	li	a0,-1
  52:	59b000ef          	jal	ra,dec <exit>
  56:	b7c1                	j	16 <main+0x10>

0000000000000058 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  58:	1141                	addi	sp,sp,-16
  5a:	e406                	sd	ra,8(sp)
    exit(main());
  5c:	fabff0ef          	jal	ra,6 <main>
  60:	58d000ef          	jal	ra,dec <exit>
    return 0;
}
  64:	60a2                	ld	ra,8(sp)
  66:	4501                	li	a0,0
  68:	0141                	addi	sp,sp,16
  6a:	8082                	ret

000000000000006c <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  6c:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  6e:	00f10593          	addi	a1,sp,15
  72:	4605                	li	a2,1
  74:	4501                	li	a0,0
{
  76:	ec06                	sd	ra,24(sp)
    char byte = 0;
  78:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  7c:	539000ef          	jal	ra,db4 <read>
    return byte;
}
  80:	60e2                	ld	ra,24(sp)
  82:	00f14503          	lbu	a0,15(sp)
  86:	6105                	addi	sp,sp,32
  88:	8082                	ret

000000000000008a <putchar>:

int putchar(int c)
{
  8a:	1101                	addi	sp,sp,-32
  8c:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  8e:	00f10593          	addi	a1,sp,15
  92:	4605                	li	a2,1
  94:	4505                	li	a0,1
{
  96:	ec06                	sd	ra,24(sp)
    char byte = c;
  98:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  9c:	523000ef          	jal	ra,dbe <write>
}
  a0:	60e2                	ld	ra,24(sp)
  a2:	2501                	sext.w	a0,a0
  a4:	6105                	addi	sp,sp,32
  a6:	8082                	ret

00000000000000a8 <puts>:

int puts(const char *s)
{
  a8:	1101                	addi	sp,sp,-32
  aa:	e822                	sd	s0,16(sp)
  ac:	ec06                	sd	ra,24(sp)
  ae:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
  b0:	145000ef          	jal	ra,9f4 <strlen>
  b4:	862a                	mv	a2,a0
  b6:	85a2                	mv	a1,s0
  b8:	4505                	li	a0,1
  ba:	505000ef          	jal	ra,dbe <write>
  be:	00055763          	bgez	a0,cc <puts+0x24>
    return r;
}
  c2:	60e2                	ld	ra,24(sp)
  c4:	6442                	ld	s0,16(sp)
  c6:	557d                	li	a0,-1
  c8:	6105                	addi	sp,sp,32
  ca:	8082                	ret
    return write(stdout, &byte, 1);
  cc:	00f10593          	addi	a1,sp,15
    char byte = c;
  d0:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
  d2:	4605                	li	a2,1
  d4:	4505                	li	a0,1
    char byte = c;
  d6:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  da:	4e5000ef          	jal	ra,dbe <write>
}
  de:	60e2                	ld	ra,24(sp)
  e0:	6442                	ld	s0,16(sp)
  e2:	41f5551b          	sraiw	a0,a0,0x1f
  e6:	6105                	addi	sp,sp,32
  e8:	8082                	ret

00000000000000ea <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
  ea:	7131                	addi	sp,sp,-192
  ec:	ecce                	sd	s3,88(sp)
  ee:	e8d2                	sd	s4,80(sp)
  f0:	e4d6                	sd	s5,72(sp)
  f2:	e0da                	sd	s6,64(sp)
  f4:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
  f6:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
  f8:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
  fa:	6ae1                	lui	s5,0x18
  fc:	000f4a37          	lui	s4,0xf4
 100:	00989b37          	lui	s6,0x989
{
 104:	fc86                	sd	ra,120(sp)
 106:	f8a2                	sd	s0,112(sp)
 108:	f4a6                	sd	s1,104(sp)
 10a:	f0ca                	sd	s2,96(sp)
 10c:	fc5e                	sd	s7,56(sp)
 10e:	e52e                	sd	a1,136(sp)
 110:	e932                	sd	a2,144(sp)
 112:	ed36                	sd	a3,152(sp)
 114:	f13a                	sd	a4,160(sp)
 116:	f942                	sd	a6,176(sp)
 118:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
 11a:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
 11c:	70f98993          	addi	s3,s3,1807 # 270f <digits+0x174f>
 120:	69fa8a93          	addi	s5,s5,1695 # 1869f <digits+0x176df>
 124:	23fa0a13          	addi	s4,s4,575 # f423f <digits+0xf327f>
 128:	67fb0b13          	addi	s6,s6,1663 # 98967f <digits+0x9886bf>
    for (;;)
    {
        if (!*s)
 12c:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
 130:	02500913          	li	s2,37
        if (!*s)
 134:	1a078f63          	beqz	a5,2f2 <printf+0x208>
 138:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 13a:	17278e63          	beq	a5,s2,2b6 <printf+0x1cc>
 13e:	00164783          	lbu	a5,1(a2)
 142:	0605                	addi	a2,a2,1
 144:	fbfd                	bnez	a5,13a <printf+0x50>
 146:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 148:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 14c:	85aa                	mv	a1,a0
 14e:	8622                	mv	a2,s0
 150:	4505                	li	a0,1
 152:	46d000ef          	jal	ra,dbe <write>
        out(f, a, l);
        if (l)
 156:	18041963          	bnez	s0,2e8 <printf+0x1fe>
            continue;
        if (s[1] == 0)
 15a:	0014c783          	lbu	a5,1(s1)
 15e:	18078a63          	beqz	a5,2f2 <printf+0x208>
            break;
        switch (s[1])
 162:	07300713          	li	a4,115
 166:	28e78e63          	beq	a5,a4,402 <printf+0x318>
 16a:	18f76f63          	bltu	a4,a5,308 <printf+0x21e>
 16e:	06400713          	li	a4,100
 172:	2ae78c63          	beq	a5,a4,42a <printf+0x340>
 176:	07000713          	li	a4,112
 17a:	3ce79c63          	bne	a5,a4,552 <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 17e:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 180:	00001797          	auipc	a5,0x1
 184:	e4078793          	addi	a5,a5,-448 # fc0 <digits>
            printptr(va_arg(ap, uint64));
 188:	6298                	ld	a4,0(a3)
 18a:	00868093          	addi	ra,a3,8
 18e:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 190:	00471293          	slli	t0,a4,0x4
 194:	00c71f13          	slli	t5,a4,0xc
 198:	01471e13          	slli	t3,a4,0x14
 19c:	01c71893          	slli	a7,a4,0x1c
 1a0:	02471813          	slli	a6,a4,0x24
 1a4:	02871513          	slli	a0,a4,0x28
 1a8:	02c71593          	slli	a1,a4,0x2c
 1ac:	03071693          	slli	a3,a4,0x30
 1b0:	00871f93          	slli	t6,a4,0x8
 1b4:	01071e93          	slli	t4,a4,0x10
 1b8:	01871313          	slli	t1,a4,0x18
 1bc:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1c0:	03c2d293          	srli	t0,t0,0x3c
 1c4:	03cf5f13          	srli	t5,t5,0x3c
 1c8:	03ce5e13          	srli	t3,t3,0x3c
 1cc:	03c8d893          	srli	a7,a7,0x3c
 1d0:	03c85813          	srli	a6,a6,0x3c
 1d4:	9171                	srli	a0,a0,0x3c
 1d6:	91f1                	srli	a1,a1,0x3c
 1d8:	92f1                	srli	a3,a3,0x3c
 1da:	92be                	add	t0,t0,a5
 1dc:	9f3e                	add	t5,t5,a5
 1de:	9e3e                	add	t3,t3,a5
 1e0:	98be                	add	a7,a7,a5
 1e2:	983e                	add	a6,a6,a5
 1e4:	953e                	add	a0,a0,a5
 1e6:	95be                	add	a1,a1,a5
 1e8:	96be                	add	a3,a3,a5
 1ea:	03c75393          	srli	t2,a4,0x3c
 1ee:	01c75b9b          	srliw	s7,a4,0x1c
 1f2:	03cfdf93          	srli	t6,t6,0x3c
 1f6:	03cede93          	srli	t4,t4,0x3c
 1fa:	03c35313          	srli	t1,t1,0x3c
 1fe:	9271                	srli	a2,a2,0x3c
 200:	0002c403          	lbu	s0,0(t0)
 204:	93be                	add	t2,t2,a5
 206:	000f4283          	lbu	t0,0(t5)
 20a:	9fbe                	add	t6,t6,a5
 20c:	000e4f03          	lbu	t5,0(t3)
 210:	9ebe                	add	t4,t4,a5
 212:	0008ce03          	lbu	t3,0(a7)
 216:	933e                	add	t1,t1,a5
 218:	00084883          	lbu	a7,0(a6)
 21c:	9bbe                	add	s7,s7,a5
 21e:	00054803          	lbu	a6,0(a0)
 222:	963e                	add	a2,a2,a5
 224:	0005c503          	lbu	a0,0(a1)
 228:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 22c:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 230:	0003c903          	lbu	s2,0(t2)
 234:	00064603          	lbu	a2,0(a2)
 238:	000fc383          	lbu	t2,0(t6)
 23c:	8b3d                	andi	a4,a4,15
 23e:	000ecf83          	lbu	t6,0(t4)
 242:	92f1                	srli	a3,a3,0x3c
 244:	00034e83          	lbu	t4,0(t1)
 248:	000bc303          	lbu	t1,0(s7)
 24c:	96be                	add	a3,a3,a5
 24e:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 250:	7761                	lui	a4,0xffff8
 252:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 256:	00710623          	sb	t2,12(sp)
 25a:	005106a3          	sb	t0,13(sp)
 25e:	01f10723          	sb	t6,14(sp)
 262:	01e107a3          	sb	t5,15(sp)
 266:	01d10823          	sb	t4,16(sp)
 26a:	01c108a3          	sb	t3,17(sp)
 26e:	00610923          	sb	t1,18(sp)
 272:	011109a3          	sb	a7,19(sp)
 276:	01010a23          	sb	a6,20(sp)
 27a:	00a10aa3          	sb	a0,21(sp)
 27e:	00b10b23          	sb	a1,22(sp)
 282:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 286:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 28a:	01210523          	sb	s2,10(sp)
 28e:	008105a3          	sb	s0,11(sp)
 292:	0006c703          	lbu	a4,0(a3)
 296:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 29a:	4649                	li	a2,18
 29c:	002c                	addi	a1,sp,8
 29e:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2a0:	00e10c23          	sb	a4,24(sp)
 2a4:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 2a8:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 2ac:	313000ef          	jal	ra,dbe <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 2b0:	00248513          	addi	a0,s1,2
 2b4:	bda5                	j	12c <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 2b6:	00064783          	lbu	a5,0(a2)
 2ba:	84b2                	mv	s1,a2
 2bc:	01278963          	beq	a5,s2,2ce <printf+0x1e4>
 2c0:	b561                	j	148 <printf+0x5e>
 2c2:	0024c783          	lbu	a5,2(s1)
 2c6:	0605                	addi	a2,a2,1
 2c8:	0489                	addi	s1,s1,2
 2ca:	e7279fe3          	bne	a5,s2,148 <printf+0x5e>
 2ce:	0014c783          	lbu	a5,1(s1)
 2d2:	ff2788e3          	beq	a5,s2,2c2 <printf+0x1d8>
        l = z - a;
 2d6:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 2da:	85aa                	mv	a1,a0
 2dc:	8622                	mv	a2,s0
 2de:	4505                	li	a0,1
 2e0:	2df000ef          	jal	ra,dbe <write>
        if (l)
 2e4:	e6040be3          	beqz	s0,15a <printf+0x70>
 2e8:	8526                	mv	a0,s1
        if (!*s)
 2ea:	00054783          	lbu	a5,0(a0)
 2ee:	e40795e3          	bnez	a5,138 <printf+0x4e>
    }
    va_end(ap);
 2f2:	70e6                	ld	ra,120(sp)
 2f4:	7446                	ld	s0,112(sp)
 2f6:	74a6                	ld	s1,104(sp)
 2f8:	7906                	ld	s2,96(sp)
 2fa:	69e6                	ld	s3,88(sp)
 2fc:	6a46                	ld	s4,80(sp)
 2fe:	6aa6                	ld	s5,72(sp)
 300:	6b06                	ld	s6,64(sp)
 302:	7be2                	ld	s7,56(sp)
 304:	6129                	addi	sp,sp,192
 306:	8082                	ret
        switch (s[1])
 308:	07800713          	li	a4,120
 30c:	24e79363          	bne	a5,a4,552 <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 310:	6782                	ld	a5,0(sp)
 312:	4394                	lw	a3,0(a5)
 314:	07a1                	addi	a5,a5,8
 316:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 318:	2606c263          	bltz	a3,57c <printf+0x492>
        buf[i--] = digits[x % base];
 31c:	00001797          	auipc	a5,0x1
 320:	ca478793          	addi	a5,a5,-860 # fc0 <digits>
 324:	00f6f713          	andi	a4,a3,15
 328:	973e                	add	a4,a4,a5
 32a:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <digits+0xffffffffffff7040>
    buf[16] = 0;
 32e:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 332:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 334:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 338:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 33c:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 340:	0046d51b          	srliw	a0,a3,0x4
 344:	0ad5d563          	bge	a1,a3,3ee <printf+0x304>
        buf[i--] = digits[x % base];
 348:	8a3d                	andi	a2,a2,15
 34a:	963e                	add	a2,a2,a5
 34c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 350:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 354:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 358:	30a5fe63          	bgeu	a1,a0,674 <printf+0x58a>
        buf[i--] = digits[x % base];
 35c:	00f77613          	andi	a2,a4,15
 360:	963e                	add	a2,a2,a5
 362:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 366:	45bd                	li	a1,15
 368:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 36c:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 370:	00475513          	srli	a0,a4,0x4
 374:	30e5f963          	bgeu	a1,a4,686 <printf+0x59c>
        buf[i--] = digits[x % base];
 378:	8a3d                	andi	a2,a2,15
 37a:	963e                	add	a2,a2,a5
 37c:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 380:	00875893          	srli	a7,a4,0x8
 384:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 388:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 38c:	30a5fd63          	bgeu	a1,a0,6a6 <printf+0x5bc>
        buf[i--] = digits[x % base];
 390:	8a3d                	andi	a2,a2,15
 392:	963e                	add	a2,a2,a5
 394:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 398:	00c75813          	srli	a6,a4,0xc
 39c:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 3a0:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 3a4:	3315fe63          	bgeu	a1,a7,6e0 <printf+0x5f6>
        buf[i--] = digits[x % base];
 3a8:	8a3d                	andi	a2,a2,15
 3aa:	963e                	add	a2,a2,a5
 3ac:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3b0:	01075893          	srli	a7,a4,0x10
 3b4:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 3b8:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 3bc:	3305ff63          	bgeu	a1,a6,6fa <printf+0x610>
        buf[i--] = digits[x % base];
 3c0:	8a3d                	andi	a2,a2,15
 3c2:	963e                	add	a2,a2,a5
 3c4:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 3c8:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 3cc:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 3d0:	3515f863          	bgeu	a1,a7,720 <printf+0x636>
        buf[i--] = digits[x % base];
 3d4:	97ba                	add	a5,a5,a4
 3d6:	0007c783          	lbu	a5,0(a5)
 3da:	45a1                	li	a1,8
 3dc:	00f10823          	sb	a5,16(sp)
    if (sign)
 3e0:	0006d763          	bgez	a3,3ee <printf+0x304>
        buf[i--] = '-';
 3e4:	02d00793          	li	a5,45
 3e8:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 3ec:	459d                	li	a1,7
    write(f, s, l);
 3ee:	4641                	li	a2,16
 3f0:	003c                	addi	a5,sp,8
 3f2:	9e0d                	subw	a2,a2,a1
 3f4:	4505                	li	a0,1
 3f6:	95be                	add	a1,a1,a5
 3f8:	1c7000ef          	jal	ra,dbe <write>
        s += 2;
 3fc:	00248513          	addi	a0,s1,2
 400:	b335                	j	12c <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 402:	6782                	ld	a5,0(sp)
 404:	6380                	ld	s0,0(a5)
 406:	07a1                	addi	a5,a5,8
 408:	e03e                	sd	a5,0(sp)
 40a:	22040a63          	beqz	s0,63e <printf+0x554>
            l = strnlen(a, 200);
 40e:	0c800593          	li	a1,200
 412:	8522                	mv	a0,s0
 414:	6cc000ef          	jal	ra,ae0 <strnlen>
    write(f, s, l);
 418:	0005061b          	sext.w	a2,a0
 41c:	85a2                	mv	a1,s0
 41e:	4505                	li	a0,1
 420:	19f000ef          	jal	ra,dbe <write>
        s += 2;
 424:	00248513          	addi	a0,s1,2
 428:	b311                	j	12c <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 42a:	6782                	ld	a5,0(sp)
 42c:	4390                	lw	a2,0(a5)
 42e:	07a1                	addi	a5,a5,8
 430:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 432:	1a064363          	bltz	a2,5d8 <printf+0x4ee>
        buf[i--] = digits[x % base];
 436:	46a9                	li	a3,10
 438:	02d6773b          	remuw	a4,a2,a3
 43c:	00001797          	auipc	a5,0x1
 440:	b8478793          	addi	a5,a5,-1148 # fc0 <digits>
    buf[16] = 0;
 444:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 448:	4525                	li	a0,9
        x = xx;
 44a:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 44e:	973e                	add	a4,a4,a5
 450:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 454:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 458:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 45c:	2cc55063          	bge	a0,a2,71c <printf+0x632>
 460:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 464:	02d5f73b          	remuw	a4,a1,a3
 468:	1702                	slli	a4,a4,0x20
 46a:	9301                	srli	a4,a4,0x20
 46c:	973e                	add	a4,a4,a5
 46e:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 472:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 476:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 47a:	1f057d63          	bgeu	a0,a6,674 <printf+0x58a>
        buf[i--] = digits[x % base];
 47e:	4529                	li	a0,10
    } while ((x /= base) != 0);
 480:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 482:	02a5f73b          	remuw	a4,a1,a0
 486:	973e                	add	a4,a4,a5
 488:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 48c:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 490:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 494:	1ab6f163          	bgeu	a3,a1,636 <printf+0x54c>
 498:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 49c:	02a776bb          	remuw	a3,a4,a0
 4a0:	96be                	add	a3,a3,a5
 4a2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4a6:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4aa:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 4ae:	20b87c63          	bgeu	a6,a1,6c6 <printf+0x5dc>
 4b2:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 4b6:	02a776bb          	remuw	a3,a4,a0
 4ba:	96be                	add	a3,a3,a5
 4bc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4c0:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4c4:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 4c8:	20b87363          	bgeu	a6,a1,6ce <printf+0x5e4>
        buf[i--] = digits[x % base];
 4cc:	02a776bb          	remuw	a3,a4,a0
 4d0:	96be                	add	a3,a3,a5
 4d2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4d6:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4da:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 4de:	20b9f563          	bgeu	s3,a1,6e8 <printf+0x5fe>
        buf[i--] = digits[x % base];
 4e2:	02a776bb          	remuw	a3,a4,a0
 4e6:	96be                	add	a3,a3,a5
 4e8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4ec:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4f0:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 4f4:	20bafb63          	bgeu	s5,a1,70a <printf+0x620>
        buf[i--] = digits[x % base];
 4f8:	02a776bb          	remuw	a3,a4,a0
 4fc:	96be                	add	a3,a3,a5
 4fe:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 502:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 506:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 50a:	1eba7c63          	bgeu	s4,a1,702 <printf+0x618>
        buf[i--] = digits[x % base];
 50e:	02a776bb          	remuw	a3,a4,a0
 512:	96be                	add	a3,a3,a5
 514:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 518:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 51c:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 520:	14bb7163          	bgeu	s6,a1,662 <printf+0x578>
        buf[i--] = digits[x % base];
 524:	1702                	slli	a4,a4,0x20
 526:	9301                	srli	a4,a4,0x20
 528:	97ba                	add	a5,a5,a4
 52a:	0007c783          	lbu	a5,0(a5)
 52e:	4599                	li	a1,6
 530:	00f10723          	sb	a5,14(sp)
    if (sign)
 534:	ea065de3          	bgez	a2,3ee <printf+0x304>
        buf[i--] = '-';
 538:	02d00793          	li	a5,45
 53c:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 540:	4595                	li	a1,5
    write(f, s, l);
 542:	003c                	addi	a5,sp,8
 544:	4641                	li	a2,16
 546:	9e0d                	subw	a2,a2,a1
 548:	4505                	li	a0,1
 54a:	95be                	add	a1,a1,a5
 54c:	073000ef          	jal	ra,dbe <write>
 550:	b575                	j	3fc <printf+0x312>
    char byte = c;
 552:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 556:	4605                	li	a2,1
 558:	002c                	addi	a1,sp,8
 55a:	4505                	li	a0,1
    char byte = c;
 55c:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 560:	05f000ef          	jal	ra,dbe <write>
    char byte = c;
 564:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 568:	4605                	li	a2,1
 56a:	002c                	addi	a1,sp,8
 56c:	4505                	li	a0,1
    char byte = c;
 56e:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 572:	04d000ef          	jal	ra,dbe <write>
        s += 2;
 576:	00248513          	addi	a0,s1,2
 57a:	be4d                	j	12c <printf+0x42>
        x = -xx;
 57c:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 580:	00001797          	auipc	a5,0x1
 584:	a4078793          	addi	a5,a5,-1472 # fc0 <digits>
 588:	00f77613          	andi	a2,a4,15
 58c:	963e                	add	a2,a2,a5
 58e:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 592:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 596:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 598:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 59c:	0047551b          	srliw	a0,a4,0x4
 5a0:	0047561b          	srliw	a2,a4,0x4
 5a4:	0ab6d263          	bge	a3,a1,648 <printf+0x55e>
        buf[i--] = digits[x % base];
 5a8:	8a3d                	andi	a2,a2,15
 5aa:	963e                	add	a2,a2,a5
 5ac:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 5b0:	463d                	li	a2,15
 5b2:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 5b6:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 5ba:	daa661e3          	bltu	a2,a0,35c <printf+0x272>
        buf[i--] = '-';
 5be:	02d00793          	li	a5,45
 5c2:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 5c6:	45b5                	li	a1,13
    write(f, s, l);
 5c8:	003c                	addi	a5,sp,8
 5ca:	4641                	li	a2,16
 5cc:	9e0d                	subw	a2,a2,a1
 5ce:	4505                	li	a0,1
 5d0:	95be                	add	a1,a1,a5
 5d2:	7ec000ef          	jal	ra,dbe <write>
 5d6:	b51d                	j	3fc <printf+0x312>
        x = -xx;
 5d8:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 5dc:	46a9                	li	a3,10
 5de:	02d875bb          	remuw	a1,a6,a3
 5e2:	00001797          	auipc	a5,0x1
 5e6:	9de78793          	addi	a5,a5,-1570 # fc0 <digits>
    buf[16] = 0;
 5ea:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5ee:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 5f0:	95be                	add	a1,a1,a5
 5f2:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 5f6:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 5fa:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 5fe:	04a65563          	bge	a2,a0,648 <printf+0x55e>
 602:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 606:	02d775bb          	remuw	a1,a4,a3
 60a:	95be                	add	a1,a1,a5
 60c:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 610:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 614:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 618:	fb0573e3          	bgeu	a0,a6,5be <printf+0x4d4>
        buf[i--] = digits[x % base];
 61c:	4529                	li	a0,10
    } while ((x /= base) != 0);
 61e:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 620:	02a5f73b          	remuw	a4,a1,a0
 624:	973e                	add	a4,a4,a5
 626:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 62a:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 62e:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 632:	e6b6e3e3          	bltu	a3,a1,498 <printf+0x3ae>
        buf[i--] = digits[x % base];
 636:	45b5                	li	a1,13
    if (sign)
 638:	da065be3          	bgez	a2,3ee <printf+0x304>
 63c:	a881                	j	68c <printf+0x5a2>
                a = "(null)";
 63e:	00001417          	auipc	s0,0x1
 642:	96240413          	addi	s0,s0,-1694 # fa0 <unlink+0x3c>
 646:	b3e1                	j	40e <printf+0x324>
        buf[i--] = '-';
 648:	02d00793          	li	a5,45
 64c:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 650:	45b9                	li	a1,14
    write(f, s, l);
 652:	003c                	addi	a5,sp,8
 654:	4641                	li	a2,16
 656:	9e0d                	subw	a2,a2,a1
 658:	4505                	li	a0,1
 65a:	95be                	add	a1,a1,a5
 65c:	762000ef          	jal	ra,dbe <write>
 660:	bb71                	j	3fc <printf+0x312>
        buf[i--] = digits[x % base];
 662:	459d                	li	a1,7
    if (sign)
 664:	d80655e3          	bgez	a2,3ee <printf+0x304>
        buf[i--] = '-';
 668:	02d00793          	li	a5,45
 66c:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 670:	4599                	li	a1,6
 672:	bbb5                	j	3ee <printf+0x304>
 674:	45b9                	li	a1,14
    write(f, s, l);
 676:	003c                	addi	a5,sp,8
 678:	4641                	li	a2,16
 67a:	9e0d                	subw	a2,a2,a1
 67c:	4505                	li	a0,1
 67e:	95be                	add	a1,a1,a5
 680:	73e000ef          	jal	ra,dbe <write>
 684:	bba5                	j	3fc <printf+0x312>
        buf[i--] = digits[x % base];
 686:	45b5                	li	a1,13
    if (sign)
 688:	d606d3e3          	bgez	a3,3ee <printf+0x304>
        buf[i--] = '-';
 68c:	02d00793          	li	a5,45
 690:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 694:	45b1                	li	a1,12
    write(f, s, l);
 696:	003c                	addi	a5,sp,8
 698:	4641                	li	a2,16
 69a:	9e0d                	subw	a2,a2,a1
 69c:	4505                	li	a0,1
 69e:	95be                	add	a1,a1,a5
 6a0:	71e000ef          	jal	ra,dbe <write>
 6a4:	bba1                	j	3fc <printf+0x312>
        buf[i--] = digits[x % base];
 6a6:	45b1                	li	a1,12
    if (sign)
 6a8:	d406d3e3          	bgez	a3,3ee <printf+0x304>
        buf[i--] = '-';
 6ac:	02d00793          	li	a5,45
 6b0:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 6b4:	45ad                	li	a1,11
    write(f, s, l);
 6b6:	003c                	addi	a5,sp,8
 6b8:	4641                	li	a2,16
 6ba:	9e0d                	subw	a2,a2,a1
 6bc:	4505                	li	a0,1
 6be:	95be                	add	a1,a1,a5
 6c0:	6fe000ef          	jal	ra,dbe <write>
 6c4:	bb25                	j	3fc <printf+0x312>
        buf[i--] = digits[x % base];
 6c6:	45b1                	li	a1,12
    if (sign)
 6c8:	d20653e3          	bgez	a2,3ee <printf+0x304>
 6cc:	b7c5                	j	6ac <printf+0x5c2>
        buf[i--] = digits[x % base];
 6ce:	45ad                	li	a1,11
    if (sign)
 6d0:	d0065fe3          	bgez	a2,3ee <printf+0x304>
        buf[i--] = '-';
 6d4:	02d00793          	li	a5,45
 6d8:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 6dc:	45a9                	li	a1,10
 6de:	bb01                	j	3ee <printf+0x304>
 6e0:	45ad                	li	a1,11
    if (sign)
 6e2:	d006d6e3          	bgez	a3,3ee <printf+0x304>
 6e6:	b7fd                	j	6d4 <printf+0x5ea>
        buf[i--] = digits[x % base];
 6e8:	45a9                	li	a1,10
    if (sign)
 6ea:	d00652e3          	bgez	a2,3ee <printf+0x304>
        buf[i--] = '-';
 6ee:	02d00793          	li	a5,45
 6f2:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 6f6:	45a5                	li	a1,9
 6f8:	b9dd                	j	3ee <printf+0x304>
 6fa:	45a9                	li	a1,10
    if (sign)
 6fc:	ce06d9e3          	bgez	a3,3ee <printf+0x304>
 700:	b7fd                	j	6ee <printf+0x604>
        buf[i--] = digits[x % base];
 702:	45a1                	li	a1,8
    if (sign)
 704:	ce0655e3          	bgez	a2,3ee <printf+0x304>
 708:	b9f1                	j	3e4 <printf+0x2fa>
        buf[i--] = digits[x % base];
 70a:	45a5                	li	a1,9
    if (sign)
 70c:	ce0651e3          	bgez	a2,3ee <printf+0x304>
        buf[i--] = '-';
 710:	02d00793          	li	a5,45
 714:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 718:	45a1                	li	a1,8
 71a:	b9d1                	j	3ee <printf+0x304>
    i = 15;
 71c:	45bd                	li	a1,15
 71e:	b9c1                	j	3ee <printf+0x304>
        buf[i--] = digits[x % base];
 720:	45a5                	li	a1,9
    if (sign)
 722:	cc06d6e3          	bgez	a3,3ee <printf+0x304>
 726:	b7ed                	j	710 <printf+0x626>

0000000000000728 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 728:	02000793          	li	a5,32
 72c:	00f50663          	beq	a0,a5,738 <isspace+0x10>
 730:	355d                	addiw	a0,a0,-9
 732:	00553513          	sltiu	a0,a0,5
 736:	8082                	ret
 738:	4505                	li	a0,1
}
 73a:	8082                	ret

000000000000073c <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 73c:	fd05051b          	addiw	a0,a0,-48
}
 740:	00a53513          	sltiu	a0,a0,10
 744:	8082                	ret

0000000000000746 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 746:	02000613          	li	a2,32
 74a:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 74c:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 750:	ff77069b          	addiw	a3,a4,-9
 754:	04c70d63          	beq	a4,a2,7ae <atoi+0x68>
 758:	0007079b          	sext.w	a5,a4
 75c:	04d5f963          	bgeu	a1,a3,7ae <atoi+0x68>
        s++;
    switch (*s)
 760:	02b00693          	li	a3,43
 764:	04d70a63          	beq	a4,a3,7b8 <atoi+0x72>
 768:	02d00693          	li	a3,45
 76c:	06d70463          	beq	a4,a3,7d4 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 770:	fd07859b          	addiw	a1,a5,-48
 774:	4625                	li	a2,9
 776:	873e                	mv	a4,a5
 778:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 77a:	4e01                	li	t3,0
    while (isdigit(*s))
 77c:	04b66a63          	bltu	a2,a1,7d0 <atoi+0x8a>
    int n = 0, neg = 0;
 780:	4501                	li	a0,0
    while (isdigit(*s))
 782:	4825                	li	a6,9
 784:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 788:	0025179b          	slliw	a5,a0,0x2
 78c:	9d3d                	addw	a0,a0,a5
 78e:	fd07031b          	addiw	t1,a4,-48
 792:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 796:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 79a:	0685                	addi	a3,a3,1
 79c:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 7a0:	0006071b          	sext.w	a4,a2
 7a4:	feb870e3          	bgeu	a6,a1,784 <atoi+0x3e>
    return neg ? n : -n;
 7a8:	000e0563          	beqz	t3,7b2 <atoi+0x6c>
}
 7ac:	8082                	ret
        s++;
 7ae:	0505                	addi	a0,a0,1
 7b0:	bf71                	j	74c <atoi+0x6>
 7b2:	4113053b          	subw	a0,t1,a7
 7b6:	8082                	ret
    while (isdigit(*s))
 7b8:	00154783          	lbu	a5,1(a0)
 7bc:	4625                	li	a2,9
        s++;
 7be:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7c2:	fd07859b          	addiw	a1,a5,-48
 7c6:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 7ca:	4e01                	li	t3,0
    while (isdigit(*s))
 7cc:	fab67ae3          	bgeu	a2,a1,780 <atoi+0x3a>
 7d0:	4501                	li	a0,0
}
 7d2:	8082                	ret
    while (isdigit(*s))
 7d4:	00154783          	lbu	a5,1(a0)
 7d8:	4625                	li	a2,9
        s++;
 7da:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7de:	fd07859b          	addiw	a1,a5,-48
 7e2:	0007871b          	sext.w	a4,a5
 7e6:	feb665e3          	bltu	a2,a1,7d0 <atoi+0x8a>
        neg = 1;
 7ea:	4e05                	li	t3,1
 7ec:	bf51                	j	780 <atoi+0x3a>

00000000000007ee <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 7ee:	16060d63          	beqz	a2,968 <memset+0x17a>
 7f2:	40a007b3          	neg	a5,a0
 7f6:	8b9d                	andi	a5,a5,7
 7f8:	00778713          	addi	a4,a5,7
 7fc:	482d                	li	a6,11
 7fe:	0ff5f593          	andi	a1,a1,255
 802:	fff60693          	addi	a3,a2,-1
 806:	17076263          	bltu	a4,a6,96a <memset+0x17c>
 80a:	16e6ea63          	bltu	a3,a4,97e <memset+0x190>
 80e:	16078563          	beqz	a5,978 <memset+0x18a>
 812:	00b50023          	sb	a1,0(a0)
 816:	4705                	li	a4,1
 818:	00150e93          	addi	t4,a0,1
 81c:	14e78c63          	beq	a5,a4,974 <memset+0x186>
 820:	00b500a3          	sb	a1,1(a0)
 824:	4709                	li	a4,2
 826:	00250e93          	addi	t4,a0,2
 82a:	14e78d63          	beq	a5,a4,984 <memset+0x196>
 82e:	00b50123          	sb	a1,2(a0)
 832:	470d                	li	a4,3
 834:	00350e93          	addi	t4,a0,3
 838:	12e78b63          	beq	a5,a4,96e <memset+0x180>
 83c:	00b501a3          	sb	a1,3(a0)
 840:	4711                	li	a4,4
 842:	00450e93          	addi	t4,a0,4
 846:	14e78163          	beq	a5,a4,988 <memset+0x19a>
 84a:	00b50223          	sb	a1,4(a0)
 84e:	4715                	li	a4,5
 850:	00550e93          	addi	t4,a0,5
 854:	12e78c63          	beq	a5,a4,98c <memset+0x19e>
 858:	00b502a3          	sb	a1,5(a0)
 85c:	471d                	li	a4,7
 85e:	00650e93          	addi	t4,a0,6
 862:	12e79763          	bne	a5,a4,990 <memset+0x1a2>
 866:	00750e93          	addi	t4,a0,7
 86a:	00b50323          	sb	a1,6(a0)
 86e:	4f1d                	li	t5,7
 870:	00859713          	slli	a4,a1,0x8
 874:	8f4d                	or	a4,a4,a1
 876:	01059e13          	slli	t3,a1,0x10
 87a:	01c76e33          	or	t3,a4,t3
 87e:	01859313          	slli	t1,a1,0x18
 882:	006e6333          	or	t1,t3,t1
 886:	02059893          	slli	a7,a1,0x20
 88a:	011368b3          	or	a7,t1,a7
 88e:	02859813          	slli	a6,a1,0x28
 892:	40f60333          	sub	t1,a2,a5
 896:	0108e833          	or	a6,a7,a6
 89a:	03059693          	slli	a3,a1,0x30
 89e:	00d866b3          	or	a3,a6,a3
 8a2:	03859713          	slli	a4,a1,0x38
 8a6:	97aa                	add	a5,a5,a0
 8a8:	ff837813          	andi	a6,t1,-8
 8ac:	8f55                	or	a4,a4,a3
 8ae:	00f806b3          	add	a3,a6,a5
 8b2:	e398                	sd	a4,0(a5)
 8b4:	07a1                	addi	a5,a5,8
 8b6:	fed79ee3          	bne	a5,a3,8b2 <memset+0xc4>
 8ba:	ff837693          	andi	a3,t1,-8
 8be:	00de87b3          	add	a5,t4,a3
 8c2:	01e6873b          	addw	a4,a3,t5
 8c6:	0ad30663          	beq	t1,a3,972 <memset+0x184>
 8ca:	00b78023          	sb	a1,0(a5)
 8ce:	0017069b          	addiw	a3,a4,1
 8d2:	08c6fb63          	bgeu	a3,a2,968 <memset+0x17a>
 8d6:	00b780a3          	sb	a1,1(a5)
 8da:	0027069b          	addiw	a3,a4,2
 8de:	08c6f563          	bgeu	a3,a2,968 <memset+0x17a>
 8e2:	00b78123          	sb	a1,2(a5)
 8e6:	0037069b          	addiw	a3,a4,3
 8ea:	06c6ff63          	bgeu	a3,a2,968 <memset+0x17a>
 8ee:	00b781a3          	sb	a1,3(a5)
 8f2:	0047069b          	addiw	a3,a4,4
 8f6:	06c6f963          	bgeu	a3,a2,968 <memset+0x17a>
 8fa:	00b78223          	sb	a1,4(a5)
 8fe:	0057069b          	addiw	a3,a4,5
 902:	06c6f363          	bgeu	a3,a2,968 <memset+0x17a>
 906:	00b782a3          	sb	a1,5(a5)
 90a:	0067069b          	addiw	a3,a4,6
 90e:	04c6fd63          	bgeu	a3,a2,968 <memset+0x17a>
 912:	00b78323          	sb	a1,6(a5)
 916:	0077069b          	addiw	a3,a4,7
 91a:	04c6f763          	bgeu	a3,a2,968 <memset+0x17a>
 91e:	00b783a3          	sb	a1,7(a5)
 922:	0087069b          	addiw	a3,a4,8
 926:	04c6f163          	bgeu	a3,a2,968 <memset+0x17a>
 92a:	00b78423          	sb	a1,8(a5)
 92e:	0097069b          	addiw	a3,a4,9
 932:	02c6fb63          	bgeu	a3,a2,968 <memset+0x17a>
 936:	00b784a3          	sb	a1,9(a5)
 93a:	00a7069b          	addiw	a3,a4,10
 93e:	02c6f563          	bgeu	a3,a2,968 <memset+0x17a>
 942:	00b78523          	sb	a1,10(a5)
 946:	00b7069b          	addiw	a3,a4,11
 94a:	00c6ff63          	bgeu	a3,a2,968 <memset+0x17a>
 94e:	00b785a3          	sb	a1,11(a5)
 952:	00c7069b          	addiw	a3,a4,12
 956:	00c6f963          	bgeu	a3,a2,968 <memset+0x17a>
 95a:	00b78623          	sb	a1,12(a5)
 95e:	2735                	addiw	a4,a4,13
 960:	00c77463          	bgeu	a4,a2,968 <memset+0x17a>
 964:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 968:	8082                	ret
 96a:	472d                	li	a4,11
 96c:	bd79                	j	80a <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 96e:	4f0d                	li	t5,3
 970:	b701                	j	870 <memset+0x82>
 972:	8082                	ret
 974:	4f05                	li	t5,1
 976:	bded                	j	870 <memset+0x82>
 978:	8eaa                	mv	t4,a0
 97a:	4f01                	li	t5,0
 97c:	bdd5                	j	870 <memset+0x82>
 97e:	87aa                	mv	a5,a0
 980:	4701                	li	a4,0
 982:	b7a1                	j	8ca <memset+0xdc>
 984:	4f09                	li	t5,2
 986:	b5ed                	j	870 <memset+0x82>
 988:	4f11                	li	t5,4
 98a:	b5dd                	j	870 <memset+0x82>
 98c:	4f15                	li	t5,5
 98e:	b5cd                	j	870 <memset+0x82>
 990:	4f19                	li	t5,6
 992:	bdf9                	j	870 <memset+0x82>

0000000000000994 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 994:	00054783          	lbu	a5,0(a0)
 998:	0005c703          	lbu	a4,0(a1)
 99c:	00e79863          	bne	a5,a4,9ac <strcmp+0x18>
 9a0:	0505                	addi	a0,a0,1
 9a2:	0585                	addi	a1,a1,1
 9a4:	fbe5                	bnez	a5,994 <strcmp>
 9a6:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 9a8:	9d19                	subw	a0,a0,a4
 9aa:	8082                	ret
 9ac:	0007851b          	sext.w	a0,a5
 9b0:	bfe5                	j	9a8 <strcmp+0x14>

00000000000009b2 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 9b2:	ce05                	beqz	a2,9ea <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9b4:	00054703          	lbu	a4,0(a0)
 9b8:	0005c783          	lbu	a5,0(a1)
 9bc:	cb0d                	beqz	a4,9ee <strncmp+0x3c>
    if (!n--)
 9be:	167d                	addi	a2,a2,-1
 9c0:	00c506b3          	add	a3,a0,a2
 9c4:	a819                	j	9da <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9c6:	00a68e63          	beq	a3,a0,9e2 <strncmp+0x30>
 9ca:	0505                	addi	a0,a0,1
 9cc:	00e79b63          	bne	a5,a4,9e2 <strncmp+0x30>
 9d0:	00054703          	lbu	a4,0(a0)
 9d4:	0005c783          	lbu	a5,0(a1)
 9d8:	cb19                	beqz	a4,9ee <strncmp+0x3c>
 9da:	0005c783          	lbu	a5,0(a1)
 9de:	0585                	addi	a1,a1,1
 9e0:	f3fd                	bnez	a5,9c6 <strncmp+0x14>
        ;
    return *l - *r;
 9e2:	0007051b          	sext.w	a0,a4
 9e6:	9d1d                	subw	a0,a0,a5
 9e8:	8082                	ret
        return 0;
 9ea:	4501                	li	a0,0
}
 9ec:	8082                	ret
 9ee:	4501                	li	a0,0
    return *l - *r;
 9f0:	9d1d                	subw	a0,a0,a5
 9f2:	8082                	ret

00000000000009f4 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 9f4:	00757793          	andi	a5,a0,7
 9f8:	cf89                	beqz	a5,a12 <strlen+0x1e>
 9fa:	87aa                	mv	a5,a0
 9fc:	a029                	j	a06 <strlen+0x12>
 9fe:	0785                	addi	a5,a5,1
 a00:	0077f713          	andi	a4,a5,7
 a04:	cb01                	beqz	a4,a14 <strlen+0x20>
        if (!*s)
 a06:	0007c703          	lbu	a4,0(a5)
 a0a:	fb75                	bnez	a4,9fe <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 a0c:	40a78533          	sub	a0,a5,a0
}
 a10:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 a12:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 a14:	6394                	ld	a3,0(a5)
 a16:	00000597          	auipc	a1,0x0
 a1a:	5925b583          	ld	a1,1426(a1) # fa8 <unlink+0x44>
 a1e:	00000617          	auipc	a2,0x0
 a22:	59263603          	ld	a2,1426(a2) # fb0 <unlink+0x4c>
 a26:	a019                	j	a2c <strlen+0x38>
 a28:	6794                	ld	a3,8(a5)
 a2a:	07a1                	addi	a5,a5,8
 a2c:	00b68733          	add	a4,a3,a1
 a30:	fff6c693          	not	a3,a3
 a34:	8f75                	and	a4,a4,a3
 a36:	8f71                	and	a4,a4,a2
 a38:	db65                	beqz	a4,a28 <strlen+0x34>
    for (; *s; s++)
 a3a:	0007c703          	lbu	a4,0(a5)
 a3e:	d779                	beqz	a4,a0c <strlen+0x18>
 a40:	0017c703          	lbu	a4,1(a5)
 a44:	0785                	addi	a5,a5,1
 a46:	d379                	beqz	a4,a0c <strlen+0x18>
 a48:	0017c703          	lbu	a4,1(a5)
 a4c:	0785                	addi	a5,a5,1
 a4e:	fb6d                	bnez	a4,a40 <strlen+0x4c>
 a50:	bf75                	j	a0c <strlen+0x18>

0000000000000a52 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a52:	00757713          	andi	a4,a0,7
{
 a56:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 a58:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a5c:	cb19                	beqz	a4,a72 <memchr+0x20>
 a5e:	ce25                	beqz	a2,ad6 <memchr+0x84>
 a60:	0007c703          	lbu	a4,0(a5)
 a64:	04b70e63          	beq	a4,a1,ac0 <memchr+0x6e>
 a68:	0785                	addi	a5,a5,1
 a6a:	0077f713          	andi	a4,a5,7
 a6e:	167d                	addi	a2,a2,-1
 a70:	f77d                	bnez	a4,a5e <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 a72:	4501                	li	a0,0
    if (n && *s != c)
 a74:	c235                	beqz	a2,ad8 <memchr+0x86>
 a76:	0007c703          	lbu	a4,0(a5)
 a7a:	04b70363          	beq	a4,a1,ac0 <memchr+0x6e>
        size_t k = ONES * c;
 a7e:	00000517          	auipc	a0,0x0
 a82:	53a53503          	ld	a0,1338(a0) # fb8 <unlink+0x54>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 a86:	471d                	li	a4,7
        size_t k = ONES * c;
 a88:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 a8c:	02c77a63          	bgeu	a4,a2,ac0 <memchr+0x6e>
 a90:	00000897          	auipc	a7,0x0
 a94:	5188b883          	ld	a7,1304(a7) # fa8 <unlink+0x44>
 a98:	00000817          	auipc	a6,0x0
 a9c:	51883803          	ld	a6,1304(a6) # fb0 <unlink+0x4c>
 aa0:	431d                	li	t1,7
 aa2:	a029                	j	aac <memchr+0x5a>
 aa4:	1661                	addi	a2,a2,-8
 aa6:	07a1                	addi	a5,a5,8
 aa8:	02c37963          	bgeu	t1,a2,ada <memchr+0x88>
 aac:	6398                	ld	a4,0(a5)
 aae:	8f29                	xor	a4,a4,a0
 ab0:	011706b3          	add	a3,a4,a7
 ab4:	fff74713          	not	a4,a4
 ab8:	8f75                	and	a4,a4,a3
 aba:	01077733          	and	a4,a4,a6
 abe:	d37d                	beqz	a4,aa4 <memchr+0x52>
 ac0:	853e                	mv	a0,a5
 ac2:	97b2                	add	a5,a5,a2
 ac4:	a021                	j	acc <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 ac6:	0505                	addi	a0,a0,1
 ac8:	00f50763          	beq	a0,a5,ad6 <memchr+0x84>
 acc:	00054703          	lbu	a4,0(a0)
 ad0:	feb71be3          	bne	a4,a1,ac6 <memchr+0x74>
 ad4:	8082                	ret
    return n ? (void *)s : 0;
 ad6:	4501                	li	a0,0
}
 ad8:	8082                	ret
    return n ? (void *)s : 0;
 ada:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 adc:	f275                	bnez	a2,ac0 <memchr+0x6e>
}
 ade:	8082                	ret

0000000000000ae0 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 ae0:	1101                	addi	sp,sp,-32
 ae2:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 ae4:	862e                	mv	a2,a1
{
 ae6:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 ae8:	4581                	li	a1,0
{
 aea:	e426                	sd	s1,8(sp)
 aec:	ec06                	sd	ra,24(sp)
 aee:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 af0:	f63ff0ef          	jal	ra,a52 <memchr>
    return p ? p - s : n;
 af4:	c519                	beqz	a0,b02 <strnlen+0x22>
}
 af6:	60e2                	ld	ra,24(sp)
 af8:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 afa:	8d05                	sub	a0,a0,s1
}
 afc:	64a2                	ld	s1,8(sp)
 afe:	6105                	addi	sp,sp,32
 b00:	8082                	ret
 b02:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 b04:	8522                	mv	a0,s0
}
 b06:	6442                	ld	s0,16(sp)
 b08:	64a2                	ld	s1,8(sp)
 b0a:	6105                	addi	sp,sp,32
 b0c:	8082                	ret

0000000000000b0e <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 b0e:	00b547b3          	xor	a5,a0,a1
 b12:	8b9d                	andi	a5,a5,7
 b14:	eb95                	bnez	a5,b48 <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 b16:	0075f793          	andi	a5,a1,7
 b1a:	e7b1                	bnez	a5,b66 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 b1c:	6198                	ld	a4,0(a1)
 b1e:	00000617          	auipc	a2,0x0
 b22:	48a63603          	ld	a2,1162(a2) # fa8 <unlink+0x44>
 b26:	00000817          	auipc	a6,0x0
 b2a:	48a83803          	ld	a6,1162(a6) # fb0 <unlink+0x4c>
 b2e:	a029                	j	b38 <stpcpy+0x2a>
 b30:	e118                	sd	a4,0(a0)
 b32:	6598                	ld	a4,8(a1)
 b34:	05a1                	addi	a1,a1,8
 b36:	0521                	addi	a0,a0,8
 b38:	00c707b3          	add	a5,a4,a2
 b3c:	fff74693          	not	a3,a4
 b40:	8ff5                	and	a5,a5,a3
 b42:	0107f7b3          	and	a5,a5,a6
 b46:	d7ed                	beqz	a5,b30 <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 b48:	0005c783          	lbu	a5,0(a1)
 b4c:	00f50023          	sb	a5,0(a0)
 b50:	c785                	beqz	a5,b78 <stpcpy+0x6a>
 b52:	0015c783          	lbu	a5,1(a1)
 b56:	0505                	addi	a0,a0,1
 b58:	0585                	addi	a1,a1,1
 b5a:	00f50023          	sb	a5,0(a0)
 b5e:	fbf5                	bnez	a5,b52 <stpcpy+0x44>
        ;
    return d;
}
 b60:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 b62:	0505                	addi	a0,a0,1
 b64:	df45                	beqz	a4,b1c <stpcpy+0xe>
            if (!(*d = *s))
 b66:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 b6a:	0585                	addi	a1,a1,1
 b6c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 b70:	00f50023          	sb	a5,0(a0)
 b74:	f7fd                	bnez	a5,b62 <stpcpy+0x54>
}
 b76:	8082                	ret
 b78:	8082                	ret

0000000000000b7a <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 b7a:	00b547b3          	xor	a5,a0,a1
 b7e:	8b9d                	andi	a5,a5,7
 b80:	1a079863          	bnez	a5,d30 <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 b84:	0075f793          	andi	a5,a1,7
 b88:	16078463          	beqz	a5,cf0 <stpncpy+0x176>
 b8c:	ea01                	bnez	a2,b9c <stpncpy+0x22>
 b8e:	a421                	j	d96 <stpncpy+0x21c>
 b90:	167d                	addi	a2,a2,-1
 b92:	0505                	addi	a0,a0,1
 b94:	14070e63          	beqz	a4,cf0 <stpncpy+0x176>
 b98:	1a060863          	beqz	a2,d48 <stpncpy+0x1ce>
 b9c:	0005c783          	lbu	a5,0(a1)
 ba0:	0585                	addi	a1,a1,1
 ba2:	0075f713          	andi	a4,a1,7
 ba6:	00f50023          	sb	a5,0(a0)
 baa:	f3fd                	bnez	a5,b90 <stpncpy+0x16>
 bac:	4805                	li	a6,1
 bae:	1a061863          	bnez	a2,d5e <stpncpy+0x1e4>
 bb2:	40a007b3          	neg	a5,a0
 bb6:	8b9d                	andi	a5,a5,7
 bb8:	4681                	li	a3,0
 bba:	18061a63          	bnez	a2,d4e <stpncpy+0x1d4>
 bbe:	00778713          	addi	a4,a5,7
 bc2:	45ad                	li	a1,11
 bc4:	18b76363          	bltu	a4,a1,d4a <stpncpy+0x1d0>
 bc8:	1ae6eb63          	bltu	a3,a4,d7e <stpncpy+0x204>
 bcc:	1a078363          	beqz	a5,d72 <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 bd0:	00050023          	sb	zero,0(a0)
 bd4:	4685                	li	a3,1
 bd6:	00150713          	addi	a4,a0,1
 bda:	18d78f63          	beq	a5,a3,d78 <stpncpy+0x1fe>
 bde:	000500a3          	sb	zero,1(a0)
 be2:	4689                	li	a3,2
 be4:	00250713          	addi	a4,a0,2
 be8:	18d78e63          	beq	a5,a3,d84 <stpncpy+0x20a>
 bec:	00050123          	sb	zero,2(a0)
 bf0:	468d                	li	a3,3
 bf2:	00350713          	addi	a4,a0,3
 bf6:	16d78c63          	beq	a5,a3,d6e <stpncpy+0x1f4>
 bfa:	000501a3          	sb	zero,3(a0)
 bfe:	4691                	li	a3,4
 c00:	00450713          	addi	a4,a0,4
 c04:	18d78263          	beq	a5,a3,d88 <stpncpy+0x20e>
 c08:	00050223          	sb	zero,4(a0)
 c0c:	4695                	li	a3,5
 c0e:	00550713          	addi	a4,a0,5
 c12:	16d78d63          	beq	a5,a3,d8c <stpncpy+0x212>
 c16:	000502a3          	sb	zero,5(a0)
 c1a:	469d                	li	a3,7
 c1c:	00650713          	addi	a4,a0,6
 c20:	16d79863          	bne	a5,a3,d90 <stpncpy+0x216>
 c24:	00750713          	addi	a4,a0,7
 c28:	00050323          	sb	zero,6(a0)
 c2c:	40f80833          	sub	a6,a6,a5
 c30:	ff887593          	andi	a1,a6,-8
 c34:	97aa                	add	a5,a5,a0
 c36:	95be                	add	a1,a1,a5
 c38:	0007b023          	sd	zero,0(a5)
 c3c:	07a1                	addi	a5,a5,8
 c3e:	feb79de3          	bne	a5,a1,c38 <stpncpy+0xbe>
 c42:	ff887593          	andi	a1,a6,-8
 c46:	9ead                	addw	a3,a3,a1
 c48:	00b707b3          	add	a5,a4,a1
 c4c:	12b80863          	beq	a6,a1,d7c <stpncpy+0x202>
 c50:	00078023          	sb	zero,0(a5)
 c54:	0016871b          	addiw	a4,a3,1
 c58:	0ec77863          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 c5c:	000780a3          	sb	zero,1(a5)
 c60:	0026871b          	addiw	a4,a3,2
 c64:	0ec77263          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 c68:	00078123          	sb	zero,2(a5)
 c6c:	0036871b          	addiw	a4,a3,3
 c70:	0cc77c63          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 c74:	000781a3          	sb	zero,3(a5)
 c78:	0046871b          	addiw	a4,a3,4
 c7c:	0cc77663          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 c80:	00078223          	sb	zero,4(a5)
 c84:	0056871b          	addiw	a4,a3,5
 c88:	0cc77063          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 c8c:	000782a3          	sb	zero,5(a5)
 c90:	0066871b          	addiw	a4,a3,6
 c94:	0ac77a63          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 c98:	00078323          	sb	zero,6(a5)
 c9c:	0076871b          	addiw	a4,a3,7
 ca0:	0ac77463          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 ca4:	000783a3          	sb	zero,7(a5)
 ca8:	0086871b          	addiw	a4,a3,8
 cac:	08c77e63          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 cb0:	00078423          	sb	zero,8(a5)
 cb4:	0096871b          	addiw	a4,a3,9
 cb8:	08c77863          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 cbc:	000784a3          	sb	zero,9(a5)
 cc0:	00a6871b          	addiw	a4,a3,10
 cc4:	08c77263          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 cc8:	00078523          	sb	zero,10(a5)
 ccc:	00b6871b          	addiw	a4,a3,11
 cd0:	06c77c63          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 cd4:	000785a3          	sb	zero,11(a5)
 cd8:	00c6871b          	addiw	a4,a3,12
 cdc:	06c77663          	bgeu	a4,a2,d48 <stpncpy+0x1ce>
 ce0:	00078623          	sb	zero,12(a5)
 ce4:	26b5                	addiw	a3,a3,13
 ce6:	06c6f163          	bgeu	a3,a2,d48 <stpncpy+0x1ce>
 cea:	000786a3          	sb	zero,13(a5)
 cee:	8082                	ret
            ;
        if (!n || !*s)
 cf0:	c645                	beqz	a2,d98 <stpncpy+0x21e>
 cf2:	0005c783          	lbu	a5,0(a1)
 cf6:	ea078be3          	beqz	a5,bac <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 cfa:	479d                	li	a5,7
 cfc:	02c7ff63          	bgeu	a5,a2,d3a <stpncpy+0x1c0>
 d00:	00000897          	auipc	a7,0x0
 d04:	2a88b883          	ld	a7,680(a7) # fa8 <unlink+0x44>
 d08:	00000817          	auipc	a6,0x0
 d0c:	2a883803          	ld	a6,680(a6) # fb0 <unlink+0x4c>
 d10:	431d                	li	t1,7
 d12:	6198                	ld	a4,0(a1)
 d14:	011707b3          	add	a5,a4,a7
 d18:	fff74693          	not	a3,a4
 d1c:	8ff5                	and	a5,a5,a3
 d1e:	0107f7b3          	and	a5,a5,a6
 d22:	ef81                	bnez	a5,d3a <stpncpy+0x1c0>
            *wd = *ws;
 d24:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d26:	1661                	addi	a2,a2,-8
 d28:	05a1                	addi	a1,a1,8
 d2a:	0521                	addi	a0,a0,8
 d2c:	fec363e3          	bltu	t1,a2,d12 <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 d30:	e609                	bnez	a2,d3a <stpncpy+0x1c0>
 d32:	a08d                	j	d94 <stpncpy+0x21a>
 d34:	167d                	addi	a2,a2,-1
 d36:	0505                	addi	a0,a0,1
 d38:	ca01                	beqz	a2,d48 <stpncpy+0x1ce>
 d3a:	0005c783          	lbu	a5,0(a1)
 d3e:	0585                	addi	a1,a1,1
 d40:	00f50023          	sb	a5,0(a0)
 d44:	fbe5                	bnez	a5,d34 <stpncpy+0x1ba>
        ;
tail:
 d46:	b59d                	j	bac <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 d48:	8082                	ret
 d4a:	472d                	li	a4,11
 d4c:	bdb5                	j	bc8 <stpncpy+0x4e>
 d4e:	00778713          	addi	a4,a5,7
 d52:	45ad                	li	a1,11
 d54:	fff60693          	addi	a3,a2,-1
 d58:	e6b778e3          	bgeu	a4,a1,bc8 <stpncpy+0x4e>
 d5c:	b7fd                	j	d4a <stpncpy+0x1d0>
 d5e:	40a007b3          	neg	a5,a0
 d62:	8832                	mv	a6,a2
 d64:	8b9d                	andi	a5,a5,7
 d66:	4681                	li	a3,0
 d68:	e4060be3          	beqz	a2,bbe <stpncpy+0x44>
 d6c:	b7cd                	j	d4e <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 d6e:	468d                	li	a3,3
 d70:	bd75                	j	c2c <stpncpy+0xb2>
 d72:	872a                	mv	a4,a0
 d74:	4681                	li	a3,0
 d76:	bd5d                	j	c2c <stpncpy+0xb2>
 d78:	4685                	li	a3,1
 d7a:	bd4d                	j	c2c <stpncpy+0xb2>
 d7c:	8082                	ret
 d7e:	87aa                	mv	a5,a0
 d80:	4681                	li	a3,0
 d82:	b5f9                	j	c50 <stpncpy+0xd6>
 d84:	4689                	li	a3,2
 d86:	b55d                	j	c2c <stpncpy+0xb2>
 d88:	4691                	li	a3,4
 d8a:	b54d                	j	c2c <stpncpy+0xb2>
 d8c:	4695                	li	a3,5
 d8e:	bd79                	j	c2c <stpncpy+0xb2>
 d90:	4699                	li	a3,6
 d92:	bd69                	j	c2c <stpncpy+0xb2>
 d94:	8082                	ret
 d96:	8082                	ret
 d98:	8082                	ret

0000000000000d9a <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 d9a:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 d9e:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 da0:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 da4:	2501                	sext.w	a0,a0
 da6:	8082                	ret

0000000000000da8 <close>:
    register long a7 __asm__("a7") = n;
 da8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 dac:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 db0:	2501                	sext.w	a0,a0
 db2:	8082                	ret

0000000000000db4 <read>:
    register long a7 __asm__("a7") = n;
 db4:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 db8:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 dbc:	8082                	ret

0000000000000dbe <write>:
    register long a7 __asm__("a7") = n;
 dbe:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dc2:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 dc6:	8082                	ret

0000000000000dc8 <getpid>:
    register long a7 __asm__("a7") = n;
 dc8:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 dcc:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 dd0:	2501                	sext.w	a0,a0
 dd2:	8082                	ret

0000000000000dd4 <sched_yield>:
    register long a7 __asm__("a7") = n;
 dd4:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 dd8:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 ddc:	2501                	sext.w	a0,a0
 dde:	8082                	ret

0000000000000de0 <fork>:
    register long a7 __asm__("a7") = n;
 de0:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 de4:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 de8:	2501                	sext.w	a0,a0
 dea:	8082                	ret

0000000000000dec <exit>:
    register long a7 __asm__("a7") = n;
 dec:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 df0:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 df4:	8082                	ret

0000000000000df6 <waitpid>:
    register long a7 __asm__("a7") = n;
 df6:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 dfa:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 dfe:	2501                	sext.w	a0,a0
 e00:	8082                	ret

0000000000000e02 <exec>:
    register long a7 __asm__("a7") = n;
 e02:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 e06:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 e0a:	2501                	sext.w	a0,a0
 e0c:	8082                	ret

0000000000000e0e <get_time>:

int64 get_time()
{
 e0e:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 e10:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e14:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e16:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e18:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 e1c:	2501                	sext.w	a0,a0
 e1e:	ed09                	bnez	a0,e38 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e20:	67a2                	ld	a5,8(sp)
 e22:	3e800713          	li	a4,1000
 e26:	00015503          	lhu	a0,0(sp)
 e2a:	02e7d7b3          	divu	a5,a5,a4
 e2e:	02e50533          	mul	a0,a0,a4
 e32:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 e34:	0141                	addi	sp,sp,16
 e36:	8082                	ret
        return -1;
 e38:	557d                	li	a0,-1
 e3a:	bfed                	j	e34 <get_time+0x26>

0000000000000e3c <sys_get_time>:
    register long a7 __asm__("a7") = n;
 e3c:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e40:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 e44:	2501                	sext.w	a0,a0
 e46:	8082                	ret

0000000000000e48 <sleep>:

int sleep(unsigned long long time)
{
 e48:	1141                	addi	sp,sp,-16
 e4a:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 e4c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e50:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e52:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e54:	00000073          	ecall
    if (err == 0)
 e58:	2501                	sext.w	a0,a0
 e5a:	e13d                	bnez	a0,ec0 <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e5c:	6722                	ld	a4,8(sp)
 e5e:	3e800693          	li	a3,1000
 e62:	00015783          	lhu	a5,0(sp)
 e66:	02d75733          	divu	a4,a4,a3
 e6a:	02d787b3          	mul	a5,a5,a3
 e6e:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 e70:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e74:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e76:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e78:	00000073          	ecall
    if (err == 0)
 e7c:	2501                	sext.w	a0,a0
 e7e:	ed15                	bnez	a0,eba <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e80:	6841                	lui	a6,0x10
 e82:	963e                	add	a2,a2,a5
 e84:	187d                	addi	a6,a6,-1
 e86:	3e800693          	li	a3,1000
 e8a:	a819                	j	ea0 <sleep+0x58>
    __asm_syscall("r"(a7))
 e8c:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 e90:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e94:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e96:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e98:	00000073          	ecall
    if (err == 0)
 e9c:	2501                	sext.w	a0,a0
 e9e:	ed11                	bnez	a0,eba <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 ea0:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 ea2:	07c00893          	li	a7,124
 ea6:	02d7d733          	divu	a4,a5,a3
 eaa:	6782                	ld	a5,0(sp)
 eac:	0107f7b3          	and	a5,a5,a6
 eb0:	02d787b3          	mul	a5,a5,a3
 eb4:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 eb6:	fcc7ebe3          	bltu	a5,a2,e8c <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 eba:	4501                	li	a0,0
 ebc:	0141                	addi	sp,sp,16
 ebe:	8082                	ret
 ec0:	57fd                	li	a5,-1
 ec2:	b77d                	j	e70 <sleep+0x28>

0000000000000ec4 <set_priority>:
    register long a7 __asm__("a7") = n;
 ec4:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 ec8:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 ecc:	2501                	sext.w	a0,a0
 ece:	8082                	ret

0000000000000ed0 <mmap>:
    register long a7 __asm__("a7") = n;
 ed0:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 ed4:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 ed8:	2501                	sext.w	a0,a0
 eda:	8082                	ret

0000000000000edc <munmap>:
    register long a7 __asm__("a7") = n;
 edc:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ee0:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 ee4:	2501                	sext.w	a0,a0
 ee6:	8082                	ret

0000000000000ee8 <wait>:

int wait(int *code)
{
 ee8:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 eea:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 eee:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ef0:	00000073          	ecall
    return waitpid(-1, code);
}
 ef4:	2501                	sext.w	a0,a0
 ef6:	8082                	ret

0000000000000ef8 <spawn>:
    register long a7 __asm__("a7") = n;
 ef8:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 efc:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 f00:	2501                	sext.w	a0,a0
 f02:	8082                	ret

0000000000000f04 <mailread>:
    register long a7 __asm__("a7") = n;
 f04:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f08:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 f0c:	2501                	sext.w	a0,a0
 f0e:	8082                	ret

0000000000000f10 <mailwrite>:
    register long a7 __asm__("a7") = n;
 f10:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f14:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 f18:	2501                	sext.w	a0,a0
 f1a:	8082                	ret

0000000000000f1c <fstat>:
    register long a7 __asm__("a7") = n;
 f1c:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f20:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 f24:	2501                	sext.w	a0,a0
 f26:	8082                	ret

0000000000000f28 <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 f28:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 f2a:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 f2e:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f30:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 f34:	2501                	sext.w	a0,a0
 f36:	8082                	ret

0000000000000f38 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 f38:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 f3a:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 f3e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f40:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 f44:	2501                	sext.w	a0,a0
 f46:	8082                	ret

0000000000000f48 <link>:

int link(char *old_path, char *new_path)
{
 f48:	87aa                	mv	a5,a0
 f4a:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 f4c:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 f50:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 f54:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 f56:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 f5a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f5c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 f60:	2501                	sext.w	a0,a0
 f62:	8082                	ret

0000000000000f64 <unlink>:

int unlink(char *path)
{
 f64:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f66:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 f6a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 f6e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f70:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 f74:	2501                	sext.w	a0,a0
 f76:	8082                	ret
