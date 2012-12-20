package Pratter::Schema;
use strict;
use warnings;

use base 'DBIx::Class::Schema';
use DateTime;
use DateTime::TimeZone;

__PACKAGE__->load_namespaces;

my $timezone = DateTime::TimeZone->new(name => 'Asia/Tokyo');
sub timezone {$timezone}
sub now      {DateTime->now(time_zone => shift->timezone)}

1;

