dim db, rs, sql, pasta, pasta_atual, audio, sound
dim nome_player, resposta, tela_anterior, contador, ranking_nome(9), ranking_pontuacao(10)
dim pergunta, alt1,alt2, alt3, alt4, alt_correta, nivel, nivel_anterior
dim total_registros, sorteado, pontuacao, pulos, cont_perguntas

call conecta_banco

sub conecta_banco()
    set pasta = createobject("Scripting.FileSystemObject")
    pasta_atual = pasta.getparentfoldername(wscript.scriptfullname)
    set db=createobject("ADODB.Connection")
    db.open ("Provider=Microsoft.ACE.OLEDB.12.0; Data Source=" & pasta_atual & "\show_milhao.mdb;Persist Security Info=False;")
    msgbox("Conexão bem sucedida!!!"),vbinformation + vbokonly,"AVISO"
    set sound = createobject("WMPlayer.OCX")
    sound.settings.volume = 100
    set audio = createobject("SAPI.SPVOICE")
    audio.volume=100
    audio.rate=1
    call setup
end sub

sub setup()
    sorteado = 0
    pontuacao = 0
    pulos = 3
    nome_player=""
    resposta = ""
    cont_perguntas = 1
    sql = "UPDATE tb_questoes SET ja_utilizada = 'N' WHERE ja_utilizada = 'S'"
    set rs=db.execute(sql)
    do while nome_player=""
        nome_player = inputbox("Informe seu nome: ", "SHOW DO MILHÃO - INFORME SEU NOME")
    loop
    call menu
end sub

sub menu()
    do while ucase(resposta) <> "N" and ucase(resposta) <> "C" and ucase(resposta) <> "S" and ucase(resposta) <> "R"
        resposta = inputbox("========== SHOW DO MILHÃO ==========" + vbnewline & _
                            + vbnewline & _
                            "Olá " & nome_player & ". Seja vem vindo(a)!" + vbnewline & _
                            + vbnewline & _
                            "Selecione uma opção:" + vbnewline & _
                            + vbnewline & _
                            "[N] Novo Jogo" + vbnewline & _
                            "[C] Cadastrar nova pergunta" + vbnewline & _
                            "[R] Ranking" + vbnewline & _
                            "[S] Sair do jogo", "SHOW DO MILHÃO - MENU")
    loop
    if ucase(resposta) = "N" then
        call sorteio
    elseif ucase(resposta) = "C" then
        call cadastrar_pergunta
    elseif ucase(resposta) = "R" then
        call ranking
    elseif ucase(resposta) = "S" then
        tela_anterior = "menu"
        call confirmar_saida
    end if
end sub

sub cadastrar_pergunta()
    pergunta = ""
    alt1 = ""
    alt2 = ""
    alt3 = ""
    alt4 = ""
    alt_correta = ""
    nivel = ""
    do while pergunta = ""
        pergunta = inputbox("Digite a sua pergunta:","SHOW DO MILHÃO - CADASTRAR PERGUNTA")
        if isempty(pergunta) then
            call menu
        end if
    loop
    do while alt1 = ""
        alt1 = inputbox("Digite a alternativa 1:", "SHOW DO MILHÃO - CADASTRAR PERGUNTA")
        if isempty(alt1) then
            call menu
        end if
    loop
    do while alt2 = ""
        alt2 = inputbox("Digite a alternativa 2:", "SHOW DO MILHÃO - CADASTRAR PERGUNTA")
        if isempty(alt2) then
            call menu
        end if
    loop
    do while alt3 = ""
        alt3 = inputbox("Digite a alternativa 3:", "SHOW DO MILHÃO - CADASTRAR PERGUNTA")
        if isempty(alt3) then
            call menu
        end if
    loop
    do while alt4 = ""
        alt4 = inputbox("Digite a alternativa 4:", "SHOW DO MILHÃO - CADASTRAR PERGUNTA")
        if isempty(alt4) then
            call menu
        end if
    loop
    do while alt_correta = ""
        alt_correta = inputbox("Qual é a alternativa certa?" + vbnewline & _
                               "Digite 1, 2, 3 ou 4:", "SHOW DO MILHÃO - CADASTRAR PERGUNTA")
        if isempty(alt_correta) then
            call menu
        end if
    loop
    do while nivel = ""
        nivel = inputbox("Qual é o nível da pergunta?" + vbnewline & _
                        "[A] Fácil" + vbnewline & _ 
                        "[B] Médio" + vbnewline & _
                        "[C] Difícil" + vbnewline & _
                        "[D] Muito Difícil", "SHOW DO MILHÃO - CADASTRAR PERGUNTA")
        if isempty(nivel) then
            call menu
        end if
    loop
    sql="INSERT INTO tb_questoes (pergunta, resposta1, resposta2, resposta3, resposta4, respostacerta, ja_utilizada, tipo) VALUES ('"& pergunta &"','"& alt1 &"','"& alt2 &"','"& alt3 &"','" & alt4 &"',"& alt_correta &",'N','"& nivel &"')"
    set rs=db.execute(ucase(sql))
    resposta = msgbox("Pergunta cadastrada com sucesso!" + vbnewline & _
                      "Deseja cadastrar outra pergunta?", vbinformation + vbyesno, "SHOW DO MILHÃO - PERGUNTA CADASTRADA!")
    if resposta = vbyes then
        call cadastrar_pergunta
    else
        call menu
    end if
