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

    ;variables to store available seating information
    trainASeatsNumber db 3 dup(20)
    trainBSeatsNumber db 3 dup(20)   
    trainCSeatsNumber db 3 dup(20) 

    ;variables to display booked/unbooked seats
    trainASeats db 20 dup(0)  
    trainBSeats db 20 dup(0)
    trainCSeats db 20 dup(0)

    ;currently chosen items
    currentlyChosenTrain db ?
    currentlyChosenClass db ?
data ends
    
;macro to print strings    
printString macro arg
    lea dx,arg
    mov ah,09h
    int 21h
endm

;code segment
code segment
assume cs:code,ds:data
      
      start:    
                mov ax,data
                mov ds,ax

                printString welcomeString
                ;print menu
       menu:           

;choose train
chooseTrain:    ;load train:no into currentlyChosenTrain

;choose class
chooseClass:    ;load class:no into currentlyChosenClass

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

;procedure to read integer
readInt proc

ret
endp

;procedure to display seating
displaySeats proc

ret
endp

code ends
end start