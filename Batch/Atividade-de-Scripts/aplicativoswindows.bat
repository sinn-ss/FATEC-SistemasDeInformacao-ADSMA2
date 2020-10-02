@echo off
title Atividade de Scripts - APLICATIVOS WINDOWS
mode 60,20
color 0E

rem INICIO FUNCAO APLICATIVOSWINDOWS
:aplicativoswindows
	cls
	echo.
	echo ==========================================
	echo            APLICATIVOS WINDOWS
	echo ==========================================
	echo [C]alculadora
	echo [T]eclado Virtual
	echo [W]indows Explorer
	echo [P]aint
	echo [B]loco de Notas
	echo [M]anutencao de Disco
	echo [R]etornar ao Menu
	echo ==========================================
	set /p op=Digite a opcao desejada : 
	
	if /I %op% == c (goto:calculadora)
	if /I %op% == t (goto:tecladovirtual)
	if /I %op% == w (goto:windowsexplorer)
	if /I %op% == p (goto:paint)
	if /I %op% == b (goto:blocodenotas) 
	if /I %op% == m (goto:manutencaodedisco)
	if /I %op% == r (call menu.bat) else (
		echo.
		echo --------------------
		echo   OPCAO INVALIDA!
		echo --------------------
		echo Pressione qualquer tecla para continuar...
		pause > nul
		goto:aplicativoswindows)
rem FIM FUNCAO APLICATIVOSWINDOWS

rem INICIO FUNCAO CALCULADORA
:calculadora
	start calc.exe
	goto:aplicativoswindows
rem FIM FUNCAO CALCULADORA

rem INICIO FUNCAO TECLADOVIRTUAL
:tecladovirtual
	start osk.exe
	goto:aplicativoswindows
rem FIM FUNCAO TECLADOVIRTUAL

rem INICIO FUNCAO WINDOWSEXPLORER
:windowsexplorer
	start explorer.exe
	goto:aplicativoswindows
rem FIM FUNCAO WINDOWSEXPLORER

rem INICIO FUNCAO PAINT
:paint
	start mspaint.exe
	goto:aplicativoswindows
rem FIM FUNCAO PAINT

rem INICIO FUNCAO BLOCODENOTAS
:blocodenotas
	start notepad.exe
	goto:aplicativoswindows
rem FIM FUNCAO BLOCODENOTAS

rem INICIO FUNCAO MANUTENCAODEDISCO
:manutencaodedisco
	echo.
	set /p disco=Informe o disco que sera analisado: 
	chkdsk %disco%:
	echo.
	echo Finalizando manutencao de disco...
	echo FINALIZADO!
	echo.
	echo Pressione qualquer tecla para continuar...
	pause > nul
	goto:aplicativoswindows
rem FIM FUNCAO MANUTENCAODEDISCO