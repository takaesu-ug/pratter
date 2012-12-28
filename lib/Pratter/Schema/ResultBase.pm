package Pratter::Schema::ResultBase;
use strict;
use warnings;
use parent 'DBIx::Class';

use JSON qw/to_json from_json/;
use String::CamelCase qw/ camelize decamelize /;
use DateTime;

__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->extra(
        mysql_table_type => 'InnoDB',
        mysql_charset => 'utf8',
    );
}

sub insert {
    my $self = shift;

    my $now = Pratter::Schema->now;
    $self->created_at( $now ) if $self->can('created_at');
    $self->updated_at( $now ) if $self->can('updated_at');
    $self->next::method(@_);
}

sub update {
    my $self = shift;

    my $now = Pratter::Schema->now;
    $self->updated_at( $now ) if $self->can('updated_at');
    $self->next::method(@_);
}

sub json_columns {
    my ($pkg, @columns) = @_;

    for my $column (@columns) {
        $pkg->inflate_column($column => {
            inflate => sub { my $p = shift; $p && from_json($p, {allow_nonref => 1}); },
            deflate => sub { my $p = shift; $p &&   to_json($p, {allow_nonref => 1}); },
        });
    }
}

sub resultset {
    my ($self, $name) = @_;

    return $self->result_source->schema->resultset(camelize $name) if $name;

    return $self->result_source->resultset;
}

1;
