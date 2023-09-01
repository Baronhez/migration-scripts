#!/bin/bash

# Replace the following variables with your GitHub username or organization name.
GITHUB_USERNAME_OR_ORG="example"

# Change the root path to the directory containing all your local repositories.
ROOT_PATH="/example"

# Find all Git repositories and create corresponding repositories on GitHub.
find "$ROOT_PATH" -type d -name .git -print0 | while IFS= read -r -d '' git_dir; do
    # Get the parent directory (repository directory) of the .git directory.
    repo_dir=$(dirname "$git_dir")
    # Get the repository name from the parent directory's path.
    repo_name=$(basename "$repo_dir")
    # Check if the parent directory is a Git repository (contains .git folder).
    if [[ -d "$git_dir" ]]; then
        gh repo create "$GITHUB_USERNAME_OR_ORG/$repo_name" --private  # Use --public for public repositories
    fi
done

