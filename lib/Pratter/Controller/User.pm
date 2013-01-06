package Pratter::Controller::User;
use Mojo::Base 'Mojolicious::Controller';
use Pratter::Models 'models';

# 全ユーザ一覧
sub index {
    my $self = shift;

    $self->stash->{users} = [ models('ResultSet::User')->search_all->all ];
    $self->render;
}

sub register {
    my $self = shift;
    my $user = models('ResultSet::User')->new_row;
    $self->stash->{user} = $user;
    $self->render;
}

sub create {
    my $self = shift;

    my $validator = $self->create_validator('Pratter::Form::Validator::User');

    my $user = $self->param('user');
    $self->stash->{user} = $user;

    if ($self->validate($validator)) {
        my $txn = models('Schema')->txn_scope_guard;
        models('ResultSet::User')->create($user);
        $txn->commit;

        $self->authenticate($user->{login_name}, $user->{pass});
        $self->redirect_to('/');
    }
    else {
        $self->render(template => 'user/register');
    }
}


1;
