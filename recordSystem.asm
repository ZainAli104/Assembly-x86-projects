include \masm32\include\masm32rt.inc

; ASCII Codes Definitions
cr  equ 13      ; Carriage Return
lf  equ 10      ; Line Feed
tab equ 9       ; Horizontal Tab
bel equ 7       ; Bell
N   equ 78      ; Upper case N
Y   equ 89      ; Upper case Y
nn   equ 110    ; Lower case n    
yy   equ 121    ; Lower case y
;; Macro Definitions
println macro
    print chr$(cr, lf)
endm
;;
printRecord macro record
    print str$(record.Id), tab 
    print str$(record.Age), tab
    print OFFSET record.FirstName
    println 
endm
;;
inputRecord macro record
    mov record.Id, sval(input("Student Id ? "))
    mov record.Age, sval(input("Student Age ? "))
    ;; Read in First.Name part of record
    mov esi, input("Student Name ? ")
    mov edi, OFFSET record.FirstName
    mov ecx, bLen
    rep movsb
    ;; Can also be accomplished 
    ;print "Student Name ? "
    ;invoke StdIn, ADDR record.FirstName, bLen
endm
;; Data Declarations
.data
menu    db  "+===============================================+", cr, lf
        db  "|                Command Menu                   |", cr, lf
        db  "|                                               |", cr, lf
        db  "|       1: Add a record ...                     |", cr, lf
        db  "|       2: List records ...                     |", cr, lf
        db  "|       3: Serach records ...                   |", cr, lf
        db  "|       4: Edit a record  ...                   |", cr, lf
        db  "|       5: Delete a record ...                  |", cr, lf
        db  "|                                               |", cr, lf
        db  "|       9: Initialize System ...                |", cr, lf
        db  "|                                               |", cr, lf
        db  "|       0: Terminate program ...                |", cr, lf
        db  "|                                               |", cr, lf
        db  "+===============================================+", cr, lf
        db  cr, lf, 0
;;*********************************************************************       
;; User Defined Hetrogeneous data type definition                     *
;; Person stucture or Template Definition                             *
;;*********************************************************************
person struct 
    Id          dd    ?
    Age         dd    ?
    FirstName   db 30 dup(?), 0
person ends
; Length of person structure in bytes;
bLen    equ SIZEOF person
;;.data 
; Defining p as an instance of structure person (uninitialized)
p   person  <>
;;
; Defining p1 as an instance of structure person (initialized)
p1  person  <1, 45, <'Aman Ullah Khan'>> 
p2  person  {1, 45, {'Aman Ullah Khan'}}
p3  person  <2, 45, {'Aman Ullah Khan'}> 
;; Varibale store the Handle of the Demo file used in the example
DemoFileH   dd  ?
;; ********************************************************************
;; Code for the program                                               *
;; ********************************************************************
.code
start:

;; ********************************************************************
;; Display the Program menu
;; ********************************************************************

DispMenu:    
    cls                                         ; Clear Screen
    print OFFSET menu                           ; Display Menu
    mov eax, sval(input("Command choice ? "))   ; Read command number in EAX
    cmp eax, 0                                  ; if EAX == 0 then terminate program
    je  Terminate
    cmp eax, 1                                  ; if EAX == 1 then goto AddRecord
    je  AddRecord
    cmp eax, 2                                  ; if EAX == 2 then goto ListRecords
    je  ListRecords                             
    cmp eax, 3                                  ; if EAX == 3 then goto SearchRecord
    je  SearchRecord
    cmp eax, 4                                  ; if EAX == 4 then goto EditRecord
    je  EditRecord
    cmp eax, 5                                  ; if EAX == 5 then goto DeleteRecord
    je  DeleteRecord
    cmp eax, 9                                  ; if EAX == 9 then goto Initialize System
    je  InitSystem
    jmp DispMenu                                ; if EAX is not in [0-5,9], goto Display Menu

;; ********************************************************************   
;;  Terminate program Code
;; ********************************************************************

Terminate:
    exit

;; ********************************************************************
;;  Search Record Code
;; ********************************************************************

SearchRecord:
    inkey "Search Record: Under construction"
    jmp DispMenu

;; ********************************************************************
;; Edit Record Code    
;; ********************************************************************

EditRecord:
    inkey "Edit Record: Under construction"
    jmp DispMenu

;; ********************************************************************
;;  Deltet Record Code
;; ********************************************************************

DeleteRecord:
    inkey "Delete Record: Under construction"
    jmp DispMenu

;; ********************************************************************
;;  Init System Code
;; ********************************************************************

InitSystem:
    println  
    print "Are you sure to initialize the system [N / Y] ?"
    getkey
    cmp eax, nn
    je  NoInitSystem
    cmp eax, N
    je  NoInitSystem
    cmp eax, yy
    je InitializeSystem
    cmp eax, Y
    je InitializeSystem
    jmp InitSystem
InitializeSystem:
    mov DemoFileH, fcreate("Demo.dat")              ; Create Demo File and close it
    fclose DemoFileH
NoInitSystem:
    jmp DispMenu

;; ********************************************************************
;; List Records Code
;; ********************************************************************

ListRecords:
    ;Open file for reading, read records, print read record and close file
    mov DemoFileH, fopen("Demo.dat")
    print  " ID ", tab , " Age ", tab, " Name ", cr, lf
    print  "=====", tab, "=====", tab, "======", cr,lf
    xor ebx, ebx                                    ; Use EBX as record counter and set ebx = 0.
    mov eax, fread(DemoFileH, OFFSET p, SIZEOF p)   ; Read a record from demo file into record p
ReadRecord:
    cmp eax, 0                                      ; EAX = 0 if no record found or at eof
    je  EndOfFile
    printRecord p
    inc ebx                                         ; Increment record counter
    mov eax, fread(DemoFileH, OFFSET p, SIZEOF p)   ; Read a record from demo file into record p
    jmp ReadRecord
EndOfFile:
    fclose DemoFileH
    print "==============================================", cr,lf
    print "Number of Records = "
    print str$(ebx)
    print chr$(cr,lf, lf)
    inkey "Press any key to continue ..."
    jmp DispMenu
    
;; ********************************************************************
;;  Code to add a record to the File
;; ********************************************************************

AddRecord:
    ; Read the required information into record p
    mov p.Id, sval(input("Student Id ? "))
    mov p.Age, sval(input("Student Age ? "))
    print "Student Name ? "
    invoke StdIn, ADDR p.FirstName, bLen
    ; Open Demo.dat file
    mov DemoFileH, fopen("Demo.dat")
    ; Position the write pointer of Demo.dat file to EOF
    mov eax, fseek(DemoFileH,0,FILE_END)    ; Move to EOF 
    ; Write record to the Demo.dat file
    mov eax, fwrite(DemoFileH, OFFSET p, SIZEOF p)
    ; Close the file after writting
    fclose DemoFileH
    jmp DispMenu
;; ********************************************************************
    exit   
;; ********************************************************************

end start