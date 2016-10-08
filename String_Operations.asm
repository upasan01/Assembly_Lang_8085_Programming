.model small
.data       
	disp macro s1
        mov ah,09h
        lea dx,s1
        int 21h
        endm

	s1 db 10,13,"    ~~~~MENU~~~~$"
        s2 db 10,13,"1.Enter a string$"
        s3 db 10,13,"2.Display length of string$"
        s4 db 10,13,"3.Reverse the string$"
        s5 db 10,13,"4.Check palindrome$"
        s6 db 10,13,"5.Find number of words,capital letters,small letters$"
        s7 db 10,13,"6.Exit$"
        s8 db 10,13,"Enter a choice :$"
        s9 db 10,13,"Enter string :$"
        s10 db 10,13,"The length is :$"
        s11 db 10,13,"The reversed string is :$"
        s12 db 10,13,"Palindrome.$"
        s13 db 10,13,"Not palindrome.$"
	s14 db 10,13,"Number of words :$"
	s15 db 10,13,"Number of capital letters :$"
	s16 db 10,13,"Number of small letters :$"
        str1 db 20 dup('$')
        str2 db 20 dup('$')
        cnt db ?     
	words db ?   
	capital db 00h
	smallw db 00h

.code

        mov ax,@data
        mov ds,ax
        mov es,ax

start:  disp s1
        disp s2
        disp s3
        disp s4
 	disp s5	
 	disp s6
	disp s7
	disp s8  
    
        mov ah,01h
        int 21h

        cmp al,31h
        jz l1
        cmp al,32h
        jz l2
        cmp al,33h
        jz l3
        cmp al,34h
        jz l4
        cmp al,35h
        jz ll5
        cmp al,36h
        jz end2

;Accepting string
;----------------------
l1:     disp s9
                
        lea dx,str1
        mov ah,0Ah
        int 21h

        jmp start
;-----------------------

;Display length
;-----------------------
l2:     disp s10
        
	lea bx,str1
        inc bx 	       

        mov dl,[bx]
        add dl,30h
        cmp dl,39h
        jbe d8
        add dl,07h

d8:     mov ah,02h
        int 21h

        jmp start
;------------------------

;Reversing string
;------------------------
l3:     lea bx,str1
        inc bx 
        mov cx,[bx]
        mov ch,00h
        lea si,str1
        lea di,str2
        add si,cx
        add si,01h

d1:     lodsb
        stosb
        dec si
        dec si
        dec cl
        jnz d1        

        disp s11

        lea dx,str2
        mov ah,09h
        int 21h

        jmp start
;-------------------------
end2: jmp end1
ll5:  jmp l5

;Check palindrome
;-------------------------
l4:     lea bx,str1
        inc bx 
        mov cx,[bx]
        mov ch,00h
        mov cnt,cl

        lea si,str1
        lea di,str2
        add si,cx
        add si,01h

d7:     lodsb
        stosb
        dec si
        dec si
        dec cl
        jnz d7 

        mov cl,cnt
        lea si,str1
        inc si
        inc si
        lea di,str2

d4:     cmpsb
        jz d2
        jmp d3                  
        
d2:     dec cl
        jz d5
        jmp d4

d5:     disp s12
        
	jmp start

d3:     disp s13         

        jmp start
;---------------------------

;Display words,capital letters,small letters
;---------------------------
;Words
l5:    	lea si,str1
	inc si
	mov cl,[si]
	inc si        
        mov words,00h
        mov al,20h

d9:  	cmp [si],al	
        jne d10        
        inc words

d10: 	inc si
        dec cl
        jnz d9
        inc words
        
        disp s14

        mov dl,words
        add dl,30h
        mov ah,02h
        int 21h

;Capital letters  
        lea si,str1
	inc si
        mov cl,[si]
	inc si
        mov al,40h
        mov ah,5bh

d11: 	cmp [si],al
        jna d12
        cmp [si],ah
        jnb d12
        inc capital

d12:    inc si
        dec cl
        jnz d11
	
	disp s15
        
        mov dl,capital
        add dl,30h
        mov ah,02h
        int 21h

;Small letters
  	lea si,str1
	inc si
        mov cl,[si]
	inc si
        mov al,60h
        mov ah,7bh

d13: 	cmp [si],al
        jna d14
        cmp [si],ah
        jnb d14
        inc smallw
d14:
        inc si
        dec cl
        jnz d13

	disp s16
        
        mov dl,smallw
        add dl,30h
        mov ah,02h
        int 21h

        jmp start
;----------------------------
end1:   mov ah,4ch
        int 21h
end
