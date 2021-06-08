
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_2_stride1:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0700006f          	j	72 <__start_main>

0000000000000006 <spin_delay>:
    int j = 1;
    for (int _ = 0; _ < 10; ++_)
    {
        j = !j;
    }
}
   6:	8082                	ret

0000000000000008 <count_during>:

// to get enough accuracy, MAX_TIME (the running time of each process) should > 1000 mseconds.
const int MAX_TIME = 1000;
int count_during(int prio)
{
   8:	7179                	addi	sp,sp,-48
   a:	f406                	sd	ra,40(sp)
   c:	f022                	sd	s0,32(sp)
   e:	ec26                	sd	s1,24(sp)
  10:	842a                	mv	s0,a0
  12:	e84a                	sd	s2,16(sp)
  14:	e44e                	sd	s3,8(sp)
    uint64 start_time = get_time();
  16:	613000ef          	jal	ra,e28 <get_time>
  1a:	892a                	mv	s2,a0
    int acc = 0;
    set_priority(prio);
  1c:	8522                	mv	a0,s0
  1e:	6c1000ef          	jal	ra,ede <set_priority>
    for (;;)
    {
        spin_delay();
        acc += 1;
  22:	4405                	li	s0,1
  24:	19000493          	li	s1,400
        if (acc % 400 == 0)
        {
            uint64 time = get_time() - start_time;
            if (time > MAX_TIME)
  28:	3e800993          	li	s3,1000
        acc += 1;
  2c:	2405                	addiw	s0,s0,1
        if (acc % 400 == 0)
  2e:	0294673b          	remw	a4,s0,s1
  32:	ff6d                	bnez	a4,2c <count_during+0x24>
            uint64 time = get_time() - start_time;
  34:	5f5000ef          	jal	ra,e28 <get_time>
  38:	41250533          	sub	a0,a0,s2
            if (time > MAX_TIME)
  3c:	fea9f8e3          	bgeu	s3,a0,2c <count_during+0x24>
            {
                return acc;
            }
        }
    }
}
  40:	70a2                	ld	ra,40(sp)
  42:	8522                	mv	a0,s0
  44:	7402                	ld	s0,32(sp)
  46:	64e2                	ld	s1,24(sp)
  48:	6942                	ld	s2,16(sp)
  4a:	69a2                	ld	s3,8(sp)
  4c:	6145                	addi	sp,sp,48
  4e:	8082                	ret

0000000000000050 <main>:

