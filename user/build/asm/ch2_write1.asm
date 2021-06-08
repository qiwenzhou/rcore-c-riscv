
/home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch2_write1:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
   0:	850a                	mv	a0,sp
    tail __start_main
   2:	0be0006f          	j	c0 <__start_main>

0000000000000006 <main>:
/// strinstring from stack section
/// strin
/// Test write1 OK!

int main(void)
{
   6:	1101                	addi	sp,sp,-32
   8:	e426                	sd	s1,8(sp)
    int str_len = strlen(DATA_STRING);
   a:	00001497          	auipc	s1,0x1
   e:	06648493          	addi	s1,s1,102 # 1070 <DATA_STRING>
  12:	6088                	ld	a0,0(s1)
{
  14:	ec06                	sd	ra,24(sp)
  16:	e822                	sd	s0,16(sp)
    int str_len = strlen(DATA_STRING);
  18:	245000ef          	jal	ra,a5c <strlen>
    assert(write(1234, DATA_STRING, str_len) == -1);
  1c:	608c                	ld	a1,0(s1)
    int str_len = strlen(DATA_STRING);
  1e:	0005041b          	sext.w	s0,a0
    assert(write(1234, DATA_STRING, str_len) == -1);
  22:	8622                	mv	a2,s0
  24:	4d200513          	li	a0,1234
  28:	5ff000ef          	jal	ra,e26 <write>
  2c:	57fd                	li	a5,-1
  2e:	00f50563          	beq	a0,a5,38 <main+0x32>
  32:	557d                	li	a0,-1
  34:	621000ef          	jal	ra,e54 <exit>
    assert(write(stdout, DATA_STRING, str_len) == str_len);
  38:	608c                	ld	a1,0(s1)
  3a:	8622                	mv	a2,s0
  3c:	4505                	li	a0,1
  3e:	5e9000ef          	jal	ra,e26 <write>
  42:	00850563          	beq	a0,s0,4c <main+0x46>
  46:	557d                	li	a0,-1
  48:	60d000ef          	jal	ra,e54 <exit>
    assert(write(stdout, DATA_STRING, 5) == 5);
  4c:	608c                	ld	a1,0(s1)
  4e:	4615                	li	a2,5
  50:	4505                	li	a0,1
  52:	5d5000ef          	jal	ra,e26 <write>
  56:	4795                	li	a5,5
  58:	00f50563          	beq	a0,a5,62 <main+0x5c>
  5c:	557d                	li	a0,-1
  5e:	5f7000ef          	jal	ra,e54 <exit>
    char *stack_string = "string from stack section\n";
    str_len = strlen(stack_string);
  62:	00001517          	auipc	a0,0x1
  66:	f7e50513          	addi	a0,a0,-130 # fe0 <unlink+0x14>
  6a:	1f3000ef          	jal	ra,a5c <strlen>
  6e:	0005041b          	sext.w	s0,a0
    assert(write(stdout, stack_string, str_len) == str_len);
  72:	8622                	mv	a2,s0
  74:	00001597          	auipc	a1,0x1
  78:	f6c58593          	addi	a1,a1,-148 # fe0 <unlink+0x14>
  7c:	4505                	li	a0,1
  7e:	5a9000ef          	jal	ra,e26 <write>
  82:	00850563          	beq	a0,s0,8c <main+0x86>
  86:	557d                	li	a0,-1
  88:	5cd000ef          	jal	ra,e54 <exit>
    assert(write(stdout, stack_string, 5) == 5);
  8c:	4615                	li	a2,5
  8e:	00001597          	auipc	a1,0x1
  92:	f5258593          	addi	a1,a1,-174 # fe0 <unlink+0x14>
  96:	4505                	li	a0,1
  98:	58f000ef          	jal	ra,e26 <write>
  9c:	4795                	li	a5,5
  9e:	00f50563          	beq	a0,a5,a8 <main+0xa2>
  a2:	557d                	li	a0,-1
  a4:	5b1000ef          	jal	ra,e54 <exit>
    puts("\nTest write1 OK!");
  a8:	00001517          	auipc	a0,0x1
  ac:	f5850513          	addi	a0,a0,-168 # 1000 <unlink+0x34>
  b0:	060000ef          	jal	ra,110 <puts>
    return 0;
}
  b4:	60e2                	ld	ra,24(sp)
  b6:	6442                	ld	s0,16(sp)
  b8:	64a2                	ld	s1,8(sp)
  ba:	4501                	li	a0,0
  bc:	6105                	addi	sp,sp,32
  be:	8082                	ret

00000000000000c0 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
  c0:	1141                	addi	sp,sp,-16
  c2:	e406                	sd	ra,8(sp)
    exit(main());
  c4:	f43ff0ef          	jal	ra,6 <main>
  c8:	58d000ef          	jal	ra,e54 <exit>
    return 0;
}
  cc:	60a2                	ld	ra,8(sp)
  ce:	4501                	li	a0,0
  d0:	0141                	addi	sp,sp,16
  d2:	8082                	ret

00000000000000d4 <getchar>:

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int getchar()
{
  d4:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
  d6:	00f10593          	addi	a1,sp,15
  da:	4605                	li	a2,1
  dc:	4501                	li	a0,0
{
  de:	ec06                	sd	ra,24(sp)
    char byte = 0;
  e0:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
  e4:	539000ef          	jal	ra,e1c <read>
    return byte;
}
  e8:	60e2                	ld	ra,24(sp)
  ea:	00f14503          	lbu	a0,15(sp)
  ee:	6105                	addi	sp,sp,32
  f0:	8082                	ret

00000000000000f2 <putchar>:

int putchar(int c)
{
  f2:	1101                	addi	sp,sp,-32
  f4:	87aa                	mv	a5,a0
    char byte = c;
    return write(stdout, &byte, 1);
  f6:	00f10593          	addi	a1,sp,15
  fa:	4605                	li	a2,1
  fc:	4505                	li	a0,1
{
  fe:	ec06                	sd	ra,24(sp)
    char byte = c;
 100:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
 104:	523000ef          	jal	ra,e26 <write>
}
 108:	60e2                	ld	ra,24(sp)
 10a:	2501                	sext.w	a0,a0
 10c:	6105                	addi	sp,sp,32
 10e:	8082                	ret

0000000000000110 <puts>:

int puts(const char *s)
{
 110:	1101                	addi	sp,sp,-32
 112:	e822                	sd	s0,16(sp)
 114:	ec06                	sd	ra,24(sp)
 116:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, s, strlen(s)) < 0 || putchar('\n') < 0);
 118:	145000ef          	jal	ra,a5c <strlen>
 11c:	862a                	mv	a2,a0
 11e:	85a2                	mv	a1,s0
 120:	4505                	li	a0,1
 122:	505000ef          	jal	ra,e26 <write>
 126:	00055763          	bgez	a0,134 <puts+0x24>
    return r;
}
 12a:	60e2                	ld	ra,24(sp)
 12c:	6442                	ld	s0,16(sp)
 12e:	557d                	li	a0,-1
 130:	6105                	addi	sp,sp,32
 132:	8082                	ret
    return write(stdout, &byte, 1);
 134:	00f10593          	addi	a1,sp,15
    char byte = c;
 138:	47a9                	li	a5,10
    return write(stdout, &byte, 1);
 13a:	4605                	li	a2,1
 13c:	4505                	li	a0,1
    char byte = c;
 13e:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
 142:	4e5000ef          	jal	ra,e26 <write>
}
 146:	60e2                	ld	ra,24(sp)
 148:	6442                	ld	s0,16(sp)
 14a:	41f5551b          	sraiw	a0,a0,0x1f
 14e:	6105                	addi	sp,sp,32
 150:	8082                	ret

