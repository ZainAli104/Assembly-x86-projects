include \masm32\include\masm32rt.inc

cr equ 13
lf equ 10

.data

arr dd 10 dup(?)
i dd 11

.code
start:
    invoke ClearScreen
    mov ebx,OFFSET arr
    mov edi,1
    forstart:
        cmp edi,i
        je forexit
        mov [ebx+edi*4],edi
        print str$([ebx+edi*4]),cr,lf
        inc edi
        cmp edi,i
        jl forstart
        forexit:
            exit

end start