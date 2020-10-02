rem O rem é a forma de comentar nessa linguagem. Igual o "//"
rem É válido lembrar que como esse é um jogo executado no DOS, devido a algumas limitações da linguagem,
rem pode ter algumas coisas que não vão ser necessárias no Java
rem No bat você não especifica o tipo de variável, uma variável pode armazenar texto ou numeros sem problemas

rem @echo off exibe só o programa, sem detalhes da execução. Não é relevante no seu caso xD
@echo off
rem title define o título da janela
title :.:.:.:.:.: ! JoKenPo ! :.:.:.:.:.:
rem mode x,x define o tamanho da janela
mode 100,35
rem color 0 é a cor do fundo e 3 a cor da letra.
rem Se quiser ver todos, abre o prompt e digita "color /?"
color 03

rem INICIO DA FUNÇÃO NOME
rem Ela serve, basicamente, pra perguntar o nome do jogador e setar valores iniciais pra algumas variáveis
rem op é a variável pra pegar a jogada do player em número (depois ela vai ser setada em texto como 'vezjogador')
rem ptjogador = pontuação do jogador; o mesmo pra ptempate e ptmaquina, respectivamente
rem playagain, variável que vai determinar se o player quer jogar de novo ou não
rem sair é uma variável parecida com a playagain, mas vai armazenar se o player quer realmente sair do jogo ou não
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
	rem depois que setar tudo, vai pra função "header" com o goto
	goto:header
rem FIM DA FUNÇÃO NOME

rem INICIO DA FUNÇÃO HEADER
rem "echo" seria o "System.out.println", é pra escrever na tela. "cls" limpa a tela
rem Ela basicamente é essa viadagem em ASCII escrito Jokenpo, dá boas vindas pro player exibindo o nome dele,
rem e faz uma filtragem pra saber se abaixo dele vai aparecer as regras (se o player apertar R) ou o menu
rem (se o player apertar qqr outra tecla)
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
 	rem É aqui nessa parte que ele diz o que fazer depois de exibir o Header, se vai pro menu ou se mostra as regras
 	if /I %op% == R (
 		goto:regras) else (goto:menu)
 rem FIM DA FUNÇÃO HEADER

