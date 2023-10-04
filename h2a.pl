#!/usr/bin/perl
# hugo based navigation definitions to asciidoc for Antora
# ./h2a.pl ~/Development/documentation/content/_index.md

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my $source_filename = shift or die "Usage: $0 Hugo Index\n";

open my $fh, '<', $source_filename;

foreach my $line (<$fh>) {
  # print $line;
  if ($line =~ /^# (.*)$/) {
    print ".$1\n";
    next;
  }
  if ($line =~ /^## (.*)$/) {
    print ".$1\n";
    next;
  }
  if ($line =~ /^### (.*)$/) {
    print "..$1\n";
    next;
  }
  #if ($line =~ /^\* (\[.*?\])\(*.?\)$/) {
  if ($line =~ /^\* (\[.*?\])\(\/docs\/(.*?)\)$/ ) {
    print "* xref:$2$1\n";
    next;
  }
  if ($line =~ /^  \* (\[.*?\])\(\/docs\/(.*?)\)$/ ) {
    print "** xref:$2$1\n";
    next;
  }
}