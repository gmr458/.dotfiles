function status_mysqld() {
    sudo systemctl status mysqld
}

function start_mysqld() {
    sudo systemctl start mysqld
}

function stop_mysqld() {
    sudo systemctl stop mysqld
}

function status_postgres() {
    sudo systemctl status postgresql
}

function start_postgres() {
    sudo systemctl start postgresql
}

function stop_postgres() {
    sudo systemctl stop postgresql
}

function status_docker() {
    sudo systemctl status docker
}

function start_docker() {
    sudo systemctl start docker
}

function stop_docker() {
    sudo systemctl stop docker.service docker.socket
}

function status_redis() {
    sudo systemctl status redis
}

function start_redis() {
    sudo systemctl start redis
}

function stop_redis() {
    sudo systemctl stop redis
}