rem INICIO DA FUNCAO MENU
rem Aqui ta a parte jogável. Inicialmente, ele escreve as opções, e mostra o placar (antes da jogada)
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

	rem Aqui é onde rola a jogada da máquina, antes até de pedir a jogada do player.
	rem Basicamente, ele tá sorteando de 1 até 5 com a variável opmaquina, e depois disso,
	rem setando a variável vezpc de acordo com o que foi sorteado na opmaquina, só pra transcrever mesmo
	set /a opmaquina=(%random% %% 5) +1
	if %opmaquina% == 1 (set vezpc=PEDRA)
	if %opmaquina% == 2 (set vezpc=PAPEL)
	if %opmaquina% == 3 (set vezpc=TESOURA)
	if %opmaquina% == 4 (set vezpc=LAGARTO)
	if %opmaquina% == 5 (set vezpc=SPOCK)

	rem O "set /p" pede que o jogador entre com a opção dele, vai ler e armazenar na variável op
	set /p op="Selecione sua jogada:" 
	
	rem Aqui vai fazer igual fez com a jogada da máquina, setar a variável vezjogador de acordo com o valor de op
	if %op% == 1 (set vezjogador=PEDRA)
	if %op% == 2 (set vezjogador=PAPEL)
	if %op% == 3 (set vezjogador=TESOURA)
	if %op% == 4 (set vezjogador=LAGARTO)
	if %op% == 5 (set vezjogador=SPOCK)

	rem Aqui vem as condicionais, que fala quem ganha de quem, e o que acontece em casa caso
	rem Observação importante: Bat não tem "else if", só "if ... else", por isso você vai ver vários
	rem if em sequencia sem o "else if", ou if dentro de if
	rem Se o player escolheu 1 (Pedra)
	if %op% == 1 (
		rem "echo." pula uma linha, em seguida fala o que o player selecionou em Texto
		echo.
		echo    OPCAO DE %nome%: %vezjogador%
		rem Aqui, ele compara com a jogada da máquina.
		rem Se a máquina jogar 3 (Tesoura) ou 4 (Lagarto), o player vence (vai pra função venceu)
		rem Se a máquina também jogar 1, vai pra função empate
		rem Se a máquina jogar qualquer coisa diferente dessas 3, o player perde e vai pra função perdeu
		if %opmaquina% == 3 (goto:venceu)
		if %opmaquina% == 4 (goto:venceu)
		if %opmaquina% == 1 (goto:empate) else (goto:perdeu))
	rem As debaixo seguem a mesma lógica das daqui de cima
	if %op% == 2 (
		echo.
		echo    OPCAO DE %nome%: %vezjogador%
		if %opmaquina% == 1 (goto:venceu)
		if %opmaquina% == 5 (goto:venceu)
		if %opmaquina% == 2 (goto:empate) else (goto:perdeu))
	if %op% == 3 (
		echo.
		echo    OPCAO DE %nome%: %vezjogador%
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

	rem Depois que ele verificou as opções de 1 até 5, ele vai verificar se o player pediu pra sair (E)
	rem ou se o player pediu pra ver as regras (R)
	if /I %op% == E (goto:sair)
	rem Aqui sim, no último if, ele faz um else (caso não tenha sido nem 1,2,3,4,5,E,R), aí ele vai falar que
	rem a opção é inválida
	if /I %op% == R (goto:header) else (
		echo.
		echo ====================================================================================================
		echo                                           OPCAO INVALIDA!
		echo ====================================================================================================
		echo Pressione qualquer tecla para continuar...
		rem pause > nul serve só pra deixar o texto na tela até pressionar alguma tecla, se nao ele sai rolando
		rem o programa e não da tempo pra ler
		pause > nul
		goto:header)
rem FIM DA FUNÇÃO MENU

rem INICIO DA FUNÇÃO REGRAS
rem Nenhum segredo aqui, só texto mostrando as regras mesmo
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
rem FIM DA FUNÇÃO REGRAS

rem INÍCIO DA FUNÇÃO VENCEU
:venceu
	rem Soma +1 na pontuação do jogador
	set /a ptjogador = %ptjogador% + 1
	rem Exibe a jogada da máquina (na ordem de execução do programa, ele aparece logo abaixo da vez do player)
	echo    OPCAO DA MAQUINA: %vezpc%
	echo.
	rem Mostra o textinho pro player ficar feliz
	echo    **************************
	echo    * PARABENS, VOCE GANHOU! *
	echo    **************************
	rem Vai pra função resultado
	goto:resultado
rem FIM DA FUNÇÃO VENCEU

rem INÍCIO DA FUNÇÃO PERDEU
:perdeu
	rem Soma +1 na pontuação da máquina
	set /a ptmaquina = %ptmaquina% + 1
	echo    OPCAO DA MAQUINA: %vezpc%
	echo.
	rem Mostra o textinho pro player ficar triste
	echo    *************************
	echo    * QUE PENA,VOCE PERDEU! *
	echo    *************************
	rem Vai pra função resultado
	goto:resultado
rem FIM DA FUNÇÃO PERDEU

rem INÍCIO DA FUNÇÃO EMPATE
:empate
	rem Soma +1 na pontuação de empate
	set /a ptempate = %ptempate% + 1
	echo    OPCAO DA MAQUINA: %vezpc%
	echo.
	rem Mostra o textinho pro player ficar puto
	echo    *****************
	echo    * OPS! EMPATOU! *
	echo    *****************
	rem Vai pra função resultado
	goto:resultado
rem FIM DA FUNÇÃO EMPATE

rem INICIO DA FUNÇÃO RESULTADO
rem Serve pra mostrar o placar atualizado e perguntar se o player quer jogar de novo
:resultado
	echo.
	echo ----------------------------
	echo   PLACAR GERAL
	echo   EMPATES: %ptempate%
	echo   VITORIAS: %ptjogador%
	echo   DERROTAS: %ptmaquina%
	echo ----------------------------
	echo.
	rem Setando a opção do player pra um valor x, pro caso do cara jogar de novo e sair apertando enter, não ler
	rem o que ele jogou anteriormente (tipo, se o cara jogou 1 anteriormente, esse set op=x "limpa" o 1 que ele
	rem tinha jogado, fazendo com que dê "opção inválida" se ele só apertar enter td hora)
	set op=x
	rem Pergunta se ele quer jogar novamente, se sim, volta pra função header, se não, vai pra função sair
	set /p playagain=Deseja jogar novamente? [S/N]: 
	if /I %playagain% == s (goto:header) else (goto:sair)
rem FIM DA FUNÇÃO RESULTADO

rem INÍCIO DA FUNÇÃO SAIR
rem Basicamente, caso o player tenha apertado sem querer o E ou tenha selecionado a opção errada quando perguntou
rem se ele queria jogar novamente, pra evitar que ele saia sem querer e perca a pontuação
:sair
	echo.
	set /p sair=Deseja realmente sair? [S/N]: 
	if /I %sair% == S (exit) else (goto:header)
rem FIM DA FUNÇÃO SAIR