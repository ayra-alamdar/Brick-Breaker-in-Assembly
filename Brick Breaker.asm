.model small
.stack 0100h
.data

dartScreeen db "                                              $"

strr1 db "Enter your name:", '$'
strr2 db 50 dup('$')		;for taking input of name of the user
strr3 db "Press enter key after entering name.", '$'
str1 db "BRICK BREAKER GAME$"
str2 db "1. Start a new game$"
str3 db "2. Instructions$"
str4 db "3. Leaderboard$"
str5 db "4. Exit$"
str6 db 09H,"Instructions: ",0AH,"$"
str7 db 09H,"Ayra Alamdar 21i-2968",0AH,"$"
str8 db 09H,"Naima Zafar 21i-0642",0AH,"$"
str9 db 09H,09H,"Level 1:",0AH,"$"
str10 db 09H,"1. In the begning, your ball should directly hit to the bricks",0AH,"$"
str11 db 09H,"2. The brick will disapper and your score is increased accordingly.",0AH,"$"
str12 db 09H,"3. You can move the paddle with the help of left and right keys to keep the ball from falling.",0AH,"$"
str13 db 09H, "4. If the ball falls, your lives will decrease.",0AH,"$"
str14 db 09H,"5. Remember! each brick has different score.",0AH,"$"
str15 db 09H,09H,"Level 2:",0AH,"$"
str16 db 09H,"1. Speed will increase.",0AH,"$"
str17 db 09H,"2. Paddle length will decrease.",0AH,"$"
str18 db 09H,"3. Each brick will require 2 hits to disapper.",0AH,"$"
str19 db 09H,09H,"Level 3:",0AH,"$"
str20 db 09H,"1. Some bricks are fixed and can not disapper after hits.",0AH,"$"
str21 db 09H,"2. Each brick will require 3 hits to disapper.",0AH,"$"
str22 db 09H,"3. Speed of ball is increased.",0AH,"$"
;;--------> 0Ah is like endl in assembly
;;--------> 09h is Tab in assembly
s1 dw 10    ;;needs to be set back everytime
temp db 0
s11 dw 10
s2 dw 35
cx1 dw 00
c1 dw 00
d1 dw 00
color db 4H
tempo dw 0
temp2 dw 0
temp1 dw 0
temp3 dw 0
ss1 dw 100
ss2 dw 150
tempp db 0
tempp2 db 0
ball db "0000B0000000BBB00000BBBBB0000BBBBB00000BBB0000000B0000"
row dw 0
col dw 0
count dw 0
;;-----------for line
line1 dw 10
templine db 0
disp1 db "Score:", '$'
disp2 db "Level:", '$'
disp3 db "Name:", '$'
xpadel dw 125
ypadel dw 190
pink db 15
red db 10
yellow db 5
blue db 5
green db 5
;;;file handling for score 
score db "$", 0
handle dw 0

text db "1$"
bytes dw 2
buffer db 2 dup (?)
noofbytes dw 2
;;;file handling for level
level db "level.txt", 0
hndle dw 0
txt db "1$"
byts dw 2
bufer db 2 dup (?)
nofbytes dw 2
;;;file handling for highscore
hscore db "highscore.txt", 0
hndl dw 0
txts db "1$"
byt dw 2
bfer db 2 dup (?)
nbytes dw 2
ballx dw 150
bally dw 150
ballcolor db 1
ss1_temp dw 1
ss2_temp dw 1


lvl1 db "1 - Level 1         $"
lvl2 db "2 - Level 2         $"
lvl3 db "3 - Level 3         $"




heart_number dw 3

scorecount db 0
scorecounttemp db "00$"
autopedal db 'm'

stage db 3	;edit this to change level number
stagetemp db 2 dup ('$')

collision db 0

r1b1 db 1
r1b2 db 1
r1b3 db 1
r1b4 db 1
r1b5 db 1
r1b6 db 1
r1b7 db 1

r2b1 db 1
r2b2 db 1
r2b3 db 1
r2b4 db 1
r2b5 db 1
r2b6 db 1
r2b7 db 1

r3b1 db 1
r3b2 db 1
r3b3 db 1
r3b4 db 1
r3b5 db 1
r3b6 db 1
r3b7 db 1

r4b1 db 1
r4b2 db 1
r4b3 db 1
r4b4 db 1
r4b5 db 1
r4b6 db 1
r4b7 db 1

r5b1 db 1
r5b2 db 1
r5b3 db 1
r5b4 db 1
r5b5 db 1
r5b6 db 1
r5b7 db 1

.code

defaulting proc
	mov s11, 10
		mov s2, 35
		mov cx1, 0
		mov d1, 0
		mov c1, 0
		mov color, 4h
		mov tempo, 0
		mov temp2, 0
		
		mov tempp, 0
		mov tempp2, 0
		mov row, 0
		mov col, 0
		mov count,0
		
	ret
defaulting endp

bgcolor1 proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "BACKGROUND COLOUR"

	mov ah, 06h
	mov al, 0			;scroll line
	mov cx, 0			;x-axis
	mov dh, 80			;y-axis
	mov dl, 80
	mov bh, 0h		;background and foreground colour
	int 10h
ret
bgcolor1 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
input proc
	mov ah, 02h
	mov bx, 0
	mov dh, 8		;x-axis
	mov dl, 11		;y-axis
	int 10h
	
	;to control info on the terminal and inputs(use dx and dl)
	lea dx, strr1		;for displaying stuff on the terminal
	mov ah, 09h
	int 21h
	
		mov ah, 02h
		mov bx, 0
		mov dh, 17		;y-axis
		mov dl, 3		;x-axis
		int 10h
		
		;to control info on the terminal and inputs(use dx and dl)
		lea dx, strr3		;for displaying stuff on the terminal
		mov ah, 09h
		int 21h
		
		mov ah, 0Ch
		mov al, 0Ch
		mov dx, 110
		mov cx, 100
		int 10h

		l1:
		inc cx
		int 10h
		inc templine
		inc line1
		cmp templine, 100
		jne l1
		
	mov si, offset strr2
		Lab:
		mov ah, 00
		int 16h			;video mode interupt for input
		;printable keys get saved in al
		.if al == 13	;13 is ascii of enter key(non printable)
		
		jmp finish
		.endif		;closing bracket of if
		mov [si], al		;will take only one character
		inc si
		
		
		mov ah, 02h
		mov bx, 0
		mov dh, 12		;y-axis
		mov dl, 16		;x-axis
		int 10h
		
		lea dx, strr2
		mov ah, 09h
		int 21h
		
		jmp Lab		;to take input of next characters
		finish:
		
		
