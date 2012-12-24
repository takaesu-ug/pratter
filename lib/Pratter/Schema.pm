package Pratter::Schema;
use strict;
use warnings;

use base 'DBIx::Class::Schema';
use DateTime;
use DateTime::TimeZone;

our $VERSION = '2';

__PACKAGE__->load_namespaces;

# スキーマのバージョニング
__PACKAGE__->load_components('Schema::Versioned');
__PACKAGE__->upgrade_directory('sql/');

my $timezone = DateTime::TimeZone->new(name => 'Asia/Tokyo');
sub timezone {$timezone}
sub now      {DateTime->now(time_zone => shift->timezone)}

1;

