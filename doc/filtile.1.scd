FILTILE(1) ["FILTILE(5)" ["Filtile Command Manual"]]

# NAME

filtile - tiled layout generator for river

# SYNOPSIS

*filtile* {*-h*|*-version*} _COMMAND_ [_options_]

*-h*
	Print a help message and exit.

*-version*
	Print the version number and exit.

# DESCRIPTION

This is a layout manager for the *river*(1) window manager. It's a drop-in replacement for *rivertile*(1), but with a few things added and configuration per tag/output.

# COMMANDS

These commands may be sent to filtile with the help of *riverctl*(1).

All number (_pixiels_, _count_, _percent_) support a prefix of either *+* of *-* for adjustment.

*view-padding* [_pixels_]
	Set the padding around views in pixels.

*outer-padding* [_pixels_]
	Set the padding around the edge of the layout area in pixels.

*main-location* [*top*|*bottom*|*left*|*right*]
	Set the location of the main area in the layout.

*main-count* [_count_]
	Set the number of views in main area of the layout.

*main-ratio* [_percent_]
	Set the ratio of the main area to total layout area in percent.
	The ratio *must* be between 10 and 90 inclusive.

*flip*
	Flip the main area to the other side of the layout.

*pad*
	Toggle single stack padding. When only one stack is visible, it will be centered and given as much width/height as it would have if there are more windows.
	Also support sending *on* or *off* to not toggle.

*monocle*
	Toggle the "monocle" layout.
	Also support sending *on* or *off* to not toggle.

*smart-padding* [_pixels_|*off*]
	The padding to apply when there is only one window (and no monocle).
	Also support sending *off* to turn off smart padding.

*smart-padding-h* [_pixels_]
	The horizontal (left and right) padding to apply when there is only one window (and no monocle).

*smart-padding-v* [_pixels_]
	The vertical (top and bottom) padding to apply when there is only one window (and no monocle).

*move-split-*[*up*|*down*|*left*|*right*] [_percent_]
	A different way to think about the main-ratio. *move-split-right*, for example, will make main-ratio lager when the *main-location* is *left*, smaller when it's *right*, and is also a no op for *top* and *bottom*.

*diminish* [0-100]
	How much to *diminish* successive windows on the stack. *0* means not at all (every window is the same size), and *100* means that each new window is one quarter the size of the preceding.

# OPTIONS

All commands can be prefaced with one or both of the following options, either can be *all*.
Both set to *all* changes the default.

*--output* MONITOR
	The output (monitor) to apply this setting to.

*--tags* TAG
	The tags to apply this setting to.

# EXAMPLES

Start *filtile* with 3 pixels smart-padding for tag 1-6 and the right main location:

	filtile --tags $((1 << 6)) smart-padding 3, main-location right

Increase the main ratio by 0.1 at runtime:

	riverctl send-layout-cmd filtile "main-ratio +0.1"

Set the main count to 3 at runtime:
	
	riverctl send-layout-cmd filtile "main-count 3"

# AUTHORS

Mantained by Phil Kulak <phil@kulak.us>. Up-to-date sources can be found at _https://github.com/pkulak/filtile.git_ and bugs/patches can be submitted to _https://github.com/pkulak/filtile/issues_

# SEE ALSO

*river*(1), *riverctl*(1)
