{
    ips[$1] = $2
}

END {
    for (ip in ips) {
        printf "%s %.1fms\n", ip, ips[ip] | "sort -k2n"
    }
}
