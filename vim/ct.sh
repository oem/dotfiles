#!/bin/bash
cd ~/.vim/bundle/command-t/ruby/command-t
RBENV_VERSION=system ruby extconf.rb
make