ret
input endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bgcolor3 proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "BACKGROUND COLOUR"

	mov ah, 06h
	mov al, 0			;scroll line
	mov cx, 0			;x-axis
	mov dh, 80			;y-axis
	mov dl, 80
	mov bh, 0h		;background and foreground colour
	int 10h
ret
bgcolor3 endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

instruction proc
;trying somethin

	mov ah, 00h		;for pixel starting 
	mov al, 12h		;video mode
	int 10h		;video graphics
	
	call bgcolor3
		mov ah, 02h
		mov dh, 1		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str6
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 3		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str7
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 4		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str8
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 6		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str9
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 8		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str10
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 9		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str11
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 10		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str12
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 12		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str13
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 13		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str14
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 15		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str15
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 17		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str16
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 18		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str17
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 19		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str18
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 21		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str19
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 23		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str20
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 24		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str21
		mov ah, 09h
		int 21h

		mov ah, 02h
		mov dh, 25		;y-axis
		mov dl, 1		;x-axis
		int 10h

		lea dx, str22
		mov ah, 09h
		int 21h

		mov ah,00h
		int 16h
		;? finally
		ret
instruction endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


beep proc
        push ax
        push bx
        push cx
        push dx
        mov     al, 182        
        out     43h, al      
        mov     ax, 400     
                              
        out     42h, al       
        mov     al, ah      
        out     42h, al 
        in      al, 61h      
                            
        or      al, 00000011b
        out     61h, al       
        mov     bx, 2    
pause1:
        mov     cx, 65535
pause2:
        dec     cx
        jne     pause2
        dec     bx
        jne     pause1
        in      al, 61h     
                         
        and     al, 11111100b  
        out     61h, al       

        pop dx
        pop cx
        pop bx
        pop ax

ret
beep endp

bgcolor2 proc 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "BACKGROUND COLOUR"
	mov ah, 00h		;for pixel starting 
	mov al, 13h
	int 10h		;video graphics

	mov ah, 06h
	mov al, 0			;scroll line
	mov cx, 0			;x-axis
	mov dh, 80			;y-axis
	mov dl, 80
	mov bh, 0h		;background and foreground colour
	int 10h
	ret 
bgcolor2 endp 

menu proc 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "BRICK BREAKER GAME" string
	; mov ah, 00h		;for pixel starting 
	; mov al, 13h
	; int 10h

	mov ah, 02h
	mov bx, 0
	mov dh, 1		;y-axis
	mov dl, 33		;x-axis
	int 10h
	
	lea dx, strr2
	mov ah, 09h
	int 21h
	
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0

	mov ah, 02h
	mov dh, 6		;y-axis
	mov dl, 10		;x-axis
	int 10h

	lea dx, str1
	mov ah, 09h
	int 21h
	
	mov line1, 10
	mov templine, 0

	mov ah, 0Ch
	mov al, 02h
	mov dx, 60
	mov cx, 80
	int 10h

	l1:
		inc cx
		int 10h
		inc templine
		inc line1
		cmp templine, 145
	jne l1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "1.START A NEW GAME"

	
	mov ah, 02h
	mov dh, 10		;y-axis
	mov dl, 9		;x-axis
	int 10h

	lea dx, str2
	mov ah, 09h
	int 21h

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "2.INSTRUCTIONS"

	mov ah, 02h
	mov dh, 13		;y-axis
	mov dl, 9		;x-axis
	int 10h

	lea dx, str3
	mov ah, 09h
	int 21h

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "3.LEADERBOARD"

	mov ah, 02h
	mov dh, 16		;y-axis
	mov dl, 9		;x-axis
	int 10h

	lea dx, str4
	mov ah, 09h
	int 21h

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "4.Exit"

	mov ah, 02h
	mov dh, 19		;y-axis
	mov dl, 9		;x-axis
	int 10h

	lea dx, str5
	mov ah, 09h
	int 21h
	ret
menu endp 


levelmenu proc 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "BRICK BREAKER GAME" string
	; mov ah, 00h		;for pixel starting 
	; mov al, 13h
	; int 10h

	mov ah, 02h
	mov bx, 0
	mov dh, 1		;y-axis
	mov dl, 33		;x-axis
	int 10h
	
	lea dx, strr2
	mov ah, 09h
	int 21h
	
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0

	mov ah, 02h
	mov dh, 6		;y-axis
	mov dl, 10		;x-axis
	int 10h

	lea dx, str1
	mov ah, 09h
	int 21h
	
	mov line1, 10
	mov templine, 0

	mov ah, 0Ch
	mov al, 02h
	mov dx, 60
	mov cx, 80
	int 10h

	l1:
		inc cx
		int 10h
		inc templine
		inc line1
		cmp templine, 145
	jne l1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "1.START A NEW GAME"
	
	
	mov ah, 02h
	mov dh, 10		;y-axis
	mov dl, 9		;x-axis
	int 10h

	lea dx, lvl1
	mov ah, 09h
	int 21h

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "2.INSTRUCTIONS"

	mov ah, 02h
	mov dh, 13		;y-axis
	mov dl, 9		;x-axis
	int 10h

	lea dx, lvl2
	mov ah, 09h
	int 21h

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;for "3.LEADERBOARD"

	mov ah, 02h
	mov dh, 16		;y-axis
	mov dl, 9		;x-axis
	int 10h

	lea dx, lvl3
	mov ah, 09h
	int 21h

	


	ret
levelmenu endp 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "BORDOR"
border proc 

	mov bx, 0
	mov ah, 0Ch
	mov al, 3h
	mov cx, 60
	mov dx, 30

	l1:
	inc cx
	int 10h
	inc s1
	inc temp
	cmp temp, 200
	jne l1

	mov s1, 10
	mov temp, 0

	l3:
	inc dx
	int 10h
	inc s1
	inc temp
	cmp temp, 150
	jne l3

	mov s1, 10
	mov temp, 0

	l4:
	dec cx
	int 10h
	inc s1
	inc temp
	cmp temp, 200
	jne l4 

	mov s1, 10
	mov temp, 0

	l2:
	dec dx
	int 10h
	inc s1
	inc temp
	cmp temp, 150
	jne l2;; constant loop i presed multiple keys aside from 1 2 3 4 so game didn't stop unless i pressed 4
	;;thus making your game continue till it is specifically told to stop :)
	
	mov s1,10
	mov temp,0
	ret
border endp 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "BORDOR"
border2 proc 

	mov bx, 0
	mov ah, 0Ch
	mov al, 4h
	mov cx, 50
	mov dx, 20
	mov temp, 0
	mov s1, 5
	

	l1:
	inc cx
	int 10h
	inc s1
	inc temp
	cmp temp, 200
	jne l1

	mov s1, 5
	mov temp, 0

	l3:
	inc dx
	int 10h
	inc s1
	inc temp
	cmp temp, 150
	jne l3

	mov s1, 5
	mov temp, 0

	l4:
	dec cx
	int 10h
	inc s1
	inc temp
	cmp temp, 200
	jne l4 

	mov s1, 5
	mov temp, 0

	l2:
	dec dx
	int 10h
	inc s1
	inc temp
	cmp temp, 150
	jne l2;; constant loop i presed multiple keys aside from 1 2 3 4 so game didn't stop unless i pressed 4
	;;thus making your game continue till it is specifically told to stop :)
	
	mov s1,10
	mov temp,0
	ret
border2 endp 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "TILES OF GAMEPLAY"
tile proc
	mov c1,ax
	mov cx1,ax
	mov d1,bx
	push s11
	mov al,color
	mov cx,s11
	
		loop1:
		 mov tempo,cx
		 mov cx,s2
		 loop2:
			mov temp2,cx
			mov ah, 0Ch
			mov al,color
			mov cx, c1		;starts from 30
			mov dx, d1
			int 10h
			inc c1
			mov cx,temp2
		 loop loop2
		 mov ax,cx1
		 mov c1,ax
		 inc d1
		 mov cx,tempo
		loop loop1
		
		
		mov tempo,0
		mov temp2,0
		mov d1,0
		mov c1,0
		mov cx,0
		pop s11
	ret
tile endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "Padel display"
padle proc
mov c1, ax
mov cx1, ax
mov d1, bx
mov al, color
mov cx, s11
loop3:
	mov temp1, cx
	mov cx, s2
	loop4:
		mov temp3, cx
		mov ah, 0Ch
		mov al, color
		mov cx, c1
		mov dx, d1
		int 10h
		inc c1
		mov cx, temp3
	loop loop4
	mov ax, cx1
	mov c1, ax
	inc d1
	mov cx, temp1
	loop loop3
ret 
padle endp


padleremove proc
mov c1, ax
mov cx1, ax
mov d1, bx
mov al, color
mov cx, 5
loop3:
	mov temp1, cx
	mov cx, 3
	loop4:
		mov temp3, cx
		mov ah, 0Ch
		mov al, color
		mov cx, c1
		mov dx, d1
		int 10h
		inc c1
		mov cx, temp3
	loop loop4
	mov ax, cx1
	mov c1, ax
	inc d1
	mov cx, temp1
	loop loop3
ret 
padleremove endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "BALL PROC 1"
; tile2 proc
	; mov cx,s11
	; mov dx,s2
	
	
	; outter:
		; L1:	
			; inc cx 
			; int 10h
			; inc tempp
		; .if tempp <= 20
			; jmp L1
		; .endif	
		
		; inc dx
		
		; L2:	
			; dec cx 
			; int 10h
			; dec tempp
		; .if tempp > 0
			; jmp L2
		; .endif
		; inc tempp2
	; .if tempp2!=6
		; mov tempp,1 ;
		; jmp outter
	; .endif
	
	; mov tempp,0
	; mov tempp2,0	
; ret
; tile2 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "BALL PROC 2"

; balltile proc
	; mov cx,ss1
	; mov dx,ss2
	
	
	; outter:
		; L1:	
			; inc cx 
			; int 10h
			; inc tempp
		; .if tempp <= 20
			; jmp L1
		; .endif	
		
		; inc dx
		
		; L2:	
			; dec cx 
			; int 10h
			; dec tempp
		; .if tempp > 0
			; jmp L2
		; .endif
		; inc tempp2
	; .if tempp2!=6
		; mov tempp,1 ;
		; jmp outter
	; .endif
	
	; mov tempp,0
	; mov tempp2,0	
; ret
; balltile endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "BALL PROC 3"

makeball proc
	mov count, 0
	mov row, 0
	j1:
		mov col, 0
		j2:
			mov bx, count
			cmp ball[bx], 66
			jne next
			mov cx, ballx
			mov dx, bally
			add cx, row
			add dx, col
			mov ah, 0ch
			mov al, ballcolor
			int 10h
			next:
			inc count
			inc col
			cmp col, 9
		jne j2
		inc row
		cmp row, 6
	jne j1			
ret
makeball endp

delay proc
	
	mov cx,0FFFFH
	
	L1:
	loop L1
	
	ret
delay endp

ball_thing proc


	
	mov ballcolor,0
	call makeball
	
	mov al,0
	mov collision,al
	

	push ax
	mov ax,ss1_temp
	add ballx ,ax
	pop ax
	;row 5
	call defaulting
	.if (r5b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 105 && bally <= 115)
	call beep

	neg ss1_temp
	mov ax, 260
	mov bx, 105
	mov color, 0h
	call tile
	dec r5b7
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	
	.endif
	.endif

	.if (r5b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 105 && bally <= 115)
	call beep
	neg ss1_temp
	mov ax, 220
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b6
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r5b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 105 && bally <= 115)
	call beep
	neg ss1_temp
	mov ax, 180
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b5
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1

	.endif
	.endif

	.if (r5b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 105 && bally <= 115)
	call beep
	neg ss1_temp
	mov ax, 140
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b4
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r5b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 105 && bally <= 115)
	call beep
	neg ss1_temp
	mov ax, 100
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b3
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r5b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 105 && bally <= 115)
	call beep
	neg ss1_temp
	mov ax, 60
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b2
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	.if (r5b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 105 && bally <= 115)
	call beep
	neg ss1_temp
	mov ax, 20
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b1
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	;row 4
	
	call defaulting
	.if (r4b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 90 && bally <= 100)
	call beep
	neg ss1_temp
	mov ax, 260
	mov bx, 90
	mov color, 0h
	call tile
	
	dec r4b7
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r4b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 90 && bally <= 100)
	call beep
	neg ss1_temp
	mov ax, 220
	mov bx, 90
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r4b6
	inc scorecount
	.endif
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r4b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 90 && bally <= 100)
	call beep
	neg ss1_temp
	mov ax, 180
	mov bx, 90
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r4b5
	inc scorecount
	.endif
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r4b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 90 && bally <= 100)
	call beep
	neg ss1_temp
	mov ax, 140
	mov bx, 90
	mov color, 0h
	call tile
	dec r4b4
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r4b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 90 && bally <= 100)
	call beep
	neg ss1_temp
	mov ax, 100
	mov bx, 90
	mov color, 0h
	call tile
	
	.if (stage!=3)
	dec r4b3
	inc scorecount
	.endif
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r4b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 90 && bally <= 100)
	call beep
	neg ss1_temp
	mov ax, 60
	mov bx, 90
	mov color, 0h
	call tile
	
	dec r4b2
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	.if (r4b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 90 && bally <= 100)
	call beep
	neg ss1_temp
	mov ax, 20
	mov bx, 90
	mov color, 0h
	call tile
	
	dec r4b1
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	
	;row 3
	
	call defaulting
	.if (r3b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 75 && bally <= 85)
	call beep
	neg ss1_temp
	mov ax, 260
	mov bx, 75
	mov color, 0h
	call tile
	
	dec r3b7
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r3b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 75 && bally <= 85)
	call beep
	neg ss1_temp
	mov ax, 220
	mov bx, 75
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r3b6
	inc scorecount
	.endif
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r3b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 75 && bally <= 85)
	call beep
	neg ss1_temp
	mov ax, 180
	mov bx, 75
	mov color, 0h
	call tile
	dec r3b5
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r3b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 75 && bally <= 85)
	call beep
	neg ss1_temp
	mov ax, 140
	mov bx, 75
	mov color, 0h
	call tile
	
	dec r3b4
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r3b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 75 && bally <= 85)
	call beep
	neg ss1_temp
	mov ax, 100
	mov bx, 75
	mov color, 0h
	call tile
	dec r3b3
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r3b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 75 && bally <= 85)
	call beep
	neg ss1_temp
	mov ax, 60
	mov bx, 75
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r3b2
	inc scorecount
	.endif
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	.if (r3b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 75 && bally <= 85)
	call beep
	neg ss1_temp
	mov ax, 20
	mov bx, 75
	mov color, 0h
	call tile
	
	dec r3b1
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	
	;row 2
	
	call defaulting
	.if (r2b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 60 && bally <= 70)
	call beep
	neg ss1_temp
	mov ax, 260
	mov bx, 60
	mov color, 0h
	call tile
	
	dec r2b7
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r2b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 60 && bally <= 70)
	call beep
	neg ss1_temp
	mov ax, 220
	mov bx, 60
	mov color, 0h
	call tile
	
	dec r2b6
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r2b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 60 && bally <= 70)
	call beep
	neg ss1_temp
	mov ax, 180
	mov bx, 60
	mov color, 0h
	call tile
	
	dec r2b5
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r2b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 60 && bally <= 70)
	call beep
	neg ss1_temp
	mov ax, 140
	mov bx, 60
	mov color, 0h
	call tile
	
	dec r2b4
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r2b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 60 && bally <= 70)
	call beep
	neg ss1_temp
	mov ax, 100
	mov bx, 60
	mov color, 0h
	call tile
	
	dec r2b3
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r2b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 60 && bally <= 70)
	call beep
	neg ss1_temp
	mov ax, 60
	mov bx, 60
	mov color, 0h
	call tile
	
	dec r2b2
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	.if (r2b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 60 && bally <= 70)
	call beep
	neg ss1_temp
	mov ax, 20
	mov bx, 60
	mov color, 0h
	call tile
	
	dec r2b1
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	
	
	;row 1
	
	call defaulting
	.if (r1b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 45 && bally <= 55)
	call beep
	neg ss1_temp
	mov ax, 260
	mov bx, 45
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r1b7
	inc scorecount
	.endif
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r1b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 45 && bally <= 55)
	call beep
	neg ss1_temp
	mov ax, 220
	mov bx, 45
	mov color, 0h
	call tile
	
	dec r1b6
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r1b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 45 && bally <= 55)
	call beep
	neg ss1_temp
	mov ax, 180
	mov bx, 45
	mov color, 0h
	call tile
	
	dec r1b5
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r1b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 45 && bally <= 55)
	call beep
	neg ss1_temp
	mov ax, 140
	mov bx, 45
	mov color, 0h
	call tile
	
	dec r1b4
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r1b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 45 && bally <= 55)
	call beep
	neg ss1_temp
	mov ax, 100
	mov bx, 45
	mov color, 0h
	call tile
	
	dec r1b3
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif

	.if (r1b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 45 && bally <= 55)
	call beep
	neg ss1_temp
	mov ax, 60
	mov bx, 45
	mov color, 0h
	call tile
	
	dec r1b2
	inc scorecount
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	.if (r1b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 45 && bally <= 55)
	call beep
	neg ss2_temp
	mov ax, 20
	mov bx, 45
	mov color, 0h
	call tile
	
	.if (stage!=3)
	dec r1b1
	inc scorecount
	.endif
	mov ax,ss1_temp
	add ballx ,ax
	mov al,1
	mov collision,al
	jmp collided1
	.endif
	.endif
	
	
	
	collided1:
	
	push ax
	mov ax,ss2_temp
	add bally ,ax
	pop ax
	
	.if (collision==1)
	jmp collided2
	.endif

	;row 5
	
	.if (r5b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 105 && bally <= 115)
	call beep
	neg ss2_temp
	mov ax, 260
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b7
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r5b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 105 && bally <= 115)
	call beep
	neg ss2_temp
	mov ax, 220
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b6
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r5b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 105 && bally <= 115)
	call beep
	neg ss2_temp
	mov ax, 180
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b5
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r5b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 105 && bally <= 115)
	call beep
	neg ss2_temp
	mov ax, 140
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b4
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r5b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 105 && bally <= 115)
	call beep
	neg ss2_temp
	mov ax, 100
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b3
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r5b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 105 && bally <= 115)
	call beep
	neg ss2_temp
	mov ax, 60
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b2
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	.if (r5b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 105 && bally <= 115)
	call beep
	neg ss2_temp
	mov ax, 20
	mov bx, 105
	mov color, 0h
	call tile
	
	dec r5b1
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	;row 4
	
	call defaulting
	.if (r4b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 90 && bally <= 100)
	call beep
	neg ss2_temp
	mov ax, 260
	mov bx, 90
	mov color, 0h
	call tile
	
	dec r4b7
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r4b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 90 && bally <= 100)
	call beep
	neg ss2_temp
	mov ax, 220
	mov bx, 90
	mov color, 0h
	call tile
	
	dec r4b6
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r4b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 90 && bally <= 100)
	call beep
	neg ss2_temp
	mov ax, 180
	mov bx, 90
	mov color, 0h
	call tile
	
	.if (stage!=3)
	dec r4b5
	inc scorecount
	.endif
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r4b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 90 && bally <= 100)
	call beep
	neg ss2_temp
	mov ax, 140
	mov bx, 90
	mov color, 0h
	call tile
	dec r4b4
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r4b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 90 && bally <= 100)
	call beep
	neg ss2_temp
	mov ax, 100
	mov bx, 90
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r4b3
	inc scorecount
	.endif
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r4b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 90 && bally <= 100)
	call beep
	neg ss2_temp
	mov ax, 60
	mov bx, 90
	mov color, 0h
	call tile
	dec r4b2
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	.if (r4b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 90 && bally <= 100)
	call beep
	neg ss2_temp
	mov ax, 20
	mov bx, 90
	mov color, 0h
	call tile
	dec r4b1
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	
	;row 3
	
	call defaulting
	.if (r3b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 75 && bally <= 85)
	call beep
	neg ss2_temp
	mov ax, 260
	mov bx, 75
	mov color, 0h
	call tile
	dec r3b7
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r3b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 75 && bally <= 85)
	call beep
	neg ss2_temp
	mov ax, 220
	mov bx, 75
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r3b6
	inc scorecount
	.endif
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r3b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 75 && bally <= 85)
	call beep
	neg ss2_temp
	mov ax, 180
	mov bx, 75
	mov color, 0h
	call tile
	dec r3b5
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r3b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 75 && bally <= 85)
	call beep
	neg ss2_temp
	mov ax, 140
	mov bx, 75
	mov color, 0h
	call tile
	dec r3b4
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r3b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 75 && bally <= 85)
	call beep
	neg ss2_temp
	mov ax, 100
	mov bx, 75
	mov color, 0h
	call tile
	dec r3b3
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r3b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 75 && bally <= 85)
	call beep
	neg ss2_temp
	mov ax, 60
	mov bx, 75
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r3b2
	inc scorecount
	.endif
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	.if (r3b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 75 && bally <= 85)
	call beep
	neg ss2_temp
	mov ax, 20
	mov bx, 75
	mov color, 0h
	call tile
	dec r3b1
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	
	;row 2
	
	call defaulting
	.if (r2b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 60 && bally <= 70)
	call beep
	neg ss2_temp
	mov ax, 260
	mov bx, 60
	mov color, 0h
	call tile
	dec r2b7
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r2b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 60 && bally <= 70)
	call beep
	neg ss2_temp
	mov ax, 220
	mov bx, 60
	mov color, 0h
	call tile
	dec r2b6
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r2b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 60 && bally <= 70)
	call beep
	neg ss2_temp
	mov ax, 180
	mov bx, 60
	mov color, 0h
	call tile
	dec r2b5
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r2b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 60 && bally <= 70)
	call beep
	neg ss2_temp
	mov ax, 140
	mov bx, 60
	mov color, 0h
	call tile
	dec r2b4
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r2b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 60 && bally <= 70)
	call beep
	neg ss2_temp
	mov ax, 100
	mov bx, 60
	mov color, 0h
	call tile
	dec r2b3
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r2b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 60 && bally <= 70)
	call beep
	neg ss2_temp
	mov ax, 60
	mov bx, 60
	mov color, 0h
	call tile
	dec r2b2
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	.if (r2b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 60 && bally <= 70)
	call beep
	neg ss2_temp
	mov ax, 20
	mov bx, 60
	mov color, 0h
	call tile
	dec r2b1
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	
	
	;row 1
	
	call defaulting
	.if (r1b7!=0)
	.if(ballx >= 260 && ballx <= 296 && bally >= 45 && bally <= 55)
	call beep
	neg ss2_temp
	mov ax, 260
	mov bx, 45
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r1b7
	inc scorecount
	.endif
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r1b6!=0)
	.if(ballx >= 220 && ballx <= 256 && bally >= 45 && bally <= 55)
	call beep
	neg ss2_temp
	mov ax, 220
	mov bx, 45
	mov color, 0h
	call tile
	dec r1b6
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r1b5!=0)
	.if(ballx >= 180 && ballx <= 216 && bally >= 45 && bally <= 55)
	call beep
	neg ss2_temp
	mov ax, 180
	mov bx, 45
	mov color, 0h
	call tile
	dec r1b5
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r1b4!=0)
	.if(ballx >= 140 && ballx <= 176 && bally >= 45 && bally <= 55)
	call beep
	neg ss2_temp
	mov ax, 140
	mov bx, 45
	mov color, 0h
	call tile
	dec r1b4
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r1b3!=0)
	.if(ballx >= 100 && ballx <= 136 && bally >= 45 && bally <= 55)
	call beep
	neg ss2_temp
	mov ax, 100
	mov bx, 45
	mov color, 0h
	call tile
	dec r1b3
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif

	.if (r1b2!=0)
	.if(ballx >= 60 && ballx <= 96 && bally >= 45 && bally <= 55)
	call beep
	neg ss2_temp
	mov ax, 60
	mov bx, 45
	mov color, 0h
	call tile
	dec r1b2
	inc scorecount
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	.if (r1b1!=0)
	.if(ballx >= 20 && ballx <= 56 && bally >= 45 && bally <= 55)
	call beep
	neg ss2_temp
	mov ax, 20
	mov bx, 45
	mov color, 0h
	call tile
	.if (stage!=3)
	dec r1b1
	inc scorecount
	.endif
	mov ax,ss2_temp
	add bally ,ax
	jmp collided2
	.endif
	.endif
	
	collided2:
	
	
	.if (scorecount==35 && stage==1)
	mov ah,4ch
	int 21h
	.elseif (scorecount==70 && stage==2)
	mov ah,4ch
	int 21h	
	.elseif (scorecount==87 && stage==3)
	mov ah,4ch
	int 21h
	.endif
	
	.if(ballx >= 300)
		neg ss1_temp
	.endif
	.if(ballx <= 10)
		neg ss1_temp
	.endif
	.if(bally >= 180)
