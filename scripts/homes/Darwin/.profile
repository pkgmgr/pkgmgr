# shellcheck shell=sh

echo "Entered ${BUILDROOT_DIR} chroot; Sourcing .profile"

cat <<EOF

**************************************************************
Entered chroot environment. When finished type 'exit' then run

   sudo scripts/darwin-chroot teardown ${BUILDROOT_DIR}

**************************************************************

EOF

alias exit='echo "Unmounting /dev";umount /dev;builtin exit'

echo "Mounting /dev"
mount -t devfs devfs /dev

echo "cd $HOME"
cd "$HOME"

if [ -x "${RUN_SCRIPT}" ]; then
    echo "Found ${RUN_SCRIPT} - executing"
    "${RUN_SCRIPT}"
fi
