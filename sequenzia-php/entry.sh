cd /sequenzia || exit 0
/wait
if [ ! -f "/sequenzia/public/data/.init" ]; then
	php install_auto.php && \
	rm install_auto.php install.php && \
	touch /sequenzia/public/data/.init && \
	echo "Configuration successfully";
fi
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