0000000000000152 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
 152:	7131                	addi	sp,sp,-192
 154:	ecce                	sd	s3,88(sp)
 156:	e8d2                	sd	s4,80(sp)
 158:	e4d6                	sd	s5,72(sp)
 15a:	e0da                	sd	s6,64(sp)
 15c:	f53e                	sd	a5,168(sp)
    } while ((x /= base) != 0);
 15e:	6989                	lui	s3,0x2
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
 160:	013c                	addi	a5,sp,136
    } while ((x /= base) != 0);
 162:	6ae1                	lui	s5,0x18
 164:	000f4a37          	lui	s4,0xf4
 168:	00989b37          	lui	s6,0x989
{
 16c:	fc86                	sd	ra,120(sp)
 16e:	f8a2                	sd	s0,112(sp)
 170:	f4a6                	sd	s1,104(sp)
 172:	f0ca                	sd	s2,96(sp)
 174:	fc5e                	sd	s7,56(sp)
 176:	e52e                	sd	a1,136(sp)
 178:	e932                	sd	a2,144(sp)
 17a:	ed36                	sd	a3,152(sp)
 17c:	f13a                	sd	a4,160(sp)
 17e:	f942                	sd	a6,176(sp)
 180:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
 182:	e03e                	sd	a5,0(sp)
    } while ((x /= base) != 0);
 184:	70f98993          	addi	s3,s3,1807 # 270f <DATA_STRING+0x169f>
 188:	69fa8a93          	addi	s5,s5,1695 # 1869f <DATA_STRING+0x1762f>
 18c:	23fa0a13          	addi	s4,s4,575 # f423f <DATA_STRING+0xf31cf>
 190:	67fb0b13          	addi	s6,s6,1663 # 98967f <DATA_STRING+0x98860f>
    for (;;)
    {
        if (!*s)
 194:	00054783          	lbu	a5,0(a0)
            break;
        for (a = s; *s && *s != '%'; s++)
 198:	02500913          	li	s2,37
        if (!*s)
 19c:	1a078f63          	beqz	a5,35a <printf+0x208>
 1a0:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
 1a2:	17278e63          	beq	a5,s2,31e <printf+0x1cc>
 1a6:	00164783          	lbu	a5,1(a2)
 1aa:	0605                	addi	a2,a2,1
 1ac:	fbfd                	bnez	a5,1a2 <printf+0x50>
 1ae:	84b2                	mv	s1,a2
            ;
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
            ;
        l = z - a;
 1b0:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 1b4:	85aa                	mv	a1,a0
 1b6:	8622                	mv	a2,s0
 1b8:	4505                	li	a0,1
 1ba:	46d000ef          	jal	ra,e26 <write>
        out(f, a, l);
        if (l)
 1be:	18041963          	bnez	s0,350 <printf+0x1fe>
            continue;
        if (s[1] == 0)
 1c2:	0014c783          	lbu	a5,1(s1)
 1c6:	18078a63          	beqz	a5,35a <printf+0x208>
            break;
        switch (s[1])
 1ca:	07300713          	li	a4,115
 1ce:	28e78e63          	beq	a5,a4,46a <printf+0x318>
 1d2:	18f76f63          	bltu	a4,a5,370 <printf+0x21e>
 1d6:	06400713          	li	a4,100
 1da:	2ae78c63          	beq	a5,a4,492 <printf+0x340>
 1de:	07000713          	li	a4,112
 1e2:	3ce79c63          	bne	a5,a4,5ba <printf+0x468>
            break;
        case 'x':
            printint(va_arg(ap, int), 16, 1);
            break;
        case 'p':
            printptr(va_arg(ap, uint64));
 1e6:	6682                	ld	a3,0(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 1e8:	00001797          	auipc	a5,0x1
 1ec:	e7078793          	addi	a5,a5,-400 # 1058 <digits>
            printptr(va_arg(ap, uint64));
 1f0:	6298                	ld	a4,0(a3)
 1f2:	00868093          	addi	ra,a3,8
 1f6:	e006                	sd	ra,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 1f8:	00471293          	slli	t0,a4,0x4
 1fc:	00c71f13          	slli	t5,a4,0xc
 200:	01471e13          	slli	t3,a4,0x14
 204:	01c71893          	slli	a7,a4,0x1c
 208:	02471813          	slli	a6,a4,0x24
 20c:	02871513          	slli	a0,a4,0x28
 210:	02c71593          	slli	a1,a4,0x2c
 214:	03071693          	slli	a3,a4,0x30
 218:	00871f93          	slli	t6,a4,0x8
 21c:	01071e93          	slli	t4,a4,0x10
 220:	01871313          	slli	t1,a4,0x18
 224:	03471613          	slli	a2,a4,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 228:	03c2d293          	srli	t0,t0,0x3c
 22c:	03cf5f13          	srli	t5,t5,0x3c
 230:	03ce5e13          	srli	t3,t3,0x3c
 234:	03c8d893          	srli	a7,a7,0x3c
 238:	03c85813          	srli	a6,a6,0x3c
 23c:	9171                	srli	a0,a0,0x3c
 23e:	91f1                	srli	a1,a1,0x3c
 240:	92f1                	srli	a3,a3,0x3c
 242:	92be                	add	t0,t0,a5
 244:	9f3e                	add	t5,t5,a5
 246:	9e3e                	add	t3,t3,a5
 248:	98be                	add	a7,a7,a5
 24a:	983e                	add	a6,a6,a5
 24c:	953e                	add	a0,a0,a5
 24e:	95be                	add	a1,a1,a5
 250:	96be                	add	a3,a3,a5
 252:	03c75393          	srli	t2,a4,0x3c
 256:	01c75b9b          	srliw	s7,a4,0x1c
 25a:	03cfdf93          	srli	t6,t6,0x3c
 25e:	03cede93          	srli	t4,t4,0x3c
 262:	03c35313          	srli	t1,t1,0x3c
 266:	9271                	srli	a2,a2,0x3c
 268:	0002c403          	lbu	s0,0(t0)
 26c:	93be                	add	t2,t2,a5
 26e:	000f4283          	lbu	t0,0(t5)
 272:	9fbe                	add	t6,t6,a5
 274:	000e4f03          	lbu	t5,0(t3)
 278:	9ebe                	add	t4,t4,a5
 27a:	0008ce03          	lbu	t3,0(a7)
 27e:	933e                	add	t1,t1,a5
 280:	00084883          	lbu	a7,0(a6)
 284:	9bbe                	add	s7,s7,a5
 286:	00054803          	lbu	a6,0(a0)
 28a:	963e                	add	a2,a2,a5
 28c:	0005c503          	lbu	a0,0(a1)
 290:	0006c583          	lbu	a1,0(a3)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
 294:	03871693          	slli	a3,a4,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 298:	0003c903          	lbu	s2,0(t2)
 29c:	00064603          	lbu	a2,0(a2)
 2a0:	000fc383          	lbu	t2,0(t6)
 2a4:	8b3d                	andi	a4,a4,15
 2a6:	000ecf83          	lbu	t6,0(t4)
 2aa:	92f1                	srli	a3,a3,0x3c
 2ac:	00034e83          	lbu	t4,0(t1)
 2b0:	000bc303          	lbu	t1,0(s7)
 2b4:	96be                	add	a3,a3,a5
 2b6:	97ba                	add	a5,a5,a4
    buf[i++] = '0';
 2b8:	7761                	lui	a4,0xffff8
 2ba:	83074713          	xori	a4,a4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2be:	00710623          	sb	t2,12(sp)
 2c2:	005106a3          	sb	t0,13(sp)
 2c6:	01f10723          	sb	t6,14(sp)
 2ca:	01e107a3          	sb	t5,15(sp)
 2ce:	01d10823          	sb	t4,16(sp)
 2d2:	01c108a3          	sb	t3,17(sp)
 2d6:	00610923          	sb	t1,18(sp)
 2da:	011109a3          	sb	a7,19(sp)
 2de:	01010a23          	sb	a6,20(sp)
 2e2:	00a10aa3          	sb	a0,21(sp)
 2e6:	00b10b23          	sb	a1,22(sp)
 2ea:	00c10ba3          	sb	a2,23(sp)
    buf[i++] = '0';
 2ee:	00e11423          	sh	a4,8(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 2f2:	01210523          	sb	s2,10(sp)
 2f6:	008105a3          	sb	s0,11(sp)
 2fa:	0006c703          	lbu	a4,0(a3)
 2fe:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
 302:	4649                	li	a2,18
 304:	002c                	addi	a1,sp,8
 306:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
 308:	00e10c23          	sb	a4,24(sp)
 30c:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
 310:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
 314:	313000ef          	jal	ra,e26 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
 318:	00248513          	addi	a0,s1,2
 31c:	bda5                	j	194 <printf+0x42>
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
 31e:	00064783          	lbu	a5,0(a2)
 322:	84b2                	mv	s1,a2
 324:	01278963          	beq	a5,s2,336 <printf+0x1e4>
 328:	b561                	j	1b0 <printf+0x5e>
 32a:	0024c783          	lbu	a5,2(s1)
 32e:	0605                	addi	a2,a2,1
 330:	0489                	addi	s1,s1,2
 332:	e7279fe3          	bne	a5,s2,1b0 <printf+0x5e>
 336:	0014c783          	lbu	a5,1(s1)
 33a:	ff2788e3          	beq	a5,s2,32a <printf+0x1d8>
        l = z - a;
 33e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
 342:	85aa                	mv	a1,a0
 344:	8622                	mv	a2,s0
 346:	4505                	li	a0,1
 348:	2df000ef          	jal	ra,e26 <write>
        if (l)
 34c:	e6040be3          	beqz	s0,1c2 <printf+0x70>
 350:	8526                	mv	a0,s1
        if (!*s)
 352:	00054783          	lbu	a5,0(a0)
 356:	e40795e3          	bnez	a5,1a0 <printf+0x4e>
    }
    va_end(ap);
 35a:	70e6                	ld	ra,120(sp)
 35c:	7446                	ld	s0,112(sp)
 35e:	74a6                	ld	s1,104(sp)
 360:	7906                	ld	s2,96(sp)
 362:	69e6                	ld	s3,88(sp)
 364:	6a46                	ld	s4,80(sp)
 366:	6aa6                	ld	s5,72(sp)
 368:	6b06                	ld	s6,64(sp)
 36a:	7be2                	ld	s7,56(sp)
 36c:	6129                	addi	sp,sp,192
 36e:	8082                	ret
        switch (s[1])
 370:	07800713          	li	a4,120
 374:	24e79363          	bne	a5,a4,5ba <printf+0x468>
            printint(va_arg(ap, int), 16, 1);
 378:	6782                	ld	a5,0(sp)
 37a:	4394                	lw	a3,0(a5)
 37c:	07a1                	addi	a5,a5,8
 37e:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 380:	2606c263          	bltz	a3,5e4 <printf+0x492>
        buf[i--] = digits[x % base];
 384:	00001797          	auipc	a5,0x1
 388:	cd478793          	addi	a5,a5,-812 # 1058 <digits>
 38c:	00f6f713          	andi	a4,a3,15
 390:	973e                	add	a4,a4,a5
 392:	00074703          	lbu	a4,0(a4) # ffffffffffff8000 <DATA_STRING+0xffffffffffff6f90>
    buf[16] = 0;
 396:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 39a:	45bd                	li	a1,15
        buf[i--] = digits[x % base];
 39c:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 3a0:	0046d61b          	srliw	a2,a3,0x4
        x = xx;
 3a4:	0006871b          	sext.w	a4,a3
    } while ((x /= base) != 0);
 3a8:	0046d51b          	srliw	a0,a3,0x4
 3ac:	0ad5d563          	bge	a1,a3,456 <printf+0x304>
        buf[i--] = digits[x % base];
 3b0:	8a3d                	andi	a2,a2,15
 3b2:	963e                	add	a2,a2,a5
 3b4:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 3b8:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 3bc:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
 3c0:	30a5fe63          	bgeu	a1,a0,6dc <printf+0x58a>
        buf[i--] = digits[x % base];
 3c4:	00f77613          	andi	a2,a4,15
 3c8:	963e                	add	a2,a2,a5
 3ca:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 3ce:	45bd                	li	a1,15
 3d0:	0047561b          	srliw	a2,a4,0x4
        buf[i--] = digits[x % base];
 3d4:	00a10aa3          	sb	a0,21(sp)
    } while ((x /= base) != 0);
 3d8:	00475513          	srli	a0,a4,0x4
 3dc:	30e5f963          	bgeu	a1,a4,6ee <printf+0x59c>
        buf[i--] = digits[x % base];
 3e0:	8a3d                	andi	a2,a2,15
 3e2:	963e                	add	a2,a2,a5
 3e4:	00064803          	lbu	a6,0(a2)
    } while ((x /= base) != 0);
 3e8:	00875893          	srli	a7,a4,0x8
 3ec:	0087561b          	srliw	a2,a4,0x8
        buf[i--] = digits[x % base];
 3f0:	01010a23          	sb	a6,20(sp)
    } while ((x /= base) != 0);
 3f4:	30a5fd63          	bgeu	a1,a0,70e <printf+0x5bc>
        buf[i--] = digits[x % base];
 3f8:	8a3d                	andi	a2,a2,15
 3fa:	963e                	add	a2,a2,a5
 3fc:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 400:	00c75813          	srli	a6,a4,0xc
 404:	00c7561b          	srliw	a2,a4,0xc
        buf[i--] = digits[x % base];
 408:	00a109a3          	sb	a0,19(sp)
    } while ((x /= base) != 0);
 40c:	3315fe63          	bgeu	a1,a7,748 <printf+0x5f6>
        buf[i--] = digits[x % base];
 410:	8a3d                	andi	a2,a2,15
 412:	963e                	add	a2,a2,a5
 414:	00064503          	lbu	a0,0(a2)
    } while ((x /= base) != 0);
 418:	01075893          	srli	a7,a4,0x10
 41c:	0107561b          	srliw	a2,a4,0x10
        buf[i--] = digits[x % base];
 420:	00a10923          	sb	a0,18(sp)
    } while ((x /= base) != 0);
 424:	3305ff63          	bgeu	a1,a6,762 <printf+0x610>
        buf[i--] = digits[x % base];
 428:	8a3d                	andi	a2,a2,15
 42a:	963e                	add	a2,a2,a5
 42c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
 430:	0147571b          	srliw	a4,a4,0x14
        buf[i--] = digits[x % base];
 434:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
 438:	3515f863          	bgeu	a1,a7,788 <printf+0x636>
        buf[i--] = digits[x % base];
 43c:	97ba                	add	a5,a5,a4
 43e:	0007c783          	lbu	a5,0(a5)
 442:	45a1                	li	a1,8
 444:	00f10823          	sb	a5,16(sp)
    if (sign)
 448:	0006d763          	bgez	a3,456 <printf+0x304>
        buf[i--] = '-';
 44c:	02d00793          	li	a5,45
 450:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
 454:	459d                	li	a1,7
    write(f, s, l);
 456:	4641                	li	a2,16
 458:	003c                	addi	a5,sp,8
 45a:	9e0d                	subw	a2,a2,a1
 45c:	4505                	li	a0,1
 45e:	95be                	add	a1,a1,a5
 460:	1c7000ef          	jal	ra,e26 <write>
        s += 2;
 464:	00248513          	addi	a0,s1,2
 468:	b335                	j	194 <printf+0x42>
            if ((a = va_arg(ap, char *)) == 0)
 46a:	6782                	ld	a5,0(sp)
 46c:	6380                	ld	s0,0(a5)
 46e:	07a1                	addi	a5,a5,8
 470:	e03e                	sd	a5,0(sp)
 472:	22040a63          	beqz	s0,6a6 <printf+0x554>
            l = strnlen(a, 200);
 476:	0c800593          	li	a1,200
 47a:	8522                	mv	a0,s0
 47c:	6cc000ef          	jal	ra,b48 <strnlen>
    write(f, s, l);
 480:	0005061b          	sext.w	a2,a0
 484:	85a2                	mv	a1,s0
 486:	4505                	li	a0,1
 488:	19f000ef          	jal	ra,e26 <write>
        s += 2;
 48c:	00248513          	addi	a0,s1,2
 490:	b311                	j	194 <printf+0x42>
            printint(va_arg(ap, int), 10, 1);
 492:	6782                	ld	a5,0(sp)
 494:	4390                	lw	a2,0(a5)
 496:	07a1                	addi	a5,a5,8
 498:	e03e                	sd	a5,0(sp)
    if (sign && (sign = xx < 0))
 49a:	1a064363          	bltz	a2,640 <printf+0x4ee>
        buf[i--] = digits[x % base];
 49e:	46a9                	li	a3,10
 4a0:	02d6773b          	remuw	a4,a2,a3
 4a4:	00001797          	auipc	a5,0x1
 4a8:	bb478793          	addi	a5,a5,-1100 # 1058 <digits>
    buf[16] = 0;
 4ac:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 4b0:	4525                	li	a0,9
        x = xx;
 4b2:	0006081b          	sext.w	a6,a2
        buf[i--] = digits[x % base];
 4b6:	973e                	add	a4,a4,a5
 4b8:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 4bc:	02d655bb          	divuw	a1,a2,a3
        buf[i--] = digits[x % base];
 4c0:	00e10ba3          	sb	a4,23(sp)
    } while ((x /= base) != 0);
 4c4:	2cc55063          	bge	a0,a2,784 <printf+0x632>
 4c8:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 4cc:	02d5f73b          	remuw	a4,a1,a3
 4d0:	1702                	slli	a4,a4,0x20
 4d2:	9301                	srli	a4,a4,0x20
 4d4:	973e                	add	a4,a4,a5
 4d6:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
 4da:	02d5d5bb          	divuw	a1,a1,a3
        buf[i--] = digits[x % base];
 4de:	00e10b23          	sb	a4,22(sp)
    } while ((x /= base) != 0);
 4e2:	1f057d63          	bgeu	a0,a6,6dc <printf+0x58a>
        buf[i--] = digits[x % base];
 4e6:	4529                	li	a0,10
    } while ((x /= base) != 0);
 4e8:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 4ea:	02a5f73b          	remuw	a4,a1,a0
 4ee:	973e                	add	a4,a4,a5
 4f0:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 4f4:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 4f8:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 4fc:	1ab6f163          	bgeu	a3,a1,69e <printf+0x54c>
 500:	06300813          	li	a6,99
        buf[i--] = digits[x % base];
 504:	02a776bb          	remuw	a3,a4,a0
 508:	96be                	add	a3,a3,a5
 50a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 50e:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 512:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
 516:	20b87c63          	bgeu	a6,a1,72e <printf+0x5dc>
 51a:	3e700813          	li	a6,999
        buf[i--] = digits[x % base];
 51e:	02a776bb          	remuw	a3,a4,a0
 522:	96be                	add	a3,a3,a5
 524:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 528:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 52c:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
 530:	20b87363          	bgeu	a6,a1,736 <printf+0x5e4>
        buf[i--] = digits[x % base];
 534:	02a776bb          	remuw	a3,a4,a0
 538:	96be                	add	a3,a3,a5
 53a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 53e:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 542:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
 546:	20b9f563          	bgeu	s3,a1,750 <printf+0x5fe>
        buf[i--] = digits[x % base];
 54a:	02a776bb          	remuw	a3,a4,a0
 54e:	96be                	add	a3,a3,a5
 550:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 554:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 558:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
 55c:	20bafb63          	bgeu	s5,a1,772 <printf+0x620>
        buf[i--] = digits[x % base];
 560:	02a776bb          	remuw	a3,a4,a0
 564:	96be                	add	a3,a3,a5
 566:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 56a:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 56e:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
 572:	1eba7c63          	bgeu	s4,a1,76a <printf+0x618>
        buf[i--] = digits[x % base];
 576:	02a776bb          	remuw	a3,a4,a0
 57a:	96be                	add	a3,a3,a5
 57c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
 580:	02a7573b          	divuw	a4,a4,a0
        buf[i--] = digits[x % base];
 584:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
 588:	14bb7163          	bgeu	s6,a1,6ca <printf+0x578>
        buf[i--] = digits[x % base];
 58c:	1702                	slli	a4,a4,0x20
 58e:	9301                	srli	a4,a4,0x20
 590:	97ba                	add	a5,a5,a4
 592:	0007c783          	lbu	a5,0(a5)
 596:	4599                	li	a1,6
 598:	00f10723          	sb	a5,14(sp)
    if (sign)
 59c:	ea065de3          	bgez	a2,456 <printf+0x304>
        buf[i--] = '-';
 5a0:	02d00793          	li	a5,45
 5a4:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
 5a8:	4595                	li	a1,5
    write(f, s, l);
 5aa:	003c                	addi	a5,sp,8
 5ac:	4641                	li	a2,16
 5ae:	9e0d                	subw	a2,a2,a1
 5b0:	4505                	li	a0,1
 5b2:	95be                	add	a1,a1,a5
 5b4:	073000ef          	jal	ra,e26 <write>
 5b8:	b575                	j	464 <printf+0x312>
    char byte = c;
 5ba:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
 5be:	4605                	li	a2,1
 5c0:	002c                	addi	a1,sp,8
 5c2:	4505                	li	a0,1
    char byte = c;
 5c4:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 5c8:	05f000ef          	jal	ra,e26 <write>
    char byte = c;
 5cc:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
 5d0:	4605                	li	a2,1
 5d2:	002c                	addi	a1,sp,8
 5d4:	4505                	li	a0,1
    char byte = c;
 5d6:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
 5da:	04d000ef          	jal	ra,e26 <write>
        s += 2;
 5de:	00248513          	addi	a0,s1,2
 5e2:	be4d                	j	194 <printf+0x42>
        x = -xx;
 5e4:	40d0073b          	negw	a4,a3
        buf[i--] = digits[x % base];
 5e8:	00001797          	auipc	a5,0x1
 5ec:	a7078793          	addi	a5,a5,-1424 # 1058 <digits>
 5f0:	00f77613          	andi	a2,a4,15
 5f4:	963e                	add	a2,a2,a5
 5f6:	00064603          	lbu	a2,0(a2)
    buf[16] = 0;
 5fa:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 5fe:	55c5                	li	a1,-15
        buf[i--] = digits[x % base];
 600:	00c10ba3          	sb	a2,23(sp)
    } while ((x /= base) != 0);
 604:	0047551b          	srliw	a0,a4,0x4
 608:	0047561b          	srliw	a2,a4,0x4
 60c:	0ab6d263          	bge	a3,a1,6b0 <printf+0x55e>
        buf[i--] = digits[x % base];
 610:	8a3d                	andi	a2,a2,15
 612:	963e                	add	a2,a2,a5
 614:	00064583          	lbu	a1,0(a2)
    } while ((x /= base) != 0);
 618:	463d                	li	a2,15
 61a:	0087571b          	srliw	a4,a4,0x8
        buf[i--] = digits[x % base];
 61e:	00b10b23          	sb	a1,22(sp)
    } while ((x /= base) != 0);
 622:	daa661e3          	bltu	a2,a0,3c4 <printf+0x272>
        buf[i--] = '-';
 626:	02d00793          	li	a5,45
 62a:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
 62e:	45b5                	li	a1,13
    write(f, s, l);
 630:	003c                	addi	a5,sp,8
 632:	4641                	li	a2,16
 634:	9e0d                	subw	a2,a2,a1
 636:	4505                	li	a0,1
 638:	95be                	add	a1,a1,a5
 63a:	7ec000ef          	jal	ra,e26 <write>
 63e:	b51d                	j	464 <printf+0x312>
        x = -xx;
 640:	40c0083b          	negw	a6,a2
        buf[i--] = digits[x % base];
 644:	46a9                	li	a3,10
 646:	02d875bb          	remuw	a1,a6,a3
 64a:	00001797          	auipc	a5,0x1
 64e:	a0e78793          	addi	a5,a5,-1522 # 1058 <digits>
    buf[16] = 0;
 652:	00010c23          	sb	zero,24(sp)
    } while ((x /= base) != 0);
 656:	555d                	li	a0,-9
        buf[i--] = digits[x % base];
 658:	95be                	add	a1,a1,a5
 65a:	0005c583          	lbu	a1,0(a1)
    } while ((x /= base) != 0);
 65e:	02d8573b          	divuw	a4,a6,a3
        buf[i--] = digits[x % base];
 662:	00b10ba3          	sb	a1,23(sp)
    } while ((x /= base) != 0);
 666:	04a65563          	bge	a2,a0,6b0 <printf+0x55e>
 66a:	06300513          	li	a0,99
        buf[i--] = digits[x % base];
 66e:	02d775bb          	remuw	a1,a4,a3
 672:	95be                	add	a1,a1,a5
 674:	0005c883          	lbu	a7,0(a1)
    } while ((x /= base) != 0);
 678:	02d755bb          	divuw	a1,a4,a3
        buf[i--] = digits[x % base];
 67c:	01110b23          	sb	a7,22(sp)
    } while ((x /= base) != 0);
 680:	fb0573e3          	bgeu	a0,a6,626 <printf+0x4d4>
        buf[i--] = digits[x % base];
 684:	4529                	li	a0,10
    } while ((x /= base) != 0);
 686:	46a5                	li	a3,9
        buf[i--] = digits[x % base];
 688:	02a5f73b          	remuw	a4,a1,a0
 68c:	973e                	add	a4,a4,a5
 68e:	00074803          	lbu	a6,0(a4)
    } while ((x /= base) != 0);
 692:	02a5d73b          	divuw	a4,a1,a0
        buf[i--] = digits[x % base];
 696:	01010aa3          	sb	a6,21(sp)
    } while ((x /= base) != 0);
 69a:	e6b6e3e3          	bltu	a3,a1,500 <printf+0x3ae>
        buf[i--] = digits[x % base];
 69e:	45b5                	li	a1,13
    if (sign)
 6a0:	da065be3          	bgez	a2,456 <printf+0x304>
 6a4:	a881                	j	6f4 <printf+0x5a2>
                a = "(null)";
 6a6:	00001417          	auipc	s0,0x1
 6aa:	99240413          	addi	s0,s0,-1646 # 1038 <unlink+0x6c>
 6ae:	b3e1                	j	476 <printf+0x324>
        buf[i--] = '-';
 6b0:	02d00793          	li	a5,45
 6b4:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
 6b8:	45b9                	li	a1,14
    write(f, s, l);
 6ba:	003c                	addi	a5,sp,8
 6bc:	4641                	li	a2,16
 6be:	9e0d                	subw	a2,a2,a1
 6c0:	4505                	li	a0,1
 6c2:	95be                	add	a1,a1,a5
 6c4:	762000ef          	jal	ra,e26 <write>
 6c8:	bb71                	j	464 <printf+0x312>
        buf[i--] = digits[x % base];
 6ca:	459d                	li	a1,7
    if (sign)
 6cc:	d80655e3          	bgez	a2,456 <printf+0x304>
        buf[i--] = '-';
 6d0:	02d00793          	li	a5,45
 6d4:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
 6d8:	4599                	li	a1,6
 6da:	bbb5                	j	456 <printf+0x304>
 6dc:	45b9                	li	a1,14
    write(f, s, l);
 6de:	003c                	addi	a5,sp,8
 6e0:	4641                	li	a2,16
 6e2:	9e0d                	subw	a2,a2,a1
 6e4:	4505                	li	a0,1
 6e6:	95be                	add	a1,a1,a5
 6e8:	73e000ef          	jal	ra,e26 <write>
 6ec:	bba5                	j	464 <printf+0x312>
        buf[i--] = digits[x % base];
 6ee:	45b5                	li	a1,13
    if (sign)
 6f0:	d606d3e3          	bgez	a3,456 <printf+0x304>
        buf[i--] = '-';
 6f4:	02d00793          	li	a5,45
 6f8:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
 6fc:	45b1                	li	a1,12
    write(f, s, l);
 6fe:	003c                	addi	a5,sp,8
 700:	4641                	li	a2,16
 702:	9e0d                	subw	a2,a2,a1
 704:	4505                	li	a0,1
 706:	95be                	add	a1,a1,a5
 708:	71e000ef          	jal	ra,e26 <write>
 70c:	bba1                	j	464 <printf+0x312>
        buf[i--] = digits[x % base];
 70e:	45b1                	li	a1,12
    if (sign)
 710:	d406d3e3          	bgez	a3,456 <printf+0x304>
        buf[i--] = '-';
 714:	02d00793          	li	a5,45
 718:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
 71c:	45ad                	li	a1,11
    write(f, s, l);
 71e:	003c                	addi	a5,sp,8
 720:	4641                	li	a2,16
 722:	9e0d                	subw	a2,a2,a1
 724:	4505                	li	a0,1
 726:	95be                	add	a1,a1,a5
 728:	6fe000ef          	jal	ra,e26 <write>
 72c:	bb25                	j	464 <printf+0x312>
        buf[i--] = digits[x % base];
 72e:	45b1                	li	a1,12
    if (sign)
 730:	d20653e3          	bgez	a2,456 <printf+0x304>
 734:	b7c5                	j	714 <printf+0x5c2>
        buf[i--] = digits[x % base];
 736:	45ad                	li	a1,11
    if (sign)
 738:	d0065fe3          	bgez	a2,456 <printf+0x304>
        buf[i--] = '-';
 73c:	02d00793          	li	a5,45
 740:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
 744:	45a9                	li	a1,10
 746:	bb01                	j	456 <printf+0x304>
 748:	45ad                	li	a1,11
    if (sign)
 74a:	d006d6e3          	bgez	a3,456 <printf+0x304>
 74e:	b7fd                	j	73c <printf+0x5ea>
        buf[i--] = digits[x % base];
 750:	45a9                	li	a1,10
    if (sign)
 752:	d00652e3          	bgez	a2,456 <printf+0x304>
        buf[i--] = '-';
 756:	02d00793          	li	a5,45
 75a:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
 75e:	45a5                	li	a1,9
 760:	b9dd                	j	456 <printf+0x304>
 762:	45a9                	li	a1,10
    if (sign)
 764:	ce06d9e3          	bgez	a3,456 <printf+0x304>
 768:	b7fd                	j	756 <printf+0x604>
        buf[i--] = digits[x % base];
 76a:	45a1                	li	a1,8
    if (sign)
 76c:	ce0655e3          	bgez	a2,456 <printf+0x304>
 770:	b9f1                	j	44c <printf+0x2fa>
        buf[i--] = digits[x % base];
 772:	45a5                	li	a1,9
    if (sign)
 774:	ce0651e3          	bgez	a2,456 <printf+0x304>
        buf[i--] = '-';
 778:	02d00793          	li	a5,45
 77c:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
 780:	45a1                	li	a1,8
 782:	b9d1                	j	456 <printf+0x304>
    i = 15;
 784:	45bd                	li	a1,15
 786:	b9c1                	j	456 <printf+0x304>
        buf[i--] = digits[x % base];
 788:	45a5                	li	a1,9
    if (sign)
 78a:	cc06d6e3          	bgez	a3,456 <printf+0x304>
 78e:	b7ed                	j	778 <printf+0x626>

