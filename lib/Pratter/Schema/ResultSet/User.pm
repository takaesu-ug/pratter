package Pratter::Schema::ResultSet::User;
use strict;
use warnings;
use parent 'DBIx::Class::ResultSet';
use DateTime;

sub find_by_id {
    my ($self, $id) = @_;
    $self->find($id);
}

sub search_all {
    my $self = shift;
    my $cond = {};
    my $attr = {
        order_by  => { -desc => 'updated_at'},
    };
    $self->search($cond, $attr);
}

sub search_by_ids {
    my ($self, $ids) = @_;
    my $cond = {id => { 'in' => $ids } };
    my $attr = {};
    $self->search($cond, $attr);
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

