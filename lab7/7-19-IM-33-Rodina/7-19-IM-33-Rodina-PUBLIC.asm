.386
.model flat, stdcall
option casemap: none
EXTERN RodinaLab6AAAAA : QWORD
EXTERN RodinaLab6BBBBB : QWORD
EXTERN RodinaLab6Fiveeeee : QWORD
PUBLIC RodinaLab6CalcDenominator
.data
RodinaLab6LnBminus5_local dq ?
.code
RodinaLab6CalcDenominator proc
fld RodinaLab6BBBBB[edi * 8]
fsub RodinaLab6Fiveeeee
fldln2
fxch st(1)
fyl2x
fstp RodinaLab6LnBminus5_local
fld RodinaLab6AAAAA[edi * 8]
fmul st(0), st(0)
fsub RodinaLab6LnBminus5_local
ret
RodinaLab6CalcDenominator endp
end