package Pratter::Controller::User;
use Mojo::Base 'Mojolicious::Controller';

# 全ユーザ一覧
sub index {
    my $self = shift;

    $self->stash->{users} = [ $self->app->rs('user')->search_all->all ];
    $self->render;
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
        $self->app->rs('User')->create($user);
        $txn->commit;

        $self->authenticate($user->{login_name}, $user->{pass});
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
