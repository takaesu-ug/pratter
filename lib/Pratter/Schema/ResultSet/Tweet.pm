package Pratter::Schema::ResultSet::Tweet;
use strict;
use warnings;
use parent 'DBIx::Class::ResultSet';
use DateTime;

sub find_by_id {
    my ($self, $id) = @_;
    $self->find($id);
}

sub search_by_user_ids {
    my ($self, $user_ids) = @_;
    my $cond = { user_id => { 'in' => $user_ids } };
    my $attr = {
        order_by  => { -desc => 'me.updated_at'},
        join      => 'user',
        '+select' => ['user.id', 'user.name', 'user.login_name', 'user.created_at', 'user.updated_at'],
    };
    $self->search($cond, $attr);
}

sub create {
    my ($self, $tweet) = @_;
    $self->SUPER::create($tweet);
}

1;

