#                  Types of links

Types of links in Linux:
- hard - name of a file (not a folder). Hard link cannot links to a file that is places on another filesystem. If you remove original "file" (actually just delete its name) - hard link still will point to the file (and it works properly). If a file has more than 1 hard link and you delete original - it still exist!
- soft - like links on windows - if you delete original "file" (actually, just its name) - now link is broken. If you now create a new file, link will point to it!