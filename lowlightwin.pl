#
# Print all messages to a window named 'lowlight'
# irssi 0.8.15-svn
# by rking + billnye & kalikiana (on Freenode)

=head1

The opposite of [hilightwin.pl](https://scripts.irssi.org/scripts/hilightwin.pl)

Though hilightwin.pl's goals are to show you all the text that is aimed at you
(nick-pings and privmsg's), lowlightwin.pl shows you the opposite -- all the
rest of the text.

This is good if you are interested enough in a channel to idle in it, but not
enought to make the effort to switch to that window repeatedly.


Installation
------------

1. `mkdir -p ~/.irssi/scripts/autorun` # (If it's not already there)
2. `(cd ~/.irssi/scripts; curl -O https://raw.github.com/ryanjosephking/irssi-lowlightwin/master/lowlightwin.pl)`
3. `ln -vsf ~/.irssi/scripts/{lowlightwin.pl,autorun}`
4. `/load lowlightwin.pl` # (or restart irssi)
5. `/win new` then `/win name lowlight` then `/win down` # See
   [irssisplit](http://quadpoint.org/articles/irssisplit) to attempt to make
   sense of this.
6. Play around with `/win grow` and `/win shrink`
7. When you get things right, `/layout save` then `/save`

Updating
--------

Perform steps #2 and #4, above.

Configuration
-------------

You can do:

    /set lowlight_ignore #noisychan1,#noisychan2

To skip all traffic on those channels (or nicks).

Also, there is:

    /set lowlight_say_less on

...which will cause these to be silenced (from /help levels):

- CLIENTNOTICE    - Irssi's notices
- CLIENTERROR     - Irssi's error messages
- CLIENTCRAP      - Some other messages from Irssi

The most noticeable change is that information that would've gone to your
"(status)" window will no longer be part of the lowlight window.

Complaints to:
--------------

<rking@panoptic.com>

=cut

use Irssi;
use POSIX;
use vars qw($VERSION %IRSSI);

our $NAME = 'lowlight';

$VERSION = "0.3";
%IRSSI = (
    authors     => "rking",
    contact     => "rking\@panoptic.com",
    name        => $NAME,
    description => "Prefix and print all messages to window named \"$NAME\"",
    license     => "Public Domain",
    url         => "http://irssi.org/",

    changed     => "Fri Apr 27 03:41:00 EDT 2012",
);

Irssi::settings_add_bool('lowlight', 'lowlight_say_less', "0");
Irssi::settings_add_str('lowlight', 'lowlight_ignore', "");

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

    $hush |= MSGLEVEL_NOTICES|MSGLEVEL_CLIENTNOTICE|MSGLEVEL_CLIENTCRAP
        if Irssi::settings_get_bool('lowlight_say_less');
    return if $dest->{level} & $hush;

    my @ignores = split /[, ]+/, Irssi::settings_get_str('lowlight_ignore');
    for (@ignores) {
        return if $dest->{target} eq $_;
    }

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
