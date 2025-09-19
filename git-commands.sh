#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_help() {
    echo -e "${BLUE}Linux Git Repository Manager${NC}"
    echo -e "${BLUE}=====================================${NC}"
    echo ""
    echo "Available commands:"
    echo ""
    echo -e "${GREEN}Git Operations:${NC}"
    echo "  g-init <directory>                    - Initialize a new Git repository"
    echo "  g-clone <remote_url> <local_dir>      - Clone a repository from remote URL"
    echo "  g-commit -m \"<message>\"              - Add and commit changes"
    echo "  g-push                                - Push committed changes to remote"
    echo "  g-pushall -m \"<message>\"             - Add, commit, and push changes in one command"
    echo ""
    echo -e "${GREEN}File Operations:${NC}"
    echo "  g-mkdir <directory_name>              - Create a directory in the repository"
    echo "  g-rm <file_name>                      - Delete a file from the repository"
    echo "  g-rmdir <directory_name>              - Delete a directory and its contents"
    echo ""
    echo -e "${GREEN}General:${NC}"
    echo "  g-help                                - Show this help message"
    echo ""
    echo "Usage:"
    echo "  ./git-commands.sh <command> [arguments]"
    echo ""
    echo "Examples:"
    echo "  ./git-commands.sh g-init myproject"
    echo "  ./git-commands.sh g-clone https://github.com/user/repo.git myrepo"
    echo "  ./git-commands.sh g-commit -m \"Initial commit\""
    echo "  ./git-commands.sh g-pushall -m \"Quick commit and push\""
    echo "  ./git-commands.sh g-mkdir docs"
}

check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}Error: Not in a Git repository${NC}"
        return 1
    fi
    return 0
}

g-init() {
    local directory="$1"
    
    if [ -z "$directory" ]; then
        echo -e "${RED}Error: Directory name required${NC}"
        echo "Usage: g-init <directory>"
        return 1
    fi
    
    if [ -d "$directory" ]; then
        echo -e "${RED}Error: Directory '$directory' already exists${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Creating directory '$directory'...${NC}"
    if ! mkdir -p "$directory"; then
        echo -e "${RED}Error: Failed to create directory '$directory'${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Initializing Git repository...${NC}"
    if ! (cd "$directory" && git init); then
        echo -e "${RED}Error: Failed to initialize Git repository${NC}"
        rm -rf "$directory"
        return 1
    fi
    
    echo -e "${GREEN}Success: Git repository initialized in '$directory'${NC}"
}

g-clone() {
    local remote_url="$1"
    local local_directory="$2"
    
    if [ -z "$remote_url" ] || [ -z "$local_directory" ]; then
        echo -e "${RED}Error: Both remote URL and local directory required${NC}"
        echo "Usage: g-clone <remote_url> <local_directory>"
        return 1
    fi
    
    if [ -d "$local_directory" ]; then
        echo -e "${RED}Error: Directory '$local_directory' already exists${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Cloning repository from '$remote_url'...${NC}"
    if ! git clone "$remote_url" "$local_directory"; then
        echo -e "${RED}Error: Failed to clone repository${NC}"
        return 1
    fi
    
    echo -e "${GREEN}Success: Repository cloned to '$local_directory'${NC}"
}

g-commit() {
    local commit_message=""
    local flag="$1"
    
    if [ "$flag" != "-m" ]; then
        echo -e "${RED}Error: -m flag required for commit message${NC}"
        echo "Usage: g-commit -m \"<commit_message>\""
        return 1
    fi
    
    commit_message="$2"
    if [ -z "$commit_message" ]; then
        echo -e "${RED}Error: Commit message required${NC}"
        echo "Usage: g-commit -m \"<commit_message>\""
        return 1
    fi
    
    if ! check_git_repo; then
        return 1
    fi
    
    echo -e "${YELLOW}Adding all changes...${NC}"
    if ! git add .; then
        echo -e "${RED}Error: Failed to add changes${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Committing changes...${NC}"
    if ! git commit -m "$commit_message"; then
        echo -e "${RED}Error: Failed to commit changes${NC}"
        return 1
    fi
    
    echo -e "${GREEN}Success: Changes committed with message: '$commit_message'${NC}"
}

g-push() {
    if ! check_git_repo; then
        return 1
    fi
    
    echo -e "${YELLOW}Pushing changes to remote repository...${NC}"
    if ! git push; then
        echo -e "${RED}Error: Failed to push changes${NC}"
        echo "Make sure you have a remote repository configured and proper permissions"
        return 1
    fi
    
    echo -e "${GREEN}Success: Changes pushed to remote repository${NC}"
}

