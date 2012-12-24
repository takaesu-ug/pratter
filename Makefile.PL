use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME      => 'Platter',
    VERSION   => '0.01',
    PREREQ_PM => {
        'Mojolicious'       => '3.60',
        'Plack'             => '1.0014',

        'DBIx::Class'       => '0.08204',
        'DBD::mysql'        => '4.022',

        'DateTime'          => '0.78',
        'String::CamelCase' => '0.02',
        'JSON'              => '2.50',

        # 開発環境関連
        'Project::Libs'     => 0,
        'SQL::Translator'   => '0.11016',
    },
    test      => {TESTS => 't/*.t'}
);
