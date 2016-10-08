.model small

.data
        disp macro msg
        mov ah,09h
        lea dx,msg
        int 21h
        endm

        fname db 20 dup ('$')
        nname db 20 dup ('$')
        msg1 db 10,13,'File successfully created :$'
        msg2 db 10,13,'**** Menu ****$'
        msg3 db 10,13,'1.Create$'
        msg4 db 10,13,'2.Open$'
        msg5 db 10,13,'3.Read$'
        msg6 db 10,13,'4.Write$'
        msg7 db 10,13,'5.Rename$'
        msg8 db 10,13,'6.Copy$'
        msg9 db 10,13,'7.Delete$'
        msg10 db 10,13,'8.Close$'
        msg11 db 10,13,'9.Exit$'       
        msg12 db 10,13,'Enter your choice :$'
        msg13 db 10,13,'File successfully opened :$'
        msg14 db 10,13,'File doesnt exist :$'
        msg15 db 10,13,'Read error$'
        msg16 db 10,13,'Enter data :$'
        msg17 db 10,13,'Data :$'
        msg18 db 10,13,'New name :$'
        msg19 db 10,13,'Rename successful$'
        msg20 db 10,13,'Rename error$'
        msg21 db 10,13,'Delete successful$'
        msg22 db 10,13,'Delete error$'
        msg23 db 10,13,'File closed$'
        msg24 db 10,13,'Close error$'
        fptr dw ?
        nfptr dw ?
        temp db ?
        temp1 dw ?
        data db 20 dup('$')           


.code

        mov ax,@data
        mov ds,ax

        mov ah,62h
        int 21h

        mov es,bx

        mov cx,[es:0080h]
        mov ch,00h

        lea di,fname
        mov si,0082h

l1:     mov dl,[es:si]
        mov [di],dl
        inc si
        inc di
        dec  cx
        jnz l1
        
        dec di
        mov cl,00h
        mov [di],cl

start:  disp msg2
        disp msg3
        disp msg4
        disp msg5
        disp msg6
        disp msg7
        disp msg8
        disp msg9
        disp msg10
        disp msg11
        disp msg12
       
        mov ah,01h
        int 21h

        sub al,30h

        cmp al,01h
         jz p1
        cmp al,02h
         jz p2
        cmp al,03h
         jz p3
        cmp al,04h
         jz p44
        cmp al,05h
         jz p55
        cmp al,06h
         jz p66
        cmp al,07h
         jz p77
        cmp al,08h
         jz p88
        cmp al,09h
        jz end11
        jmp start

;Create
;-------------------

p1 :    lea dx,fname
        mov ah,3ch
        mov cx,00h
        int 21h

        mov fptr,ax
        disp msg1                                                                        
        disp fname
        jmp start
;--------------------

;Open file
;--------------------
p2  :   lea dx,fname       

        mov ah,3Dh
        mov al,02h
        int 21h
        mov fptr,ax

        jnc p21
        disp msg14
        disp fname
        jmp start

p21 :   disp msg13
        disp fname
        jmp start

;--------------------

 end11: jmp end1
 p44:   jmp p4
 p55:   jmp p5
 p77:   jmp p7
 p66:   jmp p6
 p88: jmp p8

;Read from file
;--------------------
p3:     disp msg17
p33:    lea dx,data
        mov ah,3fh
        mov bx,fptr
        mov cx,01
        int 21h
        cmp ax,00h
        jnz p333 
        jc p31
        jmp p32
p333:   disp data
        jmp p33
p32:    jmp start

p31:    disp msg15
        jmp start

        
;-------------------- 
  
;Write file
;--------------------
p4:     disp msg16

        mov ah,0Ah
        lea dx,data
        int 21h

        lea dx,data
        inc dx
        mov si,dx
        mov cx,[si]
        mov ch,00h
        inc dx
        
        mov ah,40h
        mov bx,fptr
        int 21h

        jmp start
;---------------------

;Rename file
;---------------------
p5:    mov ax,@data
       mov es,ax
       disp msg18
       lea dx,nname
       mov ah,0Ah
       int 21h

       lea dx,fname
       mov cl,[nname+1]
       mov ch,00h
       lea di,nname+2
       add di,cx
       mov [di],ch
       sub di,cx

       mov ah,56h
       int 21h

       jnc p51
       disp msg20
       jmp start

p51:   disp msg19
       jmp start

;---------------------

;Delete file
;---------------------
p7:     lea dx,fname
        mov ah,41h
        int 21h

        jnc p71
        disp msg22
        jmp start

p71:    disp msg21
        jmp start

;---------------------
;Copy file
;---------------------
p6:     disp msg18
        lea dx,nname
        mov ah,0Ah
        int 21h

        mov cl,[nname+1]
        mov ch,00h
        lea di,nname+2
        add di,cx
        mov [di],ch
        sub di,cx

p61 :   mov dx,di
        mov ah,3ch
        mov cx,00h
        int 21h

        mov nfptr,ax                                                          
       

p62:    lea dx,data
        mov ah,3fh
        mov bx,fptr
        mov cx,01
        int 21h
        cmp ax,00h
        jnz p63
        jmp p64
               
p63:    mov cx,01
        lea dx,data
        mov ah,40h
        mov bx,nfptr
        int 21h
        jmp p62

p64:    jmp start
                
;---------------------

;Close file
;---------------------
p8:     mov bx,fptr
        mov ah,3eh
        int 21h

        jnc p81
        disp msg24
        jmp start

p81:    disp msg23
        jmp start
;---------------------
end1:   mov ah,4ch
        int 21h 

end
