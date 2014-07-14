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

    my $title  = $c->req->param('title');
    my $author = $c->req->param('author');
    my $isbn   = $c->req->param('isbn');

    $c->db->search(+{ title => $title, author => $author, isbn => $isbn });
    return $c->render( 'conbunko/index.tx', +{ title => $title } );
};

post '/register' => sub {
    my $c = shift;

    my $title  = $c->req->param('title');
    my $author = $c->req->param('author');
    my $isbn   = $c->req->param('isbn');

    my $book = $c->db->register(+{ title => $title, author => $author, isbn => $isbn });
    return $c->render( 'conbunko/index.tx', $book );
};

1;
