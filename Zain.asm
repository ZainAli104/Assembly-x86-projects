include \masm32\include\masm32rt.inc

cr equ 13
lf equ 10

.data
banner  db  " _______________________________________________", cr, lf
        db  "|                                               |", cr, lf
        db  "|                 Billing System                |", cr, lf
        db  "|                                               |", cr, lf
        db  "|_______________________________________________|", cr, lf
        db  cr, lf, 0
banner1   db  " ________________________________________________", cr, lf
        db  "|               Do You Want To Continue          |", cr, lf
        db  "|               1- Yes                           |", cr, lf
        db  "|               2- No                            |", cr, lf
        db  "|________________________________________________|", cr, lf
        db  cr, lf, 0

na      db  128 dup(?),0
ad      dq  128 dup(?),0
elc     dq   ?
gas     dq   ?
water   dq   ?
cabel   dq   ?
net     dq   ?
mob     dq   ?
w       dq   6.00
avg     dq   ?
fi      dq   ?
ac      dq  128 dup(?),0
ap      dq  ?
ar      dq  ?
ae      dq  500.00
at      dq  100.00
ao      dq  ?
ai      dd  ?
za      dd  40
zb      dd  50
zc      dd  60
zd      dd  80
m       dd  ?

.code

start:
    process:
   invoke ClearScreen 
   print OFFSET banner


   invoke StrToFloat,input("Enter Your Name :"), ADDR na
   
   invoke StrToFloat,input("Enter Your Age :"), ADDR ad
   
   invoke StrToFloat,input("Enter Your Electricity Bill Amount : "), ADDR elc
   
   invoke StrToFloat,input("Enter Your Gas Bill Amount :"), ADDR gas
   
   invoke StrToFloat,input("Enter Your Water Bill Amount :"), ADDR water
   
   invoke StrToFloat,input("Enter Your Cabel Bill Amount :"), ADDR cabel
   
   invoke StrToFloat,input("Enter Your Wifi Bill Amount :"), ADDR net
   
   invoke StrToFloat,input("Enter Your Mobile Bill Amount :"), ADDR mob

    fld elc
    fld gas
    fadd
    fld water
    fadd
    fld cabel
    fadd
    fld net
    fadd
    fld mob
    fadd
    fstp ap
    invoke FloatToStr,ap, ADDR ac
    print chr$("Your Total Bill amount is: "),cr,lf
    print OFFSET ac,cr,lf,0
    fld ap
    fld w
    fdiv
    fstp ar
    invoke FloatToStr,ar, ADDR ac
    print chr$("Your Average Bill amount is: "),cr,lf
    print OFFSET ac,cr,lf,0
    fld ap
    fld ae
    fdiv
    fld at
    fmul
    fstp ao
    invoke FloatToStr,ao, ADDR ac

    failcode:
    print OFFSET banner1
    mov m,sval(input("Enter Your Choice :"))
    cmp m,1
    je  process
    cmp m,2
    je  exitcode
    jg invalid
    exit
    
    Dcode:
    print OFFSET banner1
    mov m,sval(input("Enter Your Choice :"))
    cmp m,1
    je  process
    cmp m,2
    je  exitcode
    jg invalid
    exit
    
    Ccode:
    print OFFSET banner1
    mov m,sval(input("Enter Your Choice :"))
    cmp m,1
    je  process
    cmp m,2
    je  exitcode
    jg invalid
    exit
    
    Bcode:
    print OFFSET banner1
    mov m,sval(input("Enter Your Choice :"))
    cmp m,1
    je  process
    cmp m,2
    je  exitcode
    jg invalid
    exit
    
    Acode:
    print OFFSET banner1
    mov m,sval(input("Enter Your Choice :"))
    cmp m,1
    je  process
    cmp m,2
    je  exitcode
    jg invalid
    exit

    exitcode:
    print chr$("End Program")
    exit
    invalid:
    print chr$("Select a Valid Option")
       
    exit

end start
   
   
   