0000000000000790 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
 790:	02000793          	li	a5,32
 794:	00f50663          	beq	a0,a5,7a0 <isspace+0x10>
 798:	355d                	addiw	a0,a0,-9
 79a:	00553513          	sltiu	a0,a0,5
 79e:	8082                	ret
 7a0:	4505                	li	a0,1
}
 7a2:	8082                	ret

00000000000007a4 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
 7a4:	fd05051b          	addiw	a0,a0,-48
}
 7a8:	00a53513          	sltiu	a0,a0,10
 7ac:	8082                	ret

00000000000007ae <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
 7ae:	02000613          	li	a2,32
 7b2:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
 7b4:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
 7b8:	ff77069b          	addiw	a3,a4,-9
 7bc:	04c70d63          	beq	a4,a2,816 <atoi+0x68>
 7c0:	0007079b          	sext.w	a5,a4
 7c4:	04d5f963          	bgeu	a1,a3,816 <atoi+0x68>
        s++;
    switch (*s)
 7c8:	02b00693          	li	a3,43
 7cc:	04d70a63          	beq	a4,a3,820 <atoi+0x72>
 7d0:	02d00693          	li	a3,45
 7d4:	06d70463          	beq	a4,a3,83c <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
 7d8:	fd07859b          	addiw	a1,a5,-48
 7dc:	4625                	li	a2,9
 7de:	873e                	mv	a4,a5
 7e0:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
 7e2:	4e01                	li	t3,0
    while (isdigit(*s))
 7e4:	04b66a63          	bltu	a2,a1,838 <atoi+0x8a>
    int n = 0, neg = 0;
 7e8:	4501                	li	a0,0
    while (isdigit(*s))
 7ea:	4825                	li	a6,9
 7ec:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
 7f0:	0025179b          	slliw	a5,a0,0x2
 7f4:	9d3d                	addw	a0,a0,a5
 7f6:	fd07031b          	addiw	t1,a4,-48
 7fa:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
 7fe:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
 802:	0685                	addi	a3,a3,1
 804:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
 808:	0006071b          	sext.w	a4,a2
 80c:	feb870e3          	bgeu	a6,a1,7ec <atoi+0x3e>
    return neg ? n : -n;
 810:	000e0563          	beqz	t3,81a <atoi+0x6c>
}
 814:	8082                	ret
        s++;
 816:	0505                	addi	a0,a0,1
 818:	bf71                	j	7b4 <atoi+0x6>
 81a:	4113053b          	subw	a0,t1,a7
 81e:	8082                	ret
    while (isdigit(*s))
 820:	00154783          	lbu	a5,1(a0)
 824:	4625                	li	a2,9
        s++;
 826:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 82a:	fd07859b          	addiw	a1,a5,-48
 82e:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
 832:	4e01                	li	t3,0
    while (isdigit(*s))
 834:	fab67ae3          	bgeu	a2,a1,7e8 <atoi+0x3a>
 838:	4501                	li	a0,0
}
 83a:	8082                	ret
    while (isdigit(*s))
 83c:	00154783          	lbu	a5,1(a0)
 840:	4625                	li	a2,9
        s++;
 842:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
 846:	fd07859b          	addiw	a1,a5,-48
 84a:	0007871b          	sext.w	a4,a5
 84e:	feb665e3          	bltu	a2,a1,838 <atoi+0x8a>
        neg = 1;
 852:	4e05                	li	t3,1
 854:	bf51                	j	7e8 <atoi+0x3a>

