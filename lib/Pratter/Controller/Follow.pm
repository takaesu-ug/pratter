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
    my $self = shift;
    my $target_user_id = $self->stash->{user_id};
    my $user = $self->app->rs('user')->find_by_id($target_user_id);
    $self->render(text => 'follow error') and return unless $user;

    $self->app->rs('follow')->follow($self->current_user->id, $target_user_id);

    $self->redirect_to('/following/'.$self->current_user->id);

}

# フォロー解除
sub unfollow {
    my $self = shift;
    my $target_user_id = $self->stash->{user_id};
    my $user = $self->app->rs('user')->find_by_id($target_user_id);
    $self->render(text => 'unfollow error') and return unless $user;

    $self->app->rs('follow')->unfollow($self->current_user->id, $target_user_id);

    $self->redirect_to('/following/'.$self->current_user->id);

}

1;
