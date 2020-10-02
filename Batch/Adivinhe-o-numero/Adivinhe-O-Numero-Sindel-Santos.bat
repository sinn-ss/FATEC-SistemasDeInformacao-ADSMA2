rem Adivinhe o número!
rem Aluno: Sindel Cristina da Silva Santos
rem RA: 1680482011032
rem Turma: ADSMA2   /   Disciplina: Sistemas da Informação
rem Data de entrega: 10/09/2020

@echo off
title :.:.:.:.:.: ! ADIVINHE O NUMERO ! :.:.:.:.:.:
mode 96,35
color 03

:setup
	set /a tentativas=5
	set /a palpite=-5
	set playagain=x
	set /a numero=(%random% %% 50) +1
	goto:header

:header
	cls
	echo  ==============================================================================================
	echo                                             _     _
	echo                                            ( \---/ )
	echo                                             ) . . (
	echo               ________________________,--._(___Y___)_,--._______________________
	echo                                       `--'           `--'
	echo     db       8 w        w       8
	echo    dPYb   .d88 w Yb  dP w 8d8b. 8d8b. .d88b    .d8b.    8d8b. 8   8 8d8b.d8b. .d88b 8d8b .d8b.
	echo   dPwwYb  8  8 8  YbdP  8 8P Y8 8P Y8 8.dP'    8' .8    8P Y8 8b d8 8P Y8P Y8 8.dP' 8P   8' .8
	echo  dP    Yb `Y88 8   YP   8 8   8 8   8 `Y88P    `Y8P'    8   8 `Y8P8 8   8   8 `Y88P 8    `Y8P'
	echo  ==============================================================================================
	echo.
	echo                           ADIVINHE O NUMERO SORTEADO ENTRE 01 E 50
	echo.
	goto:verificacao

:verificacao
	if %tentativas% == 0 (goto:perdeu) else (goto:game)

:game
	echo  ----------------------------------------------------------------------------------------------
	echo                                    TENTATIVAS RESTANTES: %tentativas%
	echo  ----------------------------------------------------------------------------------------------
	echo.
	set /p "palpite= DIGITE O SEU PALPITE: "
	if %palpite% lss 1 (goto:menorzero)
	if %palpite% gtr 50 (goto:maiorcinquenta)
	if %palpite% == %numero% (goto:ganhou)
	if %palpite% gtr %numero% (goto:menor)
	if %palpite% lss %numero% (goto:maior)

:menorzero
	echo.
	echo  ----------------------------------------------------------------------------------------------
	echo                                   DIGITE UM VALOR MAIOR QUE 0!
	echo  ----------------------------------------------------------------------------------------------
	echo.
	echo  Pressione qualquer tecla para continuar...
	pause > nul
	goto:header

:maiorcinquenta
	echo.
	echo  ----------------------------------------------------------------------------------------------
	echo                                   DIGITE UM VALOR MENOR QUE 50!
	echo  ----------------------------------------------------------------------------------------------
	echo.
	echo  Pressione qualquer tecla para continuar...
	pause > nul
	goto:header

:menor
	set /a tentativas=%tentativas%-1
	echo.
	echo  ----------------------------------------------------------------------------------------------
	echo                                        O NUMERO E MENOR!
	echo  ----------------------------------------------------------------------------------------------
	echo.
	echo  Pressione qualquer tecla para continuar...
	pause > nul
	goto:header

:maior
	set /a tentativas=%tentativas%-1
	echo.
	echo  ----------------------------------------------------------------------------------------------
	echo                                         O NUMERO E MAIOR!
	echo  ----------------------------------------------------------------------------------------------
	echo.
	echo  Pressione qualquer tecla para continuar...
	pause > nul
	goto:header

:ganhou
	echo.
	echo  ----------------------------------------------------------------------------------------------
	echo                         PARABENS, VOCE ACERTOU! O NUMERO ERA %numero%.
	echo  ----------------------------------------------------------------------------------------------
	echo.
	set /p playagain=DESEJA JOGAR NOVAMENTE? [S/N]:
	if /I %playagain% == S (goto:setup) else (exit)

:perdeu
	echo  ==============================================================================================
	echo.
	echo                         QUE PENA, VOCE PERDEU! O NUMERO ERA %numero%.
	echo.
	echo  ==============================================================================================
	echo.
	set /p playagain=DESEJA JOGAR NOVAMENTE? [S/N]:
	echo %playagain%
	if /I %playagain% == S (goto:setup) else (exit)
