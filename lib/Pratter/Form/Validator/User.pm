package Pratter::Form::Validator::User;
use strict;
use warnings;
use utf8;

use parent 'MojoX::Validator';

sub new {
    my $self = shift->SUPER::new(
        messages => {
            REQUIRED => '必須項目',
        }, @_);

    $self->field('user.name')->required(1);
    $self->field('user.login_name')->required(1);
    $self->field('user.pass')->required(1);

    return $self;
}

#sub new {
#    my $class = shift;
#    my %args = @_ == 1 ? %{$_[0]} : @_;
#    bless {%args}, $class;
#
#}

1;

