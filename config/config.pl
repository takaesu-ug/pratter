use JSON;

+{
    db => [
        'dbi:mysql:pratter;', 'root', '',
        {
            on_connect_do     => ['SET NAMES utf8'],
            mysql_enable_utf8 => 1,
        },
    ],

    db_test => [
        'dbi:mysql:pratter_test;', 'root', '',
        {
            on_connect_do     => ['SET NAMES utf8'],
            mysql_enable_utf8 => 1,
        },
    ],

    # dotcloudは用意されたenvironmentファイルを利用するためCODE referenceで定義
    db_dotcloud => sub {
        my $env_dot_cloud_file = shift;
        die q{don't exists dotcloud env file} unless -e $env_dot_cloud_file;

        open my $fh, "<", $env_dot_cloud_file or die $!;
        my $env = JSON::decode_json(join '', <$fh>);
        my $user = $env->{DOTCLOUD_DB_MYSQL_LOGIN};
        my $password = $env->{DOTCLOUD_DB_MYSQL_PASSWORD};
        my $host = $env->{DOTCLOUD_DB_MYSQL_HOST};
        my $port = $env->{DOTCLOUD_DB_MYSQL_PORT};
        my $database = "pratter";

        [
            "dbi:mysql:database=$database;host=$host;port=$port;", $user, $password,
            {
                on_connect_do     => ['SET NAMES utf8'],
                mysql_enable_utf8 => 1,
            },
        ]
    },
};

