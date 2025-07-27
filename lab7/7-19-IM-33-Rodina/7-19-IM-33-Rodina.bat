@echo off
ml /c /coff "7-19-IM-33-Rodina.asm"
ml /c /coff "7-19-IM-33-Rodina-PUBLIC.asm"
link /subsystem:windows "7-19-IM-33-Rodina.obj" "7-19-IM-33-Rodina-PUBLIC.obj"
7-19-IM-33-Rodina.exe