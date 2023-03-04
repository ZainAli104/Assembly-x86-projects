include \masm32\include\masm32rt.inc
cr equ 13
lf equ 10
.data

txtmsg db"=============================================================",
   cr,lf,"*                   Factorial Program                       *",
   cr,lf,"=============================================================",cr,lf,0
a dd ?
.code
start:
    cls
    print OFFSET txtmsg
    mov ecx,sval(input("Enter value for N = "))    ; Read N in register ecx
    mov a,ecx
    cmp a, 0
    jl error
    jmp fact
    error:
        print chr$("N must be a +ve integer ", cr, lf)
        exit
    fact:    
        mov ebx, 1
    factcall:
        imul ebx, ecx ; ebx = ebx * ecx
        loop factcall
        print chr$("Factorial of ")
        print str$(a)
        print chr$("=")
        print str$(ebx)
    factexit:
        exit
end start