section .text
	global intertwine
	
	;; void intertwine(int * v1, int n1, int * v2, int n2, int * v);
	;
	; Take the 2 arrays, v1 and v2 with varying lengths, n1 and n2, 
	; and intertwine them
	; The resulting array is stored in v
intertwine:
	push rbp
	mov rbp, rsp
	
   ;mutam parametrii functiei in registrii

	mov r12, rdi                 ; v1 
	mov r13, rsi                 ; n1
	mov r14, rdx                 ; v2 
	mov r15, rcx                 ; n2 
	mov rdi, r8                  ; v 
	
	;indecsi vectori
	xor rax, rax                 ; rax = 0  ->v1
	xor rbx, rbx                 ; rbx = 0 -> v2
	xor rcx, rcx                 ; rcx = 0 -> v
	
	mov r9, r13
	add r9, r15      			;n1+n2
	
intertwine_loop:
	cmp rax, r13                 ; comparam indx pentru v1 cu lungimea (n1)
	jge check_first              ; daca am depasit => jump la eticheta 'check_first'
	cmp rbx, r15                 ; comparam indx pentru v2 vector cu lungimea (n2)
	jge check_first				; daca am depasi => jump la 'check_first'
	
	;punem element din v1 in v
	mov edx, [r12 + rax * 4]     ; edx = v1[index]
	mov [rdi + rcx * 4], edx     ; v[rcx] = v1[index]
	
	add rax, 1                   ; incrementam indx v1
	add rcx, 1                   ; incrementam indx v
	;punem element din v2 in v
	mov edx, [r14 + rbx * 4]     ; edx = v2[index]
	mov [rdi + rcx * 4], edx     ; v[rcx] = v2[index]
	
	add rcx, 1                   ; incrementam indx v
	add rbx, 1                   ; incrementam indx v2
	
	jmp intertwine_loop          ; iteram din nou

	;am ajuns la finalul lui v1 sau v2
check_first:
	cmp r13, r15  				; daca n1>n2 => umplem v cu restul elementelor din v1
	jg fill_rest
	;altfel , umplem v cu restul elementelor din v2
	mov edx, [r14 + rbx * 4]     ; edx = v2[index]
	mov [rdi + rcx * 4], edx     ; v[rcx] = v2[index]
	add rcx, 1 					 ; incrementam indx v
	add rbx, 1 				 	 ; incrementam indx v2
	cmp rbx, r15 				 ; daca am ajuns la finalul v2
	jge finished 				 ; finish
	jmp check_first				 ; altfel , reluam
	
	;umplem v cu restul elementelor din v1
fill_rest:
	cmp rax, r13				 ;daca am ajuns la finalul v1
	jge finished				 ;finish
	mov edx, [r12 + rax * 4]     ; edx = v1[index]
	mov [rdi + rcx * 4], edx     ; v[rcx] = v1[index]
	add rcx, 1					 ;incrementam indx v
	add rax, 1					 ;incrementam indx v1
	
	jmp fill_rest				 ;reluam
	
finished:
	leave
	ret
