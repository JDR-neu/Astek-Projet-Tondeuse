#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/stagiaire019/astek_ws/src/diff_drive"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/stagiaire019/astek_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/stagiaire019/astek_ws/install/lib/python2.7/dist-packages:/home/stagiaire019/astek_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/stagiaire019/astek_ws/build" \
    "/usr/bin/python" \
    "/home/stagiaire019/astek_ws/src/diff_drive/setup.py" \
    build --build-base "/home/stagiaire019/astek_ws/build/diff_drive" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/stagiaire019/astek_ws/install" --install-scripts="/home/stagiaire019/astek_ws/install/bin"
