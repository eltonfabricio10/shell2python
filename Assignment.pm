#!/usr/bin/perl -w

# Matthew Moss
# mdm@cse.unsw.edu.au
# cs2041, 12s2

use strict;

use Translate;
use Builtins;

package Assignment;

sub can_handle {
    # Identifies if this module can handle a line
    return ($_[0] =~ /[a-zA-Z]\w*=.+/);
}

sub handle {
    # This is the generic entry point for converting a line.
    # Should only be called after can_handle returns true
    my $input = $_[0];
    chomp ($input);

    $input =~ /(\w+)=(.+)/;
    my $variable = Translate::make_keyword_safe($1);
    my $rhs = $2;
    my $value = "";

    if ($rhs =~ /^\s*\d+\s*$/) {
        # It's a pure numeric
        $value = $rhs;
    } elsif (Builtins::can_handle($rhs)) {
        $value = Builtins::handle($rhs);
    } else {
        $value = Translate::escape_arg($2);
    }

    return "$variable = $value";
}

1;
