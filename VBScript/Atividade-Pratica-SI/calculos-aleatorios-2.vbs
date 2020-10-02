dim vetor(3), resp, a, b, qtdacertos, resultado, sortearop

call carregar_jogo

sub carregar_jogo()
  vetor(1) = " + "
  vetor(2) = " - "
  vetor(3) = " * "
  randomize(second(time))
  sortearop = int(rnd*3)+1
  a = int(rnd*9)
  b = int(rnd*9)
  select case sortearop
    case 1:
      resultado = a + b
    case 2:
      resultado = a - b
    case 3:
      resultado = a * b
  end select
  call operacao
end sub

sub operacao()
  resp = cint(inputbox(a & " " & vetor(sortearop) & " " & b))
  if resp = resultado then
    qtdacertos = qtdacertos + 1
    resp = msgbox("Acertou! Acertos consecutivos: " & qtdacertos & ". Deseja continuar jogando?", vbinformation + vbyesno, "ACERTOU!")
    if resp = vbyes then
      call carregar_jogo
    else
      wscript.quit
    end if
  else
    resp = msgbox("Errou! Acertos consecutivos: " & qtdacertos & ". Deseja jogar novamente?", vbinformation + vbyesno, "ERROU!")
    qtdacertos = 0
    if resp = vbyes then
      call carregar_jogo
    else
      wscript.quit
    end if
  end if
end sub
