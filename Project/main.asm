include \masm32\include\masm32rt.inc

.data
prompt db "Input a string: ",0
prompt2 db "Your string was: ",0
string db 50 dup(?)
.code

start:
push offset prompt 
call StdOut

push 50
push offset string
call StdIn

push offset prompt2
call StdOut
push offset string
call StdOut

end start