all:
	jekyll serve
apache:
	sudo rm -rf /var/www/html/*
	sudo cp -r _site/* /var/www/html/
