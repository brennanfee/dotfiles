# MooseFS Setup

All actions should be taken as root.

## All

`usermod -a -G data-user mfs`

## Master

In /etc/mfs:

Edit mfsmaster.cfg as needed

Edit mfsexports.cfg as needed

`systemctl enable --now moosefs-master` or `mfsmaster start`

`systemctl enable --now moosefs-cgiserv` or `mfscgiserv start`

Port CGI uses: 9425

Port used between master's and metaloggers: 9419

Port used between master's and chunk servers: 9420

### Master config modifications

mfsmaster.cfg -> DATA_PATH, redirect to /data/moosefs/metadata

mfsmaster.cfg -> AUTH_CODE, set to auth code password

Also need to symlink /var/lib/mfs

### Advanced Master Setup

Add the following line to /etc/sysctl.conf

vm.overcommit_memory=1

## Metaloggers

In /etc/mfs:

Edit mfsmetalogger.cfg as needed

`systemctl enable --now moosefs-metalogger` or `mfsmetalogger start`

### Metalogger config modifications

mfsmetalogger.cfg -> DATA_PATH, redirect to /data/moosefs/metadata

mfsmetalogger.cfg -> MASTER_HOST, dns entry for moosefs master server (or IP)

## Chunk Server

In /etc/mfs:

Edit mfschunkserver.cfg as needed

Edit mfshdd.cfg as needed, adding all disks

`systemctl enable --now moosefs-chunkserver` or `mfschunkserver start`

For each drive that will store chunks:

`lsblk | grep -i moose_disks | sort`

`WORKING_DISK=/mnt/<path to mounted disk>`

`chown mfs:mfs ${WORKING_DISK} && chmod 770 ${WORKING_DISK} && echo "${WORKING_DISK}" >> /etc/mfs/mfshdd.cfg`

### Chunk server config modifications

mfschunkserver.cfg -> DATA_PATH, redirect to /data/moosefs/metadata

mfschunkserver.cfg -> FILE_UMASK, default makes group read only, maybe make group rw?

mfschunkserver.cfg -> HDD_LEAVE_SPACE_DEFAULT, set to 1G

mfschunkserver.cfg -> MASTER_HOST, dns entry for moosefs master server (or IP)

mfschunkserver.cfg -> AUTH_CODE, set same as on master

mfshdd.cfg -> List the mount points to use for storing chunks

## Clients

Use my script in ~/.dotfiles/bin (should already be on path) `mount-moose` and `mount-shares` to mount shares.  Note, these scripts use kwalletcli which must be installed first.

Manually mount:  `mfsmount <mountpoint> -H <master host name> -S <path> -o rw -o msfpassword=<pwd> -o -o mfsdelayedinit`

In fstab:

`localhost:  <mountpoint>  moosefs  defaults,mfsdelayedinit,mfspassword=<pwd> 0 0`

Set the goal (# of copies) for a folder: `mfssetgoal -r 2 ${MOUNTPOINT}/path/to/folder`

Check how many copies of a file: `mfscheckfile ${MOUNTPOINT}/path/to/file`

## Dashboard

http://moose.bfee.org:9425/mfs.cgi?sections=IN%7CHD%7CRS%7CCS%7CMO%7CMS&OFsessionid=42&ALinode=1

## My storage structure and permissions

```sh

# All passwords in Bitwarden

metadata -> mount rw from LAN with a password
/ < the root of the moose data >, mount rw + admin from LAN with a password
  /backups, mount rw from LAN with password
  /files, mount ro from LAN with password=FeeGuest, mount ro from IoT with password, mount rw from LAN with password, mount rw from cloud with password
  /other, mount rw from LAN with password, mount rw from cloud with password
  /only-a, only mountable by aristotle1 (10.10.0.61)
  /only-b, only mountable by aristotle2 (10.10.0.62)
```

My net ranges:

- LAN: 10.10.0.0/20
- IoT: 10.30.0.0/20
- Cloud: 10.100.0.0/20
- VPN?: 10.15.0.0/24

The default mount options:
  readonly,maproot=999:999,mingoal=1,maxgoal=9,mintrashtime=0,maxtrashtime=4294967295

## Jumbo frames

Note: This doesn't seem to be working on the larger network, so skip for now

`sudo nmcli con mod "Wired connection 1" ethernet.mtu 9000`
`sudo nmcli con up "Wired connection 1"`