int main()
{
  50:	1141                	addi	sp,sp,-16
    int prio = 6;
    int count = count_during(prio);
  52:	4519                	li	a0,6
{
  54:	e406                	sd	ra,8(sp)
    int count = count_during(prio);
  56:	fb3ff0ef          	jal	ra,8 <count_during>
  5a:	862a                	mv	a2,a0
    printf("priority = %d, exitcode = %d\n", prio, count);
  5c:	4599                	li	a1,6
  5e:	00001517          	auipc	a0,0x1
  62:	f3a50513          	addi	a0,a0,-198 # f98 <unlink+0x1a>
  66:	09e000ef          	jal	ra,104 <printf>
    return 0;
  6a:	60a2                	ld	ra,8(sp)
  6c:	4501                	li	a0,0
  6e:	0141                	addi	sp,sp,16
  70:	8082                	ret

0000000000000072 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  72:	1141                	addi	sp,sp,-16
  74:	e406                	sd	ra,8(sp)
    exit(main());
  76:	fdbff0ef          	jal	ra,50 <main>
  7a:	58d000ef          	jal	ra,e06 <exit>
    return 0;
}
  7e:	60a2                	ld	ra,8(sp)
  80:	4501                	li	a0,0
  82:	0141                	addi	sp,sp,16
  84:	8082                	ret

0000000000000086 <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  86:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  88:	00f10593          	addi	a1,sp,15
  8c:	4605                	li	a2,1
  8e:	4501                	li	a0,0
{
  90:	ec06                	sd	ra,24(sp)
    char byte = 0;
  92:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  96:	539000ef          	jal	ra,dce <read>
    return byte;
}
  9a:	60e2                	ld	ra,24(sp)
  9c:	00f14503          	lbu	a0,15(sp)
  a0:	6105                	addi	sp,sp,32
  a2:	8082                	ret

00000000000000a4 <putchar>:

int putchar(int c)
{
  a4:	1101                	addi	sp,sp,-32
  a6:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  a8:	00f10593          	addi	a1,sp,15
  ac:	4605                	li	a2,1
  ae:	4505                	li	a0,1
{
  b0:	ec06                	sd	ra,24(sp)
    char byte = c;
  b2:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  b6:	523000ef          	jal	ra,dd8 <write>
}
  ba:	60e2                	ld	ra,24(sp)
  bc:	2501                	sext.w	a0,a0
  be:	6105                	addi	sp,sp,32
  c0:	8082                	ret

00000000000000c2 <puts>:

int puts(const char *s)
{
  c2:	1101                	addi	sp,sp,-32
  c4:	e822                	sd	s0,16(sp)
  c6:	ec06                	sd	ra,24(sp)
  c8:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
  ca:	145000ef          	jal	ra,a0e <strlen>
  ce:	862a                	mv	a2,a0
  d0:	85a2                	mv	a1,s0
  d2:	4505                	li	a0,1
  d4:	505000ef          	jal	ra,dd8 <write>
  d8:	00055763          	bgez	a0,e6 <puts+0x24>
    return r;
}
  dc:	60e2                	ld	ra,24(sp)
  de:	6442                	ld	s0,16(sp)
  e0:	557d                	li	a0,-1
  e2:	6105                	addi	sp,sp,32
  e4:	8082                	ret
    return write(stdout, &byte, 1);
  e6:	00f10593          	addi	a1,sp,15
    char byte = c;
  ea:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
  ec:	4605                	li	a2,1
  ee:	4505                	li	a0,1
    char byte = c;
  f0:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
  f4:	4e5000ef          	jal	ra,dd8 <write>
}
  f8:	60e2                	ld	ra,24(sp)
  fa:	6442                	ld	s0,16(sp)
  fc:	41f5551b          	sraiw	a0,a0,0x1f
 100:	6105                	addi	sp,sp,32
 102:	8082                	ret

0000000000000104 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
 104:	7131                	addi	sp,sp,-192
 106:	ecce                	sd	s3,88(sp)
 108:	e8d2                	sd	s4,80(sp)
 10a:	e4d6                	sd	s5,72(sp)
 10c:	e0da                	sd	s6,64(sp)
 10e:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
 110:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
 112:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
 114:	6ae1                	lui	s5,0x18
 116:	000f4a37          	lui	s4,0xf4
 11a:	00989b37          	lui	s6,0x989
{
 11e:	fc86                	sd	ra,120(sp)
 120:	f8a2                	sd	s0,112(sp)
 122:	f4a6                	sd	s1,104(sp)
 124:	f0ca                	sd	s2,96(sp)
 126:	fc5e                	sd	s7,56(sp)
 128:	e52e                	sd	a1,136(sp)
 12a:	e932                	sd	a2,144(sp)
 12c:	ed36                	sd	a3,152(sp)
 12e:	f13a                	sd	a4,160(sp)
 130:	f942                	sd	a6,176(sp)
 132:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
 134:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
 136:	70f98993          	addi	s3,s3,1807 # 270f <digits+0x172f>
 13a:	69fa8a93          	addi	s5,s5,1695 # 1869f <digits+0x176bf>
 13e:	23fa0a13          	addi	s4,s4,575 # f423f <digits+0xf325f>
 142:	67fb0b13          	addi	s6,s6,1663 # 98967f <digits+0x98869f>
    for (;;)
    {
        if (!*s)
 146:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
 14a:	02500913          	li	s2,37
        if (!*s)
 14e:	1a078f63          	beqz	a5,30c <printf+0x208>
 152:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 154:	17278e63          	beq	a5,s2,2d0 <printf+0x1cc>
 158:	00164783          	lbu	a5,1(a2)
 15c:	0605                	addi	a2,a2,1
 15e:	fbfd                	bnez	a5,154 <printf+0x50>
 160:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 162:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 166:	85aa                	mv	a1,a0
 168:	8622                	mv	a2,s0
 16a:	4505                	li	a0,1
 16c:	46d000ef          	jal	ra,dd8 <write>
        out(f, a, l);
        if (l)
 170:	18041963          	bnez	s0,302 <printf+0x1fe>
            continue;
        if (s[1] == 0)
 174:	0014c783          	lbu	a5,1(s1)
 178:	18078a63          	beqz	a5,30c <printf+0x208>
            break;
        switch (s[1])
 17c:	07300713          	li	a4,115
 180:	28e78e63          	beq	a5,a4,41c <printf+0x318>
 184:	18f76f63          	bltu	a4,a5,322 <printf+0x21e>
 188:	06400713          	li	a4,100
 18c:	2ae78c63          	beq	a5,a4,444 <printf+0x340>
 190:	07000713          	li	a4,112
 194:	3ce79c63          	bne	a5,a4,56c <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 198:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 19a:	00001797          	auipc	a5,0x1
 19e:	e4678793          	addi	a5,a5,-442 # fe0 <digits>
            printptr(va_arg(ap, uint64));
 1a2:	6298                	ld	a4,0(a3)
 1a4:	00868093          	addi	ra,a3,8
 1a8:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 1aa:	00471293          	slli	t0,a4,0x4
 1ae:	00c71f13          	slli	t5,a4,0xc
 1b2:	01471e13          	slli	t3,a4,0x14
 1b6:	01c71893          	slli	a7,a4,0x1c
 1ba:	02471813          	slli	a6,a4,0x24
 1be:	02871513          	slli	a0,a4,0x28
 1c2:	02c71593          	slli	a1,a4,0x2c
 1c6:	03071693          	slli	a3,a4,0x30
 1ca:	00871f93          	slli	t6,a4,0x8
 1ce:	01071e93          	slli	t4,a4,0x10
 1d2:	01871313          	slli	t1,a4,0x18
 1d6:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1da:	03c2d293          	srli	t0,t0,0x3c
 1de:	03cf5f13          	srli	t5,t5,0x3c
 1e2:	03ce5e13          	srli	t3,t3,0x3c
 1e6:	03c8d893          	srli	a7,a7,0x3c
 1ea:	03c85813          	srli	a6,a6,0x3c
 1ee:	9171                	srli	a0,a0,0x3c
 1f0:	91f1                	srli	a1,a1,0x3c
 1f2:	92f1                	srli	a3,a3,0x3c
 1f4:	92be                	add	t0,t0,a5
 1f6:	9f3e                	add	t5,t5,a5
 1f8:	9e3e                	add	t3,t3,a5
 1fa:	98be                	add	a7,a7,a5
 1fc:	983e                	add	a6,a6,a5
 1fe:	953e                	add	a0,a0,a5
 200:	95be                	add	a1,a1,a5
 202:	96be                	add	a3,a3,a5
 204:	03c75393          	srli	t2,a4,0x3c
 208:	01c75b9b          	srliw	s7,a4,0x1c
 20c:	03cfdf93          	srli	t6,t6,0x3c
 210:	03cede93          	srli	t4,t4,0x3c
 214:	03c35313          	srli	t1,t1,0x3c
 218:	9271                	srli	a2,a2,0x3c
 21a:	0002c403          	lbu	s0,0(t0)
 21e:	93be                	add	t2,t2,a5
 220:	000f4283          	lbu	t0,0(t5)
 224:	9fbe                	add	t6,t6,a5
 226:	000e4f03          	lbu	t5,0(t3)
 22a:	9ebe                	add	t4,t4,a5
 22c:	0008ce03          	lbu	t3,0(a7)
 230:	933e                	add	t1,t1,a5
 232:	00084883          	lbu	a7,0(a6)
 236:	9bbe                	add	s7,s7,a5
 238:	00054803          	lbu	a6,0(a0)
 23c:	963e                	add	a2,a2,a5
 23e:	0005c503          	lbu	a0,0(a1)
 242:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 246:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 24a:	0003c903          	lbu	s2,0(t2)
 24e:	00064603          	lbu	a2,0(a2)
 252:	000fc383          	lbu	t2,0(t6)
 256:	8b3d                	andi	a4,a4,15
 258:	000ecf83          	lbu	t6,0(t4)
 25c:	92f1                	srli	a3,a3,0x3c
 25e:	00034e83          	lbu	t4,0(t1)
 262:	000bc303          	lbu	t1,0(s7)
 266:	96be                	add	a3,a3,a5
 268:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 26a:	7761                	lui	a4,0xffff8
 26c:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 270:	00710623          	sb	t2,12(sp)
 274:	005106a3          	sb	t0,13(sp)
 278:	01f10723          	sb	t6,14(sp)
 27c:	01e107a3          	sb	t5,15(sp)
 280:	01d10823          	sb	t4,16(sp)
 284:	01c108a3          	sb	t3,17(sp)
 288:	00610923          	sb	t1,18(sp)
 28c:	011109a3          	sb	a7,19(sp)
 290:	01010a23          	sb	a6,20(sp)
 294:	00a10aa3          	sb	a0,21(sp)
 298:	00b10b23          	sb	a1,22(sp)
 29c:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 2a0:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2a4:	01210523          	sb	s2,10(sp)
 2a8:	008105a3          	sb	s0,11(sp)
 2ac:	0006c703          	lbu	a4,0(a3)
 2b0:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 2b4:	4649                	li	a2,18
 2b6:	002c                	addi	a1,sp,8
 2b8:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2ba:	00e10c23          	sb	a4,24(sp)
 2be:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 2c2:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 2c6:	313000ef          	jal	ra,dd8 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 2ca:	00248513          	addi	a0,s1,2
 2ce:	bda5                	j	146 <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 2d0:	00064783          	lbu	a5,0(a2)
 2d4:	84b2                	mv	s1,a2
 2d6:	01278963          	beq	a5,s2,2e8 <printf+0x1e4>
 2da:	b561                	j	162 <printf+0x5e>
 2dc:	0024c783          	lbu	a5,2(s1)
 2e0:	0605                	addi	a2,a2,1
 2e2:	0489                	addi	s1,s1,2
 2e4:	e7279fe3          	bne	a5,s2,162 <printf+0x5e>
 2e8:	0014c783          	lbu	a5,1(s1)
 2ec:	ff2788e3          	beq	a5,s2,2dc <printf+0x1d8>
        l = z - a;
 2f0:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 2f4:	85aa                	mv	a1,a0
 2f6:	8622                	mv	a2,s0
 2f8:	4505                	li	a0,1
 2fa:	2df000ef          	jal	ra,dd8 <write>
        if (l)
 2fe:	e6040be3          	beqz	s0,174 <printf+0x70>
 302:	8526                	mv	a0,s1
        if (!*s)
 304:	00054783          	lbu	a5,0(a0)
 308:	e40795e3          	bnez	a5,152 <printf+0x4e>
    }
    va_end(ap);
 30c:	70e6                	ld	ra,120(sp)
 30e:	7446                	ld	s0,112(sp)
 310:	74a6                	ld	s1,104(sp)
 312:	7906                	ld	s2,96(sp)
 314:	69e6                	ld	s3,88(sp)
 316:	6a46                	ld	s4,80(sp)
 318:	6aa6                	ld	s5,72(sp)
 31a:	6b06                	ld	s6,64(sp)
 31c:	7be2                	ld	s7,56(sp)
 31e:	6129                	addi	sp,sp,192
 320:	8082                	ret
        switch (s[1])
 322:	07800713          	li	a4,120
 326:	24e79363          	bne	a5,a4,56c <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 32a:	6782                	ld	a5,0(sp)
 32c:	4394                	lw	a3,0(a5)
 32e:	07a1                	addi	a5,a5,8
 330:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 332:	2606c263          	bltz	a3,596 <printf+0x492>
        buf[i--] = digits[x % base];
 336:	00001797          	auipc	a5,0x1
 33a:	caa78793          	addi	a5,a5,-854 # fe0 <digits>
 33e:	00f6f713          	andi	a4,a3,15
 342:	973e                	add	a4,a4,a5
 344:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <digits+0xffffffffffff7020>
    buf[16] = 0;
 348:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 34c:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 34e:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 352:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 356:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 35a:	0046d51b          	srliw	a0,a3,0x4
 35e:	0ad5d563          	bge	a1,a3,408 <printf+0x304>
        buf[i--] = digits[x % base];
 362:	8a3d                	andi	a2,a2,15
 364:	963e                	add	a2,a2,a5
 366:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 36a:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 36e:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 372:	30a5fe63          	bgeu	a1,a0,68e <printf+0x58a>
        buf[i--] = digits[x % base];
 376:	00f77613          	andi	a2,a4,15
 37a:	963e                	add	a2,a2,a5
 37c:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 380:	45bd                	li	a1,15
 382:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 386:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 38a:	00475513          	srli	a0,a4,0x4
 38e:	30e5f963          	bgeu	a1,a4,6a0 <printf+0x59c>
        buf[i--] = digits[x % base];
 392:	8a3d                	andi	a2,a2,15
 394:	963e                	add	a2,a2,a5
 396:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 39a:	00875893          	srli	a7,a4,0x8
 39e:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 3a2:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 3a6:	30a5fd63          	bgeu	a1,a0,6c0 <printf+0x5bc>
        buf[i--] = digits[x % base];
 3aa:	8a3d                	andi	a2,a2,15
 3ac:	963e                	add	a2,a2,a5
 3ae:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3b2:	00c75813          	srli	a6,a4,0xc
 3b6:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 3ba:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 3be:	3315fe63          	bgeu	a1,a7,6fa <printf+0x5f6>
        buf[i--] = digits[x % base];
 3c2:	8a3d                	andi	a2,a2,15
 3c4:	963e                	add	a2,a2,a5
 3c6:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3ca:	01075893          	srli	a7,a4,0x10
 3ce:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 3d2:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 3d6:	3305ff63          	bgeu	a1,a6,714 <printf+0x610>
        buf[i--] = digits[x % base];
 3da:	8a3d                	andi	a2,a2,15
 3dc:	963e                	add	a2,a2,a5
 3de:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 3e2:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 3e6:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 3ea:	3515f863          	bgeu	a1,a7,73a <printf+0x636>
        buf[i--] = digits[x % base];
 3ee:	97ba                	add	a5,a5,a4
 3f0:	0007c783          	lbu	a5,0(a5)
 3f4:	45a1                	li	a1,8
 3f6:	00f10823          	sb	a5,16(sp)
    if (sign)
 3fa:	0006d763          	bgez	a3,408 <printf+0x304>
        buf[i--] = '-';
 3fe:	02d00793          	li	a5,45
 402:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 406:	459d                	li	a1,7
    write(f, s, l);
 408:	4641                	li	a2,16
 40a:	003c                	addi	a5,sp,8
 40c:	9e0d                	subw	a2,a2,a1
 40e:	4505                	li	a0,1
 410:	95be                	add	a1,a1,a5
 412:	1c7000ef          	jal	ra,dd8 <write>
        s += 2;
 416:	00248513          	addi	a0,s1,2
 41a:	b335                	j	146 <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 41c:	6782                	ld	a5,0(sp)
 41e:	6380                	ld	s0,0(a5)
 420:	07a1                	addi	a5,a5,8
 422:	e03e                	sd	a5,0(sp)
 424:	22040a63          	beqz	s0,658 <printf+0x554>
            l = strnlen(a, 200);
 428:	0c800593          	li	a1,200
 42c:	8522                	mv	a0,s0
 42e:	6cc000ef          	jal	ra,afa <strnlen>
    write(f, s, l);
 432:	0005061b          	sext.w	a2,a0
 436:	85a2                	mv	a1,s0
 438:	4505                	li	a0,1
 43a:	19f000ef          	jal	ra,dd8 <write>
        s += 2;
 43e:	00248513          	addi	a0,s1,2
 442:	b311                	j	146 <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 444:	6782                	ld	a5,0(sp)
 446:	4390                	lw	a2,0(a5)
 448:	07a1                	addi	a5,a5,8
 44a:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 44c:	1a064363          	bltz	a2,5f2 <printf+0x4ee>
        buf[i--] = digits[x % base];
 450:	46a9                	li	a3,10
 452:	02d6773b          	remuw	a4,a2,a3
 456:	00001797          	auipc	a5,0x1
 45a:	b8a78793          	addi	a5,a5,-1142 # fe0 <digits>
    buf[16] = 0;
 45e:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 462:	4525                	li	a0,9
        x = xx;
 464:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 468:	973e                	add	a4,a4,a5
 46a:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 46e:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 472:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 476:	2cc55063          	bge	a0,a2,736 <printf+0x632>
 47a:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 47e:	02d5f73b          	remuw	a4,a1,a3
 482:	1702                	slli	a4,a4,0x20
 484:	9301                	srli	a4,a4,0x20
 486:	973e                	add	a4,a4,a5
 488:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 48c:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 490:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 494:	1f057d63          	bgeu	a0,a6,68e <printf+0x58a>
        buf[i--] = digits[x % base];
 498:	4529                	li	a0,10
    } while ((x /= base) != 0);
 49a:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 49c:	02a5f73b          	remuw	a4,a1,a0
 4a0:	973e                	add	a4,a4,a5
 4a2:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 4a6:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 4aa:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 4ae:	1ab6f163          	bgeu	a3,a1,650 <printf+0x54c>
 4b2:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 4b6:	02a776bb          	remuw	a3,a4,a0
 4ba:	96be                	add	a3,a3,a5
 4bc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4c0:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4c4:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 4c8:	20b87c63          	bgeu	a6,a1,6e0 <printf+0x5dc>
 4cc:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 4d0:	02a776bb          	remuw	a3,a4,a0
 4d4:	96be                	add	a3,a3,a5
 4d6:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4da:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4de:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 4e2:	20b87363          	bgeu	a6,a1,6e8 <printf+0x5e4>
        buf[i--] = digits[x % base];
 4e6:	02a776bb          	remuw	a3,a4,a0
 4ea:	96be                	add	a3,a3,a5
 4ec:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 4f0:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 4f4:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 4f8:	20b9f563          	bgeu	s3,a1,702 <printf+0x5fe>
        buf[i--] = digits[x % base];
 4fc:	02a776bb          	remuw	a3,a4,a0
 500:	96be                	add	a3,a3,a5
 502:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 506:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 50a:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 50e:	20bafb63          	bgeu	s5,a1,724 <printf+0x620>
        buf[i--] = digits[x % base];
 512:	02a776bb          	remuw	a3,a4,a0
 516:	96be                	add	a3,a3,a5
 518:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 51c:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 520:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 524:	1eba7c63          	bgeu	s4,a1,71c <printf+0x618>
        buf[i--] = digits[x % base];
 528:	02a776bb          	remuw	a3,a4,a0
 52c:	96be                	add	a3,a3,a5
 52e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 532:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 536:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 53a:	14bb7163          	bgeu	s6,a1,67c <printf+0x578>
        buf[i--] = digits[x % base];
 53e:	1702                	slli	a4,a4,0x20
 540:	9301                	srli	a4,a4,0x20
 542:	97ba                	add	a5,a5,a4
 544:	0007c783          	lbu	a5,0(a5)
 548:	4599                	li	a1,6
 54a:	00f10723          	sb	a5,14(sp)
    if (sign)
 54e:	ea065de3          	bgez	a2,408 <printf+0x304>
        buf[i--] = '-';
 552:	02d00793          	li	a5,45
 556:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 55a:	4595                	li	a1,5
    write(f, s, l);
 55c:	003c                	addi	a5,sp,8
 55e:	4641                	li	a2,16
 560:	9e0d                	subw	a2,a2,a1
 562:	4505                	li	a0,1
 564:	95be                	add	a1,a1,a5
 566:	073000ef          	jal	ra,dd8 <write>
 56a:	b575                	j	416 <printf+0x312>
    char byte = c;
 56c:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 570:	4605                	li	a2,1
 572:	002c                	addi	a1,sp,8
 574:	4505                	li	a0,1
    char byte = c;
 576:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 57a:	05f000ef          	jal	ra,dd8 <write>
    char byte = c;
 57e:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 582:	4605                	li	a2,1
 584:	002c                	addi	a1,sp,8
 586:	4505                	li	a0,1
    char byte = c;
 588:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 58c:	04d000ef          	jal	ra,dd8 <write>
        s += 2;
 590:	00248513          	addi	a0,s1,2
 594:	be4d                	j	146 <printf+0x42>
        x = -xx;
 596:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 59a:	00001797          	auipc	a5,0x1
 59e:	a4678793          	addi	a5,a5,-1466 # fe0 <digits>
 5a2:	00f77613          	andi	a2,a4,15
 5a6:	963e                	add	a2,a2,a5
 5a8:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 5ac:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5b0:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 5b2:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 5b6:	0047551b          	srliw	a0,a4,0x4
 5ba:	0047561b          	srliw	a2,a4,0x4
 5be:	0ab6d263          	bge	a3,a1,662 <printf+0x55e>
        buf[i--] = digits[x % base];
 5c2:	8a3d                	andi	a2,a2,15
 5c4:	963e                	add	a2,a2,a5
 5c6:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 5ca:	463d                	li	a2,15
 5cc:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 5d0:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 5d4:	daa661e3          	bltu	a2,a0,376 <printf+0x272>
        buf[i--] = '-';
 5d8:	02d00793          	li	a5,45
 5dc:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 5e0:	45b5                	li	a1,13
    write(f, s, l);
 5e2:	003c                	addi	a5,sp,8
 5e4:	4641                	li	a2,16
 5e6:	9e0d                	subw	a2,a2,a1
 5e8:	4505                	li	a0,1
 5ea:	95be                	add	a1,a1,a5
 5ec:	7ec000ef          	jal	ra,dd8 <write>
 5f0:	b51d                	j	416 <printf+0x312>
        x = -xx;
 5f2:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 5f6:	46a9                	li	a3,10
 5f8:	02d875bb          	remuw	a1,a6,a3
 5fc:	00001797          	auipc	a5,0x1
 600:	9e478793          	addi	a5,a5,-1564 # fe0 <digits>
    buf[16] = 0;
 604:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 608:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 60a:	95be                	add	a1,a1,a5
 60c:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 610:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 614:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 618:	04a65563          	bge	a2,a0,662 <printf+0x55e>
 61c:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 620:	02d775bb          	remuw	a1,a4,a3
 624:	95be                	add	a1,a1,a5
 626:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 62a:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 62e:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 632:	fb0573e3          	bgeu	a0,a6,5d8 <printf+0x4d4>
        buf[i--] = digits[x % base];
 636:	4529                	li	a0,10
    } while ((x /= base) != 0);
 638:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 63a:	02a5f73b          	remuw	a4,a1,a0
 63e:	973e                	add	a4,a4,a5
 640:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 644:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 648:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 64c:	e6b6e3e3          	bltu	a3,a1,4b2 <printf+0x3ae>
        buf[i--] = digits[x % base];
 650:	45b5                	li	a1,13
    if (sign)
 652:	da065be3          	bgez	a2,408 <printf+0x304>
 656:	a881                	j	6a6 <printf+0x5a2>
                a = "(null)";
 658:	00001417          	auipc	s0,0x1
 65c:	96040413          	addi	s0,s0,-1696 # fb8 <unlink+0x3a>
 660:	b3e1                	j	428 <printf+0x324>
        buf[i--] = '-';
 662:	02d00793          	li	a5,45
 666:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 66a:	45b9                	li	a1,14
    write(f, s, l);
 66c:	003c                	addi	a5,sp,8
 66e:	4641                	li	a2,16
 670:	9e0d                	subw	a2,a2,a1
 672:	4505                	li	a0,1
 674:	95be                	add	a1,a1,a5
 676:	762000ef          	jal	ra,dd8 <write>
 67a:	bb71                	j	416 <printf+0x312>
        buf[i--] = digits[x % base];
 67c:	459d                	li	a1,7
    if (sign)
 67e:	d80655e3          	bgez	a2,408 <printf+0x304>
        buf[i--] = '-';
 682:	02d00793          	li	a5,45
 686:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 68a:	4599                	li	a1,6
 68c:	bbb5                	j	408 <printf+0x304>
 68e:	45b9                	li	a1,14
    write(f, s, l);
 690:	003c                	addi	a5,sp,8
 692:	4641                	li	a2,16
 694:	9e0d                	subw	a2,a2,a1
 696:	4505                	li	a0,1
 698:	95be                	add	a1,a1,a5
 69a:	73e000ef          	jal	ra,dd8 <write>
 69e:	bba5                	j	416 <printf+0x312>
        buf[i--] = digits[x % base];
 6a0:	45b5                	li	a1,13
    if (sign)
 6a2:	d606d3e3          	bgez	a3,408 <printf+0x304>
        buf[i--] = '-';
 6a6:	02d00793          	li	a5,45
 6aa:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 6ae:	45b1                	li	a1,12
    write(f, s, l);
 6b0:	003c                	addi	a5,sp,8
 6b2:	4641                	li	a2,16
 6b4:	9e0d                	subw	a2,a2,a1
 6b6:	4505                	li	a0,1
 6b8:	95be                	add	a1,a1,a5
 6ba:	71e000ef          	jal	ra,dd8 <write>
 6be:	bba1                	j	416 <printf+0x312>
        buf[i--] = digits[x % base];
 6c0:	45b1                	li	a1,12
    if (sign)
 6c2:	d406d3e3          	bgez	a3,408 <printf+0x304>
        buf[i--] = '-';
 6c6:	02d00793          	li	a5,45
 6ca:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 6ce:	45ad                	li	a1,11
    write(f, s, l);
 6d0:	003c                	addi	a5,sp,8
 6d2:	4641                	li	a2,16
 6d4:	9e0d                	subw	a2,a2,a1
 6d6:	4505                	li	a0,1
 6d8:	95be                	add	a1,a1,a5
 6da:	6fe000ef          	jal	ra,dd8 <write>
 6de:	bb25                	j	416 <printf+0x312>
        buf[i--] = digits[x % base];
 6e0:	45b1                	li	a1,12
    if (sign)
 6e2:	d20653e3          	bgez	a2,408 <printf+0x304>
 6e6:	b7c5                	j	6c6 <printf+0x5c2>
        buf[i--] = digits[x % base];
 6e8:	45ad                	li	a1,11
    if (sign)
 6ea:	d0065fe3          	bgez	a2,408 <printf+0x304>
        buf[i--] = '-';
 6ee:	02d00793          	li	a5,45
 6f2:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 6f6:	45a9                	li	a1,10
 6f8:	bb01                	j	408 <printf+0x304>
 6fa:	45ad                	li	a1,11
    if (sign)
 6fc:	d006d6e3          	bgez	a3,408 <printf+0x304>
 700:	b7fd                	j	6ee <printf+0x5ea>
        buf[i--] = digits[x % base];
 702:	45a9                	li	a1,10
    if (sign)
 704:	d00652e3          	bgez	a2,408 <printf+0x304>
        buf[i--] = '-';
 708:	02d00793          	li	a5,45
 70c:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 710:	45a5                	li	a1,9
 712:	b9dd                	j	408 <printf+0x304>
 714:	45a9                	li	a1,10
    if (sign)
 716:	ce06d9e3          	bgez	a3,408 <printf+0x304>
 71a:	b7fd                	j	708 <printf+0x604>
        buf[i--] = digits[x % base];
 71c:	45a1                	li	a1,8
    if (sign)
 71e:	ce0655e3          	bgez	a2,408 <printf+0x304>
 722:	b9f1                	j	3fe <printf+0x2fa>
        buf[i--] = digits[x % base];
 724:	45a5                	li	a1,9
    if (sign)
 726:	ce0651e3          	bgez	a2,408 <printf+0x304>
        buf[i--] = '-';
 72a:	02d00793          	li	a5,45
 72e:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 732:	45a1                	li	a1,8
 734:	b9d1                	j	408 <printf+0x304>
    i = 15;
 736:	45bd                	li	a1,15
 738:	b9c1                	j	408 <printf+0x304>
        buf[i--] = digits[x % base];
 73a:	45a5                	li	a1,9
    if (sign)
 73c:	cc06d6e3          	bgez	a3,408 <printf+0x304>
 740:	b7ed                	j	72a <printf+0x626>