end sub

sub sorteio()
    sql = "SELECT * FROM tb_questoes"
    set rs=db.execute(sql)
    'Contando o total de perguntas
    total_registros = 0
    do while not rs.eof
        total_registros = total_registros + 1
        rs.movenext
    loop
    randomize(second(time))
    sorteado = int(1 + Rnd * (total_registros - 1 + 1))
    call verificar_nivel
end sub

sub verificar_nivel()
    sql = "SELECT * FROM tb_questoes WHERE id_pergunta = " & sorteado
    set rs=db.execute(sql)
    if cont_perguntas <= 5 then
        if rs.eof = false then
            if rs.fields(8).value <> "A" or rs.fields(7) = "S" then
                call sorteio
            else
                nivel = "Fácil"
                sql = "UPDATE tb_questoes SET ja_utilizada = 'S' WHERE id_pergunta = " & sorteado
                set rs=db.execute(sql)
                call iniciar_jogo
            end if
        end if
    elseif cont_perguntas > 5 and cont_perguntas <= 10 then
        if rs.eof = false then
            if rs.fields(8).value <> "B" or rs.fields(7) = "S" then
                call sorteio
            else
                nivel = "Médio"
                sql = "UPDATE tb_questoes SET ja_utilizada = 'S' WHERE id_pergunta = " & sorteado
                set rs=db.execute(sql)
                call iniciar_jogo
            end if
        end if
    elseif cont_perguntas > 10 and cont_perguntas <= 15 then
        if rs.eof = false then
            if rs.fields(8).value <> "C" or rs.fields(7) = "S" then
                call sorteio
            else
                nivel = "Difícil"
                sql = "UPDATE tb_questoes SET ja_utilizada = 'S' WHERE id_pergunta = " & sorteado
                set rs=db.execute(sql)
                call iniciar_jogo
            end if
        end if
    elseif cont_perguntas > 15 then
        if rs.eof = false then
            if rs.fields(8).value <> "D" or rs.fields(7) = "S" then
                call sorteio
            else
                nivel = "Muito Difícil"
                sql = "UPDATE tb_questoes SET ja_utilizada = 'S' WHERE id_pergunta = " & sorteado
                set rs=db.execute(sql)
                call iniciar_jogo
            end if
        end if
    end if
end sub

sub iniciar_jogo()
    sql = "SELECT * FROM tb_questoes WHERE id_pergunta = " & sorteado
    set rs=db.execute(sql)
    if nivel_anterior <> nivel and nivel <> "Fácil" and nivel <> "Muito Difícil" and ucase(resposta) <> "P" then
        msgbox("Parabéns! Você subiu de nível!" + vbnewline & _
               "Nível anterior: " & nivel_anterior + vbnewline & _
               "Nível atual: " & nivel & ""), vbinformation + vbokonly, "SHOW DO MILHÃO - PASSOU DE NÍVEL"
    elseif nivel = "Muito Difícil" then
        msgbox("ATENÇÃO!" + vbnewline & _
               "Esta é a última pergunta do jogo, valendo a pontuação máxima.")
    end if
    if cont_perguntas = 17 then
        resposta = msgbox("PARABÉNS! Você atingiu a pontuação máxima!" + vbnewline & _
                          "Pontuação: " & pontuacao & "" + vbnewline & _ 
                         "Deseja jogar novamente?", vbexclamation + vbyesno, "SHOW DO MILHÃO - PARABÉNS!")
        if resposta = vbyes then
            call setup
        else
            call confirmar_saida
        end if
    else
        resposta = inputbox("PONTUAÇÃO: " & pontuacao & "" + vbnewline & _
                            "==============================" + vbnewline & _
                            "               PERGUNTA " & cont_perguntas & "" + vbnewline & _
                            "==============================" + vbnewline & _
                            + vbnewline & _
                            rs.fields(1) + vbnewline & _
                            + vbnewline & _
                            "1 - " & rs.fields(2) + vbnewline & _
                            "2 - " & rs.fields(3) + vbnewline & _
                            "3 - " & rs.fields(4) + vbnewline & _
                            "4 - " & rs.fields(5) + vbnewline & _
                            + vbnewline & _
                            "==============================" + vbnewline & _
                            + vbnewline & _
                            "[P] Pular (Pulos restantes: " & pulos & ")" + vbnewline & _
                            "[O] Ouvir a pergunta em áudio" + vbnewline & _ 
                            "[S] Sair do jogo", "SHOW DO MILHÃO - NÍVEL: " & nivel & "")
        if ucase(resposta) = "P" then
            call verificar_pulos
        elseif ucase(resposta) = "O" then
            call falar_palavra
        elseif ucase(resposta) = "S" then
            tela_anterior = "iniciar_jogo"
            call confirmar_saida
        elseif resposta = rs.fields(6) then
            select case cont_perguntas
                case 1, 2, 3, 4, 5
                    pontuacao = pontuacao + 1000
                case 6
                    pontuacao = pontuacao + 5000
                case 7, 8, 9, 10
                    pontuacao = pontuacao + 10000
                case 11
                    pontuacao = pontuacao + 50000
                case 12, 13, 14, 15
                    pontuacao = pontuacao + 100000
                case 16
                    pontuacao = pontuacao + 500000
            end select
            cont_perguntas = cont_perguntas + 1
            caminho_sons = pasta_atual & "\certa-resposta.mp3"
            sound.URL = caminho_sons
            sound.Controls.play
            msgbox ("Certa resposta!" + vbnewline & _
                    "Pontuação: " & pontuacao & ""), vbinformation + vbokonly, "SHOW DO MILHÃO - CERTA RESPOSTA!"
            nivel_anterior = nivel
            call sorteio
        else
            call perdeu
        end if
    end if
