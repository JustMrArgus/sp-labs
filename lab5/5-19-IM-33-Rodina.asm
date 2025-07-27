.386
.model flat, stdcall
option casemap: none
include \masm32\include\masm32rt.inc
include \masm32\include\dialogs.inc
.data?
RodinaNumeratorLab5 dd ?
RodinaLab5SuperResult dd ?
RodinaLab5SuperTempTrash dd ?
RodinaLab5SuperTemplate db 512 dup (?)
RodinaDenominatorLab5 dd ?
.data
;; Наші змінні
RodinaLab5AITER42 db "bbbbb",0
RodinaLab5AAAAA dd 3, 4, 2, 2, 5
RodinaLab5CCCCC dd 4, 4, 4, 12, 4
RodinaLab5DDDDD dd 4, 5, 9, 6, -5
RodinaOleksandrMessageBoxCaption db "RODINA OLEKSANDR IM-33 LAB5",0
RodinaOleksandrOHNO8093 db "Варіант 19", 13,
"Значення змінних: a = %i, c = %i, d = %i",13,
"Наша формула: (12 / c - d * 4 + 73)/(2 * a * a - 18)",13,
"Наш результат Результат: (12 / %i - %i * 4 + 73)/(2 * %i * %i - 18) = ПОМИЛКА: НА НУЛЬ ДІЛИТИ НЕ МОЖНА",0
RodinaOleksandrWOW8093 db "Варіант 19", 13,
"Значення змінних: a = %i, c = %i, d = %i",13,
"Наша формула: (12 / c - d * 4 + 73)/(2 * a * a - 18)",13,
"Наш результат: (12 / %i - %i * 4 + 73)/(2 * %i * %i - 18) = %i",13,
"Наш результат після виконання модифікації: %i",0
.code
start:
mov esi, offset RodinaLab5AITER42
mov edi, 0
RodinaCalculationHOI4:
cmp byte ptr [esi], 0
je RodinaENDTHISNOW
;; Завантажуємо значення
mov eax, RodinaLab5CCCCC[edi * 4]
mov ecx, RodinaLab5AAAAA[edi * 4]
mov ebx, RodinaLab5DDDDD[edi * 4]
;; Перевірка на 0 у знаменнику (a != 0 і c != 0)
cmp eax, 0
je RodinaLab5DoBadThing
cmp ecx, 0
je RodinaLab5DoBadThing
;; Чисельник: (12 / c - d * 4 + 73)
mov edx, 0
mov eax, 12
cdq
idiv RodinaLab5CCCCC[edi * 4] ; eax = 12 / c
mov RodinaLab5SuperTempTrash, eax
mov eax, RodinaLab5DDDDD[edi * 4]
imul eax, 4 ; d * 4
mov ebx, RodinaLab5SuperTempTrash
sub ebx, eax
add ebx, 73
mov RodinaNumeratorLab5, ebx
;; Знаменник: 2 * a * a - 18
mov eax, RodinaLab5AAAAA[edi * 4]
mov ebx, eax
imul eax, ebx       ; a * a
imul eax, 2         ; 2 * a * a
sub eax, 18
mov RodinaDenominatorLab5, eax
;; Перевірка знаменника
cmp eax, 0
je RodinaLab5DoBadThing
;; Ділимо чисельник на знаменник
mov eax, RodinaNumeratorLab5
cdq
idiv RodinaDenominatorLab5
mov RodinaLab5SuperResult, eax
;; Модифікація результату:
test eax, 1
jnz WOWTHISISODD123
;; Парне — поділити на 2
mov ecx, 2
cdq
idiv ecx
jmp RodinaLab5THISISAMAZING
WOWTHISISODD123:
imul eax, 5
RodinaLab5THISISAMAZING:
invoke wsprintf, addr RodinaLab5SuperTemplate, addr RodinaOleksandrWOW8093,
RodinaLab5AAAAA[edi * 4], RodinaLab5CCCCC[edi * 4], RodinaLab5DDDDD[edi * 4],
RodinaLab5CCCCC[edi * 4], RodinaLab5DDDDD[edi * 4],
RodinaLab5AAAAA[edi * 4], RodinaLab5AAAAA[edi * 4],
RodinaLab5SuperResult, eax
invoke MessageBox, 0, addr RodinaLab5SuperTemplate, addr RodinaOleksandrMessageBoxCaption, MB_OK
inc esi
inc edi
jmp RodinaCalculationHOI4
RodinaLab5DoBadThing:
invoke wsprintf, addr RodinaLab5SuperTemplate, addr RodinaOleksandrOHNO8093,
RodinaLab5AAAAA[edi * 4], RodinaLab5CCCCC[edi * 4], RodinaLab5DDDDD[edi * 4],
RodinaLab5CCCCC[edi * 4], RodinaLab5DDDDD[edi * 4],
RodinaLab5AAAAA[edi * 4], RodinaLab5AAAAA[edi * 4]
invoke MessageBox, 0, addr RodinaLab5SuperTemplate, addr RodinaOleksandrMessageBoxCaption, MB_OK
inc esi
inc edi
jmp RodinaCalculationHOI4
RodinaENDTHISNOW:
invoke ExitProcess, 0
end start