0000000000000742 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 742:	02000793          	li	a5,32
 746:	00f50663          	beq	a0,a5,752 <isspace+0x10>
 74a:	355d                	addiw	a0,a0,-9
 74c:	00553513          	sltiu	a0,a0,5
 750:	8082                	ret
 752:	4505                	li	a0,1
}
 754:	8082                	ret

0000000000000756 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 756:	fd05051b          	addiw	a0,a0,-48
}
 75a:	00a53513          	sltiu	a0,a0,10
 75e:	8082                	ret

0000000000000760 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 760:	02000613          	li	a2,32
 764:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 766:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 76a:	ff77069b          	addiw	a3,a4,-9
 76e:	04c70d63          	beq	a4,a2,7c8 <atoi+0x68>
 772:	0007079b          	sext.w	a5,a4
 776:	04d5f963          	bgeu	a1,a3,7c8 <atoi+0x68>
        s++;
    switch (*s)
 77a:	02b00693          	li	a3,43
 77e:	04d70a63          	beq	a4,a3,7d2 <atoi+0x72>
 782:	02d00693          	li	a3,45
 786:	06d70463          	beq	a4,a3,7ee <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 78a:	fd07859b          	addiw	a1,a5,-48
 78e:	4625                	li	a2,9
 790:	873e                	mv	a4,a5
 792:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 794:	4e01                	li	t3,0
    while (isdigit(*s))
 796:	04b66a63          	bltu	a2,a1,7ea <atoi+0x8a>
    int n = 0, neg = 0;
 79a:	4501                	li	a0,0
    while (isdigit(*s))
 79c:	4825                	li	a6,9
 79e:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 7a2:	0025179b          	slliw	a5,a0,0x2
 7a6:	9d3d                	addw	a0,a0,a5
 7a8:	fd07031b          	addiw	t1,a4,-48
 7ac:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 7b0:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 7b4:	0685                	addi	a3,a3,1
 7b6:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 7ba:	0006071b          	sext.w	a4,a2
 7be:	feb870e3          	bgeu	a6,a1,79e <atoi+0x3e>
    return neg ? n : -n;
 7c2:	000e0563          	beqz	t3,7cc <atoi+0x6c>
}
 7c6:	8082                	ret
        s++;
 7c8:	0505                	addi	a0,a0,1
 7ca:	bf71                	j	766 <atoi+0x6>
 7cc:	4113053b          	subw	a0,t1,a7
 7d0:	8082                	ret
    while (isdigit(*s))
 7d2:	00154783          	lbu	a5,1(a0)
 7d6:	4625                	li	a2,9
        s++;
 7d8:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7dc:	fd07859b          	addiw	a1,a5,-48
 7e0:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 7e4:	4e01                	li	t3,0
    while (isdigit(*s))
 7e6:	fab67ae3          	bgeu	a2,a1,79a <atoi+0x3a>
 7ea:	4501                	li	a0,0
}
 7ec:	8082                	ret
    while (isdigit(*s))
 7ee:	00154783          	lbu	a5,1(a0)
 7f2:	4625                	li	a2,9
        s++;
 7f4:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 7f8:	fd07859b          	addiw	a1,a5,-48
 7fc:	0007871b          	sext.w	a4,a5
 800:	feb665e3          	bltu	a2,a1,7ea <atoi+0x8a>
        neg = 1;
 804:	4e05                	li	t3,1
 806:	bf51                	j	79a <atoi+0x3a>

