.global _start

.section .text
_start:
#your code here
    xor %rcx, %rcx          # counter
	movq $1,%rbx            # current len
	movq $1,%rsi            # max len
	xor %rdi, %rdi          # index of cur seq 
	xor %rax, %rax          # index of max seq
	xor %rdx, %rdx          # last element
	movl $1,(len)
	movl $0,(begin)
	mov $2,%r8d             
	cmpl (n) ,%r8d          # if n < 2
    ja end                   
    movl (arr),%edx         # last element
    inc %ecx                
mainloop: 	
    cmpl (n) , %ecx         # while ecx <= n
    je end
	cmpl arr(,%ecx, 4),%edx 
	ja smaller                # if cur_arr_elem < last_elem
	cmpl %ebx,%esi          # if max < curr
	jb newmax               # jump to update new max seq values

back:	
    movl $1,%ebx       # cur len = 1
	movl %ecx,%edi          # cur begin = counter - 1
	movl arr(,%ecx, 4),%edx # last elmen = cur elem
	inc %ecx
	jmp mainloop

newmax:
    movl %ebx,%esi         # max len = cur len
	movl %edi,%eax         # max begin = cur begin
    jmp back

smaller:
    inc %ebx               # cur len++
    movl arr(,%ecx, 4),%edx # last elmen = cur elem
    inc %ecx               # counter++
    jmp mainloop

finalcheckforseq:
    movl %ebx,%esi         # max len = cur len
	movl %edi,%eax         # max begin = cur begin
    jmp finally
    
end:
    cmpl %ebx,%esi         
    jb finalcheckforseq    # if cur len > max len

finally:  
    movl %esi,(len)        # write len res to memory
    movl %eax,(begin)      # write begin res to memory