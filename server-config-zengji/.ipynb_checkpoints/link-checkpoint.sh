#!/bin/bash

# Source directory containing the server configurations
SOURCE_DIR=$(dirname "$(realpath "$0")")

# Target directory for the symlinks (your home directory)
TARGET_DIR="$HOME" # Use $HOME variable for reliability in scripts

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory '$SOURCE_DIR' not found." >&2
  exit 1
fi

# Check if we can write to the target directory
if [ ! -w "$TARGET_DIR" ]; then
  echo "Error: Cannot write to target directory '$TARGET_DIR'." >&2
  exit 1
fi

echo "Creating symlinks in '$TARGET_DIR' pointing to items in '$SOURCE_DIR'..."

# Use find to get all top-level items (files, dirs, links)
# -maxdepth 1: Only look in the immediate directory
# -mindepth 1: Exclude the SOURCE_DIR itself from the list
# -print0: Use null character as separator for safety with special filenames
find "$SOURCE_DIR" -maxdepth 1 -mindepth 1 -print0 | while IFS= read -r -d $'\0' item_path; do
  # Get the base name (the file or folder name)
  item_name=$(basename "$item_path")

  # Construct the path for the symlink in the home directory
  link_path="$TARGET_DIR/$item_name"

  echo "  Linking '$item_path' -> '$link_path'"

  # Create the symbolic link
  # -s: symbolic link
  # -f: force (overwrite if link/file already exists in TARGET_DIR) - REMOVE if you don't want to overwrite
  # -T: treat LINK_NAME as a normal file always (safer than -n when LINK_NAME might be a dir)
  # Use ln -s "$item_path" "$link_path" if you want it to fail if the link already exists
  ln -sfT "$item_path" "$link_path"

  # Check if the link command failed (optional)
  if [ $? -ne 0 ]; then
    echo "  Warning: Failed to create link for '$item_name'" >&2
  fi
done

echo "Done."