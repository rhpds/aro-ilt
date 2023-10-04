#$/usr/bin/perl
use strict;
use warnings;

use YAML qw(LoadFile);
use Data::Dumper qw(Dumper);
local $YAML::Preserve = 1;

my $source_filename =  or die "Usage: $0 YAML-FILE\n";

my $data = LoadFile($source_filename);

my %nav;

my $title_style = '.';

my $subtitle_style = '*';

my $last_title = "";
my $last_subtitle = "";
my $first_title = 1;

for my $filename ( keys %{$data->{'modules'}}) {
  my $name = $data->{'modules'}{$filename}{'name'};

  my @temp = split '/', $filename;

  if ($#temp == 0) {

    my $title = $title_style . $name;
    if ($last_title ne $title) {
      if ($first_title == 1) {
          $first_title = 0;
        } else {
          print "\n";
      }
      print "$title\n";
      $last_title = $title;
    }

    my $adoc = $subtitle_style . " xref:" . $filename . ".adoc[$name]";
    print "$adoc\n";

    $nav{ "$title" }{'filenames'} = [ $adoc ];
  }

  if ($#temp == 1) {
    my $title = $title_style . $temp[0];

    if ($last_title ne $title) {
      if ($first_title == 1) {
          $first_title = 0;
        } else {
          print "\n";
        }
      print "$title\n";
      $last_title = $title;
    }

    my $adoc = $subtitle_style . ' xref:'. $filename. ".adoc[$name]";

    print "$adoc\n";

    push @{$nav{ "$title" }{'filenames'}}, $adoc;

  }

  if ($#temp == 2) {

    my $title = $title_style . $temp[0];
    if ($last_title ne $title) {
      if ($first_title == 1) {
          $first_title = 0;
        } else {
          print "\n";
      }
      print "$title\n";
      $last_title = $title;
    }

    my $subtitle = $subtitle_style . " " . $temp[1];
    if ($last_subtitle ne $subtitle) {
      print "$subtitle\n";
      $last_subtitle = $subtitle;
    }

    my $adoc = $subtitle_style x 2 . ' xref:'. $filename. ".adoc[$name]";

    print "$adoc\n";

    push @{$nav{ "$title" }{ "$subtitle" }{'filenames'}}, $adoc;

  }
}
__END__
print "HELLO!\n";
print Dumper %nav;

print "\n\nFINAL\n\n";
for my $title ( sort keys %nav ) {
  print "$title\n";

  if ( exists $nav{ "$title" }{'filenames'} ) {
    print join "\n", @{$nav{ "$title" }{'filenames'}};
    print "\n";
  }

  else {
    my $subtitle;
    for $subtitle ( keys %{ $nav{ "$title" } } ) {
      print "$subtitle\n";
      print join "\n", @{ $nav{ "$title" }{ "$subtitle" }{'filenames'} } ;
      print "\n";
      }
  }

}
__END__
# Create new HoH with
# titles, subtitles, and xrefs
# variables for title style (* -> ul, '. ' -> ol, or '.' -> title)
for my $filename ( keys $data->{'modules'} ) {
  print "$things\n";
}
# foreach my $file (sort { $a cmp $b } keys %data{'modules'}) {
#   print "$file\n";
# }