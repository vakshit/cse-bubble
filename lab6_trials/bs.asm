.data
num_buckets:  .word   10
bucket_size:  .word   100
input_array:  .float  0.42, 0.32, 0.33, 0.52, 0.37, 0.47, 0.51
n:            .word   7
sorted_array  .space  28

.text
allocate_bucket:
    li $v0, 9
    mul $a0, $a0, 4
    syscall
    jr $ra

free_bucket:
    li $v0, 9
    sub $a0, $a0, $a1
    syscall
    jr $ra

compute_bucket_index:
    lwc1 $f2, ($a0)