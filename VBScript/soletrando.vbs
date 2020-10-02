dim palavras(20), perguntas(12), nomes_nivel(12)
dim sorteado, repetido, nome_nivel, nome_player, ultima_pergunta
dim resposta, nivel, pontuacao, pulo, ouvir_novamente, ouviu
dim cont_jogo, cont_sorteio, cont_sorteio2, temp, audio

call carregar_audio

sub carregar_audio()
  set audio = createobject("SAPI.SPVOICE")
  audio.volume=100
  audio.rate=1
  call iniciar_jogo
end sub

sub iniciar_jogo
  cont_jogo = 1
  nome_player = ""
  nivel = 1
  pontuacao = 0
  pulo = 1
  ouvir_novamente = 1
  ouviu = false
  do while nome_player = ""
    nome_player = inputbox("Informe seu nome:", "Informe seu nome - SOLETRANDO")
  Loop
  audio.speak ("Seja bem vindo, " & nome_player & "." + vbnewline &_
               "Vamos jogar SOLETRANDO!" + vbnewline &_
               "Nível da primeira palavra: Fácil")
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
    palavras(19) = "Balaústre"
    palavras(20) = "Desconstitucionalização"
  call sorteio
  cont_sorteio = 1
  call jogo
end sub

sub jogo()
  do while cont_jogo <= 12
    audio.speak ("Escreva a palavra, " & palavras(perguntas(cont_jogo)) & "")
    ultima_pergunta = palavras(perguntas(cont_jogo))
    resposta = inputbox("Qual foi a palavra falada?" + vbnewline &_
                        "[P] Pular (Restantes: " & pulo & ")" + vbnewline &_
                        "[O] Ouvir novamente")
    if ucase(resposta) = "O" and ouvir_novamente = 1 then
      ouvir_novamente = 0
      audio.speak("Repetindo.")
      audio.speak ("Escreva a palavra, " & palavras(perguntas(cont_jogo)) & "")
      resposta = inputbox("Qual foi a palavra falada?" + vbnewline &_
                          "[P] Pular (Restantes: " & pulo & ")" + vbnewline &_
                          "[O] Ouvir novamente")
    elseif ucase(resposta) = "O" and ouvir_novamente = 0 then
      audio.speak("Você só pode ouvir a palavra novamente uma vez.")
      audio.speak("Escreva a palavra falada anteriormente")
      resposta = inputbox("Qual foi a palavra falada?" + vbnewline &_
                          "[P] Pular (Restantes: " & pulo & ")" + vbnewline &_
                          "[O] Ouvir novamente")
    elseif ucase(resposta) = "P" and pulo = 1 then
      audio.speak("Você pulou a palavra anterior. Nível da próxima palavra: " & nomes_nivel(cont_jogo) & "")
      pulo = 0
      call sorteio
      resposta = inputbox("Qual foi a palavra falada?" + vbnewline &_
                          "[P] Pular (Restantes: " & pulo & ")" + vbnewline &_
                          "[O] Ouvir novamente")
    elseif ucase(resposta) = "P" and pulo = 0 then
      audio.speak("Você já gastou todos os seus pulos.")
      audio.speak("Escreva a palavra falada anteriormente")


    if ouvir_novamente = 1 then
      audio.speak ("Escreva a palavra, " & palavras(perguntas(cont_jogo)) & "")
    elseif pulo = 0 and ouviu = false then
      audio.speak ("Escreva a palavra, " & palavras(perguntas(cont_jogo)) & "")
      ouviu = true
    else

    end if
    if ucase(resposta) = ucase(palavras(perguntas(cont_jogo))) then
      call ganhou
    elseif ucase(resposta) = "P" then
      if pulo = 1 then

        call pulou
      else

        ouviu = true
        call jogo
      end if
    elseif ucase(resposta) = "O" then
      if ouvir_novamente = 1 then
        call jogo
      else
        call jogo
      end if
    else
      call perdeu
    end if
    cont_jogo = cont_jogo + 1
  Loop
end sub

sub sorteio()
  cont_sorteio = 1
  do while cont_sorteio <= 12
    randomize(second(time))
    if cont_sorteio <= 3 then
      nivel = 1
      sorteado = int(1 + Rnd * (5 - 1 + 1))
      nome_nivel = "Fácil"
    elseif cont_sorteio > 3 and cont_sorteio <= 6 then
      nivel = 2
      sorteado = int(6 + Rnd * (10 - 6 + 1))
      nome_nivel = "Médio"
    elseif cont_sorteio > 6 and cont_sorteio <= 9 then
      nivel = 3
      sorteado = int(11 + Rnd * (15 - 11 + 1))
      nome_nivel = "Difícil"
    elseif cont_sorteio > 9 then
      nivel = 4
      sorteado = int(16 + Rnd * (20 - 16 + 1))
      nome_nivel = "Insano"
    end if
    repetido = false
    for cont_sorteio2 = 1 to 12 step 1
      if sorteado = perguntas(cont_sorteio2) or sorteado = ultima_pergunta then
        repetido = true
      end if
    next
    if repetido = false then
      perguntas(cont_sorteio) = sorteado
      nomes_nivel(cont_sorteio) = nome_nivel
      cont_sorteio = cont_sorteio + 1
    end if
  loop
  if cont_jogo = "" then
    cont_jogo = 1
  end if
  ouviu = false
  call jogo
end sub

sub ganhou()
  pontuacao = pontuacao + 1
  if pontuacao < 12 then
    audio.speak ("Você acertou! Nível da próxima palavra: " & nomes_nivel(cont_jogo+1) & "")
    msgbox("Parabéns, você acertou!" + vbnewline &_
           "Nível " & nomes_nivel(cont_jogo) &  + vbnewline &_
           "Pontuação: " & pontuacao & "")
  elseif pontuacao = 12 then
    audio.speak ("Parabéns! Você venceu o jogo. Deseja jogar novamente?")
    resposta = msgbox("Parabéns! Você venceu o jogo" + vbnewline &_
                      "Sua pontuação: " & pontuacao & + vbnewline &_
                      "Deseja jogar novamente?", vbexclamation + vbyesno, "PARABÉNS!")
    if resposta = vbyes then
      call iniciar_jogo
    else
      wscript.quit
    end if
  end if
  ouvir_novamente = 1
  ouviu = false
end sub

sub perdeu()
  audio.speak ("Que pena, você perdeu! Deseja jogar novamente?")
  resposta = msgbox("Que pena, você perdeu!" + vbnewline &_
                    "A palavra correta era '" & palavras(perguntas(cont_jogo)) & "'." + vbnewline &_
                    "Sua pontuação atual: " & pontuacao & "" + vbnewline &_
                    "Deseja jogar novamente?", vbcritical + vbyesno, "PERDEU")
  if resposta = vbyes then
    call iniciar_jogo
  else
    wscript.quit
  end if
end sub

sub pulou()

end sub
