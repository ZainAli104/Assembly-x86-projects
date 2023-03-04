include \masm32\include\masm32rt.inc

.data
    cr equ 13
    lf equ 10
    a dd ?
    b dd 2
    e dd 20
    d dd 30

.code

start:
    mov a,sval(input("Enter a number to check: "))
    mov ebx,a
    mov edx,0
    div b

    cmp edx,0
    je true
    jmp false
    true:
        print str$(ebx)
        print chr$(" Number is even"),cr,lf
        exit
    false:
        print str$(ebx)
        print chr$(" Number is odd"),cr,lf

end start