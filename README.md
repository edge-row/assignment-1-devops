# MyGit - Git Repository Manager

A command-line tool for Git repository management with integrated file operations. Create repositories, clone, commit, push, and manage files with smart Git integration.

## Features

-   **Git Operations**: Initialize, clone, commit, and push repositories
-   **File Operations**: Create directories, delete files/directories with smart Git integration
-   **Error Handling**: Comprehensive error checking with color-coded output

## Installation

### Quick Setup

1. **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd assignment-1-devops
    ```

2. **Run the setup script:**

    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```

3. **Add to your PATH manually:**

    **For Bash users:**

    ```bash
    echo "export PATH=\"\$PATH:$(pwd)\"" >> ~/.bashrc
    source ~/.bashrc
    ```

    **For Zsh users:**

    ```bash
    echo "export PATH=\"\$PATH:$(pwd)\"" >> ~/.zshrc
    source ~/.zshrc
    ```

4. **Verify installation:**
    ```bash
    g-help
    ```

### Manual Installation

If you prefer to set up manually:

1. **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd assignment-1-devops
    ```

2. **Make scripts executable:**

    ```bash
    chmod +x *.sh
    ```

3. **Add to your PATH:**

    **For Bash users:**

    ```bash
    echo "export PATH=\"\$PATH:$(pwd)\"" >> ~/.bashrc
    source ~/.bashrc
    ```

    **For Zsh users:**

    ```bash
    echo "export PATH=\"\$PATH:$(pwd)\"" >> ~/.zshrc
    source ~/.zshrc
    ```

4. **Test the installation:**
    ```bash
    ./git-commands.sh g-help
    ```

## Uninstallation

### Quick Uninstall

1. **Run the uninstall script:**

    ```bash
    ./uninstall.sh
    ```

2. **Remove from your PATH manually:**

    **For Bash users:**

    ```bash
    # Edit ~/.bashrc and remove the line:
    # export PATH="$PATH:/path/to/assignment-1-devops"
    nano ~/.bashrc
    source ~/.bashrc
    ```

    **For Zsh users:**

    ```bash
    # Edit ~/.zshrc and remove the line:
    # export PATH="$PATH:/path/to/assignment-1-devops"
    nano ~/.zshrc
    source ~/.zshrc
    ```

3. **Remove the repository directory:**
    ```bash
    cd ..
    rm -rf assignment-1-devops
    ```

### Manual Uninstall

If you prefer to uninstall manually:

1. **Remove symlinks:**

    ```bash
    rm -f g-init g-clone g-commit g-push g-pushall g-mkdir g-rm g-rmdir g-ls g-help
    ```

2. **Remove from your PATH:**

    **For Bash users:**

    ```bash
    # Edit ~/.bashrc and remove the PATH line
    nano ~/.bashrc
    source ~/.bashrc
    ```

    **For Zsh users:**

    ```bash
    # Edit ~/.zshrc and remove the PATH line
    nano ~/.zshrc
    source ~/.zshrc
    ```

3. **Remove the repository directory:**
    ```bash
    cd ..
    rm -rf assignment-1-devops
    ```

## Usage

Commands can be used in two ways:

-   Direct: `./git-commands.sh <command> [arguments]`
-   Global (after setup): `<command> [arguments]`

### Available Commands

#### Git Operations

| Command     | Description                                  | Usage                                    |
| ----------- | -------------------------------------------- | ---------------------------------------- |
| `g-init`    | Initialize a new Git repository              | `g-init <directory>`                     |
| `g-clone`   | Clone a repository from remote URL           | `g-clone <remote_url> <local_directory>` |
| `g-commit`  | Add and commit changes to repository         | `g-commit -m "<commit_message>"`         |
| `g-push`    | Push committed changes to remote repository  | `g-push`                                 |
| `g-pushall` | Add, commit, and push changes in one command | `g-pushall -m "<commit_message>"`        |

#### File Operations

| Command   | Description                           | Usage                      |
| --------- | ------------------------------------- | -------------------------- |
| `g-mkdir` | Create a directory in the repository  | `g-mkdir <directory_name>` |
| `g-rm`    | Delete a file (with auto-commit)      | `g-rm <file_name>`         |
| `g-rmdir` | Delete a directory (with auto-commit) | `g-rmdir <directory_name>` |
| `g-ls`    | List contents of a directory          | `g-ls <directory>`         |

#### General

| Command  | Description                              | Usage    |
| -------- | ---------------------------------------- | -------- |
| `g-help` | Show help message and available commands | `g-help` |

## Examples

### Basic Workflow

```bash
# Initialize repository
g-init myproject
cd myproject

# Create structure
g-mkdir docs src
echo "Hello World" > src/main.txt

# Commit and push
g-commit -m "Initial setup"
g-push
```

### Working with Existing Repositories

```bash
# Clone repository
g-clone https://github.com/user/repo.git myrepo
cd myrepo

# Make changes
g-mkdir tests
g-rm oldfile.txt
g-rmdir temp

# Commit and push
g-pushall -m "Updated structure"
```

### Quick Operations

```bash
# Quick commit and push
g-pushall -m "Quick update"

# List directory contents
g-ls .

# Smart file removal (auto-commits deletions)
g-rm file.txt        # Commits: "Remove file: file.txt"
g-rmdir old_folder   # Commits: "Remove directory: old_folder"
```

## Smart Git Integration

-   **File Operations**: `g-rm` and `g-rmdir` automatically detect Git tracking
    -   Tracked files: Uses `git rm` + auto-commits with descriptive messages
    -   Untracked files: Uses regular file system operations
-   **Error Handling**: Comprehensive validation with clear error messages
-   **Color-coded Output**: Red for errors, green for success, yellow for progress

## Requirements

-   Bash shell (4.0+)
-   Git installed
-   Unix-like environment (macOS, Linux, WSL)

## Troubleshooting

-   **Permission denied**: `chmod +x *.sh`
-   **Git not found**: Install Git (`sudo apt install git` or `brew install git`)
-   **Not in repository**: Use `g-init` or `g-clone` first
-   **Push fails**: Check remote with `git remote -v`

## Assignment Information

**Course**: COMP-4964 DevOps  
**Assignment**: Assignment 1 - Linux Git Repository Manager  
**Author**: Edro Gonzales, A01257468  
**Due Date**: September 21, 2024

## License

This project is created for educational purposes as part of COMP-4964 DevOps course assignment.
