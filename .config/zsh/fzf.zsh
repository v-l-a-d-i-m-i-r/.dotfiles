# start colors
FZF_BG_PLUS="#384145";
FZF_HL="#ce9178";
FZF_GUTTER="#22282a";
FZF_POINTER="#b9c2c6";
FZF_HL_PLUS="#ce9178";
# end colors

local opts=(
  '--reverse'
  "--bind='tab:down,shift-tab:up'"
  "--color=bg+:${FZF_BG_PLUS},hl+:${FZF_HL_PLUS},hl:${FZF_HL},gutter:${FZF_GUTTER},pointer:${FZF_POINTER}"
)

export FZF_DEFAULT_OPTS="${opts[@]}"
