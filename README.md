# Proxmox Backup Client Docker Containers
Two containers based on Debian 12 (bookworm) with proxmox-backup-client installed.  Github actions rebuilds the containers based on upstream once per day.  Containers are tagged with the version of the installed `proxmox-backup-client` and latest
## Common options
The `PBS_FINGERPRINT` and `PBS_PASSWORD` environment variables will need to be specified in order for `proxmox-backup-client` to create backups.  Please see the `proxmox-backup-client` documentation for other options: [Proxmox Backup Client Documentation](https://pbs.proxmox.com/docs/backup-client.html)
## Base Container
The `Entrypoint` is set to `proxmox-backup-client`, so you can specify your arguments in the `CMD` field.  
  
Docker run example:
```
docker run --rm -e PBS_FINGERPRINT="aa::bb..::ff" -e PBS_PASSWORD="hunter2" -v your_data:/mnt/data ghcr.io/00nave198/pbs-client-docker backup data.pxar:/mnt/data --repository backup-server:storage
```

Container pull tag:
```
ghcr.io/00nave198/pbs-client-docker
```
## Cron Container
The `pbs-client-docker-cron` container is based on the above base container, with the addition of cron functionality.  To enable cronjob backups, you must complete the following three steps:
1. Create and mount a cronfile for the backup job.  Include your backup command here  
``` 
# mycron Backup data at midnight
0 0 * * * root proxmox-backup-client backup data.pxar:/mnt/data > /proc/1/fd/1 2>/proc/1/fd/2
# Needs a blank line at the end to be a valid cron file
```
2. Specify your cron file in the `CRON_LIST` environment variable.  Multiple comma-separated files may be specified.  You must specify the full path if you plan to mount the file outside of the `/etc/cron.d` folder
```
CRON_LIST="mycron"
```
3. Mount the cronfile into the container and run!
```
docker run --rm -e PBS_FINGERPRINT="aa::bb..::ff" -e PBS_PASSWORD="hunter2" -e CRON_LIST="mycron" -v mycron:/etc/cron.d/mycron -v your_data:/mnt/data ghcr.io/00nave198/pbs-client-docker-cron
```


Container pull tag:
```
ghcr.io/00nave198/pbs-client-docker-cron
```
