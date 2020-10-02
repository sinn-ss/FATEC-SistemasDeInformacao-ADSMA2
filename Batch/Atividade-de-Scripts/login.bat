@echo off

:: BatchGotAdmin
:-------------------------------------
	REM  --> Check for permissions
	IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
		>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
	) ELSE (
		>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
	)

	REM --> If error flag set, we do not have admin.
	if '%errorlevel%' NEQ '0' (
		echo Solicitando privilegios administrativos...
		goto UACPrompt
	) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  


title Atividade de Scripts - LOGIN
mode 60,20
color 0A

rem INICIO FUNCAO LOGIN
:login
	cls
	echo.
	echo ==========================================
	echo                  LOGIN
	echo ==========================================
	set /p user=Usuario : 
	set /p senha=Senha : 
	
	if /I %user% == admin (
		if /I %senha% == admin (call menu.bat) else (
			echo.
			echo ---------------------------------
			echo   USUARIO OU SENHA INCORRETOS!
			echo ---------------------------------
			echo Pressione qualquer tecla para continuar...
			pause > nul
			goto:login)
	) else (
		echo.
		echo ---------------------------------
		echo   USUARIO OU SENHA INCORRETOS!
		echo ---------------------------------
		echo Pressione qualquer tecla para continuar...
		pause > nul
		goto:login)
rem FIM FUNCAO LOGIN