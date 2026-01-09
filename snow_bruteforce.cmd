@echo off
setlocal enabledelayedexpansion

set /p wordlist="Enter the wordlist file: "
set /p input_file="Enter the stego file: "
set /p output_file="Enter the output file: "

if not exist "%wordlist%" (
    echo Wordlist file not found!
    exit /b
)

if not exist "%input_file%" (
    echo Stego file not found!
    exit /b
)

> "%output_file%" echo Bruteforce Results:

for /f "delims=" %%p in (%wordlist%) do (
    set "password=%%p"
    echo Trying password: !password!
    snow -C -p "!password!" "%input_file%" > temp_output.txt 2>&1
    
    findstr /c:"Error" temp_output.txt >nul
    if errorlevel 1 (
        echo [SUCCESS] Password: !password! >> "%output_file%"
        type temp_output.txt >> "%output_file%"
    )
)

del temp_output.txt

echo Bruteforce completed. Results saved in %output_file%
