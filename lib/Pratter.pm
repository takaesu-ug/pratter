package Pratter;
use Mojo::Base 'Mojolicious';
use String::CamelCase qw/ camelize decamelize /;
use Pratter::Schema;


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
    my $module_name = 'Pratter::Schema';

    $module_name->connect(@{ $self->config->{database} });
}

sub rs {
    my ($self, $name) = @_;
    die "resultset name is required" unless $name;

    my $camel_name = camelize $name;
    $self->schema->resultset($camel_name);
}

1;
