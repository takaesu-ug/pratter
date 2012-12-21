package Pratter::Schema::Result::Tweet;
use strict;
use warnings;
use parent 'Pratter::Schema::ResultBase';
use Pratter::Schema::Types;

__PACKAGE__->table('tweet');
__PACKAGE__->add_columns(
    id         => PK_BIGINT,
    user_id    => BIGINT,
    body       => VARCHAR(
        size => 150,
    ),
    created_at => DATETIME,
    updated_at => DATETIME,
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(
    user => 'Pratter::Schema::Result::User',
    {'foreign.id' => 'self.user_id'},
    {'is_foreign_key_constraint' => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index( fields => [ qw/ user_id / ]);
    $self->next::method($sqlt_table);
}

1;

