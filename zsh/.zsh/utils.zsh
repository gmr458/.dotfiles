function upgrade() {
    sudo dnf check-update --refresh
    if [ $? -eq 100 ]; then
        sudo dnf upgrade -y
    fi
}

function copy_current_path() {
    wl-copy $(pwd)
}

function copy_current_dirname() {
    local result=${PWD##*/}
    result=${result:-/}
    wl-copy $result
}

function get_list_heaviest_dirs() {
    du -sh */ | sort -hr
}

function get_list_heaviest_files() {
    du -ah . | sort -rh
}

# mkdir and cd
nd () {
  mkdir -p -- "$1" &&
    cd -P -- "$1"
}
