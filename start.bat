@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set "PROJECT=%~dp0"
set "DEV_DIR=%PROJECT%.dev"
set "JDK_DIR=%DEV_DIR%\jdk"
set "TOMCAT_DIR=%DEV_DIR%\tomcat"

set "JAVA_SRC=%PROJECT%src\main\java"
set "WEBAPP=%PROJECT%src\main\webapp"
set "BUILD=%PROJECT%build\classes"
set "LIB=%WEBAPP%\WEB-INF\lib"

set "JDK_URL=https://api.adoptium.net/v3/binary/latest/17/ga/windows/x64/jdk/hotspot/normal/eclipse?project=jdk"
set "TOMCAT_VER=9.0.115"
set "TOMCAT_URL=https://mirror.navercorp.com/apache/tomcat/tomcat-9/v%TOMCAT_VER%/bin/apache-tomcat-%TOMCAT_VER%.zip"

echo.
echo   dodram-jsp dev server
echo   --------------------------------------------------

if not exist "%DEV_DIR%" mkdir "%DEV_DIR%"

REM ============================================================
REM Find JDK
REM ============================================================
set "FOUND_JDK="

REM 1) .dev/jdk (project-local)
if exist "%JDK_DIR%\bin\javac.exe" (
    set "JAVA_HOME=%JDK_DIR%"
    set "FOUND_JDK=local"
)

REM 2) System JAVA_HOME
if not defined FOUND_JDK (
    if exist "%JAVA_HOME%\bin\javac.exe" set "FOUND_JDK=system"
)

REM 3) Download
if not defined FOUND_JDK (
    echo [*] JDK not found. Downloading JDK 17...

    powershell -NoProfile -Command ^
        "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;" ^
        "Invoke-WebRequest '%JDK_URL%' -OutFile '%DEV_DIR%\jdk.zip' -UseBasicParsing"

    if not exist "%DEV_DIR%\jdk.zip" (
        echo [!!] JDK download failed
        exit /b 1
    )

    echo [*] Extracting JDK...
    powershell -NoProfile -Command "Expand-Archive '%DEV_DIR%\jdk.zip' '%DEV_DIR%\jdk_temp' -Force"

    for /d %%d in ("%DEV_DIR%\jdk_temp\*") do move "%%d" "%JDK_DIR%" >nul
    rmdir "%DEV_DIR%\jdk_temp" 2>nul
    del "%DEV_DIR%\jdk.zip" 2>nul

    if exist "%JDK_DIR%\bin\javac.exe" (
        set "JAVA_HOME=%JDK_DIR%"
        set "FOUND_JDK=downloaded"
    ) else (
        echo [!!] JDK install failed
        exit /b 1
    )
)

echo [OK] JDK: !JAVA_HOME! (!FOUND_JDK!)

REM ============================================================
REM Find Tomcat
REM ============================================================
if not exist "%TOMCAT_DIR%\bin\catalina.bat" (
    echo [*] Tomcat %TOMCAT_VER% not found. Downloading...

    powershell -NoProfile -Command ^
        "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;" ^
        "Invoke-WebRequest '%TOMCAT_URL%' -OutFile '%DEV_DIR%\tomcat.zip' -UseBasicParsing"

    if not exist "%DEV_DIR%\tomcat.zip" (
        echo [!!] Tomcat download failed
        exit /b 1
    )

    echo [*] Extracting Tomcat...
    powershell -NoProfile -Command "Expand-Archive '%DEV_DIR%\tomcat.zip' '%DEV_DIR%\tomcat_temp' -Force"

    for /d %%d in ("%DEV_DIR%\tomcat_temp\*") do move "%%d" "%TOMCAT_DIR%" >nul
    rmdir "%DEV_DIR%\tomcat_temp" 2>nul
    del "%DEV_DIR%\tomcat.zip" 2>nul

    if not exist "%TOMCAT_DIR%\bin\catalina.bat" (
        echo [!!] Tomcat install failed
        exit /b 1
    )
)
echo [OK] Tomcat: %TOMCAT_DIR%

set "CATALINA_HOME=%TOMCAT_DIR%"

REM ============================================================
REM Compile
REM ============================================================
echo [*] Compiling...
if not exist "%BUILD%" mkdir "%BUILD%"

set "CP="
for %%j in ("%LIB%\*.jar") do set "CP=!CP!;%%j"
for %%j in ("%CATALINA_HOME%\lib\*.jar") do set "CP=!CP!;%%j"

dir /s /b "%JAVA_SRC%\*.java" > "%TEMP%\dodram_sources.txt" 2>nul
"!JAVA_HOME!\bin\javac.exe" -encoding UTF-8 -d "%BUILD%" -cp "!CP!" @"%TEMP%\dodram_sources.txt"
if errorlevel 1 exit /b 1

robocopy "%JAVA_SRC%" "%BUILD%" /s /xf *.java >nul 2>&1
echo [OK] Compile done

REM ============================================================
REM Context XML + Start
REM ============================================================
set "CTX_DIR=%CATALINA_HOME%\conf\Catalina\localhost"
if not exist "%CTX_DIR%" mkdir "%CTX_DIR%"
set "WP=%WEBAPP:\=/%"
set "CP_BUILD=%BUILD:\=/%"
> "%CTX_DIR%\ROOT.xml" (
    echo ^<?xml version="1.0" encoding="UTF-8"?^>
    echo ^<Context docBase="%WP%"^>
    echo     ^<Resources^>
    echo         ^<PreResources className="org.apache.catalina.webresources.DirResourceSet" base="%CP_BUILD%" webAppMount="/WEB-INF/classes" /^>
    echo     ^</Resources^>
    echo ^</Context^>
)

if exist "%CATALINA_HOME%\webapps\ROOT" (
    if not exist "%CATALINA_HOME%\webapps\ROOT.bak" (
        ren "%CATALINA_HOME%\webapps\ROOT" ROOT.bak
    )
)

echo [*] Starting Tomcat on http://localhost:8080

REM Open browser after Tomcat is ready (background)
> "%DEV_DIR%\open.bat" (
    echo @echo off
    echo set /a N=0
    echo :check
    echo set /a N+=1
    echo if %%N%% gtr 25 exit /b
    echo ping -n 2 127.0.0.1 ^>nul
    echo netstat -ano 2^>nul ^| findstr ":8080 " ^| findstr "LISTENING" ^>nul 2^>^&1
    echo if errorlevel 1 goto check
    echo start "" "http://localhost:8080"
)
start "" /B cmd /c "%DEV_DIR%\open.bat"

call "%CATALINA_HOME%\bin\catalina.bat" run
