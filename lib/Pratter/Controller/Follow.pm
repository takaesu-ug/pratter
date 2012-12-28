package Pratter::Controller::Follow;
use Mojo::Base 'Mojolicious::Controller';

# フォローしているユーザ一覧
sub following {
    my $self = shift;
    my $user_id = $self->stash->{user_id};
    my $user = $self->app->rs('user')->find_by_id($user_id) || $self->current_user;
    $self->stash->{users} = [$user->following_users];

    $self->render;
}

# フォロワーのユーザ一覧
sub follower {
    my $self = shift;
    my $user_id = $self->stash->{user_id};
    my $user = $self->app->rs('user')->find_by_id($user_id) || $self->current_user;
    $self->stash->{users} = [$user->follower_users];

    $self->render;
}

# フォローする
sub follow {

}

# フォロー解除
sub unfollow {

}

1;
