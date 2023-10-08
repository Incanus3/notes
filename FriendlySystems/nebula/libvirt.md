Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-10-01T12:07:08+02:00

====== libvirt ======
Created Tuesday 01 October 2013

* migrace
Mon Sep 16 19:43:18 2013 [VMM][D]: Message received: LOG I 272 Command execution fail: /var/tmp/one/vmm/kvm/restore '/var/lib/one//datastores/0/272/checkpoint' 'node4' 272 node4
Mon Sep 16 19:43:18 2013 [VMM][D]: Message received: LOG E 272 restore: Command "virsh --connect qemu:///system restore /var/lib/one//datastores/0/272/checkpoint" failed: error: Failed to restore domain from /var/lib/one//datastores/0/272/checkpoint
Mon Sep 16 19:43:18 2013 [VMM][D]: Message received: LOG I 272 error: monitor socket did not show up.: No such file or directory
Mon Sep 16 19:43:18 2013 [VMM][D]: Message received: LOG E 272 Could not restore from /var/lib/one//datastores/0/272/checkpoint
Mon Sep 16 19:43:18 2013 [VMM][D]: Message received: LOG I 272 ExitCode: 1

http://wiki.libvirt.org/page/FAQ#Error:_domain_did_not_show_up
http://wiki.libvirt.org/page/FAQ#Error:_monitor_socket_did_not_show_up.:_Connection_refused
http://wiki.libvirt.org/page/FAQ#My_VM_fails_to_start._What_should_I_do.3F

http://libvirt.org/errors.html
http://opennebula.org/documentation:rel4.2:kvmg

* FAQ: This message usually masks a more specific error at domain start up. See 'My VM fails to start'
* nastaveni logu - http://libvirt.org/logging.html
* /etc/libvirt/libvirtd.conf:
log_level = 1
log_outputs="3:file:/var/log/libvirt/libvirt-warn.log 2:file:/var/log/libvirt/libvirt-info.log 1:file:/var/log/libvirt/libvirt-debug.log"
* service libvrit-bin stop, start (restart nestaci)

