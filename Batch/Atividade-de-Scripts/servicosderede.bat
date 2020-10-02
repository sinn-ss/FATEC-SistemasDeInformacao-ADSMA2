@echo off
title Atividade de Scripts - SERVICOS DE REDE
mode 80,20
color 0C

rem INICIO FUNCAO SERVICOSDEREDE
:servicosderede
	cls
	echo.
	echo ==========================================
	echo              SERVICOS DE REDE
	echo ==========================================
	echo [N]avegar na Internet
	echo [T]estar Conexao de Rede
	echo [O]bter o IP da Maquina
	echo [R]etornar ao Menu
	echo ==========================================
	set /p op=Digite a opcao desejada : 
	
	if /I %op% == n (goto:internet)
	if /I %op% == t (goto:testarconexao)
	if /I %op% == o (goto:obterip)
	if /I %op% == r (call menu.bat) else (
		echo.
		echo --------------------
		echo   OPCAO INVALIDA!
		echo --------------------
		echo Pressione qualquer tecla para continuar...
		pause > nul
		goto:servicosderede)
rem FIM FUNCAO PACOTEOFFICE

rem INICIO FUNCAO INTERNET	
:internet
	echo.
	set /p site=Digite o endereco da pagina: 
	start %site%
	goto:servicosderede
rem FIM FUNCAO INTERNET

rem INICIO FUNCAO TESTARCONEXAO
:testarconexao
	echo.
	set /p testar=Digite o IP da maquina ou o endereco da pagina para testar: 
	ping %testar% > nul
	if %errorlevel% == 0 (
		echo.
		echo Ping de %testar% BEM-SUCEDIDO!
		echo.
		echo Pressione qualquer tecla para continuar...
	) else (
		echo.
		echo Ping de %testar% MAL-SUCEDIDO!
		echo.
		echo Verifique se o endereco foi digitado corretamente e se a sua conexao de rede esta ativa
		echo.
		echo Pressione qualquer tecla para continuar...
	)
	pause > nul
	goto:servicosderede
rem FIM FUNCAO TESTARCONEXAO

rem INICIO FUNCAO OBTERIP
:obterip
	echo.
	echo IP da maquina:
	ipconfig | findstr IPv4
	pause : nul
	goto:servicosderede
rem FIM FUNCAO OBTERIP