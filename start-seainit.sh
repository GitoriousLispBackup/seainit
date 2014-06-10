#!/bin/sh

#Run the seainit servers.

#Suppose that the seainit servers are stored in /sea/seainit-servers/

seainit_server_directory="/sea/seainit-servers";

seainit_log="/sea/log/seainit-log";

#Suppose that SBCL is present.

sbcl_path=$(which sbcl);

#Change to the directory, so that the daemons can all see each other.

cd $seainit_server_directory;

#Start the boostrap server:

$sbcl_path --noinform --no-userinit --non-interactive --load "$seainit_server_directory/seainit-bootstrap.lsp" #&> $seainit_log;

#Now sleep indefinitely.
while true; do sleep 60; done;
