@echo off
title Atividade de Scripts - PACOTE OFFICE
mode 60,20
color 0C

rem INICIO FUNCAO PACOTEOFFICE
:pacoteoffice
	cls
	echo.
	echo ==========================================
	echo               PACOTE OFFICE
	echo ==========================================
	echo [W]ord
	echo [E]xcel
	echo [A]ccess
	echo [P]owerPoint
	echo [R]etornar ao Menu
	echo ==========================================
	set /p op=Digite a opcao desejada : 
	
	if /I %op% == w (goto:word)
	if /I %op% == e (goto:excel)
	if /I %op% == a (goto:access)
	if /I %op% == p (goto:powerpoint)
	if /I %op% == r (call menu.bat) else (
		echo.
		echo --------------------
		echo   OPCAO INVALIDA!
		echo --------------------
		echo Pressione qualquer tecla para continuar...
		pause > nul
		goto:pacoteoffice)
rem FIM FUNCAO PACOTEOFFICE

rem INICIO FUNCAO WORD	
:word
	start winword.exe
	goto:pacoteoffice
rem FIM FUNCAO WORD

rem INICIO FUNCAO EXCEL
:excel
	start excel.exe
	goto:pacoteoffice
rem FIM FUNCAO EXCEL

rem INICIO FUNCAO ACCESS	
:access
	start msaccess.exe
	goto:pacoteoffice
rem FIM FUNCAO ACCESS

rem INICIO FUNCAO POWERPOINT
:powerpoint
	start powerpnt.exe
	goto:pacoteoffice
rem FIM FUNCAO POWERPOINT