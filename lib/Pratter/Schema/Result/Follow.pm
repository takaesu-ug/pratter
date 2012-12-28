package Pratter::Schema::Result::Follow;
use strict;
use warnings;
use parent 'Pratter::Schema::ResultBase';
use Pratter::Schema::Types;

__PACKAGE__->table('follow');
__PACKAGE__->add_columns(
    id             => PK_BIGINT,
    user_id        => BIGINT,
    target_user_id => BIGINT,
    created_at     => DATETIME,
    updated_at     => DATETIME,
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(
    user => 'Pratter::Schema::Result::User',
    {'foreign.id' => 'self.user_id'},
    {'is_foreign_key_constraint' => 0 }
);

__PACKAGE__->belongs_to(
    target_user => 'Pratter::Schema::Result::User',
    {'foreign.id' => 'self.target_user_id'},
    {'is_foreign_key_constraint' => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index( fields => [ qw/ user_id / ]);
    $sqlt_table->add_index( fields => [ qw/ target_user_id / ]);
    $self->next::method($sqlt_table);
}


1;

