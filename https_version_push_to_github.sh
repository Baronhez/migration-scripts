#!/bin/bash

# Replace the following variables with your GitHub username or organization name.
GITHUB_USERNAME_OR_ORG="example"
GITHUB_DOMAIN="github.com"  # Change to a custom domain if applicable

# Change the root path to the directory containing all your local repositories.
ROOT_PATH="/example"

# Function to push a single repository
push_repository() {
    local repo_dir="$1"
    local repo_name=$(basename "$repo_dir")

    if [ -d "$repo_dir/.git" ]; then
        echo "Pushing $repo_name..."
        # Change the remote URL to the new GitHub URL.
        git -C "$repo_dir" remote set-url origin "https://$GITHUB_DOMAIN/$GITHUB_USERNAME_OR_ORG/$repo_name.git"
        # Push all branches and tags to GitHub.
        git -C "$repo_dir" push origin --all
        git -C "$repo_dir" push origin --tags
    else
        echo "Skipping $repo_name (not a Git repository)."
    fi
}

# Traverse all subdirectories and push Git repositories to GitHub.
find "$ROOT_PATH" -type d -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d '' repo_dir; do
    push_repository "$repo_dir"
done

