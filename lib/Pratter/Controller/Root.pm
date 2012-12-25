package Pratter::Controller::Root;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;

    my $user_rs = $self->app->rs('user');
    my $test = $user_rs->search()->next;

    # Render template "example/welcome.html.ep" with message
    $self->render(
        message => $test->name." Welcome to the Mojolicious real-time web framework!");
}

1;