0000000000000808 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 808:	16060d63          	beqz	a2,982 <memset+0x17a>
 80c:	40a007b3          	neg	a5,a0
 810:	8b9d                	andi	a5,a5,7
 812:	00778713          	addi	a4,a5,7
 816:	482d                	li	a6,11
 818:	0ff5f593          	andi	a1,a1,255
 81c:	fff60693          	addi	a3,a2,-1
 820:	17076263          	bltu	a4,a6,984 <memset+0x17c>
 824:	16e6ea63          	bltu	a3,a4,998 <memset+0x190>
 828:	16078563          	beqz	a5,992 <memset+0x18a>
 82c:	00b50023          	sb	a1,0(a0)
 830:	4705                	li	a4,1
 832:	00150e93          	addi	t4,a0,1
 836:	14e78c63          	beq	a5,a4,98e <memset+0x186>
 83a:	00b500a3          	sb	a1,1(a0)
 83e:	4709                	li	a4,2
 840:	00250e93          	addi	t4,a0,2
 844:	14e78d63          	beq	a5,a4,99e <memset+0x196>
 848:	00b50123          	sb	a1,2(a0)
 84c:	470d                	li	a4,3
 84e:	00350e93          	addi	t4,a0,3
 852:	12e78b63          	beq	a5,a4,988 <memset+0x180>
 856:	00b501a3          	sb	a1,3(a0)
 85a:	4711                	li	a4,4
 85c:	00450e93          	addi	t4,a0,4
 860:	14e78163          	beq	a5,a4,9a2 <memset+0x19a>
 864:	00b50223          	sb	a1,4(a0)
 868:	4715                	li	a4,5
 86a:	00550e93          	addi	t4,a0,5
 86e:	12e78c63          	beq	a5,a4,9a6 <memset+0x19e>
 872:	00b502a3          	sb	a1,5(a0)
 876:	471d                	li	a4,7
 878:	00650e93          	addi	t4,a0,6
 87c:	12e79763          	bne	a5,a4,9aa <memset+0x1a2>
 880:	00750e93          	addi	t4,a0,7
 884:	00b50323          	sb	a1,6(a0)
 888:	4f1d                	li	t5,7
 88a:	00859713          	slli	a4,a1,0x8
 88e:	8f4d                	or	a4,a4,a1
 890:	01059e13          	slli	t3,a1,0x10
 894:	01c76e33          	or	t3,a4,t3
 898:	01859313          	slli	t1,a1,0x18
 89c:	006e6333          	or	t1,t3,t1
 8a0:	02059893          	slli	a7,a1,0x20
 8a4:	011368b3          	or	a7,t1,a7
 8a8:	02859813          	slli	a6,a1,0x28
 8ac:	40f60333          	sub	t1,a2,a5
 8b0:	0108e833          	or	a6,a7,a6
 8b4:	03059693          	slli	a3,a1,0x30
 8b8:	00d866b3          	or	a3,a6,a3
 8bc:	03859713          	slli	a4,a1,0x38
 8c0:	97aa                	add	a5,a5,a0
 8c2:	ff837813          	andi	a6,t1,-8
 8c6:	8f55                	or	a4,a4,a3
 8c8:	00f806b3          	add	a3,a6,a5
 8cc:	e398                	sd	a4,0(a5)
 8ce:	07a1                	addi	a5,a5,8
 8d0:	fed79ee3          	bne	a5,a3,8cc <memset+0xc4>
 8d4:	ff837693          	andi	a3,t1,-8
 8d8:	00de87b3          	add	a5,t4,a3
 8dc:	01e6873b          	addw	a4,a3,t5
 8e0:	0ad30663          	beq	t1,a3,98c <memset+0x184>
 8e4:	00b78023          	sb	a1,0(a5)
 8e8:	0017069b          	addiw	a3,a4,1
 8ec:	08c6fb63          	bgeu	a3,a2,982 <memset+0x17a>
 8f0:	00b780a3          	sb	a1,1(a5)
 8f4:	0027069b          	addiw	a3,a4,2
 8f8:	08c6f563          	bgeu	a3,a2,982 <memset+0x17a>
 8fc:	00b78123          	sb	a1,2(a5)
 900:	0037069b          	addiw	a3,a4,3
 904:	06c6ff63          	bgeu	a3,a2,982 <memset+0x17a>
 908:	00b781a3          	sb	a1,3(a5)
 90c:	0047069b          	addiw	a3,a4,4
 910:	06c6f963          	bgeu	a3,a2,982 <memset+0x17a>
 914:	00b78223          	sb	a1,4(a5)
 918:	0057069b          	addiw	a3,a4,5
 91c:	06c6f363          	bgeu	a3,a2,982 <memset+0x17a>
 920:	00b782a3          	sb	a1,5(a5)
 924:	0067069b          	addiw	a3,a4,6
 928:	04c6fd63          	bgeu	a3,a2,982 <memset+0x17a>
 92c:	00b78323          	sb	a1,6(a5)
 930:	0077069b          	addiw	a3,a4,7
 934:	04c6f763          	bgeu	a3,a2,982 <memset+0x17a>
 938:	00b783a3          	sb	a1,7(a5)
 93c:	0087069b          	addiw	a3,a4,8
 940:	04c6f163          	bgeu	a3,a2,982 <memset+0x17a>
 944:	00b78423          	sb	a1,8(a5)
 948:	0097069b          	addiw	a3,a4,9
 94c:	02c6fb63          	bgeu	a3,a2,982 <memset+0x17a>
 950:	00b784a3          	sb	a1,9(a5)
 954:	00a7069b          	addiw	a3,a4,10
 958:	02c6f563          	bgeu	a3,a2,982 <memset+0x17a>
 95c:	00b78523          	sb	a1,10(a5)
 960:	00b7069b          	addiw	a3,a4,11
 964:	00c6ff63          	bgeu	a3,a2,982 <memset+0x17a>
 968:	00b785a3          	sb	a1,11(a5)
 96c:	00c7069b          	addiw	a3,a4,12
 970:	00c6f963          	bgeu	a3,a2,982 <memset+0x17a>
 974:	00b78623          	sb	a1,12(a5)
 978:	2735                	addiw	a4,a4,13
 97a:	00c77463          	bgeu	a4,a2,982 <memset+0x17a>
 97e:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 982:	8082                	ret
 984:	472d                	li	a4,11
 986:	bd79                	j	824 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 988:	4f0d                	li	t5,3
 98a:	b701                	j	88a <memset+0x82>
 98c:	8082                	ret
 98e:	4f05                	li	t5,1
 990:	bded                	j	88a <memset+0x82>
 992:	8eaa                	mv	t4,a0
 994:	4f01                	li	t5,0
 996:	bdd5                	j	88a <memset+0x82>
 998:	87aa                	mv	a5,a0
 99a:	4701                	li	a4,0
 99c:	b7a1                	j	8e4 <memset+0xdc>
 99e:	4f09                	li	t5,2
 9a0:	b5ed                	j	88a <memset+0x82>
 9a2:	4f11                	li	t5,4
 9a4:	b5dd                	j	88a <memset+0x82>
 9a6:	4f15                	li	t5,5
 9a8:	b5cd                	j	88a <memset+0x82>
 9aa:	4f19                	li	t5,6
 9ac:	bdf9                	j	88a <memset+0x82>

