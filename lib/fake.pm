package fake;

use strict;
use warnings;

use Carp;
use version;our $VERSION = qv('0.0.1');
require first;

sub import {
    shift;
    local $UNIVERSAL::Level = $UNIVERSAL::Level + 1; 
    local $Carp::CarpLevel  = $Carp::CarpLevel  + 1;
    
    my $mod = shift;
    
    return if !defined $mod;
    
    @_ ? $mod->use( @_ )
       : $mod->use;
    my $path = $mod;
    $path =~ s{::}{/}g;
    $INC{ $path . '.pm' } = 'fake.pm: this module is not here: ' . $@ if $@;   
}

1;

__END__

=head1 NAME

fake - use a module and fake it if its not loadable

=head1 SYNOPSIS

  use fake warnings; # Keep older versions of Perl from trying to use lexical warnings

instead of 

    BEGIN {
        # Keep older versions of Perl from trying to use lexical warnings
        $INC{'warnings.pm'} = "fake warnings entry for < 5.6 perl ($])" if $] < 5.006;
    }
    use warnings;

or

    eval 'use warnings;';
    $INC{'warnings.pm'} = "fake warnings entry for < 5.6 perl ($])" if $@;

=head1 DESCRIPTION

If a module is not available, it quietly fake's the %INC entry so that it will be seen as loaded later.
If it is available its use'd as normal as if you'd just done 'use mod;'

This example SYNOPSIS illustrates how you'd 'use warnings;' when available and not use it when its not.

=head1 SEE ALSO

L<first>

=head1 AUTHOR

Daniel Muey, L<http://drmuey.com/cpan_contact.pl>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Daniel Muey

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut