use strict;
use warnings;
use HTML::Shakan;
use Test::More tests => 6;
use CGI;

sub check {
    my ($fields, @plan) = @_;

    for my $args (@plan) {
        my $form = HTML::Shakan->new(
            request => $args->[0],
            fields => $fields,
        );
        is $form->is_valid, $args->[1];
    }
}

# TextField
check(
    [
        TextField(
            name     => 'name',
            required => 1,
        ),
    ],
    [ CGI->new(), 0 ],
    [ CGI->new( { name => 'oo' } ), 1 ]
);

# EmailField
check(
    [ EmailField( name => 'email' ) ],
    [ CGI->new( { email => 'oo' } ),             0 ],
    [ CGI->new( { email => 'oo@example.com' } ), 1 ]
);

# URLField
check(
    [ URLField( name => 'u' ) ],
    [ CGI->new( { u => 'm' } ), 0 ],
    [ CGI->new( { u => 'http://mixi.jp' } ), 1 ]
);
