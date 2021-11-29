cat <<EOF

**************************************************************
Entered chroot environment. When finished type 'exit' then run

   sudo scripts/darwin-chroot teardown

**************************************************************

EOF

alias exit='echo "umounting /dev";umount /dev;builtin exit'

echo "mounting /dev"
mount -t devfs devfs /dev