2013-09-16 20:37:38.973+0000: 14093: debug : virDomainRestore:2610 : conn=0x7f9ce40013d0, from=/var/lib/one//datastores/0/273/checkpoint
**2013-09-16 20:37:38.981+0000: 15497: warning : virDomainDiskDefForeachPath:13244 : Ignoring open failure on /var/lib/one//datastores/0/273/disk.0: Permission denied**
2013-09-16 20:37:39.399+0000: 14093: debug : virCgroupNew:602 : New group /libvirt/qemu/one-273
2013-09-16 20:37:39.400+0000: 14093: debug : virCgroupMakeGroup:523 : Make group /libvirt/qemu/one-273
2013-09-16 20:37:39.400+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/cpu/libvirt/qemu/one-273/
2013-09-16 20:37:39.679+0000: 14093: debug : virCgroupNew:602 : New group /libvirt/qemu/one-273
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupMakeGroup:523 : Make group /libvirt/qemu/one-273
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/cpu/libvirt/qemu/one-273/
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/cpuacct/libvirt/qemu/one-273/
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/cpuset/libvirt/qemu/one-273/
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupCpuSetInherit:457 : Setting up inheritance /libvirt/qemu -> /libvirt/qemu/one-273
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/cpuset/libvirt/qemu/one-273/cpuset.cpus' to '0-3'
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/cpuset/libvirt/qemu/one-273/cpuset.mems' to '0'
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/memory/libvirt/qemu/one-273/
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupGetValueStr:349 : Get value /sys/fs/cgroup/memory/libvirt/qemu/one-273/memory.use_hierarchy
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupSetMemoryUseHierarchy:505 : Setting up /libvirt/qemu/one-273/memory.use_hierarchy
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/memory/libvirt/qemu/one-273/memory.use_hierarchy' to '1'
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/devices/libvirt/qemu/one-273/
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/freezer/libvirt/qemu/one-273/
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/blkio/libvirt/qemu/one-273/
2013-09-16 20:37:39.680+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.deny' to 'a'
2013-09-16 20:37:39.680+0000: 14093: debug : qemuSetupDiskPathAllow:70 : Process path /var/lib/one//datastores/0/273/disk.0 for disk
2013-09-16 20:37:39.682+0000: 14093: debug : qemuSetupDiskPathAllow:70 : Process path /var/lib/one//datastores/0/273/disk.1 for disk
2013-09-16 20:37:39.683+0000: 14093: debug : qemuSetupDiskPathAllow:70 : Process path /var/lib/one//datastores/0/273/disk.2 for disk
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 136:* rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 1:3 rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 1:7 rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 1:5 rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 1:8 rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 1:9 rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 5:2 rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 10:232 rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 254:0 rw'
2013-09-16 20:37:39.683+0000: 14093: debug : virCgroupSetValueStr:319 : Set value '/sys/fs/cgroup/devices/libvirt/qemu/one-273/devices.allow' to 'c 10:228 rw'
2013-09-16 20:37:39.684+0000: 14093: warning : qemuBuildCommandLine:3591 : Starting machine one-273 with type pc-0.12.  We suggest a newer type.
2013-09-16 20:37:39.684+0000: 14093: warning : qemuBuildCommandLine:3591 : Starting machine one-273 with type pc-0.12.  We suggest a newer type.
2013-09-16 20:37:39.684+0000: 14093: warning : qemuBuildCommandLine:3591 : Starting machine one-273 with type pc-0.12.  We suggest a newer type.
2013-09-16 20:37:39.907+0000: 14093: warning : qemuDomainObjTaint:1134 : Domain id=39 name='one-273' uuid=8b14d3a1-0907-e862-4043-498ff86d9ca2 is tainted: high-privileges
2013-09-16 20:37:39.907+0000: 14093: warning : qemuDomainObjTaint:1134 : Domain id=39 name='one-273' uuid=8b14d3a1-0907-e862-4043-498ff86d9ca2 is tainted: high-privileges
2013-09-16 20:37:39.907+0000: 14093: warning : qemuDomainObjTaint:1134 : Domain id=39 name='one-273' uuid=8b14d3a1-0907-e862-4043-498ff86d9ca2 is tainted: high-privileges
2013-09-16 20:37:39.907+0000: 14093: debug : virCommandRunAsync:2058 : About to run LC_ALL=C PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin QEMU_AUDIO_DRV=none /usr/bin/kvm -S -M pc-0.12 -enable-kvm -m 1024 -smp 2,sockets=2,cores=1,threads=1 -name one-273 -uuid 8b14d3a1-0907-e862-4043-498ff86d9ca2 -nodefconfig -nodefaults -chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/one-273.monitor,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown -drive file=/var/lib/one//datastores/0/273/disk.0,if=none,id=drive-ide0-0-0,format=raw,cache=none -device ide-drive,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1 -drive file=/var/lib/one//datastores/0/273/disk.1,if=none,id=drive-ide0-0-1,format=raw,cache=none -device ide-drive,bus=ide.0,unit=1,drive=drive-ide0-0-1,id=ide0-0-1 -drive file=/var/lib/one//datastores/0/273/disk.2,if=none,media=cdrom,id=drive-ide0-1-0,readonly=on,format=raw -device ide-drive,bus=ide.1,unit=0,drive=drive-ide0-1-0,id=ide0-1-0 -netdev tap,fd=27,id=hostnet0 -device e1000,netdev=hostnet0,id=net0,mac=02:00:5f:a8:c7:09,bus=pci.0,addr=0x3 -netdev tap,fd=28,id=hostnet1 -device e1000,netdev=hostnet1,id=net1,mac=02:00:c0:a8:32:1a,bus=pci.0,addr=0x4 -usb -vnc 0.0.0.0:3 -vga cirrus -incoming fd:25 -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
2013-09-16 20:37:40.096+0000: 14093: debug : virCommandRunAsync:2058 : About to run /usr/lib/libvirt/virt-aa-helper -p 0 -r -u libvirt-8b14d3a1-0907-e862-4043-498ff86d9ca2 -F /var/lib/one//datastores/0/273/checkpoint
**2013-09-16 20:37:40.100+0000: 15542: warning : virDomainDiskDefForeachPath:13244 : Ignoring open failure on /var/lib/one//datastores/0/273/disk.0: Permission denied**
2013-09-16 20:37:40.536+0000: 14093: debug : qemuProcessWaitForMonitor:1326 : Connect monitor to 0x7f9cf0002740 'one-273'
2013-09-16 20:37:40.838+0000: 14090: debug : qemuProcessHandleMonitorError:177 : Received error on 0x7f9cf0002740 'one-273'
2013-09-16 20:37:40.839+0000: 14093: debug : qemuProcessStop:3436 : Shutting down VM 'one-273' pid=15541 migrated=0
2013-09-16 20:37:40.839+0000: 14093: debug : qemuProcessKill:3382 : vm=one-273 pid=15541 gracefully=0
2013-09-16 20:37:41.239+0000: 14093: debug : qemuProcessAutoDestroyRemove:3905 : vm=one-273 uuid=8b14d3a1-0907-e862-4043-498ff86d9ca2
2013-09-16 20:37:41.659+0000: 14093: debug : virCgroupNew:602 : New group /libvirt/qemu/one-273
2013-09-16 20:37:41.659+0000: 14093: debug : virCgroupMakeGroup:523 : Make group /libvirt/qemu/one-273
2013-09-16 20:37:41.659+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/cpu/libvirt/qemu/one-273/
2013-09-16 20:37:41.659+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/cpuacct/libvirt/qemu/one-273/
2013-09-16 20:37:41.659+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/cpuset/libvirt/qemu/one-273/
2013-09-16 20:37:41.659+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/memory/libvirt/qemu/one-273/
2013-09-16 20:37:41.659+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/devices/libvirt/qemu/one-273/
2013-09-16 20:37:41.660+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/freezer/libvirt/qemu/one-273/
2013-09-16 20:37:41.660+0000: 14093: debug : virCgroupMakeGroup:545 : Make controller /sys/fs/cgroup/blkio/libvirt/qemu/one-273/
2013-09-16 20:37:41.660+0000: 14093: debug : virCgroupRemove:757 : Removing cgroup /sys/fs/cgroup/cpu/libvirt/qemu/one-273/ and all child cgroups
2013-09-16 20:37:41.660+0000: 14093: debug : virCgroupRemoveRecursively:712 : Removing cgroup /sys/fs/cgroup/cpu/libvirt/qemu/one-273/
2013-09-16 20:37:41.722+0000: 14093: debug : virCgroupRemove:757 : Removing cgroup /sys/fs/cgroup/cpuacct/libvirt/qemu/one-273/ and all child cgroups
2013-09-16 20:37:41.722+0000: 14093: debug : virCgroupRemoveRecursively:712 : Removing cgroup /sys/fs/cgroup/cpuacct/libvirt/qemu/one-273/
2013-09-16 20:37:41.790+0000: 14093: debug : virCgroupRemove:757 : Removing cgroup /sys/fs/cgroup/cpuset/libvirt/qemu/one-273/ and all child cgroups
2013-09-16 20:37:41.790+0000: 14093: debug : virCgroupRemoveRecursively:712 : Removing cgroup /sys/fs/cgroup/cpuset/libvirt/qemu/one-273/
2013-09-16 20:37:41.818+0000: 14093: debug : virCgroupRemove:757 : Removing cgroup /sys/fs/cgroup/memory/libvirt/qemu/one-273/ and all child cgroups
2013-09-16 20:37:41.818+0000: 14093: debug : virCgroupRemoveRecursively:712 : Removing cgroup /sys/fs/cgroup/memory/libvirt/qemu/one-273/
2013-09-16 20:37:41.863+0000: 14093: debug : virCgroupRemove:757 : Removing cgroup /sys/fs/cgroup/devices/libvirt/qemu/one-273/ and all child cgroups
2013-09-16 20:37:41.863+0000: 14093: debug : virCgroupRemoveRecursively:712 : Removing cgroup /sys/fs/cgroup/devices/libvirt/qemu/one-273/
2013-09-16 20:37:41.866+0000: 14093: debug : virCgroupRemove:757 : Removing cgroup /sys/fs/cgroup/freezer/libvirt/qemu/one-273/ and all child cgroups
2013-09-16 20:37:41.866+0000: 14093: debug : virCgroupRemoveRecursively:712 : Removing cgroup /sys/fs/cgroup/freezer/libvirt/qemu/one-273/
2013-09-16 20:37:41.866+0000: 14093: debug : virCgroupRemove:757 : Removing cgroup /sys/fs/cgroup/blkio/libvirt/qemu/one-273/ and all child cgroups
2013-09-16 20:37:41.867+0000: 14093: debug : virCgroupRemoveRecursively:712 : Removing cgroup /sys/fs/cgroup/blkio/libvirt/qemu/one-273/
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=3 w=4
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=4 w=5
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=5 w=6
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=6 w=7
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=7 w=8
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=8 w=9
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=9 w=10
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=10 w=11
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=11 w=12
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=12 w=13
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:474 : i=13 w=93
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=93 events=1
2013-09-16 20:39:03.273+0000: 14090: debug : virNetMessageDecodeLength:149 : Got length, now need 64 total (60 more)
2013-09-16 20:39:03.273+0000: 14090: debug : virNetServerClientCalculateHandleMode:137 : tls=(nil) hs=-1, rx=0x1c64390 tx=(nil)
2013-09-16 20:39:03.273+0000: 14090: debug : virNetServerClientCalculateHandleMode:167 : mode=1
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=93 events=1
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollInterruptLocked:702 : Skip interrupt, 1 319137856
2013-09-16 20:39:03.273+0000: 14090: debug : virNetServerClientDispatchRead:889 : RPC_SERVER_CLIENT_MSG_RX: client=0x1c63910 len=64 prog=536903814 vers=1 proc=183 type=0 status=0 serial=8
2013-09-16 20:39:03.273+0000: 14090: debug : virKeepAliveCheckMessage:408 : ka=0x1c637d0, client=0x1c63910, msg=0x1c64390
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollUpdateTimeout:259 : EVENT_POLL_UPDATE_TIMEOUT: timer=245 frequency=5000
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollInterruptLocked:702 : Skip interrupt, 1 319137856
2013-09-16 20:39:03.273+0000: 14090: debug : virNetServerDispatchNewMessage:199 : server=0x1c55a00 client=0x1c63910 message=0x1c64390
2013-09-16 20:39:03.273+0000: 14090: debug : virNetServerProgramRef:87 : prog=0x1c5e8a0 refs=3
2013-09-16 20:39:03.273+0000: 14093: debug : virNetServerHandleJob:138 : server=0x1c55a00 client=0x1c63910 message=0x1c64390 prog=0x1c5e8a0
2013-09-16 20:39:03.273+0000: 14093: debug : virNetServerProgramDispatch:276 : prog=536903814 ver=1 type=0 status=0 serial=8 proc=183
2013-09-16 20:39:03.273+0000: 14090: debug : virNetMessageNew:48 : msg=0x1ca4400 tracked=1
2013-09-16 20:39:03.273+0000: 14090: debug : virNetServerClientCalculateHandleMode:137 : tls=(nil) hs=-1, rx=0x1ca4400 tx=(nil)
2013-09-16 20:39:03.273+0000: 14090: debug : virNetServerClientCalculateHandleMode:167 : mode=1
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=93 events=1
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollInterruptLocked:702 : Skip interrupt, 1 319137856
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollCleanupTimeouts:506 : Cleanup 7
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollCleanupHandles:554 : Cleanup 14
2013-09-16 20:39:03.273+0000: 14090: debug : virEventRunDefaultImpl:244 : running default event implementation
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollCleanupTimeouts:506 : Cleanup 7
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollCleanupHandles:554 : Cleanup 14
2013-09-16 20:39:03.273+0000: 14093: debug : remoteDispatchDomainHasManagedSaveImageHelper:2152 : server=0x1c55a00 client=0x1c63910 msg=0x1c64390 rerr=0x7f9d0d34cc70 args=0x7f9cf0002cc0 ret=0x7f9cf000b200
2013-09-16 20:39:03.273+0000: 14093: debug : virDomainHasManagedSaveImage:16053 : dom=0x7f9cf0002c80, (VM: name=one-250, uuid=e405b3e3-8595-db16-b95d-78a4d522fcc7), flags=0
2013-09-16 20:39:03.273+0000: 14093: debug : virDomainFree:2292 : dom=0x7f9cf0002c80, (VM: name=one-250, uuid=e405b3e3-8595-db16-b95d-78a4d522fcc7)
2013-09-16 20:39:03.273+0000: 14093: debug : virUnrefDomain:276 : unref domain 0x7f9cf0002c80 one-250 1
2013-09-16 20:39:03.273+0000: 14093: debug : virReleaseDomain:238 : release domain 0x7f9cf0002c80 one-250 e405b3e3-8595-db16-b95d-78a4d522fcc7
2013-09-16 20:39:03.273+0000: 14093: debug : virReleaseDomain:246 : unref connection 0x7f9cec0025d0 2
2013-09-16 20:39:03.273+0000: 14093: debug : virNetMessageEncodePayload:351 : Encode length as 32
2013-09-16 20:39:03.273+0000: 14093: debug : virNetServerClientSendMessage:1109 : msg=0x1c64390 proc=183 len=32 offset=0
2013-09-16 20:39:03.273+0000: 14093: debug : virNetServerClientSendMessage:1119 : RPC_SERVER_CLIENT_MSG_TX_QUEUE: client=0x1c63910 len=32 prog=536903814 vers=1 proc=183 type=1 status=0 serial=8
2013-09-16 20:39:03.273+0000: 14093: debug : virNetServerClientCalculateHandleMode:137 : tls=(nil) hs=-1, rx=0x1ca4400 tx=0x1c64390
2013-09-16 20:39:03.273+0000: 14093: debug : virNetServerClientCalculateHandleMode:167 : mode=3
2013-09-16 20:39:03.273+0000: 14093: debug : virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=93 events=3
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=0 w=1, f=9 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=1 w=2, f=11 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=2 w=3, f=13 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=3 w=4, f=14 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=4 w=5, f=15 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=5 w=6, f=16 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=6 w=7, f=8 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=7 w=8, f=18 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=8 w=9, f=19 e=25 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=9 w=10, f=20 e=25 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=10 w=11, f=21 e=25 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=11 w=12, f=22 e=25 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=12 w=13, f=23 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollMakePollFDs:383 : Prepare n=13 w=93, f=24 e=1 d=0
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2013-09-16 20:39:03.273+0000: 14090: debug : virEventPollCalculateTimeout:331 : Got a timeout scheduled for 1379363948273
2013-09-16 20:39:03.274+0000: 14090: debug : virEventPollCalculateTimeout:351 : Timeout at 1379363948273 due in 4999 ms
2013-09-16 20:39:03.274+0000: 14090: debug : virEventPollCalculateTimeout:331 : Got a timeout scheduled for 1379363948273
2013-09-16 20:39:03.274+0000: 14090: debug : virEventPollCalculateTimeout:351 : Timeout at 1379363948273 due in 4999 ms
2013-09-16 20:39:03.275+0000: 14090: debug : virEventPollCalculateTimeout:331 : Got a timeout scheduled for 1379363948273
2013-09-16 20:39:03.275+0000: 14090: debug : virEventPollCalculateTimeout:351 : Timeout at 1379363948273 due in 4998 ms
2013-09-16 20:39:06.111+0000: 14090: debug : virEventPollAddTimeout:248 : EVENT_POLL_ADD_TIMEOUT: timer=273 frequency=-1 cb=0x7f9d129927d0 opaque=0x1c63950 ff=(nil)
2013-09-16 20:39:06.125+0000: 14090: debug : virEventPollRemoveTimeout:293 : EVENT_POLL_REMOVE_TIMEOUT: timer=273
2013-09-16 20:39:06.133+0000: 14090: debug : virEventPollCleanupTimeouts:519 : EVENT_POLL_PURGE_TIMEOUT: timer=273
