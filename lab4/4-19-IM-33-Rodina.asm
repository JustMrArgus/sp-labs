.386
.model flat, stdcall
option casemap: none
include \masm32\include\masm32rt.inc
include \masm32\include\dialogs.inc
; Macro 1: Displaying information in a window interface
RodinaLab4SHOWMSG MACRO msgText:REQ, TEXTCAP
LOCAL USETHISCAPTION  ;; Local label for caption
; Public comment: Check if TEXTCAP is provided
; Public comment: Display a message box with given text and caption
IFNB <TEXTCAP>
USETHISCAPTION EQU TEXTCAP
ELSE
USETHISCAPTION EQU addr RodinaOleksandrMessageBoxCaption
ENDIF
;; Private comment: MessageBox API is used here
;; Private comment: Default caption used if none specified
invoke MessageBox, NULL, msgText, USETHISCAPTION, MB_OK
ENDM

; Macro 2: Encrypting an input string
ENCRYPTTHISSTR MACRO inputBuffer:REQ, keyBuffer:REQ, outputBuffer:REQ, counter:REQ
; Public comment: Reset the counter before loop
; Public comment: Encrypt each character using XOR with key
xor counter, counter
@@EncryptLoop:
mov al, byte ptr [inputBuffer + counter] ; Public Coment
cmp al, 0
je @@EncryptDone
xor al, byte ptr [keyBuffer + counter] ;; Privat Coment
mov byte ptr [outputBuffer + counter], al ; Public Coment
inc counter
jmp @@EncryptLoop
@@EncryptDone:
mov byte ptr [outputBuffer + counter], 0
;; Private comment: Loop terminates when null-terminator is found
;; Private comment: Result is stored in outputBuffer
ENDM

; Macro 3: Compare encrypted input with original password hash
CompAreSomeHash MACRO encryptedInput:REQ, originalHash:REQ, counter:REQ, successLabel:REQ, failLabel:REQ
LOCAL @@CheckLength, @@LengthCheckDone, @@CheckCorrectLength, @@CompareStart, @@IsStuffGoodOrNo
; Public comment: Determine length of encrypted input
; Public comment: Compare character-by-character with original hash
xor counter, counter
@@CheckLength:
mov al, byte ptr [encryptedInput + counter]
cmp al, 0
je @@LengthCheckDone
inc counter
jmp @@CheckLength
@@LengthCheckDone:
mov edx, counter  ; Save length of encrypted input
xor counter, counter
@@CheckCorrectLength:
mov al, byte ptr [originalHash + counter] ;; Privat Coment
cmp al, 0
je @@CompareStart
inc counter
jmp @@CheckCorrectLength
@@CompareStart:
cmp ecx, edx
jne failLabel
xor counter, counter
@@IsStuffGoodOrNo:
mov al, byte ptr [encryptedInput + counter] ; Public Coment
cmp al, byte ptr [originalHash + counter]
jne failLabel
inc counter
cmp byte ptr [originalHash + counter], 0 ;; Privat Coment
jne @@IsStuffGoodOrNo
jmp successLabel
;; Private comment: Jump to failLabel if mismatch or wrong length
;; Private comment: Success if all characters match till null
ENDM

.data?
RodinaOleksandrLab3PasswordHereArea db 64 dup (?)
EncryptedPassword db 64 dup (?)
.data
RodinaOleksandrLab3Password    db "y_ZOXxENCDAK",0
RodinaOleksandrLab3Key        db "************",0
RodinaOleksandrWOW8093NAME    db "Родіна Олександр Вікторович",0
RodinaOleksandrWOW8093COUNT   db "18.11.2005", 0
RodinaOleksandrWOW8093BD      db "4407", 0
RodinaOleksandrHello          db "Lab3 System Programming",0
RodinaOleksandrOHNO8093       db "О ні, схоже ви ввели неправильний пароль",0
RodinaOleksandrMessageBoxCaption db "RODINA OLEKSANDR IM-33 LAB4",0
.code
RodinaOleksandrOHNONOPlace proc
RodinaLab4SHOWMSG addr RodinaOleksandrOHNO8093, addr RodinaOleksandrMessageBoxCaption
invoke ExitProcess,NULL
RodinaOleksandrOHNONOPlace endp
RodinaOleksandrWOWBROPlace proc
RodinaLab4SHOWMSG addr RodinaOleksandrWOW8093NAME, addr RodinaOleksandrMessageBoxCaption
RodinaLab4SHOWMSG addr RodinaOleksandrWOW8093COUNT, addr RodinaOleksandrMessageBoxCaption
RodinaLab4SHOWMSG addr RodinaOleksandrWOW8093BD, addr RodinaOleksandrMessageBoxCaption
invoke ExitProcess,NULL
RodinaOleksandrWOWBROPlace endp
RodinaOleksandrPasswordValidationProcess proc
ENCRYPTTHISSTR RodinaOleksandrLab3PasswordHereArea, RodinaOleksandrLab3Key, EncryptedPassword, ecx
CompAreSomeHash EncryptedPassword, RodinaOleksandrLab3Password, ecx, WOWBro, NONOTWOWBro  
WOWBro:
call RodinaOleksandrWOWBROPlace 
NONOTWOWBro:
call RodinaOleksandrOHNONOPlace 
RodinaOleksandrPasswordValidationProcess endp
RodinaOleksandrSmorodiaMainWindow proc hWindow:dword, message:dword, wParam:dword, lParam:dword
.if message == WM_COMMAND
.if wParam == IDOK
invoke GetDlgItemText, hWindow, 1000, addr RodinaOleksandrLab3PasswordHereArea, 64
call RodinaOleksandrPasswordValidationProcess
.endif
.elseif message == WM_CLOSE
invoke ExitProcess, NULL
.endif
xor eax, eax
ret
RodinaOleksandrSmorodiaMainWindow endp
start:
Dialog "RODINA OLEKSANDR IM-33 LAB4", "Tahoma", 14, \
WS_OVERLAPPED or WS_SYSMENU or DS_CENTER, 4, 7, 7, 300, 200, 1024
DlgStatic "Пароль:", SS_CENTER, 20, 20, 260, 20, 100
DlgEdit WS_BORDER, 20, 50, 260, 25, 1000
DlgStatic "Правильний пароль: SuperRodinka", SS_CENTER, 20, 85, 260, 20, 101
DlgButton "Ввести пароль", WS_TABSTOP, 110, 150, 80, 30, IDOK
CallModalDialog 0, 0, RodinaOleksandrSmorodiaMainWindow, NULL  
end start