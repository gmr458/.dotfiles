function curl_get_json() {
    curl -s -X GET $1 | python -m json.tool | bat -l json
}

function curl_post_json() {
    curl -s -X POST -H 'Content-Type: application/json' -d $2 $1 | python -m json.tool | bat -l json
}

function curl_put_json() {
    curl -s -X PUT -H 'Content-Type: application/json' -d $2 $1 | python -m json.tool | bat -l json
}

function curl_delete_json() {
    curl -s -X DELETE $1 | python -m json.tool | bat -l json
}
