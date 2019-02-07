#!/bin/bash

bin/rake db:drop;
bin/rake db:migrate;
bin/rake db:migrate RAILS_ENV=test;
bin/rake db:seed;

exit
