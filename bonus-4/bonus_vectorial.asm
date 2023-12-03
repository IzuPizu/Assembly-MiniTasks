section .text
	global vectorial_ops

;; void vectorial_ops(int *s, int A[], int B[], int C[], int n, int D[])
;  
;  Compute the result of s * A + B .* C, and store it in D. n is the size of
;  A, B, C and D. n is a multiple of 16. The result of any multiplication will
;  fit in 32 bits. Use MMX, SSE or AVX instructions for this task.

vectorial_ops:
	push	rbp
	mov		rbp, rsp

	xor		rax, rax
	push	rdi

    ; punem in registrul xmm0 valoarea lui s
	mov		edi,DWORD[rsp]
	movd	xmm0, edi
    pshufd	xmm0, xmm0, 0
 
 
sse_loop: 
    ;calculam s*A
    ; incarca 4 valori din A in xmm1  
    movdqu xmm1, [rsi + 4 * rax]
  
    ; inmulteste xmm0 si xmm1 => rezultat in xmm0
    ; stocam doar lower half
	pmulld	xmm1, xmm0

    ;calculam B .* C  => rezultat in xmm2
    movdqu  xmm2, [rdx + 4 * rax]
    movdqu  xmm3, [rcx + 4 * rax]
    pmulld  xmm2, xmm3
	
    ;aduna rezultatele : s*A + B .* C
    paddd xmm1, xmm2

    ;stocheaza in D
    movdqu  [r9 + 4* rax], xmm1

    add     rax, 4   ; incrementare rax  => trecem la urmatoarele 4 elemente
    cmp     rax, r8  ; verifica daca s-a terminat
    jl      sse_loop  ; executa din nou loop-ul

exit:
	leave
	ret
