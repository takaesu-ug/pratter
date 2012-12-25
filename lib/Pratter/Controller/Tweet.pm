package Pratter::Controller::Tweet;
use Mojo::Base 'Mojolicious::Controller';

# つぶやき一覧
sub index {
    my $self = shift;

    my $user_rs = $self->app->rs('user');
    my $test = $user_rs->search()->next;

    # Render template "example/welcome.html.ep" with message
    $self->render(
        message => $test->name." Welcome to the Mojolicious real-time web framework!");
}

# つぶやく
sub create {

}


1;
