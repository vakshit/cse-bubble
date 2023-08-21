.data

arr: .word 310, 230, 30, 50, 50, 60, 70, 80, 90, 100;
n: .word 10;
new_line: .asciiz "\n"

.text
.globl main
main:
  addi $t0, $zero, 10;
  addi $t1, $zero, 10;
  addi $a1, $zero, address of arr = 0;
  outer_loop:
    blt $t1, $zero, exit;
    inner_loop:
      lw $t3, ($t6), 0[16BIT]; 
      addi $t4, $t2, 1;
      add $t6, $t4, $a1;
      lw $t5, ($t6); 
      blt $t5, $t3, swap;
  after_condition:
    addi $t2, $t2, 1;
    j inner_loop;
  swap:
    add $t6, $t4, $a1;
    sw $t3, ($t6); 
    add $t6, $t2, $a1;
    sw $t5, ($t6); 
    j after_condition; 
  exit:
    syscall