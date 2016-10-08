.model small
.data
        disp macro msg1
        mov ah,09h
        lea dx,msg1
        int 21h
        endm

        no1 db ?
        no2 db ?
	tot dw 00h
        msg1 db 10,13,'Enter 1st number :$'
        msg2 db 10,13,'Enter 2nd number :$'
	msg3 db 10,13,'Multiplication result :$'         
        count1 db 00h
.code
        mov ax,@data
        mov ds,ax

        disp msg1
        mov ch,02h
        mov cl,04h
	mov bl,00h

l1:     mov ah,01h
        int 21h
        sub al,30h
        add bl,al
        rol bl,cl
        mov cl,00h
        dec ch
        jnz l1
        mov no1,bl
      

        disp msg2
        mov bl,00h
        mov ch,02h
        mov cl,04h

l2:     mov ah,01h
        int 21h
        sub al,30h
        add bl,al
        rol bl,cl
        mov cl,00h
        dec ch
        jnz l2

        mov no2,bl

 	mov dh,00h
   	mov dl,no1
    	mov al,no2
    	mov count1,08h
    	mov cl,00h

l3: 	mov bl,al
    	and bl,01h
    	mov dh,00h
    	mov dl,no1    

    	cmp bl,00h
    	je l4
    	shl dx,cl
    	add tot,dx
    	jmp l5

l4:    	shl dx,cl

l5:   	mov es,tot
    	shr al,01h
    	inc cl
    	dec count1
    	jnz l3

    	disp msg3
    	mov ax,tot
    	mov cl,04h
    	mov ch,04h
    	rol tot,cl

l6: 	mov bx,tot
    	and bx,000fh
   	mov dl,bl
    	cmp dl,0Ah
    	jb l7
    	add dl,07h

l7:	add dl,30h
   	mov ah,02h
    	int 21h
    	rol tot,cl
    	dec ch
    	jnz l6    	      
        
        mov ah,4ch
        int 21h
end
