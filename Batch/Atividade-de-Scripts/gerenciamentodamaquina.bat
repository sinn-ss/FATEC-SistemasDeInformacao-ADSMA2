@echo off
title Atividade de Scripts - GERENCIAMENTO DO COMPUTADOR
mode 60,20
color 0D

rem INICIO FUNCAO GERENCIAMENTODOCOMPUTADOR
:gerenciamentodocomputador
	cls
	echo.
	echo ==========================================
	echo         GERENCIAMENTO DO COMPUTADOR
	echo ==========================================
	echo [DC] Desligar o Computador 
	echo [RC] Reiniciar o Computador
	echo [HC] Hibernar o Computador
	echo [R]etornar ao Menu
	echo ==========================================
	set /p op=Digite a opcao desejada : 
	
	if /I %op% == dc (shutdown /s)
	if /I %op% == rc (shutdown /r)
	if /I %op% == hc (shutdown /h)
	if /I %op% == r (call menu.bat) else (
		echo.
		echo --------------------
		echo   OPCAO INVALIDA!
		echo --------------------
		echo Pressione qualquer tecla para continuar...
		pause > nul
		goto:gerenciamentodocomputador)
rem FIM FUNCAO GERENCIAMENTODOCOMPUTADOR
