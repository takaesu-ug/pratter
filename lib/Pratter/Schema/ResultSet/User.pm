package Pratter::Schema::ResultSet::User;
use strict;
use warnings;
use parent 'DBIx::Class::ResultSet';
use DateTime;

sub register {
    my ($self, $user) = @_;

    $self->create($user);
}

1;

