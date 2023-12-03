section .text
	global do_math

	;; float do_math(float x, float y, float z)
	; returns x * sqrt(2) + y * sin(z * PI * 1 / e)
do_math:
	push ebp
	mov ebp, esp

  ;; comentariile arata continutul stivei la fiecare pas

    fld1		; 1
	fchs 	 	;-1
 	fldl2e   	; log2(e) , -1
	faddp ST1   ; log2(e)-1
 	f2xm1       ;  2^(log2(e)-1) - 1 <=> e/2 - 1
	fld1		; 1 , e/2 - 1
	faddp ST1   ; e/2
	fld1        ; 1 , e/2
	fadd ST0 	; 2 , e/2
	fmulp ST1 	; 2*e/2 <=> e   
	fld1		; 1 , e
	fdivrp ST1	; 1/e
  
    fld dword [ebp+16] ; z , 1/e
    fldpi  			   ; pi , z , 1/e
    fmulp ST1		   ; pi*z , 1/e
	fmulp ST1		   ; pi*z*1/e
	fsin			   ; sin(pi*z*1/e)

    fld dword [ebp+12] ;  y , sin(pi*z*1/e)
	fmulp ST1		   ;  y*sin(pi*z*1/e)

	fld dword [ebp+8]   ; x , y*sin(pi*z*1/e)
	fld1				; 1 , x , y*sin(pi*z*1/e)
	fadd ST0			; 2 , x , y*sin(pi*z*1/e)
	fsqrt				; sqrt(2) , x , y*sin(pi*z*1/e)
	fmulp ST1			; x*sqrt(2) , y*sin(pi*z*1/e)
	faddp ST1			; x * sqrt(2) + y * sin(z * PI * 1 / e)


	leave
	ret
