#!/bin/bash

nginx
uwsgi --ini /etc/uwsgi/cgit.ini
