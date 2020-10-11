' P1 - Sistemas de Informação
' Exercício 7
' Aluno: Sindel Cristina da Silva Santos
' RA: 1680482011032
' Turma: ADSMA2     ||  Disciplina: Sistemas de Informação
' Data: 05/10/2020
' Enunciado: Desenvolva um Script, através da linguagem de programação
' "VBSCRIPT", que gere 02 (dois) números aleatórios de (0) a (10), e calcule o
' resultado conforme, 03 (três) operadores matemáticos sorteados aleatoriamente:
' "adição", "subtração" e "Multiplicação". A cada acerto do resultado, exibir a
' mensagem referida abaixo, e quantificar os acertos, caso haja erro de resultado,
' notificar com a mensagem "você errou!" e exibir a mensagem de "Jogar Novamente?",
' conforme "FRONT-END" ilustrado abaixo. Faça o upload do arquivo com a extensão em PDF (2,0 pts.) 

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
                         "ACERTE O CÁLCULO MATEMÁTICO!" + vbnewline &_
                         "==================================" + vbnewline &_
                         "RESOLVA: " & a & " " & operacao & " " & b & " = ???" + vbnewline &_
                         "==================================", "SISTEMAS DE INFORMAÇÃO - P1"))
  call verificar_resposta
end sub

sub verificar_resposta()
  if resposta = resultado then
    acertos = acertos + 1
    msgbox("Parabéns você acertou!" + vbnewline &_
           "Qtde de acertos: " & acertos & ""), vbinformation+vbokonly, "AVISO"
    call carregar_jogo
  else
    msgbox("Você errou!"), vbcritical+vbokonly, "ATENÇÃO"
    acertos = 0
    resp = msgbox("Deseja Jogar Novamente?", vbquestion+vbyesno, "ATENÇÃO")
    if resp = vbyes then
      call carregar_jogo
    else
      wscript.quit
    end if
  end if
end sub
