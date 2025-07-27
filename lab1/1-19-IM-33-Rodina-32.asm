.386
.model flat, stdcall
option casemap: none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
include \masm32\include\kernel32.inc
.data
RodinaOleksandrMessageBoxLab1 db 'Мої дані', 0Dh, 0Ah
db 'Родіна Олександр Вікторович', 0Dh, 0Ah
db '18.11.2005', 0Dh, 0Ah
db 'Номер залікової книжки: ІМ3320', 0
RodinaOleksandrMessageBoxLab1Caption db 'RODINA OLEKSANDR IM-33 LAB1', 0
.code
start:
invoke MessageBox,0,addr RodinaOleksandrMessageBoxLab1,addr RodinaOleksandrMessageBoxLab1Caption,MB_OK         
invoke ExitProcess, 0
end start