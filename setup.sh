#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}MyGit Setup Script${NC}"
echo -e "${BLUE}==================${NC}"
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo -e "${YELLOW}Script directory: $SCRIPT_DIR${NC}"

if [ ! -f "$SCRIPT_DIR/git-commands.sh" ]; then
    echo -e "${RED}Error: git-commands.sh not found in $SCRIPT_DIR${NC}"
    exit 1
fi

echo -e "${YELLOW}Making git-commands.sh executable...${NC}"
chmod +x "$SCRIPT_DIR/git-commands.sh"

echo -e "${YELLOW}Note: You will need to manually add the directory to your PATH${NC}"
echo -e "${YELLOW}See README.md for detailed installation instructions${NC}"

echo -e "${YELLOW}Creating symlinks...${NC}"

COMMANDS=("g-init" "g-clone" "g-commit" "g-push" "g-pushall" "g-mkdir" "g-rm" "g-rmdir" "g-ls" "g-help")

for cmd in "${COMMANDS[@]}"; do
    if [ -L "$SCRIPT_DIR/$cmd" ]; then
        echo -e "${GREEN}Symlink $cmd already exists${NC}"
    else
        ln -s "git-commands.sh" "$SCRIPT_DIR/$cmd"
        echo -e "${GREEN}Created symlink: $cmd${NC}"
    fi
done

echo -e "${YELLOW}Updating git-commands.sh to handle symlinks...${NC}"

if grep -q "COMMAND_NAME=\$(basename \"\$0\")" "$SCRIPT_DIR/git-commands.sh"; then
    echo -e "${GREEN}Symlink handling code already exists${NC}"
else
    cat >> "$SCRIPT_DIR/git-commands.sh" << 'EOF'

# Symlink handling - detect when called via symlink
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    COMMAND_NAME=$(basename "$0")
    
    case "$COMMAND_NAME" in
        "g-init")
            g-init "$@"
            ;;
        "g-clone")
            g-clone "$@"
            ;;
        "g-commit")
            g-commit "$@"
            ;;
        "g-push")
            g-push "$@"
            ;;
        "g-pushall")
            g-pushall "$@"
            ;;
        "g-mkdir")
            g-mkdir "$@"
            ;;
        "g-rm")
            g-rm "$@"
            ;;
        "g-rmdir")
            g-rmdir "$@"
            ;;
        "g-ls")
            g-ls "$@"
            ;;
        "g-help")
            show_help
            ;;
        "git-commands.sh")
            # If called directly, use the original case statement
            case "$1" in
                "g-init")
                    shift
                    g-init "$@"
                    ;;
                "g-clone")
                    shift
                    g-clone "$@"
                    ;;
                "g-commit")
                    shift
                    g-commit "$@"
                    ;;
                "g-push")
                    shift
                    g-push "$@"
                    ;;
                "g-pushall")
                    shift
                    g-pushall "$@"
                    ;;
                "g-mkdir")
                    shift
                    g-mkdir "$@"
                    ;;
                "g-rm")
                    shift
                    g-rm "$@"
                    ;;
                "g-rmdir")
                    shift
                    g-rmdir "$@"
                    ;;
                "g-ls")
                    shift
                    g-ls "$@"
                    ;;
                "g-help"|"help"|"-h"|"--help"|"")
                    show_help
                    ;;
                *)
                    echo -e "${RED}Error: Unknown command '$1'${NC}"
                    echo "Use './git-commands.sh g-help' to see available commands"
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo -e "${RED}Error: Unknown command '$COMMAND_NAME'${NC}"
            echo "Use 'g-help' to see available commands"
            exit 1
            ;;
    esac
fi
EOF
    echo -e "${GREEN}Added symlink handling code to git-commands.sh${NC}"
fi

echo ""
echo -e "${GREEN}Setup completed successfully!${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "1. Add the following line to your shell configuration file:"
echo "   export PATH=\"\$PATH:$SCRIPT_DIR\""
echo ""
echo "2. For bash users, add to ~/.bashrc:"
echo "   echo \"export PATH=\\\"\\\$PATH:$SCRIPT_DIR\\\"\" >> ~/.bashrc"
echo ""
echo "3. For zsh users, add to ~/.zshrc:"
echo "   echo \"export PATH=\\\"\\\$PATH:$SCRIPT_DIR\\\"\" >> ~/.zshrc"
echo ""
echo "4. Reload your shell configuration:"
echo "   source ~/.bashrc  # for bash"
echo "   source ~/.zshrc   # for zsh"
echo ""
echo "5. Then you can use commands from anywhere:"
echo "   g-init myproject"
echo "   g-clone https://github.com/user/repo.git myrepo"
echo "   g-commit -m \"Initial commit\""
echo "   g-help"
echo ""
echo -e "${YELLOW}See README.md for complete installation instructions.${NC}"