0000000000000856 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
 856:	16060d63          	beqz	a2,9d0 <memset+0x17a>
 85a:	40a007b3          	neg	a5,a0
 85e:	8b9d                	andi	a5,a5,7
 860:	00778713          	addi	a4,a5,7
 864:	482d                	li	a6,11
 866:	0ff5f593          	andi	a1,a1,255
 86a:	fff60693          	addi	a3,a2,-1
 86e:	17076263          	bltu	a4,a6,9d2 <memset+0x17c>
 872:	16e6ea63          	bltu	a3,a4,9e6 <memset+0x190>
 876:	16078563          	beqz	a5,9e0 <memset+0x18a>
 87a:	00b50023          	sb	a1,0(a0)
 87e:	4705                	li	a4,1
 880:	00150e93          	addi	t4,a0,1
 884:	14e78c63          	beq	a5,a4,9dc <memset+0x186>
 888:	00b500a3          	sb	a1,1(a0)
 88c:	4709                	li	a4,2
 88e:	00250e93          	addi	t4,a0,2
 892:	14e78d63          	beq	a5,a4,9ec <memset+0x196>
 896:	00b50123          	sb	a1,2(a0)
 89a:	470d                	li	a4,3
 89c:	00350e93          	addi	t4,a0,3
 8a0:	12e78b63          	beq	a5,a4,9d6 <memset+0x180>
 8a4:	00b501a3          	sb	a1,3(a0)
 8a8:	4711                	li	a4,4
 8aa:	00450e93          	addi	t4,a0,4
 8ae:	14e78163          	beq	a5,a4,9f0 <memset+0x19a>
 8b2:	00b50223          	sb	a1,4(a0)
 8b6:	4715                	li	a4,5
 8b8:	00550e93          	addi	t4,a0,5
 8bc:	12e78c63          	beq	a5,a4,9f4 <memset+0x19e>
 8c0:	00b502a3          	sb	a1,5(a0)
 8c4:	471d                	li	a4,7
 8c6:	00650e93          	addi	t4,a0,6
 8ca:	12e79763          	bne	a5,a4,9f8 <memset+0x1a2>
 8ce:	00750e93          	addi	t4,a0,7
 8d2:	00b50323          	sb	a1,6(a0)
 8d6:	4f1d                	li	t5,7
 8d8:	00859713          	slli	a4,a1,0x8
 8dc:	8f4d                	or	a4,a4,a1
 8de:	01059e13          	slli	t3,a1,0x10
 8e2:	01c76e33          	or	t3,a4,t3
 8e6:	01859313          	slli	t1,a1,0x18
 8ea:	006e6333          	or	t1,t3,t1
 8ee:	02059893          	slli	a7,a1,0x20
 8f2:	011368b3          	or	a7,t1,a7
 8f6:	02859813          	slli	a6,a1,0x28
 8fa:	40f60333          	sub	t1,a2,a5
 8fe:	0108e833          	or	a6,a7,a6
 902:	03059693          	slli	a3,a1,0x30
 906:	00d866b3          	or	a3,a6,a3
 90a:	03859713          	slli	a4,a1,0x38
 90e:	97aa                	add	a5,a5,a0
 910:	ff837813          	andi	a6,t1,-8
 914:	8f55                	or	a4,a4,a3
 916:	00f806b3          	add	a3,a6,a5
 91a:	e398                	sd	a4,0(a5)
 91c:	07a1                	addi	a5,a5,8
 91e:	fed79ee3          	bne	a5,a3,91a <memset+0xc4>
 922:	ff837693          	andi	a3,t1,-8
 926:	00de87b3          	add	a5,t4,a3
 92a:	01e6873b          	addw	a4,a3,t5
 92e:	0ad30663          	beq	t1,a3,9da <memset+0x184>
 932:	00b78023          	sb	a1,0(a5)
 936:	0017069b          	addiw	a3,a4,1
 93a:	08c6fb63          	bgeu	a3,a2,9d0 <memset+0x17a>
 93e:	00b780a3          	sb	a1,1(a5)
 942:	0027069b          	addiw	a3,a4,2
 946:	08c6f563          	bgeu	a3,a2,9d0 <memset+0x17a>
 94a:	00b78123          	sb	a1,2(a5)
 94e:	0037069b          	addiw	a3,a4,3
 952:	06c6ff63          	bgeu	a3,a2,9d0 <memset+0x17a>
 956:	00b781a3          	sb	a1,3(a5)
 95a:	0047069b          	addiw	a3,a4,4
 95e:	06c6f963          	bgeu	a3,a2,9d0 <memset+0x17a>
 962:	00b78223          	sb	a1,4(a5)
 966:	0057069b          	addiw	a3,a4,5
 96a:	06c6f363          	bgeu	a3,a2,9d0 <memset+0x17a>
 96e:	00b782a3          	sb	a1,5(a5)
 972:	0067069b          	addiw	a3,a4,6
 976:	04c6fd63          	bgeu	a3,a2,9d0 <memset+0x17a>
 97a:	00b78323          	sb	a1,6(a5)
 97e:	0077069b          	addiw	a3,a4,7
 982:	04c6f763          	bgeu	a3,a2,9d0 <memset+0x17a>
 986:	00b783a3          	sb	a1,7(a5)
 98a:	0087069b          	addiw	a3,a4,8
 98e:	04c6f163          	bgeu	a3,a2,9d0 <memset+0x17a>
 992:	00b78423          	sb	a1,8(a5)
 996:	0097069b          	addiw	a3,a4,9
 99a:	02c6fb63          	bgeu	a3,a2,9d0 <memset+0x17a>
 99e:	00b784a3          	sb	a1,9(a5)
 9a2:	00a7069b          	addiw	a3,a4,10
 9a6:	02c6f563          	bgeu	a3,a2,9d0 <memset+0x17a>
 9aa:	00b78523          	sb	a1,10(a5)
 9ae:	00b7069b          	addiw	a3,a4,11
 9b2:	00c6ff63          	bgeu	a3,a2,9d0 <memset+0x17a>
 9b6:	00b785a3          	sb	a1,11(a5)
 9ba:	00c7069b          	addiw	a3,a4,12
 9be:	00c6f963          	bgeu	a3,a2,9d0 <memset+0x17a>
 9c2:	00b78623          	sb	a1,12(a5)
 9c6:	2735                	addiw	a4,a4,13
 9c8:	00c77463          	bgeu	a4,a2,9d0 <memset+0x17a>
 9cc:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
 9d0:	8082                	ret
 9d2:	472d                	li	a4,11
 9d4:	bd79                	j	872 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
 9d6:	4f0d                	li	t5,3
 9d8:	b701                	j	8d8 <memset+0x82>
 9da:	8082                	ret
 9dc:	4f05                	li	t5,1
 9de:	bded                	j	8d8 <memset+0x82>
 9e0:	8eaa                	mv	t4,a0
 9e2:	4f01                	li	t5,0
 9e4:	bdd5                	j	8d8 <memset+0x82>
 9e6:	87aa                	mv	a5,a0
 9e8:	4701                	li	a4,0
 9ea:	b7a1                	j	932 <memset+0xdc>
 9ec:	4f09                	li	t5,2
 9ee:	b5ed                	j	8d8 <memset+0x82>
 9f0:	4f11                	li	t5,4
 9f2:	b5dd                	j	8d8 <memset+0x82>
 9f4:	4f15                	li	t5,5
 9f6:	b5cd                	j	8d8 <memset+0x82>
 9f8:	4f19                	li	t5,6
 9fa:	bdf9                	j	8d8 <memset+0x82>

