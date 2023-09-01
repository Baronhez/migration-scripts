#!/bin/bash

# Replace the following variables with your GitHub username or organization name.
GITHUB_USERNAME_OR_ORG="example"

# Change the root path to the directory containing all your local repositories.
ROOT_PATH="/example"

# Function to push a single repository
push_repository() {
    local repo_dir="$1"
    local repo_name=$(basename "$repo_dir")

    if [ -d "$repo_dir/.git" ]; then
        echo "Pushing $repo_name..."
        # Change the remote URL to the new GitHub SSH URL.
        git -C "$repo_dir" remote set-url origin "git@github.com:$GITHUB_USERNAME_OR_ORG/$repo_name.git"
        # Push all branches and tags to GitHub.
        git -C "$repo_dir" push origin --all
        git -C "$repo_dir" push origin --tags
    else
        echo "Skipping $repo_name (not a Git repository)."
    fi
}

# Function to push all repositories inside a directory recursively.
push_all_repositories() {
    local dir="$1"

    # Push repositories in the current directory.
    push_repository "$dir"

    # Traverse all subdirectories and push Git repositories to GitHub.
    find "$dir" -type d -name '.git' -prune -o -type d -print0 | while IFS= read -r -d '' repo_dir; do
        push_repository "$repo_dir"
    done
}

# Push all repositories inside the root path recursively.
push_all_repositories "$ROOT_PATH"

