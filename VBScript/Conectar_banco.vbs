dim db, rs, sql, op, resp, nome, cpf

call conectar_banco

sub conectar_banco()
    set pasta = createobject("Scripting.FileSystemObject")
    pasta_atual = pasta.getparentfoldername(wscript.scriptfullname)
    set db=createobject("ADODB.Connection")
    db.open("Driver={SQLite3 ODBC Driver};Database=" & pasta_atual & "\cadastro-clientes.db; Version=3")
    msgbox("Conexão com o banco bem sucedida!"), vbinformation + vbokonly, "AVISO"
    call menu
end sub

sub menu()
    op = inputbox("SELECIONE A OPÇÃO DESEJADA: " + vbnewline & _
                  + vbnewline & _
                  "[1] Consultar dados de clientes" + vbnewline & _
                  "[2] Cadastrar novo cliente", "MENU - CLIENTES")
    select case op
        case 1:
            call consultar_dados
        case 2:
            call cadastrar_clientes
        case else:
            resp = msgbox("Opção Inválida! Deseja sair do programa?", vbquestion + vbyesno, "OPÇÃO INVÁLIDA! Continuar?")
            if resp = vbyes then
                wscript.quit
            else
                call menu
            end if
    end select
end sub

sub consultar_dados()
    op = inputbox("Insira o CPF ou o NOME DO CLIENTE que deseja buscar:", "PESQUISAR CLIENTES")
    if isnumeric(op) then
        sql="SELECT * FROM Clientes WHERE cpf="& op & ""
    else
        sql="SELECT * FROM Clientes WHERE nome LIKE '%" & op & "%'"
    end if
    set rs=db.execute(sql)
    if rs.eof=false then
        resp=msgbox("CPF: " & rs.fields(0).value & "" + vbnewline & _
                    "Nome: " & rs.fields(1).value & "" + vbnewline & _
                    "Deseja realizar nova Consulta?",vbquestion+vbyesno,"CONSULTA DE CLIENTES")
        if resp=vbyes then
            call consultar_dados
        else
            call menu
        end if
    else
        resp=msgbox("Cliente não cadastrado!" + vbnewline & _
                    + vbnewline & _
                    "Deseja cadastrar o cliente?",vbinformation+vbyesno,"ATENÇÃO")
        if resp=vbyes then
            call consultar_dados
        else
            call menu
        end if
    end if
end sub

sub cadastrar_clientes
    cpf = inputbox("Informe o CPF do cliente: ", "CADASTRO DE CLIENTES - CPF")
    if isnumeric(cpf) then
        sql = "SELECT * FROM Clientes WHERE cpf="& cpf &""
        set rs=db.execute(sql)
        if rs.eof=false then
            msgbox("CPF: "& cpf &" já cadastrado!"),vbexclamation + vbokonly,"ATENÇÃO"
            call menu
        else
            nome = inputbox("Informe o NOME DO CLIENTE: ", "CADASTRO DE CLIENTES - Nome")
        end if
    else
        msgbox("CPF inválido!")
        call menu
    end if
    sql="INSERT INTO Clientes values ("& cpf &",'"& nome &"')"
    set rs=db.execute(ucase(sql))
    resp=msgbox("Cliente cadastrado com sucesso!" + vbnewline & _
                "Deseja cadastrar novo Cliente??", vbquestion + vbyesno,"ATENÇÃO")
    if resp=vbyes then
        call cadastrar_clientes
    else
        call menu
    end if
end sub