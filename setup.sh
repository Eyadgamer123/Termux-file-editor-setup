#!/bin/bash

# 1. Ask for user input first
read -p "Enter your motto: " answer

# 2. Setup the directory and save the motto
mkdir -p "$HOME/bin"
echo "$answer" > "$HOME/bin/output.txt"
echo "Motto saved successfully!"

# 3. Inject the termux-file-editor code directly
cat << 'INNER_EOF' > "$HOME/bin/termux-file-editor"
#!/bin/sh

# Print the saved motto if the file exists
if [ -f "$HOME/bin/output.txt" ]; then
    cat "$HOME/bin/output.txt"
    cat "$HOME/termux-file-editor-setup/logo"
else
    echo "No motto found!"
fi

# Wait for 1 second
sleep 1

# Open the file in Nano
exec nano "$@"
INNER_EOF

# 4. Make the editor executable
chmod +x "$HOME/bin/termux-file-editor"
echo "Configuration complete! You can now test sharing a file."
