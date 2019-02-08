#!/bin/bash

bin/rake db:drop;
bin/rake db:migrate;
bin/rake db:migrate RAILS_ENV=test;
bin/rake db:migrate RAILS_ENV=production;
bin/rake db:seed;
bin/rake db:seed RAILS_ENV=production;
exit
