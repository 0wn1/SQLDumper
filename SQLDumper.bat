@ECHO OFF
TITLE SQLDumper
MODE con:cols=65 lines=14

rem Host Address
SET HOST_ADDRESS=LOCALHOST
rem Database Username
SET DB_USER=root
rem Database Password; leave it empty if there is no password
SET DB_PASS=
rem Database Name
SET DB_NAME=DATABASE_NAME
rem Set the interval in minutes to save the database
SET INTERVAL_MINUTES=30
rem Add your webhook URL below
SET WEBHOOK_URL=WEBHOOK_LINK
rem Add full path to ".\xampp\mysql\bin\" folder if not on system drive
SET XAMPP_PATH=%SystemDrive%\xampp\mysql\bin\
rem Discord Embed Settings
SET AVATAR_NAME=SQLDumper
SET AVATAR_URL=https://pbs.twimg.com/media/E-K_GusXsAQBv9n.jpg
SET EMBED_COLOR=3447003
SET EMBED_MESSAGE=File saved at
SET EMBED_TITLE=SQLDumper


rem Do not change anything below unless you know what you are doing
rem ////////////////////////////////////////////////////////////////////////////

IF NOT EXIST "%XAMPP_PATH%mysqldump.exe" (
    ECHO ERROR: MySQL dump utility not found.
    GOTO EndScript
)
IF NOT EXIST ".\lib\7z.exe" (
    ECHO ERROR: 7-Zip utility not found.
    GOTO EndScript
)
IF NOT EXIST ".\lib\curl.exe" (
    ECHO ERROR: cURL utility not found.
    GOTO EndScript
)
IF NOT EXIST ".\lib\jq.exe" (
    ECHO ERROR: jq utility not found.
    GOTO EndScript
)

SET MINUTES=%INTERVAL_MINUTES%
SET /A "INTERVAL_MINUTES*=60"
:LOOP

FOR /F "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do SET dt=%%a
SET YYYY=%dt:~0,4%
SET MM=%dt:~4,2%
SET DD=%dt:~6,2%
SET HH=%dt:~8,2%
SET Min=%dt:~10,2%
SET Sec=%dt:~12,2%

SET timestamp=%HH%-%Min%-%Sec%_%DD%-%MM%-%YYYY%
SET backup_file=%DB_NAME%_%timestamp%.sql

CLS 
SET /A num=(%Random% %%9)+1
COLOR %num%                                               
ECHO.
ECHO _______________________________________________
ECHO " _____ _____ __    ____                        "
ECHO "|   __|     |  |  |    \ _ _ _____ ___ ___ ___ "
ECHO "|__   |  |  |  |__|  |  | | |     | . | -_|  _|"
ECHO "|_____|__  _|_____|____/|___|_|_|_|  _|___|_|  "
ECHO "         |__|                     |_|          "
ECHO "_______________________________________________"
ECHO.
ECHO.
ECHO Please wait %INTERVAL_MINUTES% seconds (%MINUTES% minutes)...
TIMEOUT /T %INTERVAL_MINUTES% /NOBREAK >NUL
TIMEOUT /T 5 /NOBREAK >NUL

IF NOT "%HOST_ADDRESS%"=="" (
    IF NOT "%DB_PASS%"=="" (
        "%XAMPP_PATH%mysqldump.exe" -h %HOST_ADDRESS% -u %DB_USER% -p%DB_PASS% %DB_NAME% > %backup_file%
    ) ELSE (
        "%XAMPP_PATH%mysqldump.exe" -h %HOST_ADDRESS% -u %DB_USER% %DB_NAME% > %backup_file%
    ) 
) ELSE (
    IF NOT "%DB_PASS%"=="" (
        "%XAMPP_PATH%mysqldump.exe" -u %DB_USER% -p%DB_PASS% %DB_NAME% > %backup_file%
    ) ELSE (
        "%XAMPP_PATH%mysqldump.exe" -u %DB_USER% %DB_NAME% > %backup_file%
    )
)

SET zip_file=%backup_file:.sql=.zip%
.\lib\7z.exe a -tzip "%zip_file%" "%backup_file%"
CLS
ECHO Dumping database to file...
ECHO Compressing file...
TIMEOUT /T 5 /NOBREAK >NUL
CLS
ECHO Dumping database to file...
ECHO Compressing file...
ECHO Generating log...
ECHO Updating logs.txt...
TIMEOUT /T 2 /NOBREAK >NUL
ECHO Uploading file to webhook...
TIMEOUT /T 5 /NOBREAK >NUL

SET temp=temp.json
SET MESSAGE=%EMBED_MESSAGE% %HH%:%Min%:%Sec%, %DD%/%MM%/%YYYY%
.\lib\curl.exe -H "Content-Type: multipart/form-data" -F "payload_json={\"embeds\":[{\"title\": \"%EMBED_TITLE%\",\"description\": \"%MESSAGE%\",\"color\": %EMBED_COLOR%}], \"username\": \"%AVATAR_NAME%\", \"avatar_url\": \"%AVATAR_URL%\"}" -F "file=@%zip_file%" "%WEBHOOK_URL%" > %temp%
IF ERRORLEVEL 1 (
    ECHO ERROR: Failed to send webhook.
    GOTO Cleanup
)

.\lib\jq.exe -r ".attachments[].url" %temp% >> logs.txt
IF ERRORLEVEL 1 (
    ECHO ERROR: Failed to extract URL from JSON.
    GOTO Cleanup
)

CLS
ECHO Dumping database to file...
ECHO Compressing file...
ECHO Generating log...
ECHO Updating logs.txt...
ECHO Uploading file to webhook...
ECHO Deleting temporary files...
TIMEOUT /T 5 /NOBREAK >NUL
DEL /Q %zip_file%
DEL /Q %backup_file%
DEL /Q %temp%
GOTO LOOP

:Cleanup
ECHO Failed to execute the operation successfully.
EXIT /B

:EndScript
EXIT /B