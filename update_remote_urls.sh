#!/bin/bash

# Replace the following variables with your GitHub username or organization name and the new GitHub domain.
GITHUB_USERNAME_OR_ORG="example"
NEW_GITHUB_DOMAIN="github.com"

# Change the root path to the directory containing all your local repositories.
ROOT_PATH="/home/jonathan/migration"

# Find all Git repositories and update their remote URLs.
find "$ROOT_PATH" -type d -name .git -print0 | while IFS= read -r -d '' repo_path; do
    # Get the parent directory (repository directory) of the .git directory.
    repo_dir=$(dirname "$repo_path")
    # Change the remote URL to the new GitHub URL.
    git -C "$repo_dir" remote set-url origin "https://$NEW_GITHUB_DOMAIN/$GITHUB_USERNAME_OR_ORG/$(basename "$repo_dir").git"
    # Verify the new remote URL.
    git -C "$repo_dir" remote -v
done

