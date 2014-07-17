package Cobunko::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'Cobunko::DB::Row';

table {
    name 'books';
    pk 'user_id';
    columns qw(user_id title isbn);
};

1;
