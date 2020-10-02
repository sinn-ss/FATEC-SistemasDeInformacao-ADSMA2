Option Explicit
Dim caminho_sons
Dim pasta
Dim pasta_atual
Set pasta = CreateObject("Scripting.FileSystemObject")
pasta_atual = pasta.GetParentFolderName(WScript.ScriptFullName)
caminho_sons = pasta_atual & "\perdeu.mp3" 'Relative Path
Call Play(caminho_sons)
'**********************************************************
Sub Play(SoundFile)
Dim Sound
Set Sound = CreateObject("WMPlayer.OCX")
Sound.URL = SoundFile
Sound.settings.volume = 100
Sound.Controls.play
do while Sound.currentmedia.duration = 0
    wscript.sleep 100
loop
wscript.sleep(int(Sound.currentmedia.duration)+1)*1000
End Sub
'**********************************************************
