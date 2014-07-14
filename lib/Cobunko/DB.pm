package Cobunko::DB;
use strict;
use warnings;
use utf8;
use parent qw(Teng);

__PACKAGE__->load_plugin('Count');
__PACKAGE__->load_plugin('Replace');
__PACKAGE__->load_plugin('Pager');

sub search {
    my ( $self, $info ) = @_;
    my ( $title, $author, $isbn) = @{$info}{qw/title author isbn/};
    return +{ title => $title, author => $author, isbn => $isbn };
};

sub register {
    my ( $self, $info ) = @_;
    my ( $title, $author, $isbn) = $info{qw/title author isbn/};
    return;
};


1;
