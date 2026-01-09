@echo off
setlocal enabledelayedexpansion

set /p input_file="Enter the file to search in: "
set /p output_file="Enter the output file name: "

if not exist "%input_file%" (
    echo Target file not found!
    exit /b
)

set /p regex_pattern="Enter the regex pattern to search for: "
findstr /R "%regex_pattern%" "%input_file%" > "%output_file%"

if exist "%output_file%" (
    echo Matched lines:
    type "%output_file%"
) else (
    echo No matches found.
)

echo Results saved in %output_file%
