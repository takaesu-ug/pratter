package Pratter::Controller::User;
use Mojo::Base 'Mojolicious::Controller';

# 全ユーザ一覧
sub index {
    my $self = shift;

    my $user_rs = $self->app->rs('user');
    my $test = $user_rs->search()->next;

    # Render template "example/welcome.html.ep" with message
    $self->render(
        message => $test->name." Welcome to the Mojolicious real-time web framework!");
}

# フォローしている全ユーザ一覧
sub following {

}

# フォロワーの全ユーザ一覧
sub follower {

}

# ユーザをフォローする
sub follow {

}

1;
