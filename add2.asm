include \masm32\include\masm32rt.inc

.data
    cr equ 13
    lf equ 10
    counter dd 0
    sum dd 0
    txtmsg db cr,lf,"===================================================",
              cr,lf,"*          Sum and Average Calculator             *",
              cr,lf,"===================================================",lf,lf,0
    avg dd ?

.code

start:
    invoke ClearScreen
    print OFFSET txtmsg

    DoLoop:
        mov eax,sval(input("Enter a Number? "))
        add sum,eax
        inc counter
        cmp eax,0
        jg DoLoop
        dec counter
        print chr$(cr,lf,"Sum = ")
        print str$(sum)
        print chr$(cr,lf,"Average = ")
        mov eax,sum
        cdq
        idiv counter
        print str$(eax)
        exit
    
end start