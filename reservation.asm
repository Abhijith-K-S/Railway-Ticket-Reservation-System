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
    ;strings
    welcomeString db 0ah,0dh,'Welcome to Railway Ticket Reservation System','$'
    trainAName db 0ah,0dh,'Train A'
    trainBName db 0ah,0dh,'Train B'
    trainCName db 0ah,0dh,'Train C'

    ;variables to store seating information
    trainASeats db 3 dup(?)
    trainBSeats db 3 dup(?)   
    trainCSeats db 3 dup(?)   
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
;print menu
menu:           

;choose train
chooseTrain:    ;load train:no into ah register

;choose class
chooseClass:    ;load class:no into al register

;display remaining seats no
;read no of seats to book
;on success, display ticket info
;       -> go to main menu
;       -> exit

;if no seats - provide option
;               -> go to class selection
;               -> go to main menu
;               -> exit

exit:           mov ah,4ch
                int 21h

code ends
end start