00000000000009fc <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
 9fc:	00054783          	lbu	a5,0(a0)
 a00:	0005c703          	lbu	a4,0(a1)
 a04:	00e79863          	bne	a5,a4,a14 <strcmp+0x18>
 a08:	0505                	addi	a0,a0,1
 a0a:	0585                	addi	a1,a1,1
 a0c:	fbe5                	bnez	a5,9fc <strcmp>
 a0e:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
 a10:	9d19                	subw	a0,a0,a4
 a12:	8082                	ret
 a14:	0007851b          	sext.w	a0,a5
 a18:	bfe5                	j	a10 <strcmp+0x14>

0000000000000a1a <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
 a1a:	ce05                	beqz	a2,a52 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 a1c:	00054703          	lbu	a4,0(a0)
 a20:	0005c783          	lbu	a5,0(a1)
 a24:	cb0d                	beqz	a4,a56 <strncmp+0x3c>
    if (!n--)
 a26:	167d                	addi	a2,a2,-1
 a28:	00c506b3          	add	a3,a0,a2
 a2c:	a819                	j	a42 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
 a2e:	00a68e63          	beq	a3,a0,a4a <strncmp+0x30>
 a32:	0505                	addi	a0,a0,1
 a34:	00e79b63          	bne	a5,a4,a4a <strncmp+0x30>
 a38:	00054703          	lbu	a4,0(a0)
 a3c:	0005c783          	lbu	a5,0(a1)
 a40:	cb19                	beqz	a4,a56 <strncmp+0x3c>
 a42:	0005c783          	lbu	a5,0(a1)
 a46:	0585                	addi	a1,a1,1
 a48:	f3fd                	bnez	a5,a2e <strncmp+0x14>
        ;
    return *l - *r;
 a4a:	0007051b          	sext.w	a0,a4
 a4e:	9d1d                	subw	a0,a0,a5
 a50:	8082                	ret
        return 0;
 a52:	4501                	li	a0,0
}
 a54:	8082                	ret
 a56:	4501                	li	a0,0
    return *l - *r;
 a58:	9d1d                	subw	a0,a0,a5
 a5a:	8082                	ret

