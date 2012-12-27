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

sub register {
    my $self = shift;
    my $tweet = $self->app->row('tweet');
    $self->stash->{tweet} = $tweet;
    $self->render;
}
sub create {
    my $self = shift;
    my $validator = $self->create_validator('Pratter::Form::Validator::Tweet');

    my $tweet = $self->param('tweet');
    $self->stash->{tweet} = $tweet;

    if ($self->validate($validator)) {
        my $txn = $self->app->schema->txn_scope_guard;
        $tweet->{user_id} = $self->current_user->id;
        $self->app->rs('tweet')->create($tweet);
        $txn->commit;

        $self->redirect_to('/');
    }
    else {
        $self->render(template => 'tweet/register');
    }
}

1;