neg ss2_temp
		push ax
		push bx
		mov ax, ballx
		mov bx, bally
		mov dx,xpadel
		.if(bx <= ypadel && ax<dx)
			dec heart_number
			call heart1
			.if (heart_number==0)
			mov ah,4ch
			int 21h
			.endif
		.endif
		
		mov ax, ballx
		mov bx, bally
		mov dx,xpadel
		.if (stage==1)
		add dx,50
		.endif
		.if (stage>1)
		add dx,40
		.endif
		.if(bx <= ypadel && ax>dx)
			dec heart_number
			call heart1
			.if (heart_number==0)
			mov ah,4ch
			int 21h
			.endif
		.endif
		
		
		mov ax,ballx
		mov bx,bally
		mov dx,xpadel
		mov cx,xpadel
		add cx,20
		.if (stage>1)
		sub cx,20
		add cx,15
		.endif
		.if (bx <=ypadel && ax>dx && ax<=cx)
		mov ax,1
		mov ss1_temp,ax
		neg ss1_temp
		.endif
		
		mov ax,ballx
		mov bx,bally
		mov dx,xpadel
		.if (stage==1)
		add dx,20
		mov cx,xpadel
		add cx,30
		.endif
		.if (stage>1)
		add dx,15
		mov cx,xpadel
		add cx,25
		.endif
		.if (bx <=ypadel && ax>dx && ax<=cx)
		mov ax,0
		mov ss1_temp,ax
		.endif
		
		mov ax,ballx
		mov bx,bally
		mov dx,xpadel
		.if (stage==1)
		add dx,50
		mov cx,xpadel
		add cx,30
		.endif
		.if (stage>1)
		add dx,40
		mov cx,xpadel
		add cx,25
		.endif
		.if (bx <=ypadel && ax>cx && ax<=dx)
		mov ax,1
		mov ss1_temp,ax
		.endif
		
		
		pop bx
		pop ax
	.endif
	.if(bally <= 37)
		neg ss2_temp
	.endif
	
	
	
	call defaulting
	
	
	
	
	
	
	
	mov ballcolor,0Fh
	call makeball
	
	.if (stage==3)
	jmp nodelay
	.endif
	.if (stage==1)
	call delay
	.endif
	call delay
	nodelay:
	
	
