import "net"
import "list"

#host: {
    ip: net.IPv4 | net.IPv6
    port: int & >=1 & <=65535
}

#asn: int & >=1 & <= 4294967295

#neighbor_entry: {
    ip: net.IPv4 | net.IPv6
    asn: #asn
}

#neighbor_group: {
   name: string
   entries: [...#neighbor_entry] & list.MinItems(1)
}

#interface: {
    name: =~"swp[0-9]+" | =~ "vlan[0-9]+"
}

#protocol: {
    name: "bgp" | "ospfv2" | "ospfv3"
    if name == "bgp" {
        neighbors: [...#neighbor_group]
    }

    if name == "ospfv2" {
        interfaces: [...#interface]
    }
}

host: #host
protocols: [...#protocol]