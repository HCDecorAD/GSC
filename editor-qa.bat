@echo off
setlocal EnableExtensions
cd /d "%~dp0"
echo === GSC Visual Editor QA ===
findstr /c:"#2f8cff" admin\visual.html >nul || goto FAIL
findstr /c:"fontSel" admin\visual.html >nul || goto FAIL
findstr /c:"UTM Avo" admin\visual.html >nul || goto FAIL
findstr /c:"Typography" admin\visual.html >nul || goto FAIL
echo GSC_EDITOR_QA_PASS
exit /b 0
:FAIL
echo GSC_EDITOR_QA_FAIL
exit /b 1
