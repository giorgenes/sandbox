#!/bin/sh

cat Gemfile.lock | tail -n1 | xargs gem install bundler -v 
bundle