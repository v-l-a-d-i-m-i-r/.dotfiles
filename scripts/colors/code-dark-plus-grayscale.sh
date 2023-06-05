#!/bin/sh
set -e;

source "$(dirname $0)/utils.sh";

chan=40
chan_step=20

bg_primary=$(gray_to_hex_string $chan);
bg_secondary=$(gray_to_hex_string $(($chan + $chan_step * 0.5)));
bg_selection=$(gray_to_hex_string $(($chan + $chan_step * 1.2)));
fg_comments=$(gray_to_hex_string $(($chan + $chan_step * 2.5)));
fg_secondary=$(gray_to_hex_string $(($chan + $chan_step * 6)));
fg_primary=$(gray_to_hex_string $(($chan + $chan_step * 7)));
fg_tertiary=$(gray_to_hex_string $(($chan + $chan_step * 8)));
bg_tertiary=$(gray_to_hex_string $(($chan + $chan_step * 9)));

# red=$(hsl_to_hex_string 14 53 62);
red=$(hsl_to_hex_string 14 60 50);
orange=$(hsl_to_hex_string 17 47 64);
yellow=$(hsl_to_hex_string 60 $((42 - 10)) $((76 - 5)));
green=$(hsl_to_hex_string 168 $((53 - 10)) $((55 - 10)));
cyan=$(hsl_to_hex_string 201 $((98 - 30)) $((80 - 5)));
blue=$(hsl_to_hex_string 209 60 58);
purple=$(hsl_to_hex_string 238 20 49);
pink=$(hsl_to_hex_string 291 37 64);
