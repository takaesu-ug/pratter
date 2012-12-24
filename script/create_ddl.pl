#!/usr/bin/env perl
use 5.12.0;
use warnings;
use utf8;
use FindBin::libs;
use Path::Class qw/file/;
use Getopt::Long;
use Pod::Usage;
use Pratter;

=head1 DESCRIPTION

Schema/Result 以下を見てSQLを吐き出すスクリプト

=head1 SYNOPSIS

    script/create_ddl.pl -p 1

     Options:
       -help            brief help message
       preversion       create DDL for diff from $preversion to current_version (optional)
       no-replace       don't replace $VERSION in MyApp::Schema (optional)

=cut


my $app = Pratter->new;
my $schema = $app->schema;
my $dir = 'sql/';
my ($preversion, $help, $no_replace);

GetOptions(
    'h|help'          => \$help,
    'p|preversion=i'  => \$preversion,
    'no-replace'      => \$no_replace,
    'dir=s'           => \$dir,
) or die pod2usage;
pod2usage(1) if $help;


my $current_version = $schema->schema_version;
my $next_version    = $current_version + 1;
$preversion       ||= $current_version;

say "current  version: $current_version";
say "db       version: ".$schema->get_db_version;
say "ddl from version: ".$preversion;
say "      to version: ".$next_version;

$dir = "$FindBin::Bin/../$dir";
$schema->create_ddl_dir(
    [qw/MySQL/],
    $next_version,
    $dir,
    $preversion,
    +{
        parser      => 'SQL::Translator::Parser::DBIx::Class',
        parser_args => {
            quote_field_names => 1,
        },
    }
);

my $new_file = file($schema->ddl_filename('MySQL', $next_version, $dir));
my $diff_file = file($schema->ddl_filename('MySQL', $next_version, $dir, $preversion));

put_versioning($new_file, 1);
put_versioning($diff_file, 0);

unless ($no_replace) {
    # replace version
    my $f = file( $INC{'Pratter/Schema.pm'} );
    my $content = $f->slurp;

    $content =~ s/(\$VERSION\s*=\s*(['"]))(.+?)\2/$1$next_version$2/
        or die "Failed to replace version.";

    my $fh = $f->openw or die $!;
    print $fh $content;
    $fh->close;
}




sub put_versioning {
    my ($file, $is_new) = @_;

    my $sql = $file->slurp;
    my $versioning = "";
    my $now = $schema->now;
    my $installed = sprintf("v%04d%02d%02d_%02d%02d%02d.000",
        $now->year, $now->month, $now->day, $now->hour, $now->minute, $now->second,
    );

    if ($is_new) {
        $versioning = "CREATE TABLE IF NOT EXISTS `dbix_class_schema_versions` (`version` varchar(10) NOT NULL, `installed` varchar(20) NOT NULL, PRIMARY KEY (`version`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8; \nINSERT INTO dbix_class_schema_versions (version, installed) VALUES ($next_version, '$installed');";
        $sql .= $versioning;
    }
    else {
        $versioning = "INSERT INTO dbix_class_schema_versions (version, installed) VALUES ($next_version, '$installed');";
        $sql =~ s/COMMIT;/$versioning\nCOMMIT;/;
    }


    my $fh = $file->openw or die $!;
    $fh->print($sql);
    $fh->close;
}

