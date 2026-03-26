# find (macOS / bash)

On macOS, `find` is the **BSD** implementation (not GNU). Most examples here work the same way; common differences: no `-printf` (GNU); `-size` accepts a `c` suffix for bytes. See `man find` for full details.

## Demo scripts

The `scripts/` directory contains runnable examples that create a temporary tree, run `find`, and print the results:

```bash
cd scripts
./run-all.sh
```

Files: `01-empty-and-types.sh`, `02-name-and-quotes.sh`, `03-depth-prune.sh`, `04-time-size-perm.sh`, `05-exec-print0.sh`.

---

## Empty files

```bash
find <PATH> -type f -empty
```

Empty directories (no entries):

```bash
find <PATH> -type d -empty
```

---

## Find by name (file or directory)

Pattern matches the **file name** (not the full path). Metacharacters `*`, `?`, and `[]` should be **quoted** so the shell passes them to `find` instead of expanding them first.

```bash
find . -type f -name '*<NAME>*.ppt'
```

Find directories whose names match a pattern (recommended: put `-type` before `-name`):

```bash
find . -type d -name '*<DIR_NAME>*'
```

**Wrong** (without quotes the shell expands `*` before `find` runs; this can error or give unexpected results):

```bash
find . -type d -name *<DIR_NAME>*
```

All files under the current directory (no need for `-name "*"`):

```bash
find . -type f
```

Case-insensitive name match:

```bash
find . -type f -iname '*.pdf'
```

Match the full path (useful for directory segments):

```bash
find . -path '*/node_modules/*' -prune -o -type f -print
```

(The `-prune` pattern skips entire branches; `-o ... -print` is the usual BSD `find` idiom.)

---

## Quick predicate reference

| Option | Short meaning |
|--------|----------------|
| `.` | Starting directory for the walk (here, the current one). |
| `-type f` / `-d` / `-l` | Regular file, directory, symbolic link. |
| `-name` / `-iname` | Pattern on the base name (`fnmatch`). |
| `-empty` | Empty file or directory. |
| `-maxdepth n` / `-mindepth n` | Depth limits (supported on macOS). |
| `-mtime -1` | Modified less than 24 hours ago (whole days). |
| `-mmin -30` | Modified less than 30 minutes ago. |
| `-size +1M` | Larger than 1 megabyte (`k`, `M`, `G`; `c` = bytes). |
| `-perm -100` | Owner execute bit set. |

---

## Time and size

```bash
find . -type f -mmin -60
find ~/Downloads -type f -size +100M
```

---

## Depth and skipping directories

Only the starting directory (no descendants):

```bash
find . -maxdepth 1 -type f
```

Skip `node_modules` while listing `.js` files:

```bash
find . \( -path ./node_modules -o -path './node_modules/*' \) -prune -o -type f -name '*.js' -print
```

(Adjust `./node_modules` if your search root is not `.`.)

---

## Actions: list, run commands, delete with care

One command invocation per match (`{}` is the path; `\;` ends `-exec`):

```bash
find . -type f -name '*.txt' -exec wc -l {} \;
```

Batch arguments into fewer command runs (trailing `+`):

```bash
find . -type f -name '*.txt' -exec grep -l 'TODO' {} +
```

Paths with spaces: NUL-terminated output and safe handling in bash:

```bash
while IFS= read -r -d '' f; do ls -la "$f"; done < <(find . -type f -print0)
```

You will also often see:

```bash
find . -type f -print0 | xargs -0 ls -la
```

**Danger:** deletes bypass the Trash. Verify with `-print` first:

```bash
find /some/tmp -type f -name '*.log' -print
# find /some/tmp -type f -name '*.log' -delete
```

---

## Logical operators

```bash
find . -type f \( -name '*.png' -o -name '*.jpg' \)
```

---

## Summary

`find` combines **tree walking**, **predicates** (`-type`, `-name`, `-mtime`, `-size`, …), and **actions** (default `-print`, or `-exec`, `-delete`, etc.). It is the standard macOS tool for locating files under complex rules without proprietary extensions.
