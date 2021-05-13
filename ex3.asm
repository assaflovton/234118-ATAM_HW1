.global _start

.section .text
_start:
#your code here
 	xor %rcx, %rcx # counter
	xor %rbx, %rbx # total
	xor %rax, %rax # cur arr elem
	movl arr(, %ecx, 4), %eax # eax = cur arr elment
		cmp $0, %eax
		je end_only_one_zero
	l: 	
		movl arr(, %ecx, 4), %eax # eax = cur arr elment
		cmp $0, %eax
		je end
		inc %ecx
		addq %rax, %rbx # adds cur elem to tot 
		jmp l
	
	end:
	    	xor %rdx, %rdx 
	    	movq %rbx, %rax
	    	div %rcx  
	    	movl %eax, (avg)
	  	jmp finish
	
	end_only_one_zero:
	    	movl %eax, (avg)
	
	finish: