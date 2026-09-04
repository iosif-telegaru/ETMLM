@echo off
chcp 65001 >nul
:: Check if executed as Administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [ETMLM] Starting universal standard installation...
    echo.

    :: 1. Create a secure system directory for the Windows icon
    echo [ETMLM] Step 1: Creating secure system directory for the icon...
    set "RUTADESTINO=%ProgramData%\ETMLM"
    if not exist "%RUTADESTINO%" mkdir "%RUTADESTINO%"

    :: 2. Copy the icon file to the system directory
    echo [ETMLM] Step 2: Copying etmlm.ico to the secure system path...
    if exist "%~dp0etmlm.ico" (
        copy /Y "%~dp0etmlm.ico" "%RUTADESTINO%\etmlm.ico" >nul
        echo [ETMLM] Windows icon successfully deployed to the system.
    ) else (
        echo [ERROR] etmlm.ico file not found in the current directory.
        pause
        exit /b
    )

    :: 3. Inject registry keys and file associations (System and User levels)
    echo [ETMLM] Step 3: Injecting registry keys and file associations...
    
    :: System-wide Association (HKLM)
    reg add "HKLM\SOFTWARE\Classes\.etmlm" /ve /t REG_SZ /d "etmlm_file" /f >nul
    reg add "HKLM\SOFTWARE\Classes\.etmlm" /v "Content Type" /t REG_SZ /d "xml" /f >nul
    reg add "HKLM\SOFTWARE\Classes\.etmlm" /v "PerceivedType" /t REG_SZ /d "xml" /f >nul
    reg add "HKLM\SOFTWARE\Classes\etmlm_file" /ve /t REG_SZ /d "Enhanced Timed Multi Lyric Markup" /f >nul
    reg add "HKLM\SOFTWARE\Classes\etmlm_file\DefaultIcon" /ve /t REG_SZ /d "\"%RUTADESTINO%\etmlm.ico\"" /f >nul

    :: Current User Association (HKCU)
    reg add "HKCU\SOFTWARE\Classes\.etmlm" /ve /t REG_SZ /d "etmlm_file" /f >nul
    reg add "HKCU\SOFTWARE\Classes\.etmlm" /v "Content Type" /t REG_SZ /d "xml" /f >nul
    reg add "HKCU\SOFTWARE\Classes\.etmlm" /v "PerceivedType" /t REG_SZ /d "xml" /f >nul
    reg add "HKCU\SOFTWARE\Classes\etmlm_file" /ve /t REG_SZ /d "Enhanced Timed Multi Lyric Markup" /f >nul
    reg add "HKCU\SOFTWARE\Classes\etmlm_file\DefaultIcon" /ve /t REG_SZ /d "\"%RUTADESTINO%\etmlm.ico\"" /f >nul

    :: Force Windows Explorer to use your custom icon over the default VS Code layout
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.etmlm\UserChoice" /v "Progid" /t REG_SZ /d "etmlm_file" /f >nul
    reg add "HKCU\SOFTWARE\Classes\Applications\Code.exe\SupportedTypes" /v ".etmlm" /t REG_SZ /d "" /f >nul

    echo [ETMLM] Registry keys successfully injected.

    :: 4. Install the extension in Visual Studio Code & bind open command
    echo [ETMLM] Step 4: Detecting and installing language support in VS Code...
    where code >nul 2>&1
    if %errorLevel% == 0 (
        code --install-extension "%~dp0etmlm-support-1.0.0.vsix" --force
        
        :: Automatically bind .etmlm files to launch via VS Code command line
        reg add "HKLM\SOFTWARE\Classes\etmlm_file\shell\open\command" /ve /t REG_SZ /d "\"cmd.exe\" /c code \"%%1\"" /f >nul
        reg add "HKCU\SOFTWARE\Classes\etmlm_file\shell\open\command" /ve /t REG_SZ /d "\"cmd.exe\" /c code \"%%1\"" /f >nul
        echo [ETMLM] VS Code extension installed and file handler bound successfully.
    ) else (
        echo [WARNING] Visual Studio Code 'code' command is not in the system PATH.
        echo [INFO] Users will need to manually drag and drop the .vsix file into VS Code.
    )

    :: 5. Rebuild the file explorer icon cache
    echo [ETMLM] Step 5: Rebuilding Windows icon cache...
    ie4uinit.exe -show
    taskkill /f /im explorer.exe >nul 2>&1
    start explorer.exe
    
    echo.
    echo --------------------------------------------------
    echo Installation complete! Format and UI successfully configured.
    echo You can now edit .etmlm files with custom syntax and icons.
    echo --------------------------------------------------
    pause
) else (
    echo [ERROR] This script must be executed as Administrator.
    echo Please right-click this file and select "Run as administrator".
    pause
)
