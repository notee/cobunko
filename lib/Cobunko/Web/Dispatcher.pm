package Cobunko::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub {
    my ($c) = @_;
    my $counter = $c->session->get('counter') || 0;
    $counter++;
    $c->session->set('counter' => $counter);
    return $c->render('cobunko/index.tx', {
        counter => $counter,
    });
};

post '/search' => sub {
    my $c = shift;

    my $user_id = $c->req->param('user_id');

    my $books = $c->db->get_books_by_user_id($user_id);

#    for (@$books) {
#        $_->{url} = "http://www.isbnsearch.org/isbn/" . $_->{isbn};
#    }
    return $c->render( 'cobunko/index.tx', +{ has_search_result => 1, books => $books } );
};

post '/register' => sub {
    my $c = shift;

    my $user_id = $c->req->param('user_id');
    my $title  = $c->req->param('title');
    my $isbn   = $c->req->param('isbn');

    my $is_register_success = $c->db->register(+{ user_id => $user_id, title => $title, isbn => $isbn });
    return $c->render( 'cobunko/index.tx', +{ is_register_success => $is_register_success });
};

1;