ret
ball_thing endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bgcolor5 proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for "BACKGROUND COLOUR"

	mov ah, 06h
	mov al, 0			;scroll line
	mov cx, 0			;x-axis
	mov dh, 80			;y-axis
	mov dl, 80
	mov bh, 0h		;background and foreground colour
	int 10h
ret
bgcolor5 endp
	
gameplay proc

here:

	

	mov ah, 02h
	mov bx, 0
	mov dh, 0		;y-axis
	mov dl, 0		;x-axis
	int 10h
	lea dx,dartScreeen
	mov ah,09h
	int 12h
	
	mov dh, 1		;y-axis
	mov dl, 10		;x-axis
	int 10h
	lea dx,dartScreeen
	mov ah,09h
	int 12h
	
	mov dh, 1		;y-axis
	mov dl, 10		;x-axis
	int 10h
	lea dx,dartScreeen
	mov ah,09h
	int 12h
	;---------------for background
	call bgcolor5
again:	
	;----------------for score and display heading
	call display
	;----------------for heart
	call heart1
	;----------------for score file
		mov ah, 02h
		mov bx, 0
		mov dh, 2		;y-axis
		mov dl, 8		;x-axis
		int 10h
	;call scorefile

	;----------------for level file
		mov ah, 02h
		mov bx, 0
		mov dh, 3		;y-axis
		mov dl, 37		;x-axis
		int 10h
