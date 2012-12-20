package Pratter::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
    my $self = shift;

    my $fuga_rs = $self->app->rs('fuga');

    use DDP;
    my @test = $fuga_rs->search()->all;
    p @test;

    # Render template "example/welcome.html.ep" with message
    $self->render(
        message => 'TAKAESU Welcome to the Mojolicious real-time web framework!');
}

1;
