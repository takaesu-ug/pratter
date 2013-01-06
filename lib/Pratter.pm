package Pratter;
use Mojo::Base 'Mojolicious';
use Pratter::Models 'models';


# This method will run once at server start
sub startup {
    my $self = shift;

    # Documentation browser under "/perldoc"
    #$self->plugin('PODRenderer');

    # Pluginをロード
    $self->plugin('config' => {file => './config/config.pl'});
    $self->plugin('FormFields');
    $self->plugin('validator');
    $self->plugin('authentication' => $self->_auth_param);

    # Session
    $self->sessions->default_expiration(3600);

    # Router
    my $r = $self->routes;
    $r->namespace('Pratter::Controller');
    $r = $r->bridge->to(cb => sub {
            my $self = shift;

            return 1 if ($self->is_user_authenticated);

            my $url = $self->req->url->to_string;
            my $free_urls = ['/', '/auth', '/user/register'];
            return 1 if $url ~~ $free_urls;

            $self->redirect_to('/')
        });

    $r->get('/')->to('root#index');

    $r->post('/auth')->to('auth#auth');
    $r->get('/sign_out')->to('auth#sign_out');

    $r->get('/user')->to('user#index');
    $r->get('/user/register')->to('user#register');
    $r->post('/user/register')->to('user#create');

    $r->get('/following/:user_id')->to('follow#following');
    $r->get('/follower/:user_id')->to('follow#follower');
    $r->get('/follow/:user_id')->to('follow#follow');
    $r->get('/unfollow/:user_id')->to('follow#unfollow');

    $r->get('/tweet/register')->to('tweet#register');
    $r->post('/tweet/register')->to('tweet#create');
    $r->get('/tweet')->to('tweet#index');
    $r->get('/tweet/:user_id')->to('tweet#index');

}


sub _auth_param {
    my $self = shift;

    return {
        'autoload_user'     => 1,
        'load_user'         => sub {
            my ($self, $uid) = @_;
            my $user = models('ResultSet::User')->find_by_id($uid);
            if ($user) {
                return $user;
            }
            else {
                return;
            }
        },
        'validate_user'     => sub {
            my ($self, $username, $password, $extra) = @_;
            my $user = models('ResultSet::User')->auth_user($username, $password);

            if ($user) {
                return $user->id
            }
            else {
                return;
            }
        }
    }
}

1;
