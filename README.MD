# SQLDumper
Preview: [Streamable](https://streamable.com/37w13z "Streamable")

### Features
- Fully configurable
- Automatic backup database with interval in minutes
- Upload to Discord via Webhook
- Discord embedded message
- Name the file with current time and date
- Compress the SQL file making it smaller

### Tools:
- 7zip.exe  (x64 bits): [Link](https://www.7-zip.org/download.html "Link")
- JSON query (x64 bits)): [Link](https://stedolan.github.io/jq/download "Links")
- CURL (x64 bits): [Link](https://curl.se/windows/ "Link")

### Install
- Download SQLDumper
- Open SQLDumper.bat with a text editor
- Configure HOST_ADDRESS, DB_USER, DB_PASS, DB_NAME
- Edit XAMPP_PATH
- Add WEBHOOK_URL
- Edit INTERVAL_MINUTES (default 30 minutes)
- Run SQLDumper.bat

### To Windows x32/x86 users:

- Download and install [7zip x86](https://www.7-zip.org/download.html "7zip").
- Locate the `7zip.exe` file in the installation directory `%ProgramFiles%\7-Zip` and copy it to the `.\lib\` folder.
- Download [jq-win32.exe](https://stedolan.github.io/jq/download/ "jq-win32.exe") and rename it to `jq.exe`.
- Replace the `jq.exe` file in the `.\lib\` folder with the renamed one.
- And do the same with [CURL](https://curl.se/windows/ "CURL")

With these steps, you should now be able to use **SQLDumper** on your Windows x32/x86 system.
