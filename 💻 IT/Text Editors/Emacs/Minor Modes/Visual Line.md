Sometimes, you may need to edit files containing many long logical
lines, and it may not be practical to break them all up by adding
newlines.  In that case, you can use Visual Line mode, which enables
“word wrapping”: instead of wrapping long lines exactly at the right
window edge, Emacs wraps them at the word boundaries (i.e., space or tab
characters) nearest to the right window edge.  Visual Line mode also
redefines editing commands such as ‘C-a’, ‘C-n’, and ‘C-k’ to operate on
screen lines rather than logical lines