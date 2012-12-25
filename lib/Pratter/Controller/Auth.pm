package Pratter::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';

sub login {
    my $self = shift;

    my $user_rs = $self->app->rs('user');
    my $test = $user_rs->search()->next;

    # Render template "example/welcome.html.ep" with message
    $self->render(
        message => $test->name." Welcome to the Mojolicious real-time web framework!");
}


sub logout {
    my $self = shift;

}

1;
