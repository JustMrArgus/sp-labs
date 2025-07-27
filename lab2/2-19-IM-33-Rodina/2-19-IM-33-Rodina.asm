.386
.model flat, stdcall
option casemap: none
include \masm32\include\masm32rt.inc
.data
dbRodinaLab2Bday db "18112005", 0
dbRodinaLab2StudentBook db "4407", 0
dbRodinaLab2A db 18
dwRodinaLab2A dw 18
ddRodinaLab2A dd 18
dqRodinaLab2A dq 18
dwRodinaLab2B dw 1811
ddRodinaLab2B dd 1811
dqRodinaLab2B dq 1811
ddRodinaLab2C dd 18112005
dqRodinaLab2C dq 18112005
ddRodinaLab2D dd 0.004
dqRodinaLab2D dq 0.004
dqRodinaLab2F dq 4109.826
dtRodinaLab2F dt 4109.826
dbRodinaLab2AMinus db -18
dwRodinaLab2AMinus dw -18
ddRodinaLab2AMinus dd -18
dqRodinaLab2AMinus dq -18
dwRodinaLab2BMinus dw -1811
ddRodinaLab2BMinus dd -1811
dqRodinaLab2BMinus dq -1811
ddRodinaLab2CMinus dd -18112005
dqRodinaLab2CMinus dq -18112005
ddRodinaLab2DMinus dd -0.004
dqRodinaLab2DMinus dq -0.004
dqRodinaLab2E dq 0.411
dqRodinaLab2EMinus dq -0.411
dqRodinaLab2FMinus dq -4109.826
dtRodinaLab2FMinus dt -4109.826
RodinaOleksandrMessageBoxCaption db "RODINA OLEKSANDR IM-33 LAB2",0 
templateRodinaOleksandrMessageBox db "dd.mm.yyyy: 18.11.2005",13,
"N: 4407",13,
"A: %d",13,
"B: %d",13,
"C: %d",13,
"D: %s",13,
"E: %s",13,
"F: %s",13,
"-A: %d",13,
"-B: %d",13,
"-C: %d",13,
"-D: %s",13,
"-E: %s",13,
"-F: %s",0
.data?
RodinaLab2ContainerD db 128 dup(?)
RodinaLab2ContainerDNEG db 128 dup(?)
RodinaLab2ContainerE db 128 dup(?)
RodinaLab2ContainerENEG db 128 dup(?)
RodinaLab2ContainerFNEG db 128 dup(?)
RodinaLab2ContainerF db 128 dup(?)
RodinaOleksandrMessageBox db 256 dup(?)
.code
start:
invoke FloatToStr2,dqRodinaLab2D,addr RodinaLab2ContainerD
invoke FloatToStr2,dqRodinaLab2DMinus,addr RodinaLab2ContainerDNEG
invoke FloatToStr2,dqRodinaLab2E,addr RodinaLab2ContainerE
invoke FloatToStr2,dqRodinaLab2EMinus,addr RodinaLab2ContainerENEG
invoke FloatToStr2,dqRodinaLab2FMinus,addr RodinaLab2ContainerFNEG
invoke FloatToStr2,dqRodinaLab2F,addr RodinaLab2ContainerF
invoke wsprintf, 
addr RodinaOleksandrMessageBox, 
addr templateRodinaOleksandrMessageBox,
ddRodinaLab2A,
ddRodinaLab2B,
ddRodinaLab2C,
offset RodinaLab2ContainerD,
offset RodinaLab2ContainerE,
offset RodinaLab2ContainerF,
ddRodinaLab2AMinus,
ddRodinaLab2BMinus,
ddRodinaLab2CMinus,
offset RodinaLab2ContainerDNEG,
offset RodinaLab2ContainerENEG,
offset RodinaLab2ContainerFNEG
invoke MessageBox,0,addr RodinaOleksandrMessageBox,addr RodinaOleksandrMessageBoxCaption,MB_OK
invoke ExitProcess,0
end start