#!/bin/bash
BACKUP_DRIVE=/media/backup
BUP=bup
BUP_DIR=${BACKUP_DRIVE}/${BUP}

mountit() {
	mount ${BACKUP_DRIVE} -o remount,rw

}
unmountit() {
        mount ${BACKUP_DRIVE} -o remount,ro
}
getOwner() {
	echo $(ls -l ${BACKUP_DRIVE} | grep ${BUP} | awk '{print $3}')
}

mountit
echo "beginning backup: $(date)" >> ${BACKUP_DRIVE}/backupError.log

bup -d ${BUP_DIR} index --exclude=~./gvfs/ --exclude=~/.cache/ ~ >> ${BACKUP_DRIVE}/backupError.log

echo ""
echo "beginning Saving: $(date)" >> ${BACKUP_DRIVE}/backupError.log

bup -d ${BUP_DIR} save -n $(hostname) ~ >> ${BACKUP_DRIVE}/backupError.log
echo ""
echo "setting Directory Owner back to owner"
chown -R $(getOwner):$(getOwner) $BUP_DIR
unmountit
echo "backup Done"
echo ""
