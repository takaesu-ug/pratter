package Pratter::Schema::Result::Fuga;
use strict;
use warnings;
use parent 'Pratter::Schema::ResultBase';
use Pratter::Schema::Types;

__PACKAGE__->table('fuga');
__PACKAGE__->add_columns(
    id      => PK_INTEGER,
    body    => VARCHAR,
    created_at => DATETIME,
    updated_at => DATETIME,
);

__PACKAGE__->set_primary_key('id');

1;

