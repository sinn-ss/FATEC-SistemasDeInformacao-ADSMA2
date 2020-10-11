rem P1 - Exercício 6
rem Aluno: Sindel Cristina da Silva Santos
rem RA: 1680482011032
rem Turma: ADSMA2   /   Disciplina: Sistemas da Informação
rem Data de entrega: 05/10/2020
rem ===================================================================================================
rem ENUNCIADO:
rem Desenvolva um Script, através da linguagem de programação "BATCH", que gere e organize
rem "N" arquivos, customizados pelo usuário, conforme "FRONT-END" ilustrado abaixo. Faça o upload
rem do arquivo com a extensão em PDF (2,0 pts.) 
rem ===================================================================================================

@echo off
title P1- Sistemas de Informação
mode 60,20
color 02

:menu
    cls
	echo.
	echo =================================
	echo    GERENCIAMENTO DE ARQUIVOS
	echo =================================
	echo [G] GERAR ARQUIVOS
	echo [O] ORGANIZAR ARQUIVOS
	echo [E] ENCERRAR SCRIPT
    echo.
	echo =================================

    set /p op=Escolha a opcao..: 
	
	if /I %op% == g (goto:gerar_arquivos)
	if /I %op% == o (goto:organizar_arquivos)
	if /I %op% == e (goto:sair) else (
		echo.
		echo ====================
		echo   OPCAO INVALIDA!
		echo ====================
		echo Pressione qualquer tecla para continuar...
		pause > nul
		goto:menu)

:gerar_arquivos
    set /p nome_arquivo=Digite o nome do arquivo:  
	set /p qtde=Digite a qtde de arquivos: 
	set /p ext=Digite a extensao do arquivo: 

    for /L %%n in (1,1,%qtde%) do echo Arquivos > %nome_arquivo%%%n.%ext% 
		echo.
		echo ========================================
		echo      ARQUIVOS GERADOS COM SUCESSO!
		echo ========================================
		echo Pressione qualquer tecla para continuar...
	pause > nul
	goto:menu

:organizar_arquivos
    set /p pasta=Digite a pasta a ser criada: 
	set /p ext=Digite a extensao a ser organizada: 
	md %pasta%
	move *.%ext% %pasta%
	echo.
	echo =======================================
	echo    ARQUIVOS ORGANIZADOS COM SUCESSO!
	echo =======================================
    echo Pressione qualquer tecla para continuar...
	pause > nul
	goto:menu

:sair
    echo.
	set /p finalizar=Deseja realmente sair? [S/N]: 
	if /I %finalizar% == S (exit) else (goto:menu)