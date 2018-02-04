# stunnel
Hiding [openvpn](https://en.wikipedia.org/wiki/OpenVPN) traffic with stunnel so [DPI](https://en.wikipedia.org/wiki/Deep_packet_inspection) firewalls are less to block your traffic.

# Concept

<img src="./assets/img/diagram.png">

As you see in the above diagram, trafic encapsulates as `SSL/TLS` by `stunnel` regradless of it's internal protocol. Since we need `SSL/TLS` handshake, if `openvpn` in the underlying protocol we need to use `TCP` protocol for `openvpn`.
You can find a simple tutorial for installing `openvpn` on a debian machine [here](https://github.com/Xaqron/openvpn).
Supposing you already have installed `openvpn` over `TCP 1194` on your server, then you need to hide the trafiic via [stunnel](https://www.stunnel.org) and this tutorials will guide you trough the rest of procedures.
This has two steps:
1) Install and configure `stunnel` on server.
2) Install and configure `stunnel` on client.

In reality `SSL/TLS` traffic is short and intermittent so still it would be easy for a goverment to detect `stunnel` since lots of traffic will be passed as `SSL/TLS`. It is recommended to use port `TCP 443` or `TCP 587` to hide the traffic so far.

# Install and configure `stunnel` on server

You can run the script `stunnel.sh` provided by this tutorial like:
```bash
sudo bash stunnel.sh
```

