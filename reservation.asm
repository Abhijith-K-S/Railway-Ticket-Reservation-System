;/////////////////////////////////////////////////////////////
;Railway Ticket Reservation System using 8086 microprocessor
;
;Done by:
;   -> Abhijith K S
;   -> Jayasankar J N
;   -> Rohit Prakash
;   -> Sreehari M S
;
;/////////////////////////////////////////////////////////////

;data segment
data segment
    welcomeString db 0ah,0dh,'Welcome to Railway Ticket Reservation System','$'
data ends

    
;macro to print strings    
printString macro arg
    lea dx,arg
    mov ah,09h
    int 21h
endm

;code segment
code segment

start: printString welcomeString

mov ah,21h

code ends
end start
