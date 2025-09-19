#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}MyGit Uninstall Script${NC}"
echo -e "${BLUE}======================${NC}"
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo -e "${YELLOW}Script directory: $SCRIPT_DIR${NC}"

echo -e "${YELLOW}Removing symlinks...${NC}"
COMMANDS=("g-init" "g-clone" "g-commit" "g-push" "g-pushall" "g-mkdir" "g-rm" "g-rmdir" "g-ls" "g-help")

for cmd in "${COMMANDS[@]}"; do
    if [ -L "$SCRIPT_DIR/$cmd" ]; then
        rm "$SCRIPT_DIR/$cmd"
        echo -e "${GREEN}Removed symlink: $cmd${NC}"
    else
        echo -e "${YELLOW}Symlink $cmd not found${NC}"
    fi
done

echo -e "${YELLOW}Note: You will need to manually remove the PATH entry from your shell configuration${NC}"
echo -e "${YELLOW}See README.md for detailed uninstall instructions${NC}"

echo ""
echo -e "${GREEN}Uninstall completed successfully!${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "1. Remove the following line from your shell configuration file:"
echo "   export PATH=\"\$PATH:$SCRIPT_DIR\""
echo ""
echo "2. For bash users, edit ~/.bashrc and remove the PATH line"
echo "3. For zsh users, edit ~/.zshrc and remove the PATH line"
echo "4. Reload your shell configuration:"
echo "   source ~/.bashrc  # for bash"
echo "   source ~/.zshrc   # for zsh"
echo ""
echo -e "${BLUE}Uninstall Summary:${NC}"
echo -e "${BLUE}  Script directory: $SCRIPT_DIR${NC}"
echo -e "${BLUE}  Symlinks removed: ${#COMMANDS[@]} commands${NC}"
echo ""
echo -e "${YELLOW}See README.md for complete uninstall instructions.${NC}"