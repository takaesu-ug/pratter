package Pratter::Controller::Root;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;

    if ($self->is_user_authenticated) {
        $self->stash->{tweets} = [$self->current_user->timeline_tweets];
        $self->render(template => 'root/index_authed');
    }
    else {
        $self->render(template => 'root/index');
    }
}

1;
