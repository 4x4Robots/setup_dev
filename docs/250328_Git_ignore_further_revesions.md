# Ignore further revisions of a tracked file

#git

https://stackoverflow.com/questions/4348590/how-can-i-make-git-ignore-future-revisions-to-a-file

Ignore changes to that file, both local and upstream:
```
git update-index --skip-worktree default_settings.txt
```

until you decide to allow them again with:
```
git update-index --no-skip-worktree default_settings.txt
```

You can get a list of files that are marked skipped with:
```
git ls-files -v . | grep ^S
```

other possible solutions:
https://stackoverflow.com/questions/76571385/how-can-i-ignore-files-that-are-already-being-tracked-by-git-and-why-does-git-u