g-pushall() {
    local commit_message=""
    local flag="$1"
    
    if [ "$flag" != "-m" ]; then
        echo -e "${RED}Error: -m flag required for commit message${NC}"
        echo "Usage: g-pushall -m \"<commit_message>\""
        return 1
    fi
    
    commit_message="$2"
    if [ -z "$commit_message" ]; then
        echo -e "${RED}Error: Commit message required${NC}"
        echo "Usage: g-pushall -m \"<commit_message>\""
        return 1
    fi
    
    if ! check_git_repo; then
        return 1
    fi
    
    echo -e "${YELLOW}Adding all changes...${NC}"
    if ! git add .; then
        echo -e "${RED}Error: Failed to add changes${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Committing changes...${NC}"
    if ! git commit -m "$commit_message"; then
        echo -e "${RED}Error: Failed to commit changes${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Pushing changes to remote repository...${NC}"
    if ! git push; then
        echo -e "${RED}Error: Failed to push changes${NC}"
        echo "Make sure you have a remote repository configured and proper permissions"
        return 1
    fi
    
    echo -e "${GREEN}Success: Changes committed and pushed with message: '$commit_message'${NC}"
}

g-mkdir() {
    local directory_name="$1"
    
    if [ -z "$directory_name" ]; then
        echo -e "${RED}Error: Directory name required${NC}"
        echo "Usage: g-mkdir <directory_name>"
        return 1
    fi
    
    if ! check_git_repo; then
        return 1
    fi
    
    if [ -d "$directory_name" ]; then
        echo -e "${RED}Error: Directory '$directory_name' already exists${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Creating directory '$directory_name'...${NC}"
    if ! mkdir -p "$directory_name"; then
        echo -e "${RED}Error: Failed to create directory '$directory_name'${NC}"
        return 1
    fi
    
    echo -e "${GREEN}Success: Directory '$directory_name' created${NC}"
}

g-rm() {
    local file_name="$1"
    
    if [ -z "$file_name" ]; then
        echo -e "${RED}Error: File name required${NC}"
        echo "Usage: g-rm <file_name>"
        return 1
    fi
    
    if ! check_git_repo; then
        return 1
    fi
    
    if [ ! -f "$file_name" ]; then
        echo -e "${RED}Error: File '$file_name' does not exist${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Removing file '$file_name' from Git and file system...${NC}"
    
    if git ls-files --error-unmatch "$file_name" > /dev/null 2>&1; then
        if ! git rm "$file_name"; then
            echo -e "${RED}Error: Failed to remove file '$file_name' from Git${NC}"
            return 1
        fi
        
        echo -e "${YELLOW}Committing deletion...${NC}"
        if ! git commit -m "Remove file: $file_name"; then
            echo -e "${RED}Error: Failed to commit deletion${NC}"
            return 1
        fi
        
        echo -e "${GREEN}Success: File '$file_name' removed and committed${NC}"
    else
        if ! rm "$file_name"; then
            echo -e "${RED}Error: Failed to delete file '$file_name'${NC}"
            return 1
        fi
        echo -e "${GREEN}Success: File '$file_name' deleted from file system (not tracked by Git)${NC}"
    fi
}

g-rmdir() {
    local directory_name="$1"
    
    if [ -z "$directory_name" ]; then
        echo -e "${RED}Error: Directory name required${NC}"
        echo "Usage: g-rmdir <directory_name>"
        return 1
    fi
    
    if ! check_git_repo; then
        return 1
    fi
    
    if [ ! -d "$directory_name" ]; then
        echo -e "${RED}Error: Directory '$directory_name' does not exist${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Removing directory '$directory_name' from Git and file system...${NC}"
    
    if git ls-files "$directory_name" | grep -q .; then
        if ! git rm -r "$directory_name"; then
            echo -e "${RED}Error: Failed to remove directory '$directory_name' from Git${NC}"
            return 1
        fi
        
        echo -e "${YELLOW}Committing deletion...${NC}"
        if ! git commit -m "Remove directory: $directory_name"; then
            echo -e "${RED}Error: Failed to commit deletion${NC}"
            return 1
        fi
        
        echo -e "${GREEN}Success: Directory '$directory_name' removed and committed${NC}"
    else
        if ! rm -rf "$directory_name"; then
            echo -e "${RED}Error: Failed to delete directory '$directory_name'${NC}"
            return 1
        fi
        echo -e "${GREEN}Success: Directory '$directory_name' deleted from file system (not tracked by Git)${NC}"
    fi
}


if [[ "${BASH_SOURCE[0]}" == "${0}" ]] && [[ "$(basename "$0")" == "git-commands.sh" ]]; then
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
fi

if [[ "${BASH_SOURCE[0]}" == "${0}" ]] && [[ "$(basename "$0")" != "git-commands.sh" ]]; then
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
            echo -e "${RED}Error: This should not happen${NC}"
            exit 1
            ;;
        *)
            echo -e "${RED}Error: Unknown command '$COMMAND_NAME'${NC}"
            echo "Use 'g-help' to see available commands"
            exit 1
            ;;
    esac
fi
