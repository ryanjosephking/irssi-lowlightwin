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

Only this:

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
