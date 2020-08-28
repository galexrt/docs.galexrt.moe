---
title: "Quick Commands"
date: 2018-05-31
---

## Archives

### Extract all '*.zip' files into a directory named after the zip's filename

```shell
find -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
```

### Extract all '*.rar' files into a directry named after the rar's filename

```shell
find -name '*.rar' -exec sh -c 'mkdir "${1%.*}"; unrar e "$1" "${1%.*}"' _ {} \;
```

### Extract all '*.7z' files into a directry named after the rar's filename

```shell
find -name '*.7z' -exec sh -c 'mkdir "${1%.*}"; 7z x "$1" -o"${1%.*}"' _ {} \;
```

## Documents

### Convert PDFs to PNGs (each page is its own image)

```shell
for file in *.pdf; do
    echo "Processing file: $file ..."
    mkdir -p "$(basename "$file" .pdf)"
    pdftoppm -png "$file" "$(basename "$file" .pdf)/page"
done
```

#### Run `tesseract` OCR on all converted Pages

```shell
for file in */*.png; do
    echo "Processing file: $file ..."
    tesseract -l deu+eng "$file" "$(echo "$file" | sed 's/\.png$//g')"
done
```

!!! info
    The `-l deu+eng` are the languages to use.  In this case `deu+eng` means "Deutsch" (German) and "English".

### Convert all '*.docx' files into PDFs (using LibreOffice's `lowriter`)

```shell
find . -name '*.docx' -print0 |
    while IFS= read -r -d $'\0' line; do
        echo "Processing file: $line ..."
        lowriter --convert-to pdf "$line" --outdir "$(dirname "$line")"
    done
```

## Disks

### Get UUID for partition

```bash
blkid /dev/sdXY -s UUID -o value
```

Where `/dev/sdXY` could be, `/dev/sda2`, `/dev/nvme0n1p1`, and so on.
