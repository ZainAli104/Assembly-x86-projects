include \masm32\include\masm32rt.inc

cr equ 13
lf equ 10

.data

students dd 100 dup(?)  ; Array to store student records
count dd 0              ; Counter for the number of students in the array
name db 50 dup(?)       ; Buffer for student name
age db 2 dup(?)         ; Buffer for student age

.code
start:
    invoke ClearScreen
    mov ebx,OFFSET students
    mov esi,OFFSET count

menu:
    invoke PrintString,OFFSET menu_text
    invoke ReadInt,esi
    cmp [esi],1
    je add_student
    cmp [esi],2
    je list_students
    cmp [esi],3
    je exit
    jmp menu

add_student:
    invoke PrintString,OFFSET name_prompt
    invoke ReadString,OFFSET name,50
    invoke PrintString,OFFSET age_prompt
    invoke ReadString,OFFSET age,2
    invoke Atoi,OFFSET age
    invoke AddStudent,ebx,esi,OFFSET name,eax
    jmp menu

list_students:
    mov ecx,[esi]   ; Load the count of students into ecx
    mov edi,0       ; Initialize an index for the loop

print_loop:
    cmp edi,ecx   ; Check if we have reached the end of the array
    je print_done

    ; Print the details of the student at index edi
    mov eax,[ebx+edi*8]  ; Load the student's age into eax
    invoke PrintInt,eax
    invoke PrintString,OFFSET age_separator
    mov eax,[ebx+edi*8+4]  ; Load the address of the student's name into eax
    invoke PrintString,eax
    invoke PrintString,OFFSET crlf
    inc edi       ; Increment the index
    jmp print_loop

print_done:
    ; Code to return to the menu
    jmp menu

exit:
    invoke ExitProcess,0

; Functions

AddStudent proc student_array:ptr,count:ptr,name:ptr,age:dword
    ; Code to add a student record to the array and increment the count
    ret
AddStudent endp

end start
