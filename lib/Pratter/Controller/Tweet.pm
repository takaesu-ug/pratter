package Pratter::Controller::Tweet;
use Mojo::Base 'Mojolicious::Controller';

# つぶやき一覧
sub index {
    my $self = shift;

    my $user_id = $self->stash->{user_id};
    if ($user_id) {
        $self->stash->{tweets} = [ $self->app->rs('tweet')->search_by_user_ids([$user_id])->all ];
    }
    else {
        $self->stash->{tweets} = [ $self->app->rs('tweet')->search_all->all ];
    }

    $self->render;
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
