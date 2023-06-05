#!/bin/sh
set -e;

source "$(dirname $0)/utils.sh";

base_hue=197
base_saturation=10
base_lightnes=15
base_lightnes_step=8

chan=223
chan_step=-20

function gray_to_hex_string() {
  echo $(rgb_to_hex_string $1 $1 $1);
}

bg_primary=$(gray_to_hex_string $chan);
bg_secondary=$(gray_to_hex_string $(($chan + $chan_step * 0.5)));
bg_selection=$(gray_to_hex_string $(($chan + $chan_step * 1.2)));
fg_comments=$(gray_to_hex_string $(($chan + $chan_step * 2.5)));
fg_secondary=$(gray_to_hex_string $(($chan + $chan_step * 6)));
fg_primary=$(gray_to_hex_string $(($chan + $chan_step * 7)));
fg_tertiary=$(gray_to_hex_string $(($chan + $chan_step * 8)));
bg_tertiary=$(gray_to_hex_string $(($chan + $chan_step * 9)));

s=50
l=30
red=$(hsl_to_hex_string 14 $s $l);
orange=$(hsl_to_hex_string 17 $s $l);
yellow=$(hsl_to_hex_string 60 $s $(($l - 10)));
green=$(hsl_to_hex_string 168 $s $(($l - 10)));
cyan=$(hsl_to_hex_string 201 $s $(($l + 5)));
blue=$(hsl_to_hex_string 209 $s $l);
purple=$(hsl_to_hex_string 238 $s $l);
pink=$(hsl_to_hex_string 291 $s $l);
