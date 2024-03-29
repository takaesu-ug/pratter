package Pratter::Schema::Types;
use strict;
use warnings;
use utf8;

use parent 'Exporter';
our @EXPORT = qw/PK_BIGINT BIGINT INTEGER FLOAT DOUBLE VARCHAR VARCHAR_NULL TINYINT DATETIME DATE DATETIME_NULL DATE_NULL TEXT/;


sub PK_BIGINT {
    +{
        data_type         => 'BIGINT',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub BIGINT {
    +{
        data_type         => 'BIGINT',
        is_nullable       => 0,
        default_value     => 0,
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub INTEGER {
    +{
        data_type         => 'INTEGER',
        is_nullable       => 0,
        default_value     => 0,
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub FLOAT {
    +{
        data_type         => 'FLOAT',
        is_nullable       => 0,
        default_value     => 0,
        @_,
    };
}

sub DOUBLE {
    +{
        data_type         => 'DOUBLE',
        is_nullable       => 0,
        default_value     => 0,
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub TINYINT {
    +{
        data_type         => 'TINYINT',
        is_nullable       => 0,
        default_value     => 0,
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub VARCHAR {
    +{
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
        @_,
    },
}

sub VARCHAR_NULL {
    +{
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 1,
        @_,
    },
}

sub DATETIME {
    +{
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
        locale      => 'ja',
        @_,
    };
}

sub DATE {
    +{
        data_type   => 'DATE',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
        locale      => 'ja',
        @_,
    };
}

sub DATETIME_NULL {
    +{
        data_type   => 'DATETIME',
        is_nullable => 1,
        timezone    => 'Asia/Tokyo',
        locale      => 'ja',
        @_,
    };
}

sub DATE_NULL {
    +{
        data_type   => 'DATE',
        is_nullable => 1,
        timezone    => 'Asia/Tokyo',
        locale      => 'ja',
        @_,
    };
}

sub TEXT {
    +{
        data_type   => 'TEXT',
        is_nullable => 0,
        @_,
    },
}

1;
