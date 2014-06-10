seainit_daemons=$(wildcard *.lsp)
bootstrap_shell_script=start-seainit.sh
seainit_server_directory="/sea/seainit-servers"
seainit_log_directory="/sea/log"
#Since this is written in lisp, there's nothing to do on 'all'.

all: 
	@echo "This is lisp, there's nothing to compile.";

install: 
	mkdir -p "$(seainit_server_directory)";
	mkdir -p "$(seainit_log_directory)";
	mkdir -p /bin;
	cp -v "$(bootstrap_shell_script)" /bin;
	chmod +x /bin/"$(bootstrap_shell_script)";
	cp -v $(seainit_daemons) "$(seainit_server_directory)";

