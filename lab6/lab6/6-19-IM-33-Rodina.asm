.386
.model flat, stdcall
option casemap: none
include \masm32\include\masm32rt.inc
include \masm32\include\dialogs.inc
.data?
RodinaLab6Result dq ?
RodinaLab6tmms db 512 dup (?)
RodinaLab6strAA db 32 dup (?)
RodinaLab6Denominator dq ?
RodinaLab6strBB db 32 dup (?)
RodinaLab6FiveMin dq ?
RodinaLab6strDD db 32 dup (?)
RodinaLab6Numerator dq ?
RodinaLab6FiveMinVAAA dq ?
RodinaLab6strCC db 32 dup (?)
RodinaLab6StrResult db 32 dup (?)
.data
RodinaLab6AITER42 db "bbbbb",0 ; 5 ітерацій для 5 наборів даних
; Значення
RodinaLab6AAAAA dq 2.33,  3.33,  1.51,  0.13,  1.14
RodinaLab6BBBBB dq 6.88,  7.22,  5.53,  6.51,  4.83
RodinaLab6DDDDD dq 4.29, 10.11,  2.12,  2.36,  1.68
RodinaLab6CCCCC dq 1.11,  0.51, -1.93,  2.43,  1.36
;Константи
RodinaLab6Onee dq 1.0
RodinaLab6Zero dq 0.0
RodinaLab6Twoo dq 2.0
RodinaLab6FortyTwoo dq 42.0
RodinaLab6Fiveeeee dq 5.0
;Заголовки та шаблони
;Наша формула: (42 * c - d / 2 + 1) / (a * a - ln(b - 5))
RodinaOleksandrWOW8093 db "Наша формула: (42 * c - d / 2 + 1) / (a * a - ln(b - 5))",13,
"Значення змінних: a = %s, b = %s, c = %s, d = %s",13,
"Наш результат: (42 * %s - %s / 2 + 1) / (%s * %s - ln(%s - 5)) = %s",0
RodinaOleksandrOHNO8093 db "Наша формула: (42 * c - d / 2 + 1) / (a * a - ln(b - 5))",13,
"Значення змінних: a = %s, b = %s, c = %s, d = %s",13,
"Наш результат: (42 * %s - %s / 2 + 1) / (%s * %s - ln(%s - 5)) = ДІЛЕННЯ НА 0",0
RodinaOleksandrOHNOLOG1 db "Наша формула: (42 * c - d / 2 + 1) / (a * a - ln(b - 5))",13,
"Значення змінних: a = %s, b = %s, c = %s, d = %s",13,
"Наш результат: (42 * %s - %s / 2 + 1) / (%s * %s - ln(%s - 5)) = ЗНАЧЕННЯ НЕ ВХОДИТЬ В ОДЗ (b <= 5)",0
RodinaOleksandrMessageBoxCaption db "RODINA OLEKSANDR IM-33 LAB6",0
RodinaLab6SHOWTHIS macro message, header
invoke MessageBox, 0, addr message, addr header, MB_OK
endm
.code
start:
mov esi, offset RodinaLab6AITER42
mov edi, 0
RodinaCalculationHOI4:
cmp byte ptr [esi], 0
je RodinaLab6ENDTHISNOW
; Конвертуємо поточні значення в рядки для виводу
invoke FloatToStr2, RodinaLab6AAAAA[edi * 8], addr RodinaLab6strAA
invoke FloatToStr2, RodinaLab6BBBBB[edi * 8], addr RodinaLab6strBB
invoke FloatToStr2, RodinaLab6CCCCC[edi * 8], addr RodinaLab6strCC
invoke FloatToStr2, RodinaLab6DDDDD[edi * 8], addr RodinaLab6strDD
finit
fld     RodinaLab6BBBBB[edi * 8]
fsub    RodinaLab6Fiveeeee
ftst
fstsw   ax
sahf
jna     RodinaLab6MadeOHNOLOG
fstp    RodinaLab6FiveMin
fldln2
fld     RodinaLab6FiveMin
fyl2x
fstp    RodinaLab6FiveMinVAAA
fld     RodinaLab6AAAAA[edi * 8]
fmul    st(0), st(0)
fsub    RodinaLab6FiveMinVAAA
fstp    RodinaLab6Denominator
fld     RodinaLab6Denominator
ftst
fstsw   ax
sahf
je      RodinaLab6MadeOHNO
fld     RodinaLab6FortyTwoo
fmul    RodinaLab6CCCCC[edi * 8]
fld     RodinaLab6DDDDD[edi * 8]
fdiv    RodinaLab6Twoo
fsubp   st(1), st(0)
fadd    RodinaLab6Onee
fstp    RodinaLab6Numerator
fld     RodinaLab6Numerator
fld     RodinaLab6Denominator
fdivp   st(1), st(0)
fstp    qword ptr [RodinaLab6Result]
RodinaLab6MadeWOW:
invoke FloatToStr2, RodinaLab6Result, addr RodinaLab6StrResult
; Формуємо повідомлення про успіх
invoke wsprintf, addr RodinaLab6tmms, addr RodinaOleksandrWOW8093, \
addr RodinaLab6strAA, addr RodinaLab6strBB, addr RodinaLab6strCC, addr RodinaLab6strDD, \
addr RodinaLab6strCC, addr RodinaLab6strDD,
addr RodinaLab6strAA, addr RodinaLab6strAA, addr RodinaLab6strBB, \
addr RodinaLab6StrResult ; Результат
RodinaLab6SHOWTHIS RodinaLab6tmms, RodinaOleksandrMessageBoxCaption
jmp RodinaLab6IterSuperHoi4
RodinaLab6MadeOHNO:
; Формуємо повідомлення про ділення на 0
invoke wsprintf, addr RodinaLab6tmms, addr RodinaOleksandrOHNO8093, \
addr RodinaLab6strAA, addr RodinaLab6strBB, addr RodinaLab6strCC, addr RodinaLab6strDD, \ 
addr RodinaLab6strCC, addr RodinaLab6strDD, \ 
addr RodinaLab6strAA, addr RodinaLab6strAA, addr RodinaLab6strBB
RodinaLab6SHOWTHIS RodinaLab6tmms, RodinaOleksandrMessageBoxCaption
jmp RodinaLab6IterSuperHoi4
RodinaLab6MadeOHNOLOG:
; Формуємо повідомлення про помилку ОДЗ
invoke wsprintf, addr RodinaLab6tmms, addr RodinaOleksandrOHNOLOG1, \
addr RodinaLab6strAA, addr RodinaLab6strBB, addr RodinaLab6strCC, addr RodinaLab6strDD, \
addr RodinaLab6strCC, addr RodinaLab6strDD, \
addr RodinaLab6strAA, addr RodinaLab6strAA, addr RodinaLab6strBB
RodinaLab6SHOWTHIS RodinaLab6tmms, RodinaOleksandrMessageBoxCaption
RodinaLab6IterSuperHoi4:
inc esi
inc edi
jmp RodinaCalculationHOI4
RodinaLab6ENDTHISNOW:
invoke ExitProcess, 0 ; Завершення програми
end start