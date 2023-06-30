# Typical ln command + options

- The typical ln command to use for linking dotfiles is:
  - `ln -sfhv src_dir symlink_dir`
  - s for symolink line as opposed to hard link
  - f for force (replace the symlink if it already exists)
  - h for not following the link if it exists. Useful for symlinking directories.
  - v for verbose
