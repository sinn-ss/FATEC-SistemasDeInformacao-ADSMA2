rem JoKenPo!
rem Aluno: Sindel Cristina da Silva Santos
rem RA: 1680482011032
rem Turma: ADSMA2   /   Disciplina: Sistemas da Informação
rem Data de entrega: 03/09/2020

@echo off
title :.:.:.:.:.: ! JoKenPo ! :.:.:.:.:.:
mode 100,35
color 03

:nome
	echo ----------------------------------------------------------------------------------------------------
	set /p nome=Digite seu nome:
	echo ----------------------------------------------------------------------------------------------------
	set op=x
	set ptjogador=0
	set ptmaquina=0
	set ptempate=0
	set playagain=s
	set sair=x
	goto:header

:header
	cls
	echo.
	echo ####################################################################################################
	echo.
	echo                     ##  #######  ##    ## ######## ##    ## ########   #######  ####
  echo                     ## ##     ## ##   ##  ##       ###   ## ##     ## ##     ## ####
  echo                     ## ##     ## ##  ##   ##       ####  ## ##     ## ##     ## ####
  echo                     ## ##     ## #####    ######   ## ## ## ########  ##     ##  ##  
	echo              ##     ## ##     ## ##  ##   ##       ##  #### ##        ##     ##
	echo               ##    ## ##     ## ##   ##  ##       ##   ### ##        ##     ## ####
 	echo                ######   #######  ##    ## ######## ##    ## ##         #######  ####
 	echo.
 	echo ####################################################################################################
 	echo ----------------------------------------------------------------------------------------------------
 	echo Seja bem vindo(a), %nome%!
 	echo ----------------------------------------------------------------------------------------------------
 	if /I %op% == R (
 		goto:regras) else (goto:menu)

:menu
	echo.
	echo [1] PEDRA
	echo [2] PAPEL                                       ----------------------------
	echo [3] TESOURA                                     [        PLACAR GERAL      ]
	echo [4] LAGARTO                                     [ EMPATES: %ptempate%               ]
	echo [5] SPOCK                                       [ VITORIAS: %ptjogador%              ]
	echo [E] ENCERRAR JOGO                               [ DERROTAS: %ptmaquina%              ]
	echo [R] REGRAS                                      ----------------------------
	echo.
	echo ----------------------------------------------------------------------------------------------------

	set /a opmaquina=(%random% %% 5) +1
	if %opmaquina% == 1 (set vezpc=PEDRA)
	if %opmaquina% == 2 (set vezpc=PAPEL)
	if %opmaquina% == 3 (set vezpc=TESOURA)
	if %opmaquina% == 4 (set vezpc=LAGARTO)
	if %opmaquina% == 5 (set vezpc=SPOCK)

	set /p op="Selecione sua jogada:"

	if %op% == 2 (set vezjogador=PAPEL)
	if %op% == 3 (set vezjogador=TESOURA)
	if %op% == 4 (set vezjogador=LAGARTO)
	if %op% == 5 (set vezjogador=SPOCK)

	if %op% == 1 (
		echo.
		echo    SUA OPCAO: PEDRA
		if %opmaquina% == 3 (goto:venceu)
		if %opmaquina% == 4 (goto:venceu)
		if %opmaquina% == 1 (goto:empate) else (goto:perdeu))
	if %op% == 2 (
		echo.
		echo    SUA OPCAO: PAPEL
		if %opmaquina% == 1 (goto:venceu)
		if %opmaquina% == 5 (goto:venceu)
		if %opmaquina% == 2 (goto:empate) else (goto:perdeu))
	if %op% == 3 (
		echo.
		echo    SUA OPCAO: TESOURA
		if %opmaquina% == 2 (goto:venceu)
		if %opmaquina% == 4 (goto:venceu)
		if %opmaquina% == 3 (goto:empate) else (goto:perdeu))
	if %op% == 4 (
		echo.
		echo    OPCAO DE %nome%: LAGARTO
		if %opmaquina% == 2 (goto:venceu)
		if %opmaquina% == 5 (goto:venceu)
		if %opmaquina% == 4 (goto:empate) else (goto:perdeu))
	if %op% == 5 (
		echo.
		echo    OPCAO DE %nome%: SPOCK
		if %opmaquina% == 1 (goto:venceu)
		if %opmaquina% == 3 (goto:venceu)
		if %opmaquina% == 5 (goto:empate) else (goto:perdeu))

	if /I %op% == E (goto:sair)
	if /I %op% == R (goto:header) else (
		echo.
		echo ====================================================================================================
		echo                                           OPCAO INVALIDA!
		echo ====================================================================================================
		echo Pressione qualquer tecla para continuar...
		pause > nul
		goto:header)

:regras
	echo ====================================================================================================
	echo                                                  REGRAS
	echo ====================================================================================================
	echo.
	echo PEDRA:
	echo     Empata com Pedra; Ganha de Tesoura e Lagarto; Perde de Papel e Spock;
	echo.
	echo PAPEL:
	echo     Empata com Papel; Ganha de Pedra e Spock; Perde de Tesoura e Lagarto;
	echo.
	echo TESOURA:
	echo     Empata com Tesoura; Ganha de Lagarto e Papel; Perde de Pedra e Spock;
	echo.
	echo LAGARTO:
	echo     Empata com Lagarto; Ganha de Papel e Spock; Perde de Pedra e Tesoura;
	echo.
	echo SPOCK:
	echo     Empata com Spock; Ganha de Pedra e Tesoura; Perde de Lagarto e Papel;
	echo.
	echo Pressione qualquer tecla para continuar...
	pause > nul
	set op=x
	goto:header

:venceu
	set /a ptjogador = %ptjogador% + 1
	echo    OPCAO DA MAQUINA: %vezpc%
	echo.
	echo    **************************
	echo    * PARABENS, VOCE GANHOU! *
	echo    **************************
	goto:resultado

:perdeu
	set /a ptmaquina = %ptmaquina% + 1
	echo    OPCAO DA MAQUINA: %vezpc%
	echo.
	echo    *************************
	echo    * QUE PENA,VOCE PERDEU! *
	echo    *************************
	goto:resultado

:empate
	set /a ptempate = %ptempate% + 1
	echo    OPCAO DA MAQUINA: %vezpc%
	echo.
	echo    *****************
	echo    * OPS! EMPATOU! *
	echo    *****************
	goto:resultado

:resultado
	echo.
	echo ----------------------------
	echo   PLACAR GERAL
	echo   EMPATES: %ptempate%
	echo   VITORIAS: %ptjogador%
	echo   DERROTAS: %ptmaquina%
	echo ----------------------------
	echo.
	set op=x
	set /p playagain=Deseja jogar novamente? [S/N]:
	if /I %playagain% == s (goto:header) else (goto:sair)

:sair
	echo.
	set /p sair=Deseja realmente sair? [S/N]:
	if /I %sair% == S (exit) else (goto:header)
