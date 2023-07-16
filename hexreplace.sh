#!/bin/sh

# Input parameters
input_file="$1"         # Path to the input file
search_hex="$2"         # Hex string to search for
replace_hex="$3"        # Hex string to replace with

# Check if all command-line arguments are provided
if [ -z "$input_file" ] || [ -z "$search_hex" ] || [ -z "$replace_hex" ]; then
  printf "Usage: %s <input_file> <search_hex> <replace_hex>\n" "$0"
  exit 1
fi

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  printf "Input file '%s' does not exist.\n" "$input_file"
  exit 1
fi

printf "\nHEX String Replacement Script\n"
printf "\033[36mInput file: %s\033[0m\n" "$input_file"
printf "\033[36mOld HEX string: %s\033[0m\n" "$search_hex"
printf "\033[36mNew HEX string: %s\033[0m\n" "$replace_hex"

# Remove spaces from hex strings
search_hex_nospace=$(echo "$search_hex" | tr -d ' ')
replace_hex_nospace=$(echo "$replace_hex" | tr -d ' ')

# Check if the hex string exists in the file
if ! perl -e "exit 1 unless -s '$input_file' && do {
       local \$/ = undef; 
       my \$data = <>;
       my \$binary = pack('H*', '$search_hex_nospace');
       index(\$data, \$binary) >= 0
     }" <"$input_file"
then
  printf "\033[31mOld HEX string not found in the input file.\033[0m\n"
  exit 1
fi

# Backup the original file
backup_file="${input_file}.bak"
cp "$input_file" "$backup_file"
printf "Backup created: %s\n" "$backup_file"

# Use perl to perform the search and replace on the binary file
perl -i -pe "
BEGIN {
  \$search_hex = pack('H*', '$search_hex_nospace');
  \$replace_hex = pack('H*', '$replace_hex_nospace');
}
s/\Q\$search_hex\E/\$replace_hex/g" "$input_file"

printf "\033[32mHEX string search and replace completed.\nChanges saved to %s.\033[0m\n" "$input_file"
