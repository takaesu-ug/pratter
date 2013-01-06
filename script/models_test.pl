#!/usr/bin/env perl
use warnings;
use utf8;
use FindBin::libs;

use Pratter::Models 'models';


my $path = models('Home');
my $conf = models('Conf');
my $schema = models('Schema');

use DDP;
use Data::Dumper;
print $path."\n";


#p $conf;


my $test = [ models('ResultSet::Tweet')->search()->all ];
p $test;
