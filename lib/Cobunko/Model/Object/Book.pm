package Cobunko::Model::Object::Book;

use strict;
use warnings;
use JSON::Syck qw(Load);
use LWP::UserAgent;
use URI;

sub get_by_isbn {
    my ($self, $isbn) = @_;
    my $rakuten_search_result = get_from_rakuten(+{isbn => $isbn});
    return $rakuten_search_result->{Items}->[0]->{Item};
}

sub get_from_rakuten {
    my ($self, $params, $opts) = @_;

    my $uri = URI->new('https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522');
    $uri->query_form(
        applicationId   => '1049270485777658554',
        author          => $params->{author},
        title           => $params->{title},
        size            => $params->{size},
        publisherName   => $params->{publisherName},
        booksGenreId    => $params->{booksGenreId},
        isbn            => $params->{isbn} || '9784094510522',
        hits            => $opts->{hits},
        page            => $opts->{page},
        sort            => $opts->{sort}
    );

    my $ua = LWP::UserAgent->new;
    my $res = $ua->get($uri);
    print $res->content;
    my $content = Load($res->content);

    return $content;
}

1;
