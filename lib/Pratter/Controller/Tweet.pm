package Pratter::Controller::Tweet;
use Mojo::Base 'Mojolicious::Controller';
use Pratter::Models 'models';

# つぶやき一覧
sub index {
    my $self = shift;

    my $user_id = $self->stash->{user_id};
    if ($user_id) {
        $self->stash->{tweets} = [ models('ResultSet::Tweet')->search_by_user_ids([$user_id])->all ];
    }
    else {
        $self->stash->{tweets} = [ models('ResultSet::Tweet')->search_all->all ];
    }

    $self->render;
}

sub register {
    my $self = shift;
    my $tweet = models('ResultSet::Tweet')->new_row;
    $self->stash->{tweet} = $tweet;
    $self->render;
}
sub create {
   my $self = shift;
    my $validator = $self->create_validator('Pratter::Form::Validator::Tweet');

    my $tweet = $self->param('tweet');
    $self->stash->{tweet} = $tweet;

    if ($self->validate($validator)) {
        my $txn = models('Schema')->txn_scope_guard;
        $tweet->{user_id} = $self->current_user->id;
        models('ResultSet::Tweet')->create($tweet);
        $txn->commit;

        $self->redirect_to('/');
    }
    else {
        $self->render(template => 'tweet/register');
    }
}

1;
