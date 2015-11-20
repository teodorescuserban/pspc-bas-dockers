user = 'www-data'
group = 'www-data'
bind = '0.0.0.0:5000'
workers = 2
accesslog = '/var/log/wsgi/wsgi.access.log'
errorlog = '/var/log/wsgi/wsgi.error.log'
loglevel = 'debug'
