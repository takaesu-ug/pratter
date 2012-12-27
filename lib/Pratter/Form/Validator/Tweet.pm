package Pratter::Form::Validator::Tweet;
use strict;
use warnings;
use utf8;

use parent 'MojoX::Validator';

sub new {
    my $self = shift->SUPER::new(
        messages => {
            REQUIRED => '必須項目',
            LENGTH_CONSTRAINT_FAILED => '140字以内'
        }, @_);

    $self->field('tweet.body')->required(1)->length(1, 140);

    return $self;
}


1;

