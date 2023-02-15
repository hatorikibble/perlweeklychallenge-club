#!/usr/bin/perl
# 
# Task 2: Copy Directory
# Submitted by: Julien Fiegehenn
# 
# You are given path to two folders, $source and $target.
# 
# Write a script that recursively copy the directory from $source to
# $target except any files.
#
# This version (2a) does it without using File::Find..
# 
# Example
# 
#   Input: $source = '/a/b/c' and $target = '/x/y'
# 
#   Source directory structure:
# 
# |___ a
# |    |___ b
# |         |___ c
# |              |___ 1
# |              |    |___ 1.txt
# |              |___ 2
# |              |    |___ 2.txt
# |              |___ 3
# |              |    |___ 3.txt
# |              |___ 4
# |              |___ 5
# |              |    |___ 5.txt
# 
# Target directory structure:
# 
# |___ x
# |    |___ y
# 
# Expected Result:
# 
# |___ x
# |    |___ y
# |         |___ 1
# |         |___ 2
# |         |___ 3
# |         |___ 4
# |         |___ 5
# 
# MY NOTES: also quite easy, especially using File::Find. even using
# readdir() and recursion isn't too bad.  Might try both..
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use File::Path qw(make_path);
use Data::Dumper;

my $debug=0;
die "Usage: copy-dir-structure [--debug] srcpath dstpath\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV == 2;

my( $srcpath, $dstpath ) = @ARGV;

die "copy-dir-structure: no src path $srcpath\n" unless -d $srcpath;
die "copy-dir-structure: dst path $dstpath exists\n" if -d $dstpath;


=pod

=head2 find_dirs_rec( $srcpath, $dirs );

Recursively Find all directories inside $srcpath, accumulating in @$dirs.

=cut
fun find_dirs_rec( $srcpath, $dirs )
{
	return unless -d $srcpath;
	my $dh;
	unless( opendir($dh, $srcpath) )
	{
		warn "Can't opendir $srcpath: $!\n";
		return;
	}
	my @subdirs = map { "$srcpath/$_" }
		      grep { $_ ne "." && $_ ne ".." && -d "$srcpath/$_" }
		      sort readdir($dh);
	closedir $dh;

	#say "read: $_" for @subdirs;

	foreach my $dir (@subdirs)
	{
		push @$dirs, $dir;
		#say "adding $dir" if $debug;
		find_dirs_rec( $dir, $dirs );
	}
}


=pod

=head2 
my @dirs = find_dirs( $srcpath );

Find all directories inside $srcpath; return a list of paths.

=cut
fun find_dirs( $srcpath )
{
	my $dirs = [];
	find_dirs_rec( $srcpath, $dirs );
	return @$dirs;
}


make_path( $dstpath );

die "copy-dir-structure: no dst path $dstpath after make_path!\n"
	unless -d $dstpath;

my @dirs = map { s|^$srcpath/|$dstpath/|; $_ } find_dirs( $srcpath );
if( $debug )
{
	say "about to mkdir $_" for @dirs;
}
mkdir( $_ ) for @dirs;
