# find

# find a file or directory

``` bash
find . -type f -name "*Old*.ppt"
```

- .       it means that you want to look into the current directory.
- -type   it means the type of file you want to find
- f       it means file type
- d       it means directory type
- -name   it means that you want to find by name
- ""      you have to put "" characteres it you want to use special characters to find an specific file.

``` bash
find . -type f -name "*Old*.ppt"
find . -name *NORMA* -type d
find . -name "*" -type f
```

# find empty files

```console
find <PATH> -type f -empty
```
