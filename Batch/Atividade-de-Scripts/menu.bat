@echo off
title Atividade de Scripts - MENU
mode 60,20
color 0B

rem INICIO FUNCAO MENU
:menu
	cls
	echo.
	echo ==========================================
	echo                   MENU
	echo ==========================================
	echo [P]acote Office
	echo [S]ervicos de Rede
	echo [A]plicativos Windows
	echo [G]erenciamento da Maquina
	echo [E]ncerrar Sessao
	echo [F]inalizar Programa
	echo ==========================================
	set /p op=Digite a opcao desejada : 
	
	if /I %op% == p (call pacoteoffice.bat)
	if /I %op% == s (call servicosderede.bat)
	if /I %op% == a (call aplicativoswindows.bat)
	if /I %op% == g (call gerenciamentodamaquina.bat)
	if /I %op% == e (call login.bat)
	if /I %op% == f (exit) else (
		echo.
		echo --------------------
		echo   OPCAO INVALIDA!
		echo --------------------
		echo Pressione qualquer tecla para continuar...
		pause > nul
		goto:menu)
rem FIM FUNCAO MENU