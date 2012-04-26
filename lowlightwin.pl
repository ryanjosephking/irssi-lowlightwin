#
# Print all messages to a window named 'lowlight'
# irssi 0.8.15-svn
# by rking + billnye (on Freenode)
#

# 1. Put it in ~/.irssi/scripts (maybe also symlink from autoload/)
# 2. /load lowlightwin.pl
# 3. /win new
# 4. /win name lowlight
# 5. Much enjoy!!

# 6. When you get things right, /layout save  then  /save

use Irssi;
use POSIX;
use vars qw($VERSION %IRSSI); 

our $NAME = 'lowlight';

$VERSION = "0.01";
%IRSSI = (
    authors     => "rking",
    contact     => "rking\@panoptic.com", 
    name        => $NAME,
    description => "Prefix and print all messages to window named \"$NAME\"",
    license     => "Public Domain",
    url         => "http://irssi.org/",

    changed     => "Thu Apr 26 10:09:13 EDT 2012",
);

# lifted from nickcolor.pl
my @colors = qw/31 32 33 34 35 36 37/;
sub simple_hash {
  my ($string) = @_;
  chomp $string;
  my @chars = split //, $string;
  my $counter;
  foreach my $char (@chars) {
    $counter += ord $char;
  }
  $counter = $colors[$counter % 11];
  return $counter;
}

sub sig_printtext {
    my ($dest, $text, $stripped) = @_;
    $window = Irssi::window_find_name($NAME);
    my $hush = MSGLEVEL_NEVER|MSGLEVEL_JOINS|MSGLEVEL_PARTS|MSGLEVEL_QUITS;
    return if $dest->{level} & $hush;
    if (
        $dest->{level} & MSGLEVEL_PUBLIC and not $dest->{level} & $hush
    ) {
        $color_esc = "\e[" . simple_hash($dest->{target}) . ";1m";
        $text = "$color_esc$dest->{target}\e[10;1m\e[0m: $text";
    }
    $text = strftime(
        Irssi::settings_get_str('timestamp_format')." ",
        localtime
    ) . $text;
    $window->print($text, MSGLEVEL_NEVER) if ($window);
}

$window = Irssi::window_find_name($NAME);
Irssi::print("Create a window named '$NAME'") if (!$window);
Irssi::signal_add('print text', 'sig_printtext');

# vim:set ts=4 sw=4 et:
