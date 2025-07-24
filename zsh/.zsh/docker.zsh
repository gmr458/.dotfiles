function stop_all_docker_containers() {
    docker ps -q | xargs docker stop
}

function delete_all_docker_containers() {
    docker ps -a --format "{{.ID}}" | xargs docker rm
}
