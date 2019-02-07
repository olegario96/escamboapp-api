#!/bin/bash

bin/rake db:drop;
bin/rake db:migrate;
bin/rake db:seed;
bin/rake db:migrate RAILS_ENV=test;
exit
