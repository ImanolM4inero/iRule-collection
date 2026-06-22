when CLIENT_ACCEPTED {
    set req_id [string range [AES::key 256] 0 8]
    set client_ip [IP::client_addr]
    set client_port [TCP::client_port]
}

when HTTP_REQUEST {
    set req_start [clock clicks -milliseconds]

    log local0. "REQ_ID=$req_id CLIENT=$client_ip:$client_port VS=[virtual] HOST=[HTTP::host] URI=[HTTP::uri]"
}

when LB_SELECTED {
    set lb_selected_time [clock clicks -milliseconds]

    set selected_pool [LB::server pool]
    set member_ip [LB::server addr]
    set member_port [LB::server port]

    log local0. "REQ_ID=$req_id POOL=$selected_pool MEMBER=$member_ip:$member_port"
}

when HTTP_RESPONSE {
    set resp_start [clock clicks -milliseconds]

    set server_time [expr {$resp_start - $lb_selected_time}]

    log local0. "REQ_ID=$req_id STATUS=[HTTP::status] SERVER_RESPONSE_TIME=${server_time}ms"
}

when HTTP_RESPONSE_RELEASE {
    set resp_release [clock clicks -milliseconds]

    set total_time [expr {$resp_release - $req_start}]
    set f5_response_time [expr {$resp_release - $resp_start}]
    set f5_request_time [expr {$lb_selected_time - $req_start}]

    log local0. "REQ_ID=$req_id ===== PERFORMANCE ====="
    log local0. "REQ_ID=$req_id CLIENT=$client_ip:$client_port"
    log local0. "REQ_ID=$req_id POOL=$selected_pool"
    log local0. "REQ_ID=$req_id MEMBER=$member_ip:$member_port"
    log local0. "REQ_ID=$req_id F5_REQUEST_TIME=${f5_request_time}ms"
    log local0. "REQ_ID=$req_id SERVER_PROCESS_TIME=${server_time}ms"
    log local0. "REQ_ID=$req_id F5_RESPONSE_TIME=${f5_response_time}ms"
    log local0. "REQ_ID=$req_id TOTAL_TRANSACTION_TIME=${total_time}ms"
    log local0. "REQ_ID=$req_id ======================"
}
