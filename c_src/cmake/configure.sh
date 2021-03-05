#!/bin/sh

# copy input arguments
# if input argument is ***FLAGS=*** then the contents of the environment variable is prepended
ARGS=""
for i; do
  name=$(echo "$i" | sed s/=.*//)
  isflags=$(echo "$name" | grep 'FLAGS$')
  if [ "x$name" = "x$isflags" ]; then
    # this is a ***FLAGS variable, so prepend with the env value (e.g. CFLAGS=$CFLAGS ***)
    ARGS="$ARGS \"$name=$(eval "echo \$$name") $(echo "$i" | sed "s/$name=//")\""
  else
    # regular argument, copy it
    ARGS="$ARGS $i"
  fi
done

eval "./configure $ARGS ${CONFIGURE_ARGS}"

