#!/bin/bash

# 1. Define the Morse Table
declare -A morse_table
morse_table=(
    [A]=".-"     [B]="-..."    [C]="-.-."    [D]="-.."
    [E]="."      [F]="..-."    [G]="--."     [H]="...."
    [I]=".."      [J]=".---"    [K]="-.-"     [L]=".-.."
    [M]="--"      [N]="-."      [O]="---"     [P]=".--."
    [Q]="--.-"    [R]=".-."     [S]="..."     [T]="-"
    [U]="..-"     [V]="...-"    [W]=".--"     [X]="-..-"
    [Y]="-.--"    [Z]="--.."    [0]="-----"   [1]=".----"
    [2]="..---"   [3]="...--"    [4]="....-"   [5]="....."
    [6]="-...."   [7]="--..."    [8]="---.."   [9]="----."
    [" "]=/
)

echo "----------------------------"
echo " Morse Code Converter "
echo "----------------------------"
echo "1. Text to Morse (Encode)"
echo "2. Morse to Text (Decode)"
read -p "Select option (1 or 2): " choice

# --- ENCODING LOGIC (Text to Morse) ---
if [[ $choice == "1" ]]; then
    read -p "Enter text: " input
    # Convert input to uppercase to match keys
    input=$(echo "$input" | tr '[:lower:]' '[:upper:]')
    encoded=""

    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        # Check if the character exists in our table
        if [[ -n "${morse_table[$char]}" ]]; then
            encoded+="${morse_table[$char]} "
        fi
    done
    echo -e "\nEncoded Morse: $encoded"

# --- DECODING LOGIC (Morse to Text) ---
elif [[ $choice == "2" ]]; then
    echo "Note: Use spaces between letters and '/' between words."
    read -p "Enter Morse: " input
    decoded=""

    # Convert the input string into an array of signals
    read -a signals <<< "$input"

    for s in "${signals[@]}"; do
        found=false
        # Reverse lookup: find the key that matches the value $s
        for key in "${!morse_table[@]}"; do
            if [[ "${morse_table[$key]}" == "$s" ]]; then
                decoded+="$key"
                found=true
                break
            fi
        done
        
        # If no match is found, add a placeholder
        if [[ $found == false ]]; then
            decoded+="?"
        fi
    done
    echo -e "\nDecoded Text: $decoded"

else
    echo "Invalid selection. Please run the script again."
fi