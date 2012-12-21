package Pratter::Schema::Result::User;
use strict;
use warnings;
use parent 'Pratter::Schema::ResultBase';
use Pratter::Schema::Types;

__PACKAGE__->table('user');
__PACKAGE__->add_columns(
    id         => PK_BIGINT,
    name       => VARCHAR,
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

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index( fields => [ qw/ name / ]);
    $self->next::method($sqlt_table);
}


1;

