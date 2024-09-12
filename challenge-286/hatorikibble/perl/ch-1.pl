#!/usr/env/perl
# Task 1 Challenge 286 Solution by hatorikibble
#  Self Spammer    Submitted by:   David Ferrone      Write a program
# which outputs one word of its own script / source code at random.
# A word is anything between whitespace, including symbols.
#   Example 1    If the source code contains a line such as: 'open
# my $fh, &quot;<&quot;, &quot;ch-1.pl&quot; or die;' then the program
# would output each of the words { open, my, $fh,, &quot;<&quot;,,
# &quot;ch-1.pl&quot;, or, die; } (along with other words in the
# source) with some positive probability.     Example 2    Technically
# 'print(&quot; hello &quot;);' is *not* an example program, because
# it does not assign positive probability to the other two words
# in the script. It will never display print(&quot; or &quot;);
#     Example 3    An empty script is one trivial solution, and
# here is another: echo &quot;42&quot; > ch-1.pl && perl -p -e ''
# ch-1.pl

use strict;
use warnings;
use File::Slurper 'read_text';

my $buffer = read_text(__FILE__);
my @words  = split( / /, $buffer );

print $words[ int( rand($#words) ) ];
