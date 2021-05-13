.global _start

.section .text
_start:

    movq head , %rsi  # store the first node in rsi
    
   test %rsi , %rsi    # Validate head isn't NULL
    je done

    movq $head , %rdi # store the address of head (previous node to src) in rdi
    subq $8 , %rdi    # offset rdi so that when depointed with an offset of 8 we get the next node

find_src_step:
    # check if the current node has the value of src
    movq (%rsi) , %rax
    cmpq src , %rax
    je found_src

    # advance the previous , current node and loop
    movq %rsi , %rdi
    movq 8(%rsi) , %rsi
    jmp find_src_step

found_src:
    # save src_prev , src , src_next into r8 , r9 , r10
    movq %rdi , %r8
    movq %rsi , %r9
    movq 8(%rsi) , %r10

    # advance the previous , current node before searching for dst
    movq %rsi , %rdi
    movq 8(%rsi) , %rsi

# search for dst
find_dst_step:
    # validate current node isn't NULL
    test %rsi , %rsi
    je done

    # check if the current node has the value of dst
    movq (%rsi) , %rax
    cmpq dst , %rax
    je found_dst

    # advance the previous , current node and loop
    movq %rsi , %rdi
    movq 8(%rsi) , %rsi
    jmp find_dst_step

found_dst:

    # save dst_prev , dst , dst_next into r11 , r12 , r13
    movq %rdi , %r11
    movq %rsi , %r12
    movq 8(%rsi) , %r13

    # r8    <-- src_prev
    # r9    <-- src
    # r10   <-- src_next
    
    # r11   <-- dst_prev
    # r12   <-- dst
    # r13   <-- dst_next

    # check if nodes are adjacent
    cmpq %r10 , %r12
    je swap_adjacent


# swap non adjacent nodes

    # src_prev.next = dst
    movq %r12 , 8(%r8)

    # src.next = dst_next
    movq %r13 , 8(%r9)

    # dst_prev.next = src (only if they are not adjacent)
    movq %r9 , 8(%r11)

    # dst.next = src_next
    movq %r10 , 8(%r12)

    jmp done

swap_adjacent:
    # dst.next = src
    movq %r9 , 8(%r12)

    # src.next = dst_next
    movq %r13 , 8(%r9)

    # src_prev.next = dst
    movq %r12 , 8(%r8)

done:


