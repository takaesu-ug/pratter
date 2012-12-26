package Pratter::Controller::User;
use Mojo::Base 'Mojolicious::Controller';

# 全ユーザ一覧
sub index {
    my $self = shift;

    my $user_rs = $self->app->rs('user');
    my $test = $user_rs->search()->next;

    $self->render(
        message => $test->name." Welcome to the Mojolicious real-time web framework!");
}

sub register {
    my $self = shift;
    my $user = $self->app->row('user');
    $self->stash->{user} = $user;
    $self->render;
}

sub create {
    my $self = shift;

    my $validator = $self->create_validator('Pratter::Form::Validator::User');

    my $user = $self->param('user');
    $self->stash->{user} = $user;

    if ($self->validate($validator)) {
        my $txn = $self->app->schema->txn_scope_guard;
        $self->app->rs('User')->register($user);
        $txn->commit;

        $self->redirect_to('/');
    }
    else {
        $self->render(template => 'user/register');
    }
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
