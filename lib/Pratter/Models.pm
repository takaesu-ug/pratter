package Pratter::Models;
use strict;
use warnings;
use utf8;

use Object::Container '-base';
use Path::Class qw/file dir/;
use Module::Find;
use Any::Moose;

use constant PROJECT_NAME => 'Pratter';

# アプリのHomeディレクトリ
register(
    Home => sub {
        my $self = shift;

        my $class = ref $self || $self;
        (my $file = "${class}.pm") =~ s!::!/!g;

        if (my $path = $INC{$file}) {
            $path =~ s/$file$//;

            # オブジェクトに変更
            $path = dir($path);

            if (-d $path) {
                $path = $path->absolute;
                while ($path->dir_list(-1) =~ /^b?lib$/) {
                    $path = $path->parent;
                }
                return $path;
            }
        }

        die q{Error: don't detect home directory};
    }
);

# コンフィグのハッシュリファレンス
register(
    Conf => sub {
        my $home = shift->get('Home');

        my $conf = {};
        for my $conf_file (qw/config\/config.pl config\/config_local.pl/) {
            my $file = $home->file($conf_file);
            if (-e $file) {
                my $c = do $file;
                die 'config should return HASHREF' unless ref($c) eq 'HASH';

                $conf = { %$conf, %$c };
            }
        }

        $conf;
    }
);

## DBICの設定
# スキーマ オブジェクト
register Schema => sub {
    my $self = shift;
    my $module_name = PROJECT_NAME.'::Schema';
    my $env_dot_cloud_file = "/home/dotcloud/environment.json";

    # connectする前にMooseを使ってSchemaをロードする
    Any::Moose::load_class('Pratter::Schema');

    if ( -e $env_dot_cloud_file ) {
        # dotcloud environment
        $module_name->connect($self->get('Conf')->{db_dotcloud}->($env_dot_cloud_file));
    }
    else {
        # local development environment
        my $db_conf = $self->get('Conf')->{db} or die 'require database config';
        $module_name->connect(@{ $db_conf });
    }
};

# ResultSet オブジェクト
# 「ResultSet::モデル名」でResultSetオブジェクトを登録
{
    my @modules = Module::Find::findallmod(PROJECT_NAME.'::Schema::Result');
    my %module_by_name = map {
        my $module = $_;
        my $skip   = PROJECT_NAME.'::Schema::Result::';
        (my $name = $module) =~ s/$skip//;
        $name => $module;
    } @modules;

    for my $source (keys %module_by_name) {
        register "ResultSet::${source}" => sub {
            shift->get('Schema')->resultset($source);
        };
    }
}


__PACKAGE__->meta->make_immutable;

1;
