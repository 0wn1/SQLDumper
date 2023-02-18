# SQLDumper
Preview: [Streamable](https://streamable.com/37w13z "Streamable")

### Features
- Fully configurable
- Automatic backup database with interval in minutes
- Upload to Discord via Webhook
- Discord embedded message
- Name the file with current time and date
- Compress the SQL file making it smaller

###Used tools:
7zip.exe  (x64 bits): [Link](https://www.7-zip.org/download.html "Link")
JSON query (x64 bits)): [Links](https://stedolan.github.io/jq/download "Links")

### Install
- Download SQLDumper
- Open SQLDumper.bat with a text editor
- Configure HOST_ADDRESS, DB_USER, DB_PASS, DB_NAME
- Edit XAMPP_PATH
- Add WEBHOOK_URL
- Edit INTERVAL_MINUTES (default 30 minutes)
- Run SQLDumper.bat

###Note
Windows x32/86: Download and install 7zip and copy from %ProgramFiles%\7-Zip\7zip.exe to .\lib\ and replace 7zip.exe;
Download "jq-win32.exe" and rename to "jq.exe" and then copy it to .\lib\ and replace jq.exe.