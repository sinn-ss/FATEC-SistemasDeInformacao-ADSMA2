' Aluno: Sindel C. S. Santos
' RA: 1680482011032
' Turma: ADSMA2     ||  Disciplina: Sistemas de Informação

dim palavras(20), sorteadas(12), contador, audio, pergunta_anterior, resposta
dim nome_player, nivel, pontuacao, pulos, ouvir_novamente, sorteado, nivel_anterior
dim caminho_sons, pasta, pasta_atual, sound

call carregar_audio

sub carregar_audio()
  set pasta = createobject("Scripting.FileSystemObject")
  pasta_atual = pasta.getparentfoldername(wscript.scriptfullname)
  set sound = createobject("WMPlayer.OCX")
  sound.settings.volume = 100
  set audio = createobject("SAPI.SPVOICE")
  audio.volume=100
  audio.rate=1
  call inicializar_palavras
end sub

sub inicializar_palavras()
  'NÍVEL FÁCIL
    palavras(1) = "Bola"
    palavras(2) = "Carro"
    palavras(3) = "Caneta"
    palavras(4) = "Sapato"
    palavras(5) = "Gato"
  'NÍVEL MÉDIO
    palavras(6) = "Assinatura"
    palavras(7) = "Criança"
    palavras(8) = "Avestruz"
    palavras(9) = "Caixa"
    palavraS(10) = "Ventilador"
  'NÍVEL DIFÍCIL
    palavras(11) = "Balbúrdia"
    palavras(12) = "Ressuscitar"
    palavras(13) = "Filantropia"
    palavras(14) = "Prognóstico"
    palavras(15) = "Quimera"
  'NÍVEL INSANO
    palavras(16) = "Otorrinolaringologista"
    palavras(17) = "Verossimilhança"
    palavras(18) = "Vertiginoso"
    palavras(19) = "Nasofibrolaringoscopia"
    palavras(20) = "Desconstitucionalização"
    call iniciar_jogo
end sub

sub iniciar_jogo()
  'Inicializando as variáveis
  nome_player = ""
  pontuacao = 1
  pulos = 1
  ouvir_novamente = 1
  for contador = 1 to 12 step 1
    sorteadas(contador) = 0
  next
  do while nome_player = ""
    nome_player = inputbox("Informe seu nome:", "SOLETRANDO - Informe seu nome")
    if isempty(nome_player) then
      resposta = msgbox("Deseja sair do jogo?", vbquestion + vbyesno, "SOLETRANDO - Sair do jogo?")
      if resposta = vbyes then
        wscript.quit
      else
        call carregar_audio
      end if
    end if
  Loop
  if resposta = vbyes then
    call sorteio
  else
    audio.speak("Bem vindo, " & nome_player & "." + vbnewline &_
                "Vamos jogar SOLETRANDO." + vbnewline &_
                "Serão 12 palavras em 4 níveis." + vbnewline &_
                "Você pode repetir uma palavra por nível, e tem direito a um pulo durante o jogo." + vbnewline &_
                "Vamos começar!")
    call sorteio
  end if
end sub

sub sorteio()
  randomize(second(time))
  if pontuacao <= 3 then
    sorteado = int(1 + Rnd * (5 - 1 + 1))
    nivel = "Fácil"
    call verificar_repetidos
  elseif pontuacao > 3 and pontuacao <= 6 then
    sorteado = int(6 + Rnd * (10 - 6 + 1))
    nivel = "Médio"
    call verificar_repetidos
  elseif pontuacao > 6 and pontuacao <= 9 then
    sorteado = int(11 + Rnd * (15 - 11 + 1))
    nivel = "Difícil"
    call verificar_repetidos
  elseif pontuacao > 9 then
    sorteado = int(16 + Rnd * (20 - 16 + 1))
    nivel = "Insano"
    call verificar_repetidos
  end if
  if nivel_anterior <> nivel then
    if ucase(resposta) <> "O" and ucase(resposta) <> "P" then
      audio.speak("Nível: " & nivel)
    end if
    if ouvir_novamente = 0 and ucase(resposta) <> "P" then
      ouvir_novamente = 1
      audio.speak("Você ganhou uma repetição de palavra para esse nível.")
    end if
  end if
  call falar_palavra
