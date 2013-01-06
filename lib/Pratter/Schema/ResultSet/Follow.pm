package Pratter::Schema::ResultSet::Follow;
use strict;
use warnings;
use parent 'Pratter::Schema::ResultSetBase';
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

sub unfollow {
    my ($self, $user_id, $target_user_id) = @_;
    my $cond = {
        user_id        => $user_id,
        target_user_id => $target_user_id,
    };
    my $attr = {};

    $self->search($cond, $attr)->delete;
}

sub follow {
    my ($self, $user_id, $target_user_id) = @_;
    my $data = {
        user_id        => $user_id,
        target_user_id => $target_user_id,
    };

    $self->create($data);
}


1;