end sub

sub verificar_pulos()
    if pulos <> 0 then
        pulos = pulos - 1
        msgbox("Você pulou a pergunta."), vbokonly + vbinformation, "SHOW DO MILHÃO - PULOU"
        call sorteio
    else
        msgbox("Você não tem mais pulos!"), vbokonly + vbinformation, "SHOW DO MILHÃO - SEM MAIS PULOS"
        call iniciar_jogo
    end if
end sub

sub falar_palavra()
    audio.speak(rs.fields(1))
    audio.speak("Alternativa 1: " & rs.fields(2))
    audio.speak("Alternativa 2: " & rs.fields(3))
    audio.speak("Alternativa 3: " & rs.fields(4))
    audio.speak("Alternativa 4: " & rs.fields(5))
    call iniciar_jogo
end sub

sub perdeu()
    caminho_sons = pasta_atual & "\que-pena.mp3"
    sound.URL = caminho_sons
    sound.Controls.play
    resposta = msgbox ("Que pena, você errou!" + vbnewline & _
                       "A resposta certa era: " & rs.fields(6) & "" + vbnewline & _
                       "Seus dados foram inseridos no Ranking." + vbnewline & _
                       "Deseja jogar novamente?", vbcritical + vbyesno, "SHOW DO MILHÃO - ERROU!")
    sql = "INSERT INTO tb_ranking (nome_player, pontuacao) VALUES ('" & nome_player & "', " & pontuacao & ")"
    set rs=db.execute(sql)
    if resposta = vbyes then
        call setup
    else
        sql = "UPDATE tb_questoes SET ja_utilizada = 'N' WHERE ja_utilizada = 'S'"
        set rs=db.execute(sql)
        wscript.quit
    end if
end sub

sub ranking()
    sql = "SELECT * FROM tb_ranking ORDER BY pontuacao DESC"
    set rs=db.execute(sql)
    rs.movefirst
    contador = 0
    do while rs.eof = false and contador <= 9
        ranking_nome(contador) = rs.fields(1)
        ranking_pontuacao(contador) = rs.fields(2)
        rs.movenext
        contador = contador + 1
    loop
    resposta = msgbox("==============================" + vbnewline & _
                      "           RANKING" + vbnewline & _
                      "==============================" + vbnewline & _
                      "[1] " & ranking_nome(0) & " - " & ranking_pontuacao(0) & "" + vbnewline & _
                      "[2] " & ranking_nome(1) & " - " & ranking_pontuacao(1) & "" + vbnewline & _
                      "[3] " & ranking_nome(2) & " - " & ranking_pontuacao(2) & "" + vbnewline & _
                      "[4] " & ranking_nome(3) & " - " & ranking_pontuacao(3) & "" + vbnewline & _
                      "[5] " & ranking_nome(4) & " - " & ranking_pontuacao(4) & "" + vbnewline & _
                      "[6] " & ranking_nome(5) & " - " & ranking_pontuacao(5) & "" + vbnewline & _
                      "[7] " & ranking_nome(6) & " - " & ranking_pontuacao(6) & "" + vbnewline & _
                      "[8] " & ranking_nome(7) & " - " & ranking_pontuacao(7) & "" + vbnewline & _
                      "[9] " & ranking_nome(8) & " - " & ranking_pontuacao(8) & "" + vbnewline & _
                      "[10] " & ranking_nome(9) & " - " & ranking_pontuacao(9) & "" + vbnewline & _
                      + vbnewline & _
                      "Voltar ao menu?", vbinformation + vbyesno, "SHOW DO MILHÃO - RANKING")
    if resposta = vbyes then
        call menu
    else
        call ranking
    end ifM
end sub

sub confirmar_saida()
    resposta = msgbox("Deseja realmente sair?", vbquestion + vbyesno, "SHOW DO MILHÃO - DESEJA SAIR?")
    if resposta = vbyes then
        sql = "UPDATE tb_questoes SET ja_utilizada = 'N' WHERE ja_utilizada = 'S'"
        set rs=db.execute(sql)
        wscript.quit
    else
        if tela_anterior = "menu" then
            call menu
        elseif tela_anterior = "iniciar_jogo" then
            call iniciar_jogo
        end if
    end if
end sub