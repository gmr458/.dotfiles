function extract_gz() {
    [[ -f "$1" ]] || { print -u2 "extract_gz: no such file: $1"; return 1 }
    [[ "$(file -b --mime-type -- "$1")" == application/gzip ]] || { print -u2 "extract_gz: not gzip data: $1"; return 1 }
    [[ "$(gzip -dc -- "$1" 2>/dev/null | file -b --mime-type -)" != application/x-tar ]] || { print -u2 "extract_gz: tar archive, use extract_tar_gz: $1"; return 1 }
    gzip -d "$1"
}

function extract_bz2() {
    [[ -f "$1" ]] || { print -u2 "extract_bz2: no such file: $1"; return 1 }
    [[ "$(file -b --mime-type -- "$1")" == application/x-bzip2 ]] || { print -u2 "extract_bz2: not bzip2 data: $1"; return 1 }
    [[ "$(bzip2 -dc -- "$1" 2>/dev/null | file -b --mime-type -)" != application/x-tar ]] || { print -u2 "extract_bz2: tar archive, use extract_tar_bz2: $1"; return 1 }
    bunzip2 "$1"
}

function extract_xz() {
    [[ -f "$1" ]] || { print -u2 "extract_xz: no such file: $1"; return 1 }
    [[ "$(file -b --mime-type -- "$1")" == application/x-xz ]] || { print -u2 "extract_xz: not xz data: $1"; return 1 }
    [[ "$(xz -dc -- "$1" 2>/dev/null | file -b --mime-type -)" != application/x-tar ]] || { print -u2 "extract_xz: tar archive, use extract_tar_xz: $1"; return 1 }
    unxz "$1"
}

function extract_tar() {
    [[ -f "$1" ]] || { print -u2 "extract_tar: no such file: $1"; return 1 }
    [[ "$(file -b --mime-type -- "$1")" == application/x-tar ]] || { print -u2 "extract_tar: not tar data: $1"; return 1 }
    tar -xf "$1"
}

function extract_tar_gz() {
    [[ -f "$1" ]] || { print -u2 "extract_tar_gz: no such file: $1"; return 1 }
    [[ "$(file -b --mime-type -- "$1")" == application/gzip ]] || { print -u2 "extract_tar_gz: not gzip data: $1"; return 1 }
    [[ "$(gzip -dc -- "$1" 2>/dev/null | file -b --mime-type -)" == application/x-tar ]] || { print -u2 "extract_tar_gz: not a tar archive: $1"; return 1 }
    tar -xzf "$1"
}

function extract_tar_bz2() {
    [[ -f "$1" ]] || { print -u2 "extract_tar_bz2: no such file: $1"; return 1 }
    [[ "$(file -b --mime-type -- "$1")" == application/x-bzip2 ]] || { print -u2 "extract_tar_bz2: not bzip2 data: $1"; return 1 }
    [[ "$(bzip2 -dc -- "$1" 2>/dev/null | file -b --mime-type -)" == application/x-tar ]] || { print -u2 "extract_tar_bz2: not a tar archive: $1"; return 1 }
    tar -xjf "$1"
}

function extract_tar_xz() {
    [[ -f "$1" ]] || { print -u2 "extract_tar_xz: no such file: $1"; return 1 }
    [[ "$(file -b --mime-type -- "$1")" == application/x-xz ]] || { print -u2 "extract_tar_xz: not xz data: $1"; return 1 }
    [[ "$(xz -dc -- "$1" 2>/dev/null | file -b --mime-type -)" == application/x-tar ]] || { print -u2 "extract_tar_xz: not a tar archive: $1"; return 1 }
    tar -xJf "$1"
}

function extract_zip() {
    [[ -f "$1" ]] || { print -u2 "extract_zip: no such file: $1"; return 1 }
    [[ "$(file -b --mime-type -- "$1")" == application/zip ]] || { print -u2 "extract_zip: not zip data: $1"; return 1 }
    unzip "$1"
}
