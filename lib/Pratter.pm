package Pratter;
use Mojo::Base 'Mojolicious';
use String::CamelCase qw/ camelize decamelize /;
use Pratter::Schema;

use JSON;


# This method will run once at server start
sub startup {
    my $self = shift;

    $self->plugin('config' => {file => './config/pratter.conf'});

    # Documentation browser under "/perldoc"
    #$self->plugin('PODRenderer');

    # Router
    my $r = $self->routes;
    $r->namespace('Pratter::Controller');

    # Normal route to controller
    #$r->get('/')->to('example#welcome');
    $r->route('/')->via('POST','GET')->to(controller =>'example', action => 'welcome');

    #$r->route('/:controller/:action')->to(controller => $controller, action => $action);
}

sub schema {
    my $self = shift;
    my $env_dot_cloud_file = "/home/dotcloud/environment.json";
    my $module_name = 'Pratter::Schema';

    if ( -e $env_dot_cloud_file ) {
        open my $fh, "<", $env_dot_cloud_file or die $!;
        my $env = JSON::decode_json(join '', <$fh>);
        my $user = $env->{DOTCLOUD_DB_MYSQL_LOGIN};
        my $password = $env->{DOTCLOUD_DB_MYSQL_PASSWORD};
        my $host = $env->{DOTCLOUD_DB_MYSQL_HOST};
        my $port = $env->{DOTCLOUD_DB_MYSQL_PORT};
        my $database = "hoge";
        $module_name->connect(
            "dbi:mysql:database=$database;host=$host;port=$port;", $user, $password,
            {
                on_connect_do     => ['SET NAMES utf8'],
                mysql_enable_utf8 => 1,
            },
        );
    }
    else {
        # local development environment
        $module_name->connect(@{ $self->config->{db} });
    }
}

sub rs {
    my ($self, $name) = @_;
    die "resultset name is required" unless $name;

    my $camel_name = camelize $name;
    $self->schema->resultset($camel_name);
}

1;