00000000000009ae <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 9ae:	00054783          	lbu	a5,0(a0)
 9b2:	0005c703          	lbu	a4,0(a1)
 9b6:	00e79863          	bne	a5,a4,9c6 <strcmp+0x18>
 9ba:	0505                	addi	a0,a0,1
 9bc:	0585                	addi	a1,a1,1
 9be:	fbe5                	bnez	a5,9ae <strcmp>
 9c0:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 9c2:	9d19                	subw	a0,a0,a4
 9c4:	8082                	ret
 9c6:	0007851b          	sext.w	a0,a5
 9ca:	bfe5                	j	9c2 <strcmp+0x14>

00000000000009cc <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 9cc:	ce05                	beqz	a2,a04 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9ce:	00054703          	lbu	a4,0(a0)
 9d2:	0005c783          	lbu	a5,0(a1)
 9d6:	cb0d                	beqz	a4,a08 <strncmp+0x3c>
    if (!n--)
 9d8:	167d                	addi	a2,a2,-1
 9da:	00c506b3          	add	a3,a0,a2
 9de:	a819                	j	9f4 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 9e0:	00a68e63          	beq	a3,a0,9fc <strncmp+0x30>
 9e4:	0505                	addi	a0,a0,1
 9e6:	00e79b63          	bne	a5,a4,9fc <strncmp+0x30>
 9ea:	00054703          	lbu	a4,0(a0)
 9ee:	0005c783          	lbu	a5,0(a1)
 9f2:	cb19                	beqz	a4,a08 <strncmp+0x3c>
 9f4:	0005c783          	lbu	a5,0(a1)
 9f8:	0585                	addi	a1,a1,1
 9fa:	f3fd                	bnez	a5,9e0 <strncmp+0x14>
        ;
    return *l - *r;
 9fc:	0007051b          	sext.w	a0,a4
 a00:	9d1d                	subw	a0,a0,a5
 a02:	8082                	ret
        return 0;
 a04:	4501                	li	a0,0
}
 a06:	8082                	ret
 a08:	4501                	li	a0,0
    return *l - *r;
 a0a:	9d1d                	subw	a0,a0,a5
 a0c:	8082                	ret

