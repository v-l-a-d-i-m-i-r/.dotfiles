#!/bin/sh
set -e;

source "$(dirname $0)/utils.sh";

base_hue=197
base_saturation=10
base_lightnes=15
base_lightnes_step=8

bg_primary=$(hsl_to_hex_string ${base_hue} ${base_saturation} $((${base_lightnes} + ${base_lightnes_step} * 0)));
bg_secondary=$(hsl_to_hex_string ${base_hue} ${base_saturation} $((${base_lightnes} + ${base_lightnes_step} * 0.5)));
bg_selection=$(hsl_to_hex_string ${base_hue} ${base_saturation} $((${base_lightnes} + ${base_lightnes_step} * 1.2)));
fg_comments=$(hsl_to_hex_string ${base_hue} ${base_saturation} $((${base_lightnes} + ${base_lightnes_step} * 2.5)));
fg_secondary=$(hsl_to_hex_string ${base_hue} ${base_saturation} $((${base_lightnes} + ${base_lightnes_step} * 6)));
fg_primary=$(hsl_to_hex_string ${base_hue} ${base_saturation} $((${base_lightnes} + ${base_lightnes_step} * 7.5)));
fg_tertiary=$(hsl_to_hex_string ${base_hue} ${base_saturation} $((${base_lightnes} + ${base_lightnes_step} * 8)));
bg_tertiary=$(hsl_to_hex_string ${base_hue} ${base_saturation} $((${base_lightnes} + ${base_lightnes_step} * 9)));

# red=$(hsl_to_hex_string 14 53 62);
red=$(hsl_to_hex_string 14 60 50);
orange=$(hsl_to_hex_string 17 47 64);
yellow=$(hsl_to_hex_string 60 $((42 - 10)) $((76 - 5)));
green=$(hsl_to_hex_string 168 $((53 - 10)) $((55 - 10)));
cyan=$(hsl_to_hex_string 201 $((98 - 30)) $((80 - 5)));
blue=$(hsl_to_hex_string 209 60 58);
purple=$(hsl_to_hex_string 238 20 49);
pink=$(hsl_to_hex_string 291 37 64);

