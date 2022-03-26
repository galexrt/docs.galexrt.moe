---
title: "Quick Commands"
---

## Archives

### Extract all '*.zip' files into a directory named after the zip's filename

```console
find -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
```

### Extract all '*.rar' files into a directry named after the rar's filename

```console
find -name '*.rar' -exec sh -c 'mkdir "${1%.*}"; unrar e "$1" "${1%.*}"' _ {} \;
```

### Extract all '*.7z' files into a directry named after the rar's filename

```console
find -name '*.7z' -exec sh -c 'mkdir "${1%.*}"; 7z x "$1" -o"${1%.*}"' _ {} \;
```

### Extrat all '*.tar' files into a directory named after the tar's filename

```console
find -name '*.tar' -exec sh -c 'mkdir -p "${1%.*}"; tar -C "${1%.*}" -xvf "$1"' _ {} \;
```

### Extrat all '*.tar.gz' files into a directory named after the tar's filename

```console
find -name '*.tar.gz' -or -name '*.tgz' -exec sh -c 'mkdir -p "${1%.*}"; tar -C "${1%.*}" -xvzf "$1"' _ {} \;
```

## Music

### Convert all FLAC to MP3 (same directory)

```console
find -name "*.flac" -print | parallel -j 14 ffmpeg -i {} -acodec libmp3lame -ab 192k {.}.mp3 \;
```

### Convert all OGG to FLAC (same directory)

```console
find -name "*.ogg" -print | parallel -j 14 ffmpeg -i {} -c:a flac {.}.flac \;
```

## Documents

### Convert PDFs to PNGs (each page is its own image)

```console
for file in *.pdf; do
    echo "Processing file: $file ..."
    mkdir -p "$(basename "$file" .pdf)"
    pdftoppm -png "$file" "$(basename "$file" .pdf)/page"
done
```

#### Run `tesseract` OCR on all converted Pages

```console
for file in */*.png; do
    echo "Processing file: $file ..."
    tesseract -l deu+eng "$file" "$(echo "$file" | sed 's/\.png$//g')"
done
```

!!! info
    The `-l deu+eng` are the languages to use.  In this case `deu+eng` means "Deutsch" (German) and "English".

### Convert all '*.docx' files into PDFs (using LibreOffice's `lowriter`)

```console
find . -name '*.docx' -print0 |
    while IFS= read -r -d $'\0' line; do
        echo "Processing file: $line ..."
        lowriter --convert-to pdf "$line" --outdir "$(dirname "$line")"
    done
```

## Disks

### Get UUID for partition

```console
blkid /dev/sdXY -s UUID -o value
```

Where `/dev/sdXY` could be, `/dev/sda2`, `/dev/nvme0n1p1`, and so on.

## Images

### Optimize JPEG Images

!!! warning
    The `-m LEVEL` flag reduces the JPEG image quality to that level, in the example below to `95`.

```console
$ jpegoptim -p --strip-com --strip-iptc -m 95 IMAGE.jpeg
# Find and optimize PNGs in parallel
$ find -iname '*.jpg' -iname '*.jpeg' -print0 | xargs -n1 -P6 -0 jpegoptim -p --strip-com --strip-iptc -m 95
```

### Optimize PNG Images

```console
$ jpegoptim
# Find and optimize PNGs in parallel
$ find -iname '*.png' -print0 | xargs -n1 -P6 -0 optipng -strip all -clobber -fix -o9
```

### Remove EXIF data from Image(s)

```console
$ exiftool -overwrite_original -all= IMAGE1.jpeg IMAGE2.png ...
# Remove EXIF data from all `*.jpeg` files
$ find -iname '*.jpeg' -exec exiftool -overwrite_original -all= {} \;
```
