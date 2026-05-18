# Node Modules Cleanup Script

This script recursively searches your system for node_modules directories and interactively prompts you to delete them. It is intended for cleaning up disk space on development machines where multiple Node.js projects may leave behind large dependency folders.

## Overview
Searches the entire filesystem (/) for directories named node_modules
Skips virtual/system directories such as:
```shell
/proc
/sys
/dev
/run
```
Prevents duplicate processing of the same directory
Prompts for confirmation before deleting each match
Deletes selected directories using sudo rm -rf
## Requirements
Bash (version 4+ recommended for associative arrays)
sudo privileges
Standard Unix utilities: find, rm
## Usage

Save the script to a file, for example:
```shell
cleanup-node-modules.sh

#Make it executable:

chmod +x cleanup-node-modules.sh

#Run the script:

./cleanup-node-modules.sh
```
## How It Works

The script performs a system-wide search:
```shell
sudo find / \
  \( -path /proc -o -path /sys -o -path /dev -o -path /run \) -prune -o \
  -type d -name "node_modules" -print
```
For each discovered node_modules directory:

It checks whether the directory was already processed
Prints the path to the terminal
Prompts the user for confirmation:
y or Y → deletes the directory
Any other input → skips it

Deletion is performed using:
```shell
sudo rm -rf --one-file-system "$node_dir"
```
## Safety Notes
This script can delete large amounts of data permanently.
Always review each prompt carefully before confirming deletion.
Running this on production systems is not recommended.
Ensure you understand the paths being removed before approving.
## Limitations
Requires manual confirmation for each directory (no batch mode)
May take a long time on large filesystems
Needs root permissions to access many directories
## Example Output
```shell
Found node_modules:
  /home/user/project/node_modules
Delete this node_modules? [y/N]
```
## License
MIT

Use at your own risk. No warranty is provided.
