@echo off
set UUID=unknown
if exist C:\uuid.txt set /p UUID=<"C:\uuid.txt"
echo uuid=%UUID%
