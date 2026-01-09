#!/bin/bash

# Check if correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <image_path> <wordlist>"
    exit 1
fi

IMAGE_PATH="$1"
WORDLIST="$2"

# Check if image file exists
if [ ! -f "$IMAGE_PATH" ]; then
    echo "Error: Image file '$IMAGE_PATH' not found!"
    exit 1
fi

# Check if wordlist file exists
if [ ! -f "$WORDLIST" ]; then
    echo "Error: Wordlist file '$WORDLIST' not found!"
    exit 1
fi

# Loop through each password in the wordlist
while IFS= read -r PASSWORD; do
    echo "Trying password: $PASSWORD"

    # Run OpenStego extract command with current password
    java -jar openstego.jar extract --stegofile "$IMAGE_PATH" --password "$PASSWORD" --extractfile output.txt

    # Check if extraction was successful
    if [ -s output.txt ]; then
        echo "Success! Correct password: $PASSWORD"
        exit 0
    fi
done < "$WORDLIST"

echo "Bruteforce completed. No valid password found."
exit 1