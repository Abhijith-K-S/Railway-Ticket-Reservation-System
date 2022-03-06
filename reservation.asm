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
    trainASeats db 60 dup(0)  
    trainBSeats db 60 dup(0)
    trainCSeats db 60 dup(0)

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
                printNewline
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
;load the appropriate location into si
trainAChosen:   cmp currentlyChosenTrain,01h
                jnz trainBChosen
                lea si,trainASeats
                jmp classAChosen

trainBChosen:   cmp currentlyChosenTrain,02h
                jnz trainCChosen
                lea si,trainBSeats
                jmp classAChosen

trainCChosen:   lea si,trainCSeats
                
classAChosen:   cmp currentlyChosenClass,01h
                jnz classBChosen
                jmp chooseOver

classBChosen:   cmp currentlyChosenClass,02h
                jnz classCChosen
                add si,20h
                jmp chooseOver

classCChosen:   add si,40h

chooseOver:     mov di,si
                inc di
                mov ch,02h

nextrow:        mov cl,0ah

;display the seats
   disploop1:   cmp [si],00h
                jnz booked
                mov dl,'-'
                jmp show

      booked:   mov dl,'X'

;show '-' if not booked and 'X' if booked
        show:   mov ah,02h
                int 21h

                mov dl,' '
                mov ah,02h
                int 21h

                add si,02h
                dec cl
                jnz disploop1

                mov si,di
                dec ch
                jnz nextrow
ret
endp

code ends
end start