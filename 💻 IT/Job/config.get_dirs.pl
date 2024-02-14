#!/usr/bin/env perl
use warnings;
use strict;
use config;
require "config.pm";
open D, ">", "directory.log";
print D @config::directory;
close(D) or die $!;
