package Pratter::Schema::ResultSet::User;
use strict;
use warnings;
use parent 'DBIx::Class::ResultSet';
use DateTime;

sub find_by_id {
    my ($self, $id) = @_;
    $self->find($id);
}

sub create {
    my ($self, $user) = @_;
    $self->SUPER::create($user);
}

sub auth_user {
    my ($self, $username, $password) = @_;
    $self->search({
            login_name => $username,
            pass       => $password,
        })->next;
}

1;

