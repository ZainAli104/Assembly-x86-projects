include \masm32\include\masm32rt.inc

N equ 10

.data
    cr equ 13
    lf equ 10
    m dd ?

.code
start:
    mov m, sval(input("generate table of ? "))
    mov ebx,1
forstart:
    cmp ebx,N
    jle forbody
    jmp forend
forbody:
    print str$(ebx)
    print chr$("*")
    print str$(m)
    print chr$("=")
    mov eax,m
    mul ebx
    print str$(eax),cr,lf

    inc ebx
    jmp forstart
forend:
    exit
end start