' 3 entradas de dados (numeros inteiros)
' Exibir o menor e maior valor

dim a, b, c, maior, menor
dim resp, audio

call carregar_audio

sub carregar_audio()
  set audio = createobject("SAPI.SPVOICE")
  audio.volume=100
  audio.rate=2
  call verificar_numeros
end sub

sub verificar_numeros()
  a=cint(inputbox("Digite o 1� n�mero inteiro: ", "ATEN��O"))
  b=cint(inputbox("Digite o 2� n�mero inteiro: ", "ATEN��O"))
  do while a = b and a <> 0 and b <> 0
    b=cint(inputbox("N�meros n�o podem ser iguais!" + vbnewline &_
                    "Digite o 2� n�mero inteiro: ", "ATEN��O"))
  loop
  if a > b then
    maior=a
    menor=b
  else
    maior=b
    menor=a
  end if
  c=cint(inputbox("Digite o 3� n�mero inteiro: ", "ATEN��O"))
  do while (c = a or c = b) and (a <> 0 and b <> 0 and c <> 0)
  c=cint(inputbox("N�meros n�o podem ser iguais!" + vbnewline &_
                  "Digite o 3� n�mero inteiro: ", "ATEN��O"))
  loop
  if c > maior then
    maior=c
  elseif c < menor then
    menor=c
  end if
  audio.speak ("O maior n�mero �" & maior & "" + vbnewline &_
               "O menor n�mero �" & menor & "")
  msgbox("O maior n�mero � " & maior & "." + vbnewline &_
         "O menor n�mero � " & menor & "."),vbinformation + vbokonly,"RESULTADO"
  resp=msgbox("Deseja realizar novo c�lculo?", vbquestion + vbyesno, "ATEN��O")
  if resp = vbyes then
    call verificar_numeros
  else
    wscript.quit
  end if
end sub