0000000000000a5c <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
 a5c:	00757793          	andi	a5,a0,7
 a60:	cf89                	beqz	a5,a7a <strlen+0x1e>
 a62:	87aa                	mv	a5,a0
 a64:	a029                	j	a6e <strlen+0x12>
 a66:	0785                	addi	a5,a5,1
 a68:	0077f713          	andi	a4,a5,7
 a6c:	cb01                	beqz	a4,a7c <strlen+0x20>
        if (!*s)
 a6e:	0007c703          	lbu	a4,0(a5)
 a72:	fb75                	bnez	a4,a66 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
 a74:	40a78533          	sub	a0,a5,a0
}
 a78:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
 a7a:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
 a7c:	6394                	ld	a3,0(a5)
 a7e:	00000597          	auipc	a1,0x0
 a82:	5c25b583          	ld	a1,1474(a1) # 1040 <unlink+0x74>
 a86:	00000617          	auipc	a2,0x0
 a8a:	5c263603          	ld	a2,1474(a2) # 1048 <unlink+0x7c>
 a8e:	a019                	j	a94 <strlen+0x38>
 a90:	6794                	ld	a3,8(a5)
 a92:	07a1                	addi	a5,a5,8
 a94:	00b68733          	add	a4,a3,a1
 a98:	fff6c693          	not	a3,a3
 a9c:	8f75                	and	a4,a4,a3
 a9e:	8f71                	and	a4,a4,a2
 aa0:	db65                	beqz	a4,a90 <strlen+0x34>
    for (; *s; s++)
 aa2:	0007c703          	lbu	a4,0(a5)
 aa6:	d779                	beqz	a4,a74 <strlen+0x18>
 aa8:	0017c703          	lbu	a4,1(a5)
 aac:	0785                	addi	a5,a5,1
 aae:	d379                	beqz	a4,a74 <strlen+0x18>
 ab0:	0017c703          	lbu	a4,1(a5)
 ab4:	0785                	addi	a5,a5,1
 ab6:	fb6d                	bnez	a4,aa8 <strlen+0x4c>
 ab8:	bf75                	j	a74 <strlen+0x18>

0000000000000aba <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 aba:	00757713          	andi	a4,a0,7
{
 abe:	87aa                	mv	a5,a0
    c = (unsigned char)c;
 ac0:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
 ac4:	cb19                	beqz	a4,ada <memchr+0x20>
 ac6:	ce25                	beqz	a2,b3e <memchr+0x84>
 ac8:	0007c703          	lbu	a4,0(a5)
 acc:	04b70e63          	beq	a4,a1,b28 <memchr+0x6e>
 ad0:	0785                	addi	a5,a5,1
 ad2:	0077f713          	andi	a4,a5,7
 ad6:	167d                	addi	a2,a2,-1
 ad8:	f77d                	bnez	a4,ac6 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
 ada:	4501                	li	a0,0
    if (n && *s != c)
 adc:	c235                	beqz	a2,b40 <memchr+0x86>
 ade:	0007c703          	lbu	a4,0(a5)
 ae2:	04b70363          	beq	a4,a1,b28 <memchr+0x6e>
        size_t k = ONES * c;
 ae6:	00000517          	auipc	a0,0x0
 aea:	56a53503          	ld	a0,1386(a0) # 1050 <unlink+0x84>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 aee:	471d                	li	a4,7
        size_t k = ONES * c;
 af0:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
 af4:	02c77a63          	bgeu	a4,a2,b28 <memchr+0x6e>
 af8:	00000897          	auipc	a7,0x0
 afc:	5488b883          	ld	a7,1352(a7) # 1040 <unlink+0x74>
 b00:	00000817          	auipc	a6,0x0
 b04:	54883803          	ld	a6,1352(a6) # 1048 <unlink+0x7c>
 b08:	431d                	li	t1,7
 b0a:	a029                	j	b14 <memchr+0x5a>
 b0c:	1661                	addi	a2,a2,-8
 b0e:	07a1                	addi	a5,a5,8
 b10:	02c37963          	bgeu	t1,a2,b42 <memchr+0x88>
 b14:	6398                	ld	a4,0(a5)
 b16:	8f29                	xor	a4,a4,a0
 b18:	011706b3          	add	a3,a4,a7
 b1c:	fff74713          	not	a4,a4
 b20:	8f75                	and	a4,a4,a3
 b22:	01077733          	and	a4,a4,a6
 b26:	d37d                	beqz	a4,b0c <memchr+0x52>
 b28:	853e                	mv	a0,a5
 b2a:	97b2                	add	a5,a5,a2
 b2c:	a021                	j	b34 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
 b2e:	0505                	addi	a0,a0,1
 b30:	00f50763          	beq	a0,a5,b3e <memchr+0x84>
 b34:	00054703          	lbu	a4,0(a0)
 b38:	feb71be3          	bne	a4,a1,b2e <memchr+0x74>
 b3c:	8082                	ret
    return n ? (void *)s : 0;
 b3e:	4501                	li	a0,0
}
 b40:	8082                	ret
    return n ? (void *)s : 0;
 b42:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
 b44:	f275                	bnez	a2,b28 <memchr+0x6e>
}
 b46:	8082                	ret

0000000000000b48 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
 b48:	1101                	addi	sp,sp,-32
 b4a:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
 b4c:	862e                	mv	a2,a1
{
 b4e:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
 b50:	4581                	li	a1,0
{
 b52:	e426                	sd	s1,8(sp)
 b54:	ec06                	sd	ra,24(sp)
 b56:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
 b58:	f63ff0ef          	jal	ra,aba <memchr>
    return p ? p - s : n;
 b5c:	c519                	beqz	a0,b6a <strnlen+0x22>
}
 b5e:	60e2                	ld	ra,24(sp)
 b60:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
 b62:	8d05                	sub	a0,a0,s1
}
 b64:	64a2                	ld	s1,8(sp)
 b66:	6105                	addi	sp,sp,32
 b68:	8082                	ret
 b6a:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
 b6c:	8522                	mv	a0,s0
}
 b6e:	6442                	ld	s0,16(sp)
 b70:	64a2                	ld	s1,8(sp)
 b72:	6105                	addi	sp,sp,32
 b74:	8082                	ret

0000000000000b76 <stpcpy>:
char *stpcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
 b76:	00b547b3          	xor	a5,a0,a1
 b7a:	8b9d                	andi	a5,a5,7
 b7c:	eb95                	bnez	a5,bb0 <stpcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
 b7e:	0075f793          	andi	a5,a1,7
 b82:	e7b1                	bnez	a5,bce <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
 b84:	6198                	ld	a4,0(a1)
 b86:	00000617          	auipc	a2,0x0
 b8a:	4ba63603          	ld	a2,1210(a2) # 1040 <unlink+0x74>
 b8e:	00000817          	auipc	a6,0x0
 b92:	4ba83803          	ld	a6,1210(a6) # 1048 <unlink+0x7c>
 b96:	a029                	j	ba0 <stpcpy+0x2a>
 b98:	e118                	sd	a4,0(a0)
 b9a:	6598                	ld	a4,8(a1)
 b9c:	05a1                	addi	a1,a1,8
 b9e:	0521                	addi	a0,a0,8
 ba0:	00c707b3          	add	a5,a4,a2
 ba4:	fff74693          	not	a3,a4
 ba8:	8ff5                	and	a5,a5,a3
 baa:	0107f7b3          	and	a5,a5,a6
 bae:	d7ed                	beqz	a5,b98 <stpcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
 bb0:	0005c783          	lbu	a5,0(a1)
 bb4:	00f50023          	sb	a5,0(a0)
 bb8:	c785                	beqz	a5,be0 <stpcpy+0x6a>
 bba:	0015c783          	lbu	a5,1(a1)
 bbe:	0505                	addi	a0,a0,1
 bc0:	0585                	addi	a1,a1,1
 bc2:	00f50023          	sb	a5,0(a0)
 bc6:	fbf5                	bnez	a5,bba <stpcpy+0x44>
        ;
    return d;
}
 bc8:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
 bca:	0505                	addi	a0,a0,1
 bcc:	df45                	beqz	a4,b84 <stpcpy+0xe>
            if (!(*d = *s))
 bce:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
 bd2:	0585                	addi	a1,a1,1
 bd4:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
 bd8:	00f50023          	sb	a5,0(a0)
 bdc:	f7fd                	bnez	a5,bca <stpcpy+0x54>
}
 bde:	8082                	ret
 be0:	8082                	ret

