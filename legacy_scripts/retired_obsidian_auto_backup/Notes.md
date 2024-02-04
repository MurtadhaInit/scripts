# Notes

- Here the idea was to first symlink the .plist file to ~/Library/LaunchAgents and then enable the service and start it.
- The .sh script is executed every 7 minutes as per instructions in the .plist file.
- The script adds changed files if there were changes, commit them with a custom message, pulls and rebases changes from the remote repo, and pushes changes.
- The setup has been replicated (or at least attempted to replicate) in Ansible without testing.
- This whole workflow has been replaced with the fantastic Git plugin in Obsidian that does this and more (e.g. only backup after a set period after last file change).
