package Cobunko::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Cobunko::Model::Object::Book;

any '/' => sub {
    my ($c) = @_;
    my $counter = $c->session->get('counter') || 0;
    $counter++;
    $c->session->set('counter' => $counter);
    return $c->render('cobunko/index.tx', {
        counter => $counter,
    });
};

post '/book_detail' => sub {
    my $c = shift;

    my $user_id = $c->req->param('user_id');
    my $isbn    = $c->req->param('isbn');

    my $book_own_info = $c->db->get_book($user_id, $isbn);
    my $book_info     = Cobunko::Model::Object::Book->get_by_isbn($isbn);

    return $c->render(
        'cobunko/book_detail.tx',
        +{
            book            => $book_info,
            book_own_info   => $book_own_info,
        }
    );
};

post '/lending' => sub {
};

post '/return' => sub {
};

post '/search' => sub {
    my $c = shift;

    my $user_id = $c->req->param('user_id');

    my $books_iter = $c->db->get_books_by_user_id($user_id);
    my $books_isbn = [];

    while (my $row = $books_iter->next) {
        push @$books_isbn, $row->isbn;
    }

    my $books = Cobunko::Model::Object::Book->get_by_keywords($books_isbn);
    for (@$books){
        $_->{url} = "http://www.isbnsearch.org/isbn/" . "$_->{isbn}";
    }
    return $c->render( 'cobunko/index.tx', +{ has_search_result => 1, books => $books, user_id => $user_id } );
};

post '/register' => sub {
    my $c = shift;

    my $user_id = $c->req->param('user_id');
    my $isbn   = $c->req->param('isbn');

    my $is_register_success = $c->db->register(+{ user_id => $user_id, isbn => $isbn });
    return $c->render( 'cobunko/index.tx', +{ is_register_success => $is_register_success });
};

1;