0000000000000be2 <stpncpy>:
char *stpncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
 be2:	00b547b3          	xor	a5,a0,a1
 be6:	8b9d                	andi	a5,a5,7
 be8:	1a079863          	bnez	a5,d98 <stpncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
 bec:	0075f793          	andi	a5,a1,7
 bf0:	16078463          	beqz	a5,d58 <stpncpy+0x176>
 bf4:	ea01                	bnez	a2,c04 <stpncpy+0x22>
 bf6:	a421                	j	dfe <stpncpy+0x21c>
 bf8:	167d                	addi	a2,a2,-1
 bfa:	0505                	addi	a0,a0,1
 bfc:	14070e63          	beqz	a4,d58 <stpncpy+0x176>
 c00:	1a060863          	beqz	a2,db0 <stpncpy+0x1ce>
 c04:	0005c783          	lbu	a5,0(a1)
 c08:	0585                	addi	a1,a1,1
 c0a:	0075f713          	andi	a4,a1,7
 c0e:	00f50023          	sb	a5,0(a0)
 c12:	f3fd                	bnez	a5,bf8 <stpncpy+0x16>
 c14:	4805                	li	a6,1
 c16:	1a061863          	bnez	a2,dc6 <stpncpy+0x1e4>
 c1a:	40a007b3          	neg	a5,a0
 c1e:	8b9d                	andi	a5,a5,7
 c20:	4681                	li	a3,0
 c22:	18061a63          	bnez	a2,db6 <stpncpy+0x1d4>
 c26:	00778713          	addi	a4,a5,7
 c2a:	45ad                	li	a1,11
 c2c:	18b76363          	bltu	a4,a1,db2 <stpncpy+0x1d0>
 c30:	1ae6eb63          	bltu	a3,a4,de6 <stpncpy+0x204>
 c34:	1a078363          	beqz	a5,dda <stpncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
 c38:	00050023          	sb	zero,0(a0)
 c3c:	4685                	li	a3,1
 c3e:	00150713          	addi	a4,a0,1
 c42:	18d78f63          	beq	a5,a3,de0 <stpncpy+0x1fe>
 c46:	000500a3          	sb	zero,1(a0)
 c4a:	4689                	li	a3,2
 c4c:	00250713          	addi	a4,a0,2
 c50:	18d78e63          	beq	a5,a3,dec <stpncpy+0x20a>
 c54:	00050123          	sb	zero,2(a0)
 c58:	468d                	li	a3,3
 c5a:	00350713          	addi	a4,a0,3
 c5e:	16d78c63          	beq	a5,a3,dd6 <stpncpy+0x1f4>
 c62:	000501a3          	sb	zero,3(a0)
 c66:	4691                	li	a3,4
 c68:	00450713          	addi	a4,a0,4
 c6c:	18d78263          	beq	a5,a3,df0 <stpncpy+0x20e>
 c70:	00050223          	sb	zero,4(a0)
 c74:	4695                	li	a3,5
 c76:	00550713          	addi	a4,a0,5
 c7a:	16d78d63          	beq	a5,a3,df4 <stpncpy+0x212>
 c7e:	000502a3          	sb	zero,5(a0)
 c82:	469d                	li	a3,7
 c84:	00650713          	addi	a4,a0,6
 c88:	16d79863          	bne	a5,a3,df8 <stpncpy+0x216>
 c8c:	00750713          	addi	a4,a0,7
 c90:	00050323          	sb	zero,6(a0)
 c94:	40f80833          	sub	a6,a6,a5
 c98:	ff887593          	andi	a1,a6,-8
 c9c:	97aa                	add	a5,a5,a0
 c9e:	95be                	add	a1,a1,a5
 ca0:	0007b023          	sd	zero,0(a5)
 ca4:	07a1                	addi	a5,a5,8
 ca6:	feb79de3          	bne	a5,a1,ca0 <stpncpy+0xbe>
 caa:	ff887593          	andi	a1,a6,-8
 cae:	9ead                	addw	a3,a3,a1
 cb0:	00b707b3          	add	a5,a4,a1
 cb4:	12b80863          	beq	a6,a1,de4 <stpncpy+0x202>
 cb8:	00078023          	sb	zero,0(a5)
 cbc:	0016871b          	addiw	a4,a3,1
 cc0:	0ec77863          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 cc4:	000780a3          	sb	zero,1(a5)
 cc8:	0026871b          	addiw	a4,a3,2
 ccc:	0ec77263          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 cd0:	00078123          	sb	zero,2(a5)
 cd4:	0036871b          	addiw	a4,a3,3
 cd8:	0cc77c63          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 cdc:	000781a3          	sb	zero,3(a5)
 ce0:	0046871b          	addiw	a4,a3,4
 ce4:	0cc77663          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 ce8:	00078223          	sb	zero,4(a5)
 cec:	0056871b          	addiw	a4,a3,5
 cf0:	0cc77063          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 cf4:	000782a3          	sb	zero,5(a5)
 cf8:	0066871b          	addiw	a4,a3,6
 cfc:	0ac77a63          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 d00:	00078323          	sb	zero,6(a5)
 d04:	0076871b          	addiw	a4,a3,7
 d08:	0ac77463          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 d0c:	000783a3          	sb	zero,7(a5)
 d10:	0086871b          	addiw	a4,a3,8
 d14:	08c77e63          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 d18:	00078423          	sb	zero,8(a5)
 d1c:	0096871b          	addiw	a4,a3,9
 d20:	08c77863          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 d24:	000784a3          	sb	zero,9(a5)
 d28:	00a6871b          	addiw	a4,a3,10
 d2c:	08c77263          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 d30:	00078523          	sb	zero,10(a5)
 d34:	00b6871b          	addiw	a4,a3,11
 d38:	06c77c63          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 d3c:	000785a3          	sb	zero,11(a5)
 d40:	00c6871b          	addiw	a4,a3,12
 d44:	06c77663          	bgeu	a4,a2,db0 <stpncpy+0x1ce>
 d48:	00078623          	sb	zero,12(a5)
 d4c:	26b5                	addiw	a3,a3,13
 d4e:	06c6f163          	bgeu	a3,a2,db0 <stpncpy+0x1ce>
 d52:	000786a3          	sb	zero,13(a5)
 d56:	8082                	ret
            ;
        if (!n || !*s)
 d58:	c645                	beqz	a2,e00 <stpncpy+0x21e>
 d5a:	0005c783          	lbu	a5,0(a1)
 d5e:	ea078be3          	beqz	a5,c14 <stpncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d62:	479d                	li	a5,7
 d64:	02c7ff63          	bgeu	a5,a2,da2 <stpncpy+0x1c0>
 d68:	00000897          	auipc	a7,0x0
 d6c:	2d88b883          	ld	a7,728(a7) # 1040 <unlink+0x74>
 d70:	00000817          	auipc	a6,0x0
 d74:	2d883803          	ld	a6,728(a6) # 1048 <unlink+0x7c>
 d78:	431d                	li	t1,7
 d7a:	6198                	ld	a4,0(a1)
 d7c:	011707b3          	add	a5,a4,a7
 d80:	fff74693          	not	a3,a4
 d84:	8ff5                	and	a5,a5,a3
 d86:	0107f7b3          	and	a5,a5,a6
 d8a:	ef81                	bnez	a5,da2 <stpncpy+0x1c0>
            *wd = *ws;
 d8c:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
 d8e:	1661                	addi	a2,a2,-8
 d90:	05a1                	addi	a1,a1,8
 d92:	0521                	addi	a0,a0,8
 d94:	fec363e3          	bltu	t1,a2,d7a <stpncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
 d98:	e609                	bnez	a2,da2 <stpncpy+0x1c0>
 d9a:	a08d                	j	dfc <stpncpy+0x21a>
 d9c:	167d                	addi	a2,a2,-1
 d9e:	0505                	addi	a0,a0,1
 da0:	ca01                	beqz	a2,db0 <stpncpy+0x1ce>
 da2:	0005c783          	lbu	a5,0(a1)
 da6:	0585                	addi	a1,a1,1
 da8:	00f50023          	sb	a5,0(a0)
 dac:	fbe5                	bnez	a5,d9c <stpncpy+0x1ba>
        ;