0000000000000a0e <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 a0e:	00757793          	andi	a5,a0,7
 a12:	cf89                	beqz	a5,a2c <strlen+0x1e>
 a14:	87aa                	mv	a5,a0
 a16:	a029                	j	a20 <strlen+0x12>
 a18:	0785                	addi	a5,a5,1
 a1a:	0077f713          	andi	a4,a5,7
 a1e:	cb01                	beqz	a4,a2e <strlen+0x20>
        if (!*s)
 a20:	0007c703          	lbu	a4,0(a5)
 a24:	fb75                	bnez	a4,a18 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 a26:	40a78533          	sub	a0,a5,a0
}
 a2a:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 a2c:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 a2e:	6394                	ld	a3,0(a5)
 a30:	00000597          	auipc	a1,0x0
 a34:	5985b583          	ld	a1,1432(a1) # fc8 <MAX_TIME+0x8>
 a38:	00000617          	auipc	a2,0x0
 a3c:	59863603          	ld	a2,1432(a2) # fd0 <MAX_TIME+0x10>
 a40:	a019                	j	a46 <strlen+0x38>
 a42:	6794                	ld	a3,8(a5)
 a44:	07a1                	addi	a5,a5,8
 a46:	00b68733          	add	a4,a3,a1
 a4a:	fff6c693          	not	a3,a3
 a4e:	8f75                	and	a4,a4,a3
 a50:	8f71                	and	a4,a4,a2
 a52:	db65                	beqz	a4,a42 <strlen+0x34>
    for (; *s; s++)
 a54:	0007c703          	lbu	a4,0(a5)
 a58:	d779                	beqz	a4,a26 <strlen+0x18>
 a5a:	0017c703          	lbu	a4,1(a5)
 a5e:	0785                	addi	a5,a5,1
 a60:	d379                	beqz	a4,a26 <strlen+0x18>
 a62:	0017c703          	lbu	a4,1(a5)
 a66:	0785                	addi	a5,a5,1
 a68:	fb6d                	bnez	a4,a5a <strlen+0x4c>
 a6a:	bf75                	j	a26 <strlen+0x18>

0000000000000a6c <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a6c:	00757713          	andi	a4,a0,7
{
 a70:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 a72:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 a76:	cb19                	beqz	a4,a8c <memchr+0x20>
 a78:	ce25                	beqz	a2,af0 <memchr+0x84>
 a7a:	0007c703          	lbu	a4,0(a5)
 a7e:	04b70e63          	beq	a4,a1,ada <memchr+0x6e>
 a82:	0785                	addi	a5,a5,1
 a84:	0077f713          	andi	a4,a5,7
 a88:	167d                	addi	a2,a2,-1
 a8a:	f77d                	bnez	a4,a78 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 a8c:	4501                	li	a0,0
    if (n && *s != c)
 a8e:	c235                	beqz	a2,af2 <memchr+0x86>
 a90:	0007c703          	lbu	a4,0(a5)
 a94:	04b70363          	beq	a4,a1,ada <memchr+0x6e>
        size_t k = ONES * c;
 a98:	00000517          	auipc	a0,0x0
 a9c:	54053503          	ld	a0,1344(a0) # fd8 <MAX_TIME+0x18>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 aa0:	471d                	li	a4,7
        size_t k = ONES * c;
 aa2:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 aa6:	02c77a63          	bgeu	a4,a2,ada <memchr+0x6e>
 aaa:	00000897          	auipc	a7,0x0
 aae:	51e8b883          	ld	a7,1310(a7) # fc8 <MAX_TIME+0x8>
 ab2:	00000817          	auipc	a6,0x0
 ab6:	51e83803          	ld	a6,1310(a6) # fd0 <MAX_TIME+0x10>
 aba:	431d                	li	t1,7
 abc:	a029                	j	ac6 <memchr+0x5a>
 abe:	1661                	addi	a2,a2,-8
 ac0:	07a1                	addi	a5,a5,8
 ac2:	02c37963          	bgeu	t1,a2,af4 <memchr+0x88>
 ac6:	6398                	ld	a4,0(a5)
 ac8:	8f29                	xor	a4,a4,a0
 aca:	011706b3          	add	a3,a4,a7
 ace:	fff74713          	not	a4,a4
 ad2:	8f75                	and	a4,a4,a3
 ad4:	01077733          	and	a4,a4,a6
 ad8:	d37d                	beqz	a4,abe <memchr+0x52>
 ada:	853e                	mv	a0,a5
 adc:	97b2                	add	a5,a5,a2
 ade:	a021                	j	ae6 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 ae0:	0505                	addi	a0,a0,1
 ae2:	00f50763          	beq	a0,a5,af0 <memchr+0x84>
 ae6:	00054703          	lbu	a4,0(a0)
 aea:	feb71be3          	bne	a4,a1,ae0 <memchr+0x74>
 aee:	8082                	ret
    return n ? (void *)s : 0;
 af0:	4501                	li	a0,0
}
 af2:	8082                	ret
    return n ? (void *)s : 0;
 af4:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 af6:	f275                	bnez	a2,ada <memchr+0x6e>
}
 af8:	8082                	ret

0000000000000afa <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 afa:	1101                	addi	sp,sp,-32
 afc:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 afe:	862e                	mv	a2,a1
{
 b00:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 b02:	4581                	li	a1,0
{
 b04:	e426                	sd	s1,8(sp)
 b06:	ec06                	sd	ra,24(sp)
 b08:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 b0a:	f63ff0ef          	jal	ra,a6c <memchr>
    return p ? p - s : n;
 b0e:	c519                	beqz	a0,b1c <strnlen+0x22>
}
 b10:	60e2                	ld	ra,24(sp)
 b12:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 b14:	8d05                	sub	a0,a0,s1
}
 b16:	64a2                	ld	s1,8(sp)
 b18:	6105                	addi	sp,sp,32
 b1a:	8082                	ret
 b1c:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 b1e:	8522                	mv	a0,s0
}
 b20:	6442                	ld	s0,16(sp)
 b22:	64a2                	ld	s1,8(sp)
 b24:	6105                	addi	sp,sp,32
 b26:	8082                	ret

0000000000000b28 <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 b28:	00b547b3          	xor	a5,a0,a1
 b2c:	8b9d                	andi	a5,a5,7
 b2e:	eb95                	bnez	a5,b62 <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 b30:	0075f793          	andi	a5,a1,7
 b34:	e7b1                	bnez	a5,b80 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 b36:	6198                	ld	a4,0(a1)
 b38:	00000617          	auipc	a2,0x0
 b3c:	49063603          	ld	a2,1168(a2) # fc8 <MAX_TIME+0x8>
 b40:	00000817          	auipc	a6,0x0
 b44:	49083803          	ld	a6,1168(a6) # fd0 <MAX_TIME+0x10>
 b48:	a029                	j	b52 <stpcpy+0x2a>
 b4a:	e118                	sd	a4,0(a0)
 b4c:	6598                	ld	a4,8(a1)
 b4e:	05a1                	addi	a1,a1,8
 b50:	0521                	addi	a0,a0,8
 b52:	00c707b3          	add	a5,a4,a2
 b56:	fff74693          	not	a3,a4
 b5a:	8ff5                	and	a5,a5,a3
 b5c:	0107f7b3          	and	a5,a5,a6
 b60:	d7ed                	beqz	a5,b4a <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 b62:	0005c783          	lbu	a5,0(a1)
 b66:	00f50023          	sb	a5,0(a0)
 b6a:	c785                	beqz	a5,b92 <stpcpy+0x6a>
 b6c:	0015c783          	lbu	a5,1(a1)
 b70:	0505                	addi	a0,a0,1
 b72:	0585                	addi	a1,a1,1
 b74:	00f50023          	sb	a5,0(a0)
 b78:	fbf5                	bnez	a5,b6c <stpcpy+0x44>
        ;
    return d;
}
 b7a:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 b7c:	0505                	addi	a0,a0,1
 b7e:	df45                	beqz	a4,b36 <stpcpy+0xe>
            if (!(*d = *s))
 b80:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 b84:	0585                	addi	a1,a1,1
 b86:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 b8a:	00f50023          	sb	a5,0(a0)
 b8e:	f7fd                	bnez	a5,b7c <stpcpy+0x54>
}
 b90:	8082                	ret
 b92:	8082                	ret

