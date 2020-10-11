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
  resposta=cint(inputbox("==================================" + vbnewline &_
                         "ACERTE O C�LCULO MATEM�TICO!" + vbnewline &_
                         "==================================" + vbnewline &_
                         "RESOLVA: " & a & " " & operacao & " " & b & " = ???" + vbnewline &_
                         "=================================="))
  call verificar_resposta
end sub

sub verificar_resposta()
  if resposta = resultado then
    acertos = acertos + 1
    msgbox("Parab�ns voc� acertou!" + vbnewline &_
           "Qtde de acertos: " & acertos & "", vbinformation+vbokonly, "AVISO")
    call carregar_jogo
  else
    msgbox("Voc� errou!", vbcritical+vbokonly, "ATEN��O")
    acertos = 0
    resp = msgbox("Deseja Jogar Novamente?", vbquestion+vbyesno, "ATEN��O")
    if resp = vbyes then
      call carregar_jogo
    else
      wscript.quit
    end if
  end if
end sub
