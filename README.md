Bifrost-Boeger
==============

To install and start type:

* bundle install
* rake jetty:clean
* rake jetty:config
* install [rabbitmq](https://www.rabbitmq.com/install-debian.html)
* rabbitmq-server
* rake db:migrate
* rake jetty:start
* rails s

To load test data into Fedora type:
* rake bifrost:clean  
* rake bifrost:superloader 
