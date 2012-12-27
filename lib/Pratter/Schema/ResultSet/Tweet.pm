package Pratter::Schema::ResultSet::Tweet;
use strict;
use warnings;
use parent 'DBIx::Class::ResultSet';
use DateTime;

sub find_by_id {
    my ($self, $id) = @_;
    $self->find($id);
}

sub create {
    my ($self, $tweet) = @_;
    $self->SUPER::create($tweet);
}


1;

