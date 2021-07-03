---
title: "sysctl"
date: 2020-01-25
---

See [GitHub Gist `90-edenmal-custom.conf`](https://gist.github.com/galexrt/8faa48a05bab303ec922bd89e8f7adc5) for more information on the used `sysctl` settings / values.

The sysctl can be easily using the following command:

```console
curl -L https://gist.githubusercontent.com/galexrt/8faa48a05bab303ec922bd89e8f7adc5/raw/90-edenmal-custom.conf -o /etc/sysctl.d/90-edenmal-custom.conf
sysctl --system
```

***

!!! info
    The below list might be outdated, please check the GitHub Gist linked above for the latest version.

```ini
fs.aio_max_nr = 1048576
fs.file-max = 2097152
fs.inotify.max_user_instances = 5120
fs.inotify.max_user_watches = 1572864
fs.nr_open = 3145728
fs.suid_dumpable = 0
kernel.core_uses_pid = 1
kernel.dmesg_restrict = 1
kernel.exec-shield = 2
kernel.panic_on_oops = 1
kernel.panic = 10
kernel.pid_max = 4194303
kernel.randomize_va_space = 2
kernel.sched_autogroup_enabled = 0
kernel.sched_migration_cost = 5000000
kernel.sysrq = 0
net.core.default_qdisc = fq
net.core.netdev_budget = 600
net.core.netdev_max_backlog = 65536
net.core.optmem_max = 4048000
net.core.rmem_default = 266240
net.core.rmem_max = 4048000
net.core.somaxconn = 65536
net.core.wmem_default = 266240
net.core.wmem_max = 4048000
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.bootp_relay = 0
net.ipv4.conf.all.forwarding = 1
net.ipv4.conf.all.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.all.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.all.ignore_routes_with_linkdown = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.all.proxy_arp = 0
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.all.secure_redirects = 1
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.default.forwarding = 1
net.ipv4.conf.default.log_martians = 1
net.ipv4.conf.default.rp_filter = 2
net.ipv4.conf.default.secure_redirects = 1
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.lo.accept_source_route = 1
net.ipv4.fwmark_reflect = 0
net.ipv4.icmp_echo_ignore_all = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.icmp_msgs_burst = 50
net.ipv4.icmp_msgs_per_sec = 1000
net.ipv4.ip_forward = 1
net.ipv4.ip_local_port_range = 1024 65535
net.ipv4.ipfrag_secret_interval = 600
net.ipv4.neigh.default.gc_thresh1 = 4048
net.ipv4.neigh.default.gc_thresh2 = 6144
net.ipv4.neigh.default.gc_thresh3 = 8192
net.ipv4.netfilter.ip_conntrack_tcp_timeout_syn_recv = 45
net.ipv4.netfilter.nf_conntrack_generic_timeout = 300
net.ipv4.netfilter.nf_conntrack_tcp_timeout_time_wait = 60
net.ipv4.tcp_abort_on_overflow = 1
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_fin_timeout = 10
net.ipv4.tcp_keepalive_intvl = 25
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_time = 420
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_max_tw_buckets = 160000
net.ipv4.tcp_moderate_rcvbuf = 1
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.tcp_notsent_lowat = 16384
net.ipv4.tcp_rfc1337 = 1
net.ipv4.tcp_rmem = 4096 87380 8388608
net.ipv4.tcp_sack = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_synack_retries = 3
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_wmem = 4096 87380 8388608
net.ipv4.udp_rmem_min = 16384
net.ipv4.udp_wmem_min = 16384
net.ipv4.vs.conn_reuse_mode = 1
net.ipv4.vs.conntrack = 1
net.ipv4.vs.expire_nodest_conn = 1
net.ipv4.vs.sloppy_tcp = 1
net.ipv6.conf.all.accept_ra_defrtr = 0
net.ipv6.conf.all.accept_ra_pinfo = 0
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.default.accept_ra_defrtr = 0
net.ipv6.conf.default.accept_ra_pinfo = 0
net.ipv6.conf.default.accept_ra_rtr_pref = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv6.conf.default.accept_source_route = 0
net.ipv6.conf.default.autoconf = 0
net.ipv6.conf.default.dad_transmits = 0
net.ipv6.conf.default.forwarding = 1
net.ipv6.conf.default.max_addresses = 16
net.ipv6.conf.default.router_solicitations = 0
net.ipv6.ip6frag_secret_interval = 600
net.ipv6.route.max_size = 16384
net.ipv6.xfrm6_gc_thresh = 32768
net.netfilter.nf_conntrack_expect_max = 2048
net.netfilter.nf_conntrack_max = 1024000
net.netfilter.nf_conntrack_tcp_timeout_established = 600
net.nf_conntrack_max = 1024000
vm.mmap_rnd_bits=32
vm.mmap_rnd_compat_bits=16
vm.overcommit_memory = 1
vm.overcommit_ratio = 20
vm.panic_on_oom = 0
```