tail:
 dae:	b59d                	j	c14 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
 db0:	8082                	ret
 db2:	472d                	li	a4,11
 db4:	bdb5                	j	c30 <stpncpy+0x4e>
 db6:	00778713          	addi	a4,a5,7
 dba:	45ad                	li	a1,11
 dbc:	fff60693          	addi	a3,a2,-1
 dc0:	e6b778e3          	bgeu	a4,a1,c30 <stpncpy+0x4e>
 dc4:	b7fd                	j	db2 <stpncpy+0x1d0>
 dc6:	40a007b3          	neg	a5,a0
 dca:	8832                	mv	a6,a2
 dcc:	8b9d                	andi	a5,a5,7
 dce:	4681                	li	a3,0
 dd0:	e4060be3          	beqz	a2,c26 <stpncpy+0x44>
 dd4:	b7cd                	j	db6 <stpncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
 dd6:	468d                	li	a3,3
 dd8:	bd75                	j	c94 <stpncpy+0xb2>
 dda:	872a                	mv	a4,a0
 ddc:	4681                	li	a3,0
 dde:	bd5d                	j	c94 <stpncpy+0xb2>
 de0:	4685                	li	a3,1
 de2:	bd4d                	j	c94 <stpncpy+0xb2>
 de4:	8082                	ret
 de6:	87aa                	mv	a5,a0
 de8:	4681                	li	a3,0
 dea:	b5f9                	j	cb8 <stpncpy+0xd6>
 dec:	4689                	li	a3,2
 dee:	b55d                	j	c94 <stpncpy+0xb2>
 df0:	4691                	li	a3,4
 df2:	b54d                	j	c94 <stpncpy+0xb2>
 df4:	4695                	li	a3,5
 df6:	bd79                	j	c94 <stpncpy+0xb2>
 df8:	4699                	li	a3,6
 dfa:	bd69                	j	c94 <stpncpy+0xb2>
 dfc:	8082                	ret
 dfe:	8082                	ret
 e00:	8082                	ret

0000000000000e02 <open>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
 e02:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
 e06:	4609                	li	a2,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 e08:	00000073          	ecall
#include "syscall.h"

int open(const char *path, int flags)
{
    return syscall(SYS_openat, path, flags, O_RDWR);
}
 e0c:	2501                	sext.w	a0,a0
 e0e:	8082                	ret

0000000000000e10 <close>:
    register long a7 __asm__("a7") = n;
 e10:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
 e14:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
 e18:	2501                	sext.w	a0,a0
 e1a:	8082                	ret

0000000000000e1c <read>:
    register long a7 __asm__("a7") = n;
 e1c:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 e20:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
 e24:	8082                	ret

0000000000000e26 <write>:
    register long a7 __asm__("a7") = n;
 e26:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 e2a:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
 e2e:	8082                	ret

0000000000000e30 <getpid>:
    register long a7 __asm__("a7") = n;
 e30:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
 e34:	00000073          	ecall

int getpid(void)
{
    return syscall(SYS_getpid);
}
 e38:	2501                	sext.w	a0,a0
 e3a:	8082                	ret

0000000000000e3c <sched_yield>:
    register long a7 __asm__("a7") = n;
 e3c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
 e40:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
 e44:	2501                	sext.w	a0,a0
 e46:	8082                	ret

0000000000000e48 <fork>:
    register long a7 __asm__("a7") = n;
 e48:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
 e4c:	00000073          	ecall

int fork(void)
{
    return syscall(SYS_clone);
}
 e50:	2501                	sext.w	a0,a0
 e52:	8082                	ret

0000000000000e54 <exit>:
    register long a7 __asm__("a7") = n;
 e54:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
 e58:	00000073          	ecall

void exit(int code)
{
    syscall(SYS_exit, code);
}
 e5c:	8082                	ret

0000000000000e5e <waitpid>:
    register long a7 __asm__("a7") = n;
 e5e:	10400893          	li	a7,260
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e62:	00000073          	ecall

int waitpid(int pid, int *code)
{
    return syscall(SYS_wait4, pid, code);
}
 e66:	2501                	sext.w	a0,a0
 e68:	8082                	ret

0000000000000e6a <exec>:
    register long a7 __asm__("a7") = n;
 e6a:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
 e6e:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
 e72:	2501                	sext.w	a0,a0
 e74:	8082                	ret

0000000000000e76 <get_time>:

int64 get_time()
{
 e76:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
 e78:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 e7c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 e7e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 e80:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
 e84:	2501                	sext.w	a0,a0
 e86:	ed09                	bnez	a0,ea0 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 e88:	67a2                	ld	a5,8(sp)
 e8a:	3e800713          	li	a4,1000
 e8e:	00015503          	lhu	a0,0(sp)
 e92:	02e7d7b3          	divu	a5,a5,a4
 e96:	02e50533          	mul	a0,a0,a4
 e9a:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
 e9c:	0141                	addi	sp,sp,16
 e9e:	8082                	ret
        return -1;
 ea0:	557d                	li	a0,-1
 ea2:	bfed                	j	e9c <get_time+0x26>

0000000000000ea4 <sys_get_time>:
    register long a7 __asm__("a7") = n;
 ea4:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ea8:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
 eac:	2501                	sext.w	a0,a0
 eae:	8082                	ret

0000000000000eb0 <sleep>:

int sleep(unsigned long long time)
{
 eb0:	1141                	addi	sp,sp,-16
 eb2:	862a                	mv	a2,a0
    register long a7 __asm__("a7") = n;
 eb4:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 eb8:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 eba:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ebc:	00000073          	ecall
    if (err == 0)
 ec0:	2501                	sext.w	a0,a0
 ec2:	e13d                	bnez	a0,f28 <sleep+0x78>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 ec4:	6722                	ld	a4,8(sp)
 ec6:	3e800693          	li	a3,1000
 eca:	00015783          	lhu	a5,0(sp)
 ece:	02d75733          	divu	a4,a4,a3
 ed2:	02d787b3          	mul	a5,a5,a3
 ed6:	97ba                	add	a5,a5,a4
    register long a7 __asm__("a7") = n;
 ed8:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 edc:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 ede:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 ee0:	00000073          	ecall
    if (err == 0)
 ee4:	2501                	sext.w	a0,a0
 ee6:	ed15                	bnez	a0,f22 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 ee8:	6841                	lui	a6,0x10
 eea:	963e                	add	a2,a2,a5
 eec:	187d                	addi	a6,a6,-1
 eee:	3e800693          	li	a3,1000
 ef2:	a819                	j	f08 <sleep+0x58>
    __asm_syscall("r"(a7))
 ef4:	00000073          	ecall
    register long a7 __asm__("a7") = n;
 ef8:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
 efc:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
 efe:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f00:	00000073          	ecall
    if (err == 0)
 f04:	2501                	sext.w	a0,a0
 f06:	ed11                	bnez	a0,f22 <sleep+0x72>
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
 f08:	67a2                	ld	a5,8(sp)
    register long a7 __asm__("a7") = n;
 f0a:	07c00893          	li	a7,124
 f0e:	02d7d733          	divu	a4,a5,a3
 f12:	6782                	ld	a5,0(sp)
 f14:	0107f7b3          	and	a5,a5,a6
 f18:	02d787b3          	mul	a5,a5,a3
 f1c:	97ba                	add	a5,a5,a4
    unsigned long long s = get_time();
    while (get_time() < s + time)
 f1e:	fcc7ebe3          	bltu	a5,a2,ef4 <sleep+0x44>
    {
        sched_yield();
    }
    return 0;
}
 f22:	4501                	li	a0,0
 f24:	0141                	addi	sp,sp,16
 f26:	8082                	ret
 f28:	57fd                	li	a5,-1
 f2a:	b77d                	j	ed8 <sleep+0x28>

0000000000000f2c <set_priority>:
    register long a7 __asm__("a7") = n;
 f2c:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
 f30:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
 f34:	2501                	sext.w	a0,a0
 f36:	8082                	ret

0000000000000f38 <mmap>:
    register long a7 __asm__("a7") = n;
 f38:	0de00893          	li	a7,222
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f3c:	00000073          	ecall

int mmap(void *start, unsigned long long len, int prot)
{
    return syscall(SYS_mmap, start, len, prot);
}
 f40:	2501                	sext.w	a0,a0
 f42:	8082                	ret

0000000000000f44 <munmap>:
    register long a7 __asm__("a7") = n;
 f44:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f48:	00000073          	ecall

int munmap(void *start, unsigned long long len)
{
    return syscall(SYS_munmap, start, len);
}
 f4c:	2501                	sext.w	a0,a0
 f4e:	8082                	ret

0000000000000f50 <wait>:

int wait(int *code)
{
 f50:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 f52:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
 f56:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f58:	00000073          	ecall
    return waitpid(-1, code);
}
 f5c:	2501                	sext.w	a0,a0
 f5e:	8082                	ret

0000000000000f60 <spawn>:
    register long a7 __asm__("a7") = n;
 f60:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
 f64:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
 f68:	2501                	sext.w	a0,a0
 f6a:	8082                	ret

0000000000000f6c <mailread>:
    register long a7 __asm__("a7") = n;
 f6c:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f70:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
 f74:	2501                	sext.w	a0,a0
 f76:	8082                	ret

0000000000000f78 <mailwrite>:
    register long a7 __asm__("a7") = n;
 f78:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 f7c:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
 f80:	2501                	sext.w	a0,a0
 f82:	8082                	ret

0000000000000f84 <fstat>:
    register long a7 __asm__("a7") = n;
 f84:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
 f88:	00000073          	ecall

int fstat(int fd, Stat *st)
{
    return syscall(SYS_fstat, fd, st);
}
 f8c:	2501                	sext.w	a0,a0
 f8e:	8082                	ret

0000000000000f90 <sys_linkat>:
    register long a7 __asm__("a7") = n;
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
 f90:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
 f92:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
 f96:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 f98:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
 f9c:	2501                	sext.w	a0,a0
 f9e:	8082                	ret

0000000000000fa0 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
 fa0:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
 fa2:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
 fa6:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 fa8:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
 fac:	2501                	sext.w	a0,a0
 fae:	8082                	ret

0000000000000fb0 <link>:

int link(char *old_path, char *new_path)
{
 fb0:	87aa                	mv	a5,a0
 fb2:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
 fb4:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
 fb8:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
 fbc:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
 fbe:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
 fc2:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
 fc4:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
 fc8:	2501                	sext.w	a0,a0
 fca:	8082                	ret

0000000000000fcc <unlink>:

int unlink(char *path)
{
 fcc:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
 fce:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
 fd2:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
 fd6:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
 fd8:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
 fdc:	2501                	sext.w	a0,a0
 fde:	8082                	ret