end sub

sub verificar_repetidos()
  for contador = 1 to 12 step 1
    if sorteadas(contador) = sorteado or pergunta_anterior = sorteado then
      call sorteio
    end if
  next
  sorteadas(pontuacao) = sorteado
end sub

sub falar_palavra()
  if ucase(resposta) = "O" then
    audio.speak("Repetindo.")
  end if
  audio.speak ("Escreva a palavra, " & palavras(sorteado) & "")
  call solicitar_resposta
end sub

sub solicitar_resposta()
  resposta = inputbox("[O] Ouvir novamente (Restantes: " & ouvir_novamente & ")" + vbnewline &_
                      "[P] Pular a palavra (Restantes: " & pulos & ")"+ vbnewline &_
                      "" + vbnewline &_
                      "Pontuação: " & pontuacao-1 & "" + vbnewline &_
                      "" + vbnewline &_
                      "Qual foi a palavra falada?", "SOLETRANDO - Nível: " & nivel & " - Player: " & nome_player)
  call verificar_resposta
end sub

sub verificar_resposta()
  if isempty(resposta) then
    resposta = msgbox("Deseja sair do jogo?", + vbquestion + vbyesno, "SOLETRANDO - DESEJA SAIR?")
    if resposta = vbyes then
      wscript.quit
    else
      call solicitar_resposta
    end if
  elseif ucase(resposta) = "O" then
    if ouvir_novamente = 1 then
      ouvir_novamente = 0
      call falar_palavra
    else
      do while ucase(resposta) = "O"
        audio.speak("Só é possível repetir uma vez por nível.")
        call solicitar_resposta
      loop
    end if
  elseif ucase(resposta) = "P" then
    if pulos = 1 then
      pulos = 0
      pergunta_anterior = sorteado
      audio.speak("Você pulou a palavra atual.")
      call sorteio
    else
      do while ucase(resposta) = "P"
        audio.speak("Você não tem mais pulos.")
        call solicitar_resposta
      loop
    end if
  elseif ucase(resposta) = ucase(palavras(sorteado)) then
    pontuacao = pontuacao + 1
    msgbox("VOCÊ ACERTOU!" + vbnewline &_
           + vbnewline &_
           "A palavra foi: " & ucase(resposta) & "" + vbnewline &_
           + vbnewline &_
           "Pontuação: " & pontuacao-1 & ""), vbinformation + vbokonly, "SOLETRANDO - Nível " & nivel
    if pontuacao < 13 then
      nivel_anterior = nivel
      call sorteio
    else
      caminho_sons = pasta_atual & "\ganhou.mp3"
      sound.URL = caminho_sons
      sound.Controls.play
      resposta = msgbox("PARABÉNS! VOCÊ VENCEU O JOGO" + vbnewline &_
                        "Pontuação: " & pontuacao-1 & "" + vbnewline &_
                        "Deseja jogar novamente?", vbexclamation + vbyesno, "SOLETRANDO - Parabéns! Você venceu o jogo!")
      if resposta = vbyes then
        call iniciar_jogo
      else
        wscript.quit
      end if
    end if
  else
    'Sonzinhooo
    caminho_sons = pasta_atual & "\perdeu.mp3"
    sound.URL = caminho_sons
    sound.Controls.play
    resposta = msgbox("VOCÊ ERROU!" + vbnewline &_
                      + vbnewline &_
                      "Pontuação: " & pontuacao-1 & "" + vbnewline &_
                      + vbnewline &_
                      "Sua resposta foi: " & ucase(resposta) & "" + vbnewline &_
                      "A palavra correta era: " & ucase(palavras(sorteado)) + vbnewline &_
                      + vbnewline &_
                      "Deseja jogar novamente?", vbcritical + vbyesno, "SOLETRANDO - Você perdeu!")
    if resposta = vbyes then
      call iniciar_jogo
    else
      wscript.quit
    end if
  end if
end sub
