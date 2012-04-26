lowlightwin.pl
==============

The opposite of [hilightwin.pl](https://scripts.irssi.org/scripts/hilightwin.pl)

Though hilightwin.pl's goals are to show you all the text that is aimed at you
(nick-pings and privmsg's), lowlightwin.pl shows you the opposite -- all the
rest of the text.

This is good if you are interested enough in a channel to idle in it, but not
enought to make the effort to switch to that window repeatedly.


Installation
------------

1. Put it in ~/.irssi/scripts (maybe also symlink from autoload/)
2. /load lowlightwin.pl
3. /win new
4. /win name lowlight
5. Much enjoy!!
6. When you get things right, /layout save  then  /save

Configuration
-------------

None beyond tweaking the script itself, currently. It will automatically
colorize the channel name and hide join/parts/quits, whether you like it or
not. Feel free to send suggestions about what you'd like to see as an option,
though.

Complaints to:
--------------

<rking@panoptic.com>
