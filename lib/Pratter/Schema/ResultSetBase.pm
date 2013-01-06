package Pratter::Schema::ResultSetBase;
use strict;
use warnings;
use parent 'DBIx::Class::ResultSet';

sub new_row {
    my ($self, $columns) = @_;

    $columns = {} unless $columns;
    $self->new($columns);
}

1;
