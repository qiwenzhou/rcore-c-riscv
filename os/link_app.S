    .align 4
    .section .data
    .global _app_num
_app_num:
    .quad 30
    .quad app_0_start
    .quad app_1_start
    .quad app_2_start
    .quad app_3_start
    .quad app_4_start
    .quad app_5_start
    .quad app_6_start
    .quad app_7_start
    .quad app_8_start
    .quad app_9_start
    .quad app_10_start
    .quad app_11_start
    .quad app_12_start
    .quad app_13_start
    .quad app_14_start
    .quad app_15_start
    .quad app_16_start
    .quad app_17_start
    .quad app_18_start
    .quad app_19_start
    .quad app_20_start
    .quad app_21_start
    .quad app_22_start
    .quad app_23_start
    .quad app_24_start
    .quad app_25_start
    .quad app_26_start
    .quad app_27_start
    .quad app_28_start
    .quad app_29_start
    .quad app_29_end

    .global _app_names
_app_names:
   .string "ch2_exit"
   .string "ch2_hello_world"
   .string "ch2_power"
   .string "ch2_write1"
   .string "ch3_0_setprio"
   .string "ch3_0_sleep"
   .string "ch3_0_sleep1"
   .string "ch4_mmap0"
   .string "ch4_mmap1"
   .string "ch4_mmap2"
   .string "ch4_mmap3"
   .string "ch4_unmap"
   .string "ch4_unmap2"
   .string "ch5_exit0"
   .string "ch5_exit1"
   .string "ch5_getchar"
   .string "ch5_getpid"
   .string "ch5_spawn0"
   .string "ch5_spawn1"
   .string "ch5_usershell"
   .string "ch5_usertest"
   .string "ch6_mail0"
   .string "ch6_mail1"
   .string "ch6_mail2"
   .string "ch6_mail3"
   .string "ch6_usertest"
   .string "ch7_file0"
   .string "ch7_file1"
   .string "ch7_file2"
   .string "ch7_usertest"

    .global app_0_start
    .align 12
app_0_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch2_exit.bin"

    .global app_1_start
    .align 12
app_1_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch2_hello_world.bin"

    .global app_2_start
    .align 12
app_2_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch2_power.bin"

    .global app_3_start
    .align 12
app_3_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch2_write1.bin"

    .global app_4_start
    .align 12
app_4_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch3_0_setprio.bin"

    .global app_5_start
    .align 12
app_5_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch3_0_sleep.bin"

    .global app_6_start
    .align 12
app_6_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch3_0_sleep1.bin"

    .global app_7_start
    .align 12
app_7_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch4_mmap0.bin"

    .global app_8_start
    .align 12
app_8_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch4_mmap1.bin"

    .global app_9_start
    .align 12
app_9_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch4_mmap2.bin"

    .global app_10_start
    .align 12
app_10_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch4_mmap3.bin"

    .global app_11_start
    .align 12
app_11_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch4_unmap.bin"

    .global app_12_start
    .align 12
app_12_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch4_unmap2.bin"

    .global app_13_start
    .align 12
app_13_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch5_exit0.bin"

    .global app_14_start
    .align 12
app_14_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch5_exit1.bin"

    .global app_15_start
    .align 12
app_15_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch5_getchar.bin"

    .global app_16_start
    .align 12
app_16_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch5_getpid.bin"

    .global app_17_start
    .align 12
app_17_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch5_spawn0.bin"

    .global app_18_start
    .align 12
app_18_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch5_spawn1.bin"

    .global app_19_start
    .align 12
app_19_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch5_usershell.bin"

    .global app_20_start
    .align 12
app_20_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch5_usertest.bin"

    .global app_21_start
    .align 12
app_21_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch6_mail0.bin"

    .global app_22_start
    .align 12
app_22_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch6_mail1.bin"

    .global app_23_start
    .align 12
app_23_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch6_mail2.bin"

    .global app_24_start
    .align 12
app_24_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch6_mail3.bin"

    .global app_25_start
    .align 12
app_25_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch6_usertest.bin"

    .global app_26_start
    .align 12
app_26_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch7_file0.bin"

    .global app_27_start
    .align 12
app_27_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch7_file1.bin"

    .global app_28_start
    .align 12
app_28_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch7_file2.bin"

    .global app_29_start
    .align 12
app_29_start:
    .incbin "../riscvos-c-tests/user/target/bin/ch7_usertest.bin"
app_29_end:

