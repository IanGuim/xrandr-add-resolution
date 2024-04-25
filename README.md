# Description

This script is meant to simplify the process of adding custom screen resolutions to secondary monitors; it can be used with most *Linux Desktop Environments* that use the [RandR](https://www.x.org/wiki/Projects/XRandR/) protocol.

Currently, the script `ONLY SUPPORTS` secondary monitors connected via ``VGA`` port. Future updates may include support for other connection types, such as **HDMI**, **DVI**, and **DisplayPort**.

# How to use

```shell
user@desktop:~$ xrandr-add-resolution <width> <height> # e.g. (xrandr-add-resolution 1920 1080)
user@desktop:~$ xrandr-add-resolution -h  # for help
```
After the new resolution is added, the script will ask if you want to save the new settings; if you choose so, it will generate the `~/.xprofile` file that can be later included as an autostart file.

# How does it work?

The script is nothing but a way to simplify the xrandr command line configuration. combining the steps below into a simple script.

1. Generate a "modeline" by using cvt.
```shell
cvt 1360 768 75 # <width> <height> <refresh-rate>
```
That will return 

```shell
1360x768 74.89 Hz (CVT) hsync: 60.29 kHz; pclk: 109.00 MHz
Modeline "1360x768_75.00"  109.00  1360 1448 1584 1808  768 771 781 805 -hsync +vsync
```

2. Create a new mode usign the modeline parameters given in the previous step.
```shell
xrandr --newmode "1360x768_75.00" 109.00  1360 1448 1584 1808  768 771 781 805 -hsync +vsync
```

3. Add new mode.

```shell
xrandr --addmode VGA-0 "1360x768_75.00"
```
The new resolution should now be visible on the ``Display Settings menu``.

4. Apply new mode (optional, immediate effect).

```shell
xrandr --output VGA-0 "1360x768_75.00"
```