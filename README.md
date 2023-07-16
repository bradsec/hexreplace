# HEX String Replacement Script

This script replaces **all instances** of a specific hexadecimal string within a binary file. If more than one match of the `search_hex` is found in the input file, each match will be replaced with the `replace_hex` string. The script first checks if the `search_hex` exists in the file. If it does, it proceeds to use Perl to perform the search and replace operation on the binary file. This script can handle hex string values that span across multiple lines. The script creates a backup of the original file by appending the extension ".bak".

## Usage

*`sudo` may be required in front of command depending on permissions of the file being modified.*

```terminal
# make executable
chmod +x hexreplace.sh

# run with command-line arguments
./hexreplace.sh <input_file> <search_hex> <replace_hex>

# Example
sudo ./hexreplace.sh "/path/thisfile" "C0 0F 00 00 01 01" "C1 FF 00 01 02 02"
```

## Parameters

- `input_file`: Path to the input file.
- `search_hex`: Hex string to search for.
- `replace_hex`: Hex string to replace with.

## Prerequisites

- This script requires Perl to be installed on the system. It is commonly installed by default on many Linux distros and most macOS versions. Perl was used over sed, grep combined with hexdump or xxd to more simply handle the string replacement. It also worked more reliabably with strings which span multiple lines.
