when HTTP_REQUEST {
    if { ([HTTP::host] == "www.") } {
        log local0.info "ClientIP: [IP::client_addr], Request: [HTTP::host][HTTP::uri], UA: [HTTP::header "User-Agent"]"
    } 
}
