#!/bin/sh

INSTALL_DIR=$PWD

bin="$INSTALL_DIR/ipfs"
binpaths="/usr/local/bin /usr/bin"

is_write_perm_missing=""

for binpath in $binpaths; do
  if mv "$bin" "$binpath/" ; then
    echo "Moved $bin to $binpath"
    ipfs init
    echo "hello world" > hello
    ipfs add hello
    ipfs cat QmT78zSuBmuS4z925WZfrqQ1qHaJ56DQaTfyMUF7F8ff5o

    exit 0
  else
    if [ -d "$binpath" ] && [ ! -w "$binpath" ]; then
      is_write_perm_missing=1
    fi
  fi
done

echo "We cannot install $bin in one of the directories $binpaths"

if [ -n "$is_write_perm_missing" ]; then
  echo "It seems that we do not have the necessary write permissions."
  echo "Perhaps try running this script as a privileged user:"
  echo
  echo "    sudo $0"
  echo
fi

exit 1
