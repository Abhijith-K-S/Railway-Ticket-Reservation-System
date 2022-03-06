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
    newlineString db 0ah,0dh,' $'  
    welcomeString db 0ah,0dh,'Welcome to Railway Ticket Reservation System','$'   

    ;train menu
    trainMenuString db 0ah,0dh,'Please Select a Train to Book Tickets: $' 
    trainSelection db 0ah,0dh,'Enter Train number: $'                     
    trainAName db 0ah,0dh,'1: Train A $'
    trainBName db 0ah,0dh,'2: Train B $'
    trainCName db 0ah,0dh,'3: Train C $' 

    ;class menu         
    classMenuString db 0ah,0dh,'Please select a class  $'     
    classSelection db 0ah,0dh,'Select a class: $'
    classAName db 0ah,0dh,'1: CLASS A $' 
    classBName db 0ah,0dh,'2: CLASS B $'
    classCName db 0ah,0dh,'3: CLASS C $'  
    
    ;error message
    errorString db 0ah,0dh,'INVALID OPTION.PLEASE TRY AGAIN!!!$'
   
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
      
start:          mov ax,data
                mov ds,ax
;print menu
menu:           printString welcomeString  
                printString newlineString

;train menu
                printString trainMenuString  
                printString newlineString  
                printString trainAName
                printString newlineString
                printString trainBName
                printString newlineString 
                printString trainCName  
chooseTrain:    printString newlineString 
                printString trainSelection             


                call readInt                
;check for errors
                cmp al,04h
                jc noErrorTrain
                printString newlineString
                printString errorString
                jmp chooseTrain

;choose class
 noErrorTrain:  mov currentlyChosenTrain,al
                
                printString newlineString
                printString classMenuString  
                printString newlineString  
                printString classAName
                printString newlineString
                printString classBName
                printString newlineString 
                printString classCName  
chooseClass:    printString newlineString 
                printString classSelection 
           
                call readInt
;check for errors 
                cmp al,04h
                jc noErrorClass
                printString newlineString
                printString errorString
                jmp chooseClass
  
           
noErrorClass:   mov currentlyChosenClass,al

                printString newlineString
                call displaySeats

exit:           mov ah,4ch
                int 21h 
                

;procedure to read integer
readInt proc   
    mov ah,01h
    int 21h
    sub al,30h
    cmp al,09h
    jc rn
    jz rn
    sub al,07h
 rn:ret
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
                add si,14h
                jmp chooseOver

classCChosen:   add si,28h

chooseOver:     mov di,si
                inc di
                mov ch,02h

nextrow:        mov cl,0ah

;display the seats
disploop1:      cmp [si],00h
                jnz booked
                mov dl,'-'
                jmp show

booked:         mov dl,'X'

;show '-' if not booked and 'X' if booked
show:           mov ah,02h
                int 21h

                mov dl,' '
                mov ah,02h
                int 21h

                add si,02h
                dec cl
                jnz disploop1

                printString newlineString

                mov si,di
                dec ch
                jnz nextrow
ret
endp

code ends
end start
     
     
     