;	call levelfile
	

	call defaulting
	;---------row 5
	.if(r5b1>0)
	mov ax,20
	mov bx,105
	mov color, 03h
	
	.if (r5b1==1)
	mov cl,8
	add color,cl
	.endif
	.if (r5b1==3)
	mov cl,0Fh
	mov color,cl
	.endif
	
	call tile

	; .else
	; mov ax,20
	; mov bx,105
	; mov color, 0h
	; call tile
	.endif
	
	.if(r5b2>0)
	mov ax,60
	mov bx,105
	mov color, 06h
	.if (r5b2==1)
	mov cl,8
	add color,cl
	.endif
	.if (r5b2==3)
	mov cl,0Fh
	mov color,cl
	.endif

	
	call tile
	; .else
	; mov ax,60
	; mov bx,105
	; mov color, 0h
	; call tile
	.endif
	
	.if(r5b3>0)
	mov ax,100
	mov bx,105
	mov color, 02h
	.if (r5b3==1)
	mov cl,8
	add color,cl
	.endif
	.if (r5b3==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	; .else
	; mov ax,100
	; mov bx,105
	; mov color, 0h
	; call tile
	.endif
	
	
	.if(r5b4>0)
	mov ax,140
	mov bx,105
	mov color, 04h
	.if (r5b4==1)
	mov cl,8
	add color,cl
	.endif
	.if (r5b4==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	; .else
	; mov ax,140
	; mov bx,105
	; mov color, 0h
	; call tile
	.endif
	
	
	.if(r5b5>0)
	mov ax,180
	mov bx,105
	mov color, 03h
	.if (r5b5==1)
	mov cl,8
	add color,cl
	.endif
	.if (r5b5==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	; .else
	; mov ax,180
	; mov bx,105
	; mov color, 0h
	; call tile
	.endif

	
	.if(r5b6>0)
	mov ax, 220
	mov bx, 105
	mov color, 06h
	.if (r5b6==1)
	mov cl,8
	add color,cl
	.endif
	.if (r5b6==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	; .else
	; mov ax,220
	; mov bx,105
	; mov color, 0h
	; call tile
	.endif

	
	.if(r5b7>0)
	mov ax, 260
	mov bx, 105
	mov color, 02h
	.if (r5b7==1)
	mov cl,8
	add color,cl
	.endif
	.if (r5b7>=3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	; .else
	; mov ax,260
	; mov bx,105
	; mov color, 0h
	; call tile
	.endif

	;---------------row1
	
	.if(r1b1>0)
	mov ax,20
	mov bx,45
	mov color, 03h
	.if (r1b1==1)
	mov cl,8
	add color,cl
	.endif
	.if (r1b1>=3)
	mov cl,08h
	mov color,cl
	.endif
	call tile
	.endif
	
	
	.if(r1b2>0)
	mov ax,60
	mov bx,45
	mov color, 04h
	.if (r1b2==1)
	mov cl,8
	add color,cl
	.endif
	.if (r1b2==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif
	 
	 
	.if(r1b3>0)
	mov ax,100
	mov bx,45
	mov color, 05h
	.if (r1b3==1)
	mov cl,8
	add color,cl
	.endif
	.if (r1b3==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif
	
	
	.if(r1b4>0)
	mov ax,140
	mov bx,45
	mov color, 06h
	.if (r1b4==1)
	mov cl,8
	add color,cl
	.endif
	.if (r1b4==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif
	
	
	.if(r1b5>0)
	mov ax,180
	mov bx,45
	mov color, 04h
	.if (r1b5==1)
	mov cl,8
	add color,cl
	.endif
	.if (r1b5==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif


	.if(r1b6>0)
	mov ax, 220
	mov bx, 45
	mov color, 02h
	.if (r1b6==1)
	mov cl,8
	add color,cl
	.endif
	.if (r1b6==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif


	.if(r1b7>0)
	mov ax, 260
	mov bx, 45
	mov color, 03h
	.if (r1b7==1)
	mov cl,8
	add color,cl
	.endif
	.if (r1b7>=3)
	mov cl,08h
	mov color,cl
	.endif
	call tile
	.endif

	;----------row3
	
	.if(r2b1>0)
	mov ax,20
	mov bx,60
	mov color, 06h
	.if (r2b1==1)
	mov cl,8
	add color,cl
	.endif
	.if (r2b1==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif


	.if(r2b2>0)
	mov ax,60
	mov bx,60
	mov color, 03h
	.if (r2b2==1)
	mov cl,8
	add color,cl
	.endif
	.if (r2b2==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r2b3>0)
	mov ax,100
	mov bx,60
	mov color, 04h
	.if (r2b3==1)
	mov cl,8
	add color,cl
	.endif
	.if (r2b3==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif
	 
	.if(r2b4>0)
	mov ax,140
	mov bx,60
	mov color, 05h
	.if (r2b4==1)
	mov cl,8
	add color,cl
	.endif
	.if (r2b4==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r2b5>0)
	mov ax,180
	mov bx,60
	mov color, 02h
	.if (r2b5==1)
	mov cl,8
	add color,cl
	.endif
	.if (r2b5==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r2b6>0)
	mov ax,220
	mov bx,60
	mov color, 05h
	.if (r2b6==1)
	mov cl,8
	add color,cl
	.endif
	.if (r2b6==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r2b7>0)
	mov ax, 260
	mov bx, 60
	mov color, 06h
	.if (r2b7==1)
	mov cl,8
	add color,cl
	.endif
	.if (r2b7==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	;---------------row3
	
	.if(r3b1>0)
	mov ax,20
	mov bx,75
	mov color, 04h
	.if (r3b1==1)
	mov cl,8
	add color,cl
	.endif
	.if (r3b1==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r3b2>0)
	mov ax,60
	mov bx,75
	mov color, 06h
	.if (r3b2==1)
	mov cl,8
	add color,cl
	.endif
	.if (r3b2>=3)
	mov cl,08h
	mov color,cl
	.endif
	call tile
	.endif
	 
	 
	.if(r3b3>0)
	mov ax,100
	mov bx,75
	mov color, 02h
	.if (r3b3==1)
	mov cl,8
	add color,cl
	.endif
	.if (r3b3==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r3b4>0)
	mov ax,140
	mov bx,75
	mov color, 03h
	.if (r3b4==1)
	mov cl,8
	add color,cl
	.endif
	.if (r3b4==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r3b5>0)
	mov ax,180
	mov bx,75
	mov color, 06h
	.if (r3b5==1)
	mov cl,8
	add color,cl
	.endif
	.if (r3b5==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r3b6>0)
	mov ax, 220
	mov bx, 75
	mov color, 04h
	.if (r3b6==1)
	mov cl,8
	add color,cl
	.endif
	.if (r3b6>=3)
	mov cl,08h
	mov color,cl
	.endif
	call tile
	.endif

	.if(r3b7>0)
	mov ax, 260
	mov bx, 75
	mov color, 02h
	.if (r3b7==1)
	mov cl,8
	add color,cl
	.endif
	.if (r3b7==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	;---------------row4
	.if(r4b1>0)
	mov ax,20
	mov bx,90
	mov color, 05h
	.if (r4b1==1)
	mov cl,8
	add color,cl
	.endif
	.if (r4b1==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r4b2>0)
	mov ax,60
	mov bx,90
	mov color, 02h
	.if (r4b2==1)
	mov cl,8
	add color,cl
	.endif
	.if (r4b2==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif	 
	
	.if(r4b3>0)
	mov ax,100
	mov bx,90
	mov color, 04h
	.if (r4b3==1)
	mov cl,8
	add color,cl
	.endif
	.if (r4b3>=3)
	mov cl,08h
	mov color,cl
	.endif
	call tile
	.endif

	.if(r4b4>0)
	mov ax,140
	mov bx,90
	mov color, 06h
	.if (r4b4==1)
	mov cl,8
	add color,cl
	.endif
	.if (r4b4==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r4b5>0)
	mov ax,180
	mov bx,90
	mov color, 03h
	.if (r4b5==1)
	mov cl,8
	add color,cl
	.endif
	.if (r4b5>=3)
	mov cl,08h
	mov color,cl
	.endif
	call tile
	.endif

	.if(r4b6>0)
	mov ax, 220
	mov bx, 90
	mov color, 02h
	.if (r4b6==1)
	mov cl,8
	add color,cl
	.endif
	.if (r4b6==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	.if(r4b7>0)
	mov ax, 260
	mov bx, 90
	mov color, 03h
	.if (r4b7==1)
	mov cl,8
	add color,cl
	.endif
	.if (r4b7==3)
	mov cl,0Fh
	mov color,cl
	.endif
	call tile
	.endif

	;-----------------for navigation bar
	mov s11, 1
	mov s2, 320
	mov ax, 0
	mov bx, 37
	mov color, 01h
	call tile

	
	;;--------------------------
	call ball_thing
	



	;-----------------for pedal


	.if (stage==1)
	mov s11, 5
	mov s2, 50
	.elseif (stage>=2)
	mov s11,5
	mov s2,40
	.endif


	mov ax, xpadel
	mov bx, ypadel
	mov color, 00h
	call padle
	
	

	.if (autopedal=='r')
		add xpadel,3
	.if (stage==1)
	.if (xpadel >=270 || xpadel <=0)
		sub xpadel,3
	.endif
	.endif
	.if (stage>=2)
	.if (xpadel >=280 || xpadel <=0)
		sub xpadel,3
	.endif
	.endif
	.endif

	.if (autopedal=='l')
	sub xpadel,3
	.if (stage==1)
	.if (xpadel >=270 || xpadel <=0)
		add xpadel,3
	.endif
	.endif
	.if (stage>=2)
	.if (xpadel >=280 || xpadel <=0)
		add xpadel,3
	.endif
	.endif
	.endif

	
	
	mov ax, xpadel		;x-axis
	mov bx, ypadel		;y-axis
	mov color, 07h

	call padle
	
	;call delay
	mov ah,01h
	int 16h
	jz again
	
	mov ah,00
	int 16h
	.if(ah == 4Dh)
		mov autopedal,'r'
		jmp again
	.elseif(ah == 4Bh)
		mov autopedal,'l'
		jmp again
	.elseif(al=='e')
		mov ah,4ch
		int 21h
	.endif
	
	out1:

	;----------------for ball

		; mov ah,00H
		; mov al, 13h
		; int 10h
		; clc
	;L1:	
		call ball_thing
;jmp L1
ret
gameplay endp

deletepadel proc
dec s11
dec s2
ret
deletepadel endp

display proc
	;for "SCORE"
	mov ah, 02h
	mov bx, 0
	mov dh, 2		;y-axis
	mov dl, 1		;x-axis
	int 10h
	
	lea dx, disp1
	mov ah, 09h
	int 21h
	
	mov ah, 02h
	mov bx, 0
	mov dh, 2		;y-axis
	mov dl, 8		;x-axis
	int 10h
	
	mov ax,0
	mov al,scorecount
	mov bl,10
	div bl
	add ah,'0'
	add al,'0'
	mov [scorecounttemp+1],ah
	mov [scorecounttemp],al
	
	
	lea dx, scorecounttemp
	mov ah, 09h
	int 21h
	
	
	
	
	mov ah, 02h
	mov bx, 0
	mov dh, 3		;y-axis
	mov dl, 36	;x-axis
	int 10h
	
	mov ax,0
	mov al,stage
	mov ah,'$'
	add al,'0'
	
	mov [stagetemp],al
	
	
	lea dx, stagetemp
	mov ah,09h
	int 21h
	
	
	
	
	
	;for "DISPLAY"
	mov ah, 02h
	mov bx, 0
	mov dh, 3		;y-axis
	mov dl, 30		;x-axis
	int 10h
	
	lea dx, disp2
	mov ah, 09h
	int 21h
	
	;for "DISPLAY OF NAME"
	mov ah, 02h
	mov bx, 0
	mov dh, 1		;y-axis
	mov dl, 28		;x-axis
	int 10h
	
	lea dx, disp3
	mov ah, 09h
	int 21h
	
	;for "NAME"
	mov ah, 02h
	mov bx, 0
	mov dh, 1		;y-axis
	mov dl, 34		;x-axis
	int 10h
	
	lea dx, strr2
	mov ah, 09h
	int 21h
ret
display endp

	;for "HEART"
heart1 proc
	;;;setting the location of hearts
	mov ah, 02h
	mov dl, 17		;x-axis
	mov dh, 2		;y-axis
	int 10h
	
	mov ah, 09h
	mov al, 00h		;ascii of heart
	mov bx, 04h		;colour of heart
	mov cx, 3	;no of hearts being printed
	int 10h
	
	
	
	
	mov ah, 02h
	mov dl, 17		;x-axis
	mov dh, 2		;y-axis
	int 10h
	
	mov ah, 09h
	mov al, 03h		;ascii of heart
	mov bx, 04h		;colour of heart
	mov cx, heart_number	;no of hearts being printed
	int 10h
ret
heart1 endp

scorefile proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;CREATING A FILE
mov ax,00
mov ah, 03ch
mov cx, 0
; lea dx, score
mov dx, offset score
int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;OPENING A FILE
mov ah, 3dh
mov al, 2;/1/2
lea dx, score		;file opened
int 21h
mov handle, ax		;file is identified by its handle 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;HOW TO WRITE INTO A FILE
mov cx, 0
mov dx, 0
mov al, 2		;to append the file we move in "2"
mov ah, 42h
int 21h
lea dx, text
mov bx, handle
mov cx, bytes
mov ah, 40h
int 21h

mov ah, 3eh				;closing file to save value in it
mov bx, handle
int 21h


mov ah, 3dh
mov al, 2;/1/2
lea dx, score				;file opened again
int 21h
mov handle, ax	
;put $ 
;at the end of the text otherwise the rest of it won't be read
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;HOW TO READ A FILE
mov ah, 03fh
mov cx, noofbytes		
lea dx, buffer			;length of buffer(size of array)
mov bx, handle
int 21h

mov ah, 09h
lea dx, buffer
int 21h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;HOW TO CLOSE A FILE
mov ah, 3eh
mov bx, handle
int 21h
ret
scorefile endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				;MAIN PROC BEGINS HERE
main proc
	mov ax, @data
	mov ds, ax
	mov ax, 00

	mov ah, 00h		;for pixel starting 
	mov al, 13h		;video mode
	int 10h		;video graphics
	
	call bgcolor1
	call input
	
	starting:
	mov ax, 00
	mov bx, 00
	mov cx, 00
	mov dx, 00
	
	call bgcolor2

	call border
	call border2
	call menu
	
	
	mov ah,00h
	int 16h
	
	.if (al=='1')
		call levelmenu
		mov ah,00h
		int 16h
		
		.if (al=='4')
		jmp exit
		.endif
		
		sub al,'0'
		mov stage,al	
	
	mov al,stage
	mov r1b1,al
	mov r1b2,al
	mov r1b3,al
	mov r1b4,al
	mov r1b5,al
	mov r1b6,al
	mov r1b7,al
	
	mov r2b1,al
	mov r2b2,al
	mov r2b3,al
	mov r2b4,al
	mov r2b5,al
	mov r2b6,al
	mov r2b7,al
	
	mov r3b1,al
	mov r3b2,al
	mov r3b3,al
	mov r3b4,al
	mov r3b5,al
	mov r3b6,al
	mov r3b7,al
	
	mov r4b1,al
	mov r4b2,al
	mov r4b3,al
	mov r4b4,al
	mov r4b5,al
	mov r4b6,al
	mov r4b7,al
	
	mov r5b1,al
	mov r5b2,al
	mov r5b3,al
	mov r5b4,al
	mov r5b5,al
	mov r5b6,al
	mov r5b7,al
	
	.if (stage==3)
	mov al,255
	mov r1b1,al
	mov r3b2,al
	mov r4b3,al
	
	mov r1b7,al
	mov r3b6,al
	mov r4b5,al
	.endif
		
		here:
		gameloop:

                ; ; mov cx, 5
				; ; mov ballcolor,3
                        ; ; call makeball
                        
                        ; ; mov cx,0FFFFh

                        ; ; L1:
                        ; ; loop L1

                    ; ; mov ballcolor,0
                    ; ; call makeball
					; ; add ballx,3
					; add bally,3
					; ; .if(ballx < 10 && bally < 40)
						; ; inc ballx
                        ; ; dec bally
					; ; .elseif(ballx > 270)
						; ; dec ballx
						; ; dec bally
					; ; .elseif(ballx == 37 && bally == 0)
						; ; inc bally
						
					; .elseif(ball
					; ; .endif
                        ; ; mov ah,0ch
		call gameplay
		 add ss1,2

		mov s11, 10
		mov s2, 35
		mov cx1, 0
		mov d1, 0
		mov c1, 0
		mov color, 4h
		mov tempo, 0
		mov temp2, 0
		
		mov tempp, 0
		mov tempp2, 0
		mov row, 0
		mov col, 0
		mov count,0
		mov ah, 01h
		int 16h
		
		mov cx,0FFFFh
		
		.while(cx)
			dec cx
		.endw
		
		
		.if(al=='e')
			jmp exitgame
		.endif
		jmp gameloop
		jmp here
	.elseif (al=='2')
	mov ah, 2
	mov dl, 7
	int 21h
	call instruction
		
		;;;--------> delay self made so will stop till a key is pressed
	.elseif (al=='3')
		;----------------for high score file
		mov ah, 02h
		mov bx, 0
		mov dh, 0		;y-axis
		mov dl, 0		;x-axis
		int 10h
		
	.elseif (al=='4')
		jmp exit
	.else
		jmp starting
	.endif
	exitgame:
	jmp starting

exit:
	
mov ah, 4Ch
int 21h
main endp


end main