0000000000000b94 <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 b94:	00b547b3          	xor	a5,a0,a1
 b98:	8b9d                	andi	a5,a5,7
 b9a:	1a079863          	bnez	a5,d4a <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 b9e:	0075f793          	andi	a5,a1,7
 ba2:	16078463          	beqz	a5,d0a <stpncpy+0x176>
 ba6:	ea01                	bnez	a2,bb6 <stpncpy+0x22>
 ba8:	a421                	j	db0 <stpncpy+0x21c>
 baa:	167d                	addi	a2,a2,-1
 bac:	0505                	addi	a0,a0,1
 bae:	14070e63          	beqz	a4,d0a <stpncpy+0x176>
 bb2:	1a060863          	beqz	a2,d62 <stpncpy+0x1ce>
 bb6:	0005c783          	lbu	a5,0(a1)
 bba:	0585                	addi	a1,a1,1
 bbc:	0075f713          	andi	a4,a1,7
 bc0:	00f50023          	sb	a5,0(a0)
 bc4:	f3fd                	bnez	a5,baa <stpncpy+0x16>
 bc6:	4805                	li	a6,1
 bc8:	1a061863          	bnez	a2,d78 <stpncpy+0x1e4>
 bcc:	40a007b3          	neg	a5,a0
 bd0:	8b9d                	andi	a5,a5,7
 bd2:	4681                	li	a3,0
 bd4:	18061a63          	bnez	a2,d68 <stpncpy+0x1d4>
 bd8:	00778713          	addi	a4,a5,7
 bdc:	45ad                	li	a1,11
 bde:	18b76363          	bltu	a4,a1,d64 <stpncpy+0x1d0>
 be2:	1ae6eb63          	bltu	a3,a4,d98 <stpncpy+0x204>
 be6:	1a078363          	beqz	a5,d8c <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 bea:	00050023          	sb	zero,0(a0)
 bee:	4685                	li	a3,1
 bf0:	00150713          	addi	a4,a0,1
 bf4:	18d78f63          	beq	a5,a3,d92 <stpncpy+0x1fe>
 bf8:	000500a3          	sb	zero,1(a0)
 bfc:	4689                	li	a3,2
 bfe:	00250713          	addi	a4,a0,2
 c02:	18d78e63          	beq	a5,a3,d9e <stpncpy+0x20a>
 c06:	00050123          	sb	zero,2(a0)
 c0a:	468d                	li	a3,3
 c0c:	00350713          	addi	a4,a0,3
 c10:	16d78c63          	beq	a5,a3,d88 <stpncpy+0x1f4>
 c14:	000501a3          	sb	zero,3(a0)
 c18:	4691                	li	a3,4
 c1a:	00450713          	addi	a4,a0,4
 c1e:	18d78263          	beq	a5,a3,da2 <stpncpy+0x20e>
 c22:	00050223          	sb	zero,4(a0)
 c26:	4695                	li	a3,5
 c28:	00550713          	addi	a4,a0,5
 c2c:	16d78d63          	beq	a5,a3,da6 <stpncpy+0x212>
 c30:	000502a3          	sb	zero,5(a0)
 c34:	469d                	li	a3,7
 c36:	00650713          	addi	a4,a0,6
 c3a:	16d79863          	bne	a5,a3,daa <stpncpy+0x216>
 c3e:	00750713          	addi	a4,a0,7
 c42:	00050323          	sb	zero,6(a0)
 c46:	40f80833          	sub	a6,a6,a5
 c4a:	ff887593          	andi	a1,a6,-8
 c4e:	97aa                	add	a5,a5,a0
 c50:	95be                	add	a1,a1,a5
 c52:	0007b023          	sd	zero,0(a5)
 c56:	07a1                	addi	a5,a5,8
 c58:	feb79de3          	bne	a5,a1,c52 <stpncpy+0xbe>
 c5c:	ff887593          	andi	a1,a6,-8
 c60:	9ead                	addw	a3,a3,a1
 c62:	00b707b3          	add	a5,a4,a1
 c66:	12b80863          	beq	a6,a1,d96 <stpncpy+0x202>
 c6a:	00078023          	sb	zero,0(a5)
 c6e:	0016871b          	addiw	a4,a3,1
 c72:	0ec77863          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 c76:	000780a3          	sb	zero,1(a5)
 c7a:	0026871b          	addiw	a4,a3,2
 c7e:	0ec77263          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 c82:	00078123          	sb	zero,2(a5)
 c86:	0036871b          	addiw	a4,a3,3
 c8a:	0cc77c63          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 c8e:	000781a3          	sb	zero,3(a5)
 c92:	0046871b          	addiw	a4,a3,4
 c96:	0cc77663          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 c9a:	00078223          	sb	zero,4(a5)
 c9e:	0056871b          	addiw	a4,a3,5
 ca2:	0cc77063          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 ca6:	000782a3          	sb	zero,5(a5)
 caa:	0066871b          	addiw	a4,a3,6
 cae:	0ac77a63          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 cb2:	00078323          	sb	zero,6(a5)
 cb6:	0076871b          	addiw	a4,a3,7
 cba:	0ac77463          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 cbe:	000783a3          	sb	zero,7(a5)
 cc2:	0086871b          	addiw	a4,a3,8
 cc6:	08c77e63          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 cca:	00078423          	sb	zero,8(a5)
 cce:	0096871b          	addiw	a4,a3,9
 cd2:	08c77863          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 cd6:	000784a3          	sb	zero,9(a5)
 cda:	00a6871b          	addiw	a4,a3,10
 cde:	08c77263          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 ce2:	00078523          	sb	zero,10(a5)
 ce6:	00b6871b          	addiw	a4,a3,11
 cea:	06c77c63          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 cee:	000785a3          	sb	zero,11(a5)
 cf2:	00c6871b          	addiw	a4,a3,12
 cf6:	06c77663          	bgeu	a4,a2,d62 <stpncpy+0x1ce>
 cfa:	00078623          	sb	zero,12(a5)
 cfe:	26b5                	addiw	a3,a3,13
 d00:	06c6f163          	bgeu	a3,a2,d62 <stpncpy+0x1ce>
 d04:	000786a3          	sb	zero,13(a5)
 d08:	8082                	ret
            ;
        if (!n || !*s)
 d0a:	c645                	beqz	a2,db2 <stpncpy+0x21e>
 d0c:	0005c783          	lbu	a5,0(a1)
 d10:	ea078be3          	beqz	a5,bc6 <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d14:	479d                	li	a5,7
 d16:	02c7ff63          	bgeu	a5,a2,d54 <stpncpy+0x1c0>
 d1a:	00000897          	auipc	a7,0x0
 d1e:	2ae8b883          	ld	a7,686(a7) # fc8 <MAX_TIME+0x8>
 d22:	00000817          	auipc	a6,0x0
 d26:	2ae83803          	ld	a6,686(a6) # fd0 <MAX_TIME+0x10>
 d2a:	431d                	li	t1,7
 d2c:	6198                	ld	a4,0(a1)
 d2e:	011707b3          	add	a5,a4,a7
 d32:	fff74693          	not	a3,a4
 d36:	8ff5                	and	a5,a5,a3
 d38:	0107f7b3          	and	a5,a5,a6
 d3c:	ef81                	bnez	a5,d54 <stpncpy+0x1c0>
            *wd = *ws;
 d3e:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d40:	1661                	addi	a2,a2,-8
 d42:	05a1                	addi	a1,a1,8
 d44:	0521                	addi	a0,a0,8
 d46:	fec363e3          	bltu	t1,a2,d2c <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 d4a:	e609                	bnez	a2,d54 <stpncpy+0x1c0>
 d4c:	a08d                	j	dae <stpncpy+0x21a>
 d4e:	167d                	addi	a2,a2,-1
 d50:	0505                	addi	a0,a0,1
 d52:	ca01                	beqz	a2,d62 <stpncpy+0x1ce>
 d54:	0005c783          	lbu	a5,0(a1)
 d58:	0585                	addi	a1,a1,1
 d5a:	00f50023          	sb	a5,0(a0)
 d5e:	fbe5                	bnez	a5,d4e <stpncpy+0x1ba>
        ;
