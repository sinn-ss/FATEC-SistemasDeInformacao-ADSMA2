' Aluno: Sindel C. S. Santos
' RA: 1680482011032
' Turma: ADSMA2     ||  Disciplina: Sistemas de Informa��o

dim sortearop, operacao, a, b, resposta, resultado, acertos

call carregar_jogo

sub carregar_jogo()
  randomize(second(time))
  sortearop=int(rnd*3)+1
  a=int(rnd*9)
  b=int(rnd*9)
  select case sortearop
    case 1:
      resultado = a+b
      operacao = "+"
    case 2:
      resultado = a-b
      operacao = "-"
    case 3:
      resultado = a*b
      operacao = "*"
  end select
  call solicitar_resposta
end sub

sub solicitar_resposta()
  resposta=cstr(inputbox("==================================" + vbnewline &_
                         "ACERTE O C�LCULO MATEM�TICO!" + vbnewline &_
                         + vbnewline &_
                         "RESOLVA: " & a & " " & operacao & " " & b & " = ???" + vbnewline &_
                         "=================================="))
  call verificar_resposta
end sub

sub verificar_resposta()
  if resposta = "" then
    resposta = msgbox("Deseja sair do jogo?", vbquestion + vbyesno, "CALCULANDO - Deseja sair?")
    if resposta = vbyes then
      wscript.quit
    else
      call solicitar_resposta
    end if
  elseif resposta = cstr(resultado) then
    acertos = acertos + 1
    resp=msgbox("=============================" + vbnewline &_
                "PARAB�NS! VOC� ACERTOU!" + vbnewline &_
                "= ============================" + vbnewline &_
                "Acertos consecutivos: " & acertos & "" + vbnewline &_
                "=============================" + vbnewline &_
                "Deseja continuar jogando?", vbinformation+vbyesno, "PARAB�NS!")
    if resp=vbyes then
      call carregar_jogo
    else
      wscript.quit
    end if
  else
      call perdeu
  end if
end sub

sub perdeu
  resp=msgbox("=============================" + vbnewline &_
              "QUE PENA, VOC� ERROU!" + vbnewline &_
              + vbnewline &_
              "A resposta correta era " & resultado & "." + vbnewline &_
              + vbnewline &_
              "Acertos consecutivos at� aqui: " & acertos & "" + vbnewline &_
              "=============================" + vbnewline &_
              "Deseja continuar jogando?", vbcritical+vbyesno, "ERROU!")
  acertos = 0
  if resp=vbyes then
    call carregar_jogo
  else
    wscript.quit
  end if
end sub
