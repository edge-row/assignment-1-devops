#!/bin/bash
# File: create-commands.sh

COMMANDS=("g-init" "g-clone" "g-commit" "g-push" "g-pushall" "g-mkdir" "g-rm" "g-rmdir" "g-ls" "g-help")

for cmd in "${COMMANDS[@]}"; do
    cat > "${cmd}.sh" << EOF
#!/bin/bash
SCRIPT_DIR="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)"
source "\$SCRIPT_DIR/git-commands.sh"
${cmd} "\$@"
EOF
    chmod +x "${cmd}.sh"
    echo "Created ${cmd}.sh"
done

echo "All command files created and made executable!"