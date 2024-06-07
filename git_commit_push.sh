#!/bin/bash
pushd "$(dirname "$0")" > /dev/null

commit_message="Updating file at $(date --iso-8601=minutes)"
echo ${commit_message}

# Specify the file
filepath="$1"
filename="$(basename -- "$filepath")"
echo "Copying ${filepath} to ${filename}"
cp ${filepath} ${filename}

# Add it and commit it
git add ${filename}

# If there are staged files commit and push
staged_files=$(git diff --cached --name-only)

if [ ! -z "$staged_files" ]; then
  echo "Pushing changed file: ${filename} to the remote..."
  git commit -m "${commit_message}"
  git push origin main
fi

