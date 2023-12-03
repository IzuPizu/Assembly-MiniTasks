/*
 * Don't forget to include "positions.h"
 */
#include "positions.h"
.section .text

.global add_vect

/* 
 * void add_vect(int *v1, int *v2, int n, int *v)
 *
 * add v1 and v2, that have both the length n, and store the result in v3.
 * also, substract from v3 the values provided in positions.S, as described
 * in the task
 */

add_vect:
	pushl	%ebp
	movl 	%esp, %ebp
	
	/* accesează parametrii */
	movl 	8(%ebp), %esi    	/* v1 */
	movl 	12(%ebp), %edi   	/* v2 */
	movl 	16(%ebp), %ecx   	/* n */
	movl 	20(%ebp), %edx   	/* v */

/* iteram prin vectori si adaugam elementele */

	movl 	%ecx, %eax        	/* %eax -> contor */
loop_start:
	movl 	(%esi), %ebx      	/* v1[i] */
	addl 	(%edi), %ebx      	/* v2[i] + v1[i] */
	movl 	%ebx, (%edx)      	/* v[i] = v2[i] + v1[i] */

	addl 	$4, %esi          	/* incrementare ptr v1 */
	addl 	$4, %edi          	/* incrementare ptr v2 */
	addl 	$4, %edx          	/* incrementare ptr v */

	loop 	loop_start     

	movl 	16(%ebp), %esi   	/* n */
	movl    $10 , %ecx         /*dimensiune vect pentru care sunt definite*/

//pentru prima scadere

	movl 	$FIRST_POSITION,%eax  
	imull   %esi ,%eax  	  // index(eax)*esi(N) -> rezultat in eax 
	cdq
	idivl	%ecx

	movl 	20(%ebp), %edx   	/* v */
	subl	$FIRST_VALUE, (%edx,%eax,4)    //scadem FIRST_VALUE de pe pozitia scalata

 //pentru a doua scadere
  
	movl 	$SECOND_POSITION,%eax  
	imull   %esi ,%eax  // index(eax)*esi(N) -> rezultat  in eax 
	cdq
	idivl	%ecx

	movl 	20(%ebp), %edx   	/* v */
	subl	$SECOND_VALUE, (%edx,%eax,4)   //scadem SECOND_VALUE de pe pozitia scalata
//pentru a treia scadere
	
	movl 	$THIRD_POSITION,%eax  
	imull   %esi ,%eax  // index(eax)*esi(N) -> rezultat in eax 
	cdq
	idivl	%ecx

	movl 	20(%ebp), %edx   	/* v */
	subl	$THIRD_VALUE, (%edx,%eax,4)  ////scadem THIRD_VALUE de pe pozitia scalata

	leave
	ret
