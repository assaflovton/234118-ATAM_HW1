.global _start

.section .text
_start:
	movq (num) , %rcx
        popcnt %rcx , %rdx 
        movq %rdx , (countBits)