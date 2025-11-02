# Filtile

This is a layout manager for the [River](https://github.com/riverwm/river) window manager. It's a drop-in replacement for `rivertile`, but with a few things added and configuration per tag/output.

## Getting Started

After you install, you can simply replace all instances of `rivertile` with `filtile` in your config to keep everything the same (but switch to per-tag configuration). If you want more than that, keep reading.

## Usage

All numbers will set the value, but also support a prefix of either `+` or `-` for adjustment.

Following are the commands that can be sent to `riverctl send-layout-cmd filtile ...`:

```bash
    view-padding [pixels]
    # Set the padding around views in pixels.
    outer-padding [pixels]
    # Set the padding around the edge of the layout area in pixels.
    main-location [left | top | right | bottom]
    # Set the location of the main area in the layout.
    main-count [count]
    # Set the number of views in the main area of the layout.
    main-ratio [percent]
    # Set the ratio of the main area to total layout area, in percent. The ratio must be between 10 and 90, inclusive.
    flip
    # Flip the main area to the other side of the layout.
    pad
    # Toggle single stack padding. When only one stack is visible, it will be centered and given as much width/height as it would have if there were more windows. Also supports sending "on" or "off" to not toggle.
    monocle
    # Toggle the "monocle" layout. Also supports sending "on" or "off" to not toggle.
    smart-padding [pixels]
    # The padding to apply when there is only one window (and no monocle).
    smart-padding off
    # Turn off smart padding.
    smart-padding-h [pixels]
    # The horizontal (left and right) padding to apply when there is only one window (and no monocle).
    smart-padding-v [pixels]
    # The vertical (top and bottom) padding to apply when there is only one window (and no monocle).
    move-split-[up|down|left|right] [percent]
    # A different way to think about the main ratio. "move-split-right", for example, will make the main-ratio larger when the main-location is left, smaller when it's right, and is a no op for top and bottom.
    diminish [0-100]
    # How much to "diminish" successive windows on the stack. 0 means not at all (every window is the same size), and 100 means that each new window is one quarter the size of the preceding.
```

All commands can be prefaced with one or both of the following options. Either
can be "all". Both set to "all" changes the default.

```bash
    --output
    # The output (monitor) to apply this setting to.
    --tags
    # The tags to apply this setting to.
```

Commands can also be sent to the executable on startup, separated by commas, as shown below.

## Examples

```bash
riverctl map normal Super Z send-layout-cmd filtile "flip"
riverctl map normal Super C send-layout-cmd filtile "pad"

riverctl map normal Super F send-layout-cmd filtile "monocle"

# Move the split locations around
riverctl map normal Super LEFT send-layout-cmd filtile "move-split-left 5"
riverctl map normal Super RIGHT send-layout-cmd filtile "move-split-right 5"

riverctl map normal Super UP send-layout-cmd filtile "diminish -20"
riverctl map normal Super DOWN send-layout-cmd filtile "diminish +20"

riverctl map normal Super+Shift UP send-layout-cmd filtile "diminish -200"
riverctl map normal Super+Shift DOWN send-layout-cmd filtile "diminish +200"

# Set the default layout generator to be filtile and start it.
riverctl default-layout filtile

# - Smart gaps on the sides of every tag (on the larger monitor), to keep
#   single windows from being gigantic.
#
# - A scratch pad on tag 7 with pad (to keep the first window from resizing
#   a bunch) and giant gaps for bling.
#
# - Tag 1 usually has a browser, which is usually easier to read when it's on
#   the right.
filtile \
    --output HDMI-A-1 smart-padding-h 384, \
    --tags $((1 << 6)) pad on, \
    --tags $((1 << 6)) view-padding 64, \
    --tags $((1 << 6)) outer-padding 64, \
    --output HDMI-A-1 --tags 1 main-location right &
```

## Installation

You can build it by yourself and then move the binary to your environment path.

```bash
cargo build --release
```
