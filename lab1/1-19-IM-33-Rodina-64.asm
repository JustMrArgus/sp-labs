OPTION DOTNAME
option casemap:none
include \masm64\include\temphls.inc
include \masm64\include\win64.inc
includelib \masm64\lib\kernel32.lib
includelib \masm64\lib\user32.lib
include \masm64\include\kernel32.inc
OPTION PROLOGUE:rbpFramePrologue
include \masm64\include\user32.inc
OPTION EPILOGUE:none
.data
RodinaOleksandrMessageBoxLab1 db '�� ���', 0Dh, 0Ah
db '����� ��������� ³��������', 0Dh, 0Ah
db '18.11.2005', 0Dh, 0Ah
db '����� ������� ������: ��3320', 0
RodinaOleksandrMessageBoxLab1Caption db "RODINA OLEKSANDR IM-33 LAB1",0
.code
WinMain proc
sub rsp,28h
invoke MessageBox,0,addr RodinaOleksandrMessageBoxLab1,addr RodinaOleksandrMessageBoxLab1Caption,MB_OK
invoke ExitProcess,0
WinMain endp
end