package Pratter::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';

sub auth {
    my $self = shift;

    my $u = $self->req->param('login_name');
    my $p = $self->req->param('pass');

    $self->flash( login_error => 1 ) unless $self->authenticate($u, $p);
    $self->redirect_to('/');
}

sub sign_out {
    my $self = shift;
    $self->logout();
    $self->redirect_to('/');
}


1;
