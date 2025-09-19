# MyGit - Linux Git Repository Manager

A simplified command-line tool that combines Git repository management with Linux file system operations. This tool allows users to create Git repositories, clone existing repositories, perform basic commit and push operations, and manage files and directories within the repositories.

## Features

-   **Git Operations**: Initialize repositories, clone from remote URLs, commit changes, and push to remote repositories
-   **File System Operations**: Create directories, delete files and directories, and list directory contents
-   **Smart Git Integration**: File operations automatically handle Git tracking (staged deletions, proper Git removal)
-   **Error Handling**: Comprehensive error checking with informative messages
-   **User-Friendly Interface**: Color-coded output and clear usage instructions

## Installation

1. Download the `git-commands.sh` file
2. Make it executable:
    ```bash
    chmod +x git-commands.sh
    ```

## Usage

All commands follow the format: `./git-commands.sh <command> [arguments]`

### Available Commands

#### Git Operations

| Command     | Description                                  | Usage                                                      |
| ----------- | -------------------------------------------- | ---------------------------------------------------------- |
| `g-init`    | Initialize a new Git repository              | `./git-commands.sh g-init <directory>`                     |
| `g-clone`   | Clone a repository from remote URL           | `./git-commands.sh g-clone <remote_url> <local_directory>` |
| `g-commit`  | Add and commit changes to repository         | `./git-commands.sh g-commit -m "<commit_message>"`         |
| `g-push`    | Push committed changes to remote repository  | `./git-commands.sh g-push`                                 |
| `g-pushall` | Add, commit, and push changes in one command | `./git-commands.sh g-pushall -m "<commit_message>"`        |

#### File Operations

| Command   | Description                               | Usage                                        |
| --------- | ----------------------------------------- | -------------------------------------------- |
| `g-mkdir` | Create a directory in the repository      | `./git-commands.sh g-mkdir <directory_name>` |
| `g-rm`    | Delete a file (with Git integration)      | `./git-commands.sh g-rm <file_name>`         |
| `g-rmdir` | Delete a directory (with Git integration) | `./git-commands.sh g-rmdir <directory_name>` |
| `g-ls`    | List contents of a directory              | `./git-commands.sh g-ls <directory>`         |

#### General

| Command  | Description                              | Usage                      |
| -------- | ---------------------------------------- | -------------------------- |
| `g-help` | Show help message and available commands | `./git-commands.sh g-help` |

## Examples

### Basic Git Workflow

```bash
# Initialize a new repository
./git-commands.sh g-init myproject

# Navigate to the project directory
cd myproject

# Create some directories and files
./git-commands.sh g-mkdir docs
./git-commands.sh g-mkdir src
echo "Hello World" > src/main.txt

# List directory contents
./git-commands.sh g-ls .

# Commit changes
./git-commands.sh g-commit -m "Initial project setup"

# Push to remote (if remote is configured)
./git-commands.sh g-push
```

### Cloning and Working with Existing Repositories

```bash
# Clone an existing repository
./git-commands.sh g-clone https://github.com/user/repo.git myrepo

# Navigate to the cloned repository
cd myrepo

# Create additional directories
./git-commands.sh g-mkdir tests

# Delete a tracked file (automatically staged for deletion)
./git-commands.sh g-rm oldfile.txt

# Delete a directory with tracked files (automatically staged for deletion)
./git-commands.sh g-rmdir temp

# Commit and push changes in one command
./git-commands.sh g-pushall -m "Updated project structure"
```

### File Management with Git Integration

```bash
# List current directory contents
./git-commands.sh g-ls .

# List specific directory contents
./git-commands.sh g-ls docs

# Create multiple directories
./git-commands.sh g-mkdir config
./git-commands.sh g-mkdir logs

# Remove files (smart Git integration)
./git-commands.sh g-rm config.txt        # If tracked: removes from Git + file system
                                        # If untracked: removes from file system only

# Remove directories (smart Git integration)
./git-commands.sh g-rmdir old_backup     # If contains tracked files: removes from Git + file system
                                        # If no tracked files: removes from file system only

# Commit the staged deletions
./git-commands.sh g-commit -m "Clean up old files and directories"
```

