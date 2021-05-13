.global _start

.section .text
_start: 
main:

	xor  %rcx, %rcx             # rcx=0
	movl (num), %ecx            # counter = num of bytes to write to stack
	
	leaq (source),%rax          # where we start reading from 
	addq %rcx, %rax             # start reading from the last int 
	leaq (destination),%rbx     # where we write to
	addq %rcx, %rbx             # start writing from the last int
	
	cmpl $0,%ecx                # if asked to read 0 byte or less finish immediately
	jle end
	
	read_write:    
		cmpl $0,%ecx            #if there are no byte left to read finish
		jle end
		sub $4, %ecx            # reduce num of bytes left to write on stack by size of int
		sub $4, %rax            # reduce adress to read the next int (started reading from last int)
		sub $4, %rbx            # reduce adress to write the next int (started writing from last int)
		mov (%rax), %esi        # read the current int
		mov  %esi, (%rbx)       # write the current int
		jmp read_write
		
	end:
