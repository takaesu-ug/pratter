use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME      => 'Platter',
    VERSION   => '0.01',
    PREREQ_PM => {
        'Mojolicious'                           => '3.60',
        'Mojolicious::Plugin::Authentication'   => '1.24',
        'Mojolicious::Plugin::FormFields'       => '0.02',
        'Mojolicious::Plugin::Validator'        => 0,
        'Plack'                                 => '1.0014',

        'DBIx::Class'                           => '0.08204',
        'DBD::mysql'                            => '4.022',

        'DateTime'                              => '0.78',
        'DateTime::Format::MySQL'               => 0,
        'String::CamelCase'                     => '0.02',
        'JSON'                                  => '2.50',
        'Object::Container'                     => '0.14',
        'Path::Class'                           => '0.29',
        'Module::Find'                          => '0.11',

        # 開発環境関連
        'Project::Libs'                         => 0,
        'SQL::Translator'                       => '0.11016',
    },
    test      => {TESTS => 't/*.t'}
);

