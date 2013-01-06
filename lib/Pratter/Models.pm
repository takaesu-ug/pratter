package Pratter::Models;
use strict;
use warnings;
use utf8;

use Object::Container '-base';

use Path::Class qw/file dir/;

register(
    home => sub {
        my $class = shift;

        $class = ref $class || $class;
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


register(
    conf => sub {
        my $home = shift->get('home');

        my $conf = {};
        for my $fn (qw/config\/config.pl config\/config_local.pl/) {
            my $file = $home->file($fn);
            if (-e $file) {
                my $c = do $file;
                die 'config should return HASHREF'
                unless ref($c) and ref($c) eq 'HASH';

                $conf = { %$conf, %$c };
            }
        }

        $conf;
    }
);


1;
