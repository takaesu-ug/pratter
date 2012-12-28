package Pratter::Schema::Result::User;
use strict;
use warnings;
use parent 'Pratter::Schema::ResultBase';
use Pratter::Schema::Types;

__PACKAGE__->table('user');
__PACKAGE__->add_columns(
    id         => PK_BIGINT,
    name       => VARCHAR,
    login_name => VARCHAR,
    pass       => VARCHAR,
    created_at => DATETIME,
    updated_at => DATETIME,
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many(
    tweets => 'Pratter::Schema::Result::Tweet',
    {'foreign.user_id' => 'self.id'},
    {'is_foreign_key_constraint' => 0}
);

__PACKAGE__->has_many(
    followers => 'Pratter::Schema::Result::Follow',
    {'foreign.target_user_id' => 'self.id'},
    {'is_foreign_key_constraint' => 0}
);

__PACKAGE__->has_many(
    followings => 'Pratter::Schema::Result::Follow',
    {'foreign.user_id' => 'self.id'},
    {'is_foreign_key_constraint' => 0}
);


sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index( fields => [ qw/ name / ]);
    $self->next::method($sqlt_table);
}

sub timeline_tweets {
    my $self = shift;
    $self->id;

    my $ids = $self->following_user_ids;
    push @$ids, $self->id;

    $self->resultset('tweet')->search_by_user_ids($ids)->all;
}

sub following_users {
    my $self = shift;
    my $user_ids = $self->following_user_ids;
    my $rs = $self->resultset->search_by_ids($user_ids);
    $rs->all;
}

sub following_user_ids {
    my $self = shift;
    [$self->followings->get_column('target_user_id')->all];
}

sub follower_users {
    my $self = shift;
    my $user_ids = $self->follower_user_ids;
    my $rs = $self->resultset->search_by_ids($user_ids);
    $rs->all;
}

sub follower_user_ids {
    my $self = shift;
    [$self->followers->get_column('user_id')->all];
}

1;
