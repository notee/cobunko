package Cobunko::DB;
use strict;
use warnings;
use utf8;
use parent qw(Teng);

__PACKAGE__->load_plugin('Count');
__PACKAGE__->load_plugin('Replace');
__PACKAGE__->load_plugin('Pager');

sub get_books_by_user_id {
    my ( $self, $user_id ) = @_;
    return $self->search('books', +{ user_id => $user_id }, +{ order_by => 'isbn' });
};

sub get_book {
    my ( $self, $user_id, $isbn ) = @_;
    return $self->search('books', +{ user_id => $user_id, isbn => $isbn }, +{ order_by => 'isbn' });
};

sub register {
    my ( $self, $info ) = @_;
    my ( $user_id, $isbn ) = @{$info}{qw/user_id title isbn/};
    eval {
        $self->insert('books', +{ user_id => $user_id, isbn => $isbn });
    };
    if ($@) {
        return 0;
    }
    return 1;
};


1;
