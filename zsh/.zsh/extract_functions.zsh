function extract_gz() {
    gzip -d $1
}

function extract_bz2() {
    bunzip2 $1
}

function extract_xz() {
    unxz $1
}

function extract_tar() {
    tar -xf $1
}

function extract_tar_gz() {
    tar -xzf $1
}

function extract_tar_bz2() {
    tar -xjf $1
}

function extract_tar_xz() {
    tar -xf $1
}
