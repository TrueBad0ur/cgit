#!/bin/sh

nginx
uwsgi --ini /etc/uwsgi/cgit.ini
