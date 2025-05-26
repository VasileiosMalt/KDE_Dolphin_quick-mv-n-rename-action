#!/bin/bash
targetFolder="$(pwd)/NewFolder"
mkdir -p "$targetFolder"
for file in "$@"; do
    mv "$file" "$targetFolder"
done

# renamedScript="$(pwd)/renamed.sh"
# if [ -x "$renamedScript" ]; then
#     "$renamedScript"
# fi

originalFolder="$(pwd)/NewFolder"

# Check if the folder existsP
if [ ! -d "$originalFolder" ]; then
  echo "Folder 'NewFolder' does not exist in $(pwd)."
  exit 1
fi

newestFile=""
newestTime=""

# Loop through each regular file in the folder
for file in "$originalFolder"/*; do
    if [ -f "$file" ]; then
        # Use GNU stat; if your system needs a different command (e.g., on macOS: stat -f %m), adjust here.
        mtime=$(stat -c %Y "$file")
        # On the first valid file, initialize newestTime and newestFile.
        if [ -z "$newestTime" ] || [ "$mtime" -gt "$newestTime" ]; then
            newestTime="$mtime"
            newestFile="$file"
        fi
    fi
done

# Exit if no regular file was found in the folder
if [ -z "$newestFile" ]; then
    echo "No files found in 'NewFolder'."
    exit 1
fi

# Get the base filename from the newest file (removing any extension)
filename=$(basename "$newestFile")

# Remove the extension using parameter expansion. This only removes a final suffix after a dot.
baseName="${filename%.*}"

# Define the new target folder name (in the same directory as originalFolder)
targetFolder="$(pwd)/$baseName"

# Check if a folder or file with the target name already exists.
if [ -e "$targetFolder" ]; then
  echo "A folder or file named '$baseName' already exists in $(pwd). Aborting rename."
  exit 1
fi

# Perform the rename.
mv "$originalFolder" "$targetFolder"

echo "Renamed 'NewFolder' to '$baseName'."
