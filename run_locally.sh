#!/bin/bash

cd Desktop/Website.io

rm Gemfile.lock

bundle clean
bundle install
bundle exec jekyll liveserve