### Advanced Git Operations

```bash
# Quick add, commit, and push in one command
./git-commands.sh g-pushall -m "Quick update"

# Traditional workflow (separate steps)
./git-commands.sh g-commit -m "Make changes"
./git-commands.sh g-push
```

## Error Handling

The tool includes comprehensive error handling for common scenarios:

-   **Missing arguments**: Clear error messages when required parameters are not provided
-   **File/Directory conflicts**: Checks for existing files/directories before operations
-   **Git repository validation**: Ensures operations are performed within Git repositories when required
-   **Command execution errors**: Handles failures in Git and file system operations gracefully
-   **Smart file tracking**: Automatically detects if files are tracked by Git and handles removal appropriately

### Common Error Messages

-   `Error: Directory name required` - When required directory parameter is missing
-   `Error: Directory 'name' already exists` - When trying to create an existing directory
-   `Error: Not in a Git repository` - When Git operations are attempted outside a repository
-   `Error: File 'name' does not exist` - When trying to delete a non-existent file
-   `Error: Failed to remove file from Git` - When Git removal operation fails

## Git Integration Features

### Smart File Operations

-   **`g-rm`**: Automatically detects if a file is tracked by Git

    -   If tracked: Uses `git rm` to remove from both Git index and file system
    -   If untracked: Uses regular `rm` to remove from file system only
    -   Changes are automatically staged for commit

-   **`g-rmdir`**: Automatically detects if a directory contains tracked files
    -   If contains tracked files: Uses `git rm -r` to remove from both Git index and file system
    -   If no tracked files: Uses regular `rm -rf` to remove from file system only
    -   Changes are automatically staged for commit

### Git Workflow Integration

-   **Staged deletions**: File/directory removals are automatically staged for commit
-   **Proper Git tracking**: Uses Git's built-in removal mechanisms for tracked files
-   **Fallback handling**: Gracefully handles untracked files with regular file system operations

## Requirements

-   **Bash shell** (version 4.0 or higher)
-   **Git** installed on the system
-   **Linux/Unix environment** (macOS, Linux, WSL)

## Output Format

The tool uses color-coded output for better user experience:

-   **Red**: Error messages
-   🟢 **Green**: Success messages
-   🟡 **Yellow**: Progress/status messages
-   **Blue**: Information and help text

## Technical Details

-   **Language**: Bash shell script
-   **Dependencies**: Git command-line tool
-   **File Size**: Single executable script
-   **Compatibility**: Works with standard Git repositories and remote services (GitHub, GitLab, etc.)
-   **Git Integration**: Uses `git rm` and `git rm -r` for proper file tracking management

## Troubleshooting

### Common Issues

1. **Permission Denied**

    ```bash
    chmod +x git-commands.sh
    ```

2. **Git Not Found**

    - Ensure Git is installed: `git --version`
    - Install Git if missing: `sudo apt install git` (Ubuntu/Debian) or `brew install git` (macOS)

3. **Repository Not Found**

    - Ensure you're in a Git repository for Git operations
    - Use `g-init` to create a new repository or `g-clone` to clone an existing one

4. **Remote Push Fails**

    - Check if remote repository is configured: `git remote -v`
    - Ensure you have proper permissions to push to the remote repository

5. **File Removal Issues**

    - For tracked files: The tool automatically uses `git rm` for proper Git integration
    - For untracked files: The tool uses regular file system removal
    - Check Git status: `git status` to see staged changes

## Assignment Information

**Course**: COMP-4964 DevOps  
**Assignment**: Assignment 1 - Linux Git Repository Manager  
**Author**: Edro Gonzales, A01257468  
**Due Date**: September 21, 2024

## License

This project is created for educational purposes as part of COMP-4964 DevOps course assignment.
