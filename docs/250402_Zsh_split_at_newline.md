# ZSH split variable at newline

https://unix.stackexchange.com/questions/567792/zsh-for-loop-over-newline-delimited-entries

ZSH doesn't automatically split variables at newline.

To split on newline in zsh, you use the
[`f` parameter expansion flag](https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags)
(`f` for line `f`eed) which is short for `ps:\n:`:

```
for num (${(f)numholds}) print -r New item: $num
```

You could also use `$IFS`-splitting which in zsh (contrary to other Bourne-like shells)
you have to ask for explicitly for parameter expansion using the `$=param` syntax
`$=` looks a bit like a pair of scissors):

```
for num ($=numholds) print -r New item: $num
```

