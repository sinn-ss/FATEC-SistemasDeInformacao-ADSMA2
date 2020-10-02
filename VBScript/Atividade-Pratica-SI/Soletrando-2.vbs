dim audio, resp, palavra(20), repeticao(12), qtdacertos, nivel
dim pular, ouvir_novamente, cont, num_sorteado, nome

call carregar_audio

sub carregar_audio()
  set audio = createobject("SAPI.SPVOICE")
  audio.volume=100
  audio.rate=2  'Velocidade da fala
  call calcular_notas
end sub
