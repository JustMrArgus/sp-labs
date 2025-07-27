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