tail:
 d60:	b59d                	j	bc6 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 d62:	8082                	ret
 d64:	472d                	li	a4,11
 d66:	bdb5                	j	be2 <stpncpy+0x4e>
 d68:	00778713          	addi	a4,a5,7
 d6c:	45ad                	li	a1,11
 d6e:	fff60693          	addi	a3,a2,-1
 d72:	e6b778e3          	bgeu	a4,a1,be2 <stpncpy+0x4e>
 d76:	b7fd                	j	d64 <stpncpy+0x1d0>
 d78:	40a007b3          	neg	a5,a0
 d7c:	8832                	mv	a6,a2
 d7e:	8b9d                	andi	a5,a5,7
 d80:	4681                	li	a3,0
 d82:	e4060be3          	beqz	a2,bd8 <stpncpy+0x44>
 d86:	b7cd                	j	d68 <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 d88:	468d                	li	a3,3
 d8a:	bd75                	j	c46 <stpncpy+0xb2>
 d8c:	872a                	mv	a4,a0
 d8e:	4681                	li	a3,0
 d90:	bd5d                	j	c46 <stpncpy+0xb2>
 d92:	4685                	li	a3,1
 d94:	bd4d                	j	c46 <stpncpy+0xb2>
 d96:	8082                	ret
 d98:	87aa                	mv	a5,a0
 d9a:	4681                	li	a3,0
 d9c:	b5f9                	j	c6a <stpncpy+0xd6>
 d9e:	4689                	li	a3,2
 da0:	b55d                	j	c46 <stpncpy+0xb2>
 da2:	4691                	li	a3,4
 da4:	b54d                	j	c46 <stpncpy+0xb2>
 da6:	4695                	li	a3,5
 da8:	bd79                	j	c46 <stpncpy+0xb2>
 daa:	4699                	li	a3,6
 dac:	bd69                	j	c46 <stpncpy+0xb2>
 dae:	8082                	ret
 db0:	8082                	ret
 db2:	8082                	ret

0000000000000db4 <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 db4:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 db8:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dba:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 dbe:	2501                	sext.w	a0,a0
 dc0:	8082                	ret

0000000000000dc2 <close>:
    register long a7 __asm__("a7") = n;
 dc2:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 dc6:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 dca:	2501                	sext.w	a0,a0
 dcc:	8082                	ret

0000000000000dce <read>:
    register long a7 __asm__("a7") = n;
 dce:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 dd2:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 dd6:	8082                	ret

0000000000000dd8 <write>:
    register long a7 __asm__("a7") = n;
 dd8:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 ddc:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 de0:	8082                	ret

0000000000000de2 <getpid>:
    register long a7 __asm__("a7") = n;
 de2:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 de6:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 dea:	2501                	sext.w	a0,a0
 dec:	8082                	ret

0000000000000dee <sched_yield>:
    register long a7 __asm__("a7") = n;
 dee:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 df2:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 df6:	2501                	sext.w	a0,a0
 df8:	8082                	ret

0000000000000dfa <fork>:
    register long a7 __asm__("a7") = n;
 dfa:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 dfe:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 e02:	2501                	sext.w	a0,a0
 e04:	8082                	ret

0000000000000e06 <exit>:
    register long a7 __asm__("a7") = n;
 e06:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 e0a:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 e0e:	8082                	ret

0000000000000e10 <waitpid>:
    register long a7 __asm__("a7") = n;
 e10:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e14:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 e18:	2501                	sext.w	a0,a0
 e1a:	8082                	ret

0000000000000e1c <exec>:
    register long a7 __asm__("a7") = n;
 e1c:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 e20:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 e24:	2501                	sext.w	a0,a0
 e26:	8082                	ret

0000000000000e28 <get_time>:

int64 get_time()
{
 e28:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 e2a:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e2e:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e30:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e32:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 e36:	2501                	sext.w	a0,a0
 e38:	ed09                	bnez	a0,e52 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e3a:	67a2                	ld	a5,8(sp)
 e3c:	3e800713          	li	a4,1000
 e40:	00015503          	lhu	a0,0(sp)
 e44:	02e7d7b3          	divu	a5,a5,a4
 e48:	02e50533          	mul	a0,a0,a4
 e4c:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 e4e:	0141                	addi	sp,sp,16
 e50:	8082                	ret
        return -1;
 e52:	557d                	li	a0,-1
 e54:	bfed                	j	e4e <get_time+0x26>

0000000000000e56 <sys_get_time>:
    register long a7 __asm__("a7") = n;
 e56:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e5a:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 e5e:	2501                	sext.w	a0,a0
 e60:	8082                	ret

0000000000000e62 <sleep>:

int sleep(unsigned long long time)
{
 e62:	1141                	addi	sp,sp,-16
 e64:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 e66:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e6a:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e6c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e6e:	00000073          	ecall
    if (err == 0)
 e72:	2501                	sext.w	a0,a0
 e74:	e13d                	bnez	a0,eda <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e76:	6722                	ld	a4,8(sp)
 e78:	3e800693          	li	a3,1000
 e7c:	00015783          	lhu	a5,0(sp)
 e80:	02d75733          	divu	a4,a4,a3
 e84:	02d787b3          	mul	a5,a5,a3
 e88:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 e8a:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e8e:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e90:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e92:	00000073          	ecall
    if (err == 0)
 e96:	2501                	sext.w	a0,a0
 e98:	ed15                	bnez	a0,ed4 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e9a:	6841                	lui	a6,0x10
 e9c:	963e                	add	a2,a2,a5
 e9e:	187d                	addi	a6,a6,-1
 ea0:	3e800693          	li	a3,1000
 ea4:	a819                	j	eba <sleep+0x58>
    __asm_syscall("r"(a7))
 ea6:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 eaa:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 eae:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 eb0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 eb2:	00000073          	ecall
    if (err == 0)
 eb6:	2501                	sext.w	a0,a0
 eb8:	ed11                	bnez	a0,ed4 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 eba:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 ebc:	07c00893          	li	a7,124
 ec0:	02d7d733          	divu	a4,a5,a3
 ec4:	6782                	ld	a5,0(sp)
 ec6:	0107f7b3          	and	a5,a5,a6
 eca:	02d787b3          	mul	a5,a5,a3
 ece:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 ed0:	fcc7ebe3          	bltu	a5,a2,ea6 <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 ed4:	4501                	li	a0,0
 ed6:	0141                	addi	sp,sp,16
 ed8:	8082                	ret
 eda:	57fd                	li	a5,-1
 edc:	b77d                	j	e8a <sleep+0x28>

0000000000000ede <set_priority>:
    register long a7 __asm__("a7") = n;
 ede:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 ee2:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 ee6:	2501                	sext.w	a0,a0
 ee8:	8082                	ret

0000000000000eea <mmap>:
    register long a7 __asm__("a7") = n;
 eea:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 eee:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 ef2:	2501                	sext.w	a0,a0
 ef4:	8082                	ret

0000000000000ef6 <munmap>:
    register long a7 __asm__("a7") = n;
 ef6:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 efa:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 efe:	2501                	sext.w	a0,a0
 f00:	8082                	ret

0000000000000f02 <wait>:

int wait(int *code)
{
 f02:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f04:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 f08:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f0a:	00000073          	ecall
    return waitpid(-1, code);
}
 f0e:	2501                	sext.w	a0,a0
 f10:	8082                	ret

0000000000000f12 <spawn>:
    register long a7 __asm__("a7") = n;
 f12:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 f16:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 f1a:	2501                	sext.w	a0,a0
 f1c:	8082                	ret

0000000000000f1e <mailread>:
    register long a7 __asm__("a7") = n;
 f1e:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f22:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 f26:	2501                	sext.w	a0,a0
 f28:	8082                	ret

0000000000000f2a <mailwrite>:
    register long a7 __asm__("a7") = n;
 f2a:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f2e:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 f32:	2501                	sext.w	a0,a0
 f34:	8082                	ret

0000000000000f36 <fstat>:
    register long a7 __asm__("a7") = n;
 f36:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f3a:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 f3e:	2501                	sext.w	a0,a0
 f40:	8082                	ret

0000000000000f42 <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 f42:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 f44:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 f48:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f4a:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 f4e:	2501                	sext.w	a0,a0
 f50:	8082                	ret

0000000000000f52 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 f52:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 f54:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 f58:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f5a:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 f5e:	2501                	sext.w	a0,a0
 f60:	8082                	ret

0000000000000f62 <link>:

int link(char *old_path, char *new_path)
{
 f62:	87aa                	mv	a5,a0
 f64:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 f66:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 f6a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 f6e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 f70:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 f74:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f76:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 f7a:	2501                	sext.w	a0,a0
 f7c:	8082                	ret

0000000000000f7e <unlink>:

int unlink(char *path)
{
 f7e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f80:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 f84:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 f88:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f8a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 f8e:	2501                	sext.w	a0,a0
 f90:	8082                	ret
