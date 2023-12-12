# start colors
FZF_BG_PLUS="#434C5E";
FZF_HL="#D08770";
FZF_GUTTER="#2E3440";
FZF_POINTER="#c2c8d2";
FZF_HL_PLUS="#D08770";
# end colors

local opts=(
  '--reverse'
  "--bind='tab:down,shift-tab:up'"
  "--color=bg+:${FZF_BG_PLUS},hl+:${FZF_HL_PLUS},hl:${FZF_HL},gutter:${FZF_GUTTER},pointer:${FZF_POINTER}"
)

export FZF_DEFAULT_OPTS="${opts[@]}"
