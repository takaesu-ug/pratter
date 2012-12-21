package Pratter::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
    my $self = shift;

    my $fuga_rs = $self->app->rs('fuga');
    my $test = $fuga_rs->search()->next;

    # Render template "example/welcome.html.ep" with message
    $self->render(
        message => $test->body." Welcome to the Mojolicious real-time web framework!");
}

1;
