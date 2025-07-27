.386
.model flat, stdcall
option casemap: none
include \masm32\include\masm32rt.inc
include \masm32\include\dialogs.inc
.data?
RodinaOleksandrLab3PasswordHereArea db 64 dup (?)
.data
RodinaOleksandrLab3Password	db "SuperRodinka",0
RodinaOleksandrWOW8093 db "Системне програмування лаб 3",13,
"Родіна Олександр Вікторович",13,"18.11.2005",13,"4407",0
RodinaOleksandrHello db "Lab3 System Programming",0
R dw 8
RodinaOleksandrOHNO8093 db "О ні, схоже ви ввели неправильний пароль",0
RodinaOleksandrMessageBoxCaption db "RODINA OLEKSANDR IM-33 LAB3",0
.code
RodinaOleksandrOHNONOPlace proc
invoke MessageBox,NULL,addr RodinaOleksandrOHNO8093,addr RodinaOleksandrMessageBoxCaption,MB_OK
invoke ExitProcess,NULL
RodinaOleksandrOHNONOPlace endp
RodinaOleksandrWOWBROPlace proc
invoke MessageBox,NULL,addr RodinaOleksandrWOW8093,addr RodinaOleksandrMessageBoxCaption,MB_OK
invoke ExitProcess,NULL
RodinaOleksandrWOWBROPlace endp
RodinaOleksandrPasswordValidationProcess proc
xor ecx, ecx
CheckLength:
mov al, RodinaOleksandrLab3PasswordHereArea[ecx]
cmp al, 0
je LengthCheckDone
inc ecx
jmp CheckLength
LengthCheckDone:
mov edx, ecx
xor ecx, ecx
CheckCorrectLength:
mov al, RodinaOleksandrLab3Password[ecx]
cmp al, 0
je CompareStart
inc ecx
jmp CheckCorrectLength
CompareStart:
cmp ecx, edx
jne NONOTWOWBro
xor ecx, ecx
IsStuffGoodOrNo:
mov al, RodinaOleksandrLab3PasswordHereArea[ecx]
cmp al, RodinaOleksandrLab3Password[ecx]
jne NONOTWOWBro
inc ecx
cmp byte ptr RodinaOleksandrLab3Password[ecx], 0
jne IsStuffGoodOrNo
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
Dialog "RODINA OLEKSANDR IM-33 LAB3", "Tahoma", 14, \
WS_OVERLAPPED or WS_SYSMENU or DS_CENTER, 4, 7, 7, 300, 200, 1024
DlgStatic "Пароль:", SS_CENTER, 20, 20, 260, 20, 100
DlgEdit WS_BORDER, 20, 50, 260, 25, 1000
DlgStatic "Правильний пароль: SuperRodinka", SS_CENTER, 20, 85, 260, 20, 101
DlgButton "Ввести пароль", WS_TABSTOP, 110, 150, 80, 30, IDOK
CallModalDialog 0, 0, RodinaOleksandrSmorodiaMainWindow, NULL
end start