#!/bin/sh
set -e;

source "$(dirname $0)/$1.sh";

patch_file() {
  local start_separator="${1}";
  local end_separator="${2}";
  local template="${3}";
  local file_path="${4}";

  local patched_file=$(sed -e "/${start_separator}/,/${end_separator}/c\\${start_separator}\n${template}\n${end_separator}" "${file_path}");
  echo "$patched_file" > "${file_path}";
}

patch_shell_syntax() {
  local start_separator='# start colors';
  local end_separator='# end colors';
  local template='';

  template+="BG_PRIMARY=\"${bg_primary}\";\n";
  template+="BG_SECONDARY=\"${bg_secondary}\";\n";
  template+="BG_SELECTION=\"${bg_selection}\";\n";
  template+="FG_COMMENTS=\"${fg_comments}\";\n";
  template+="FG_SECONDARY=\"${fg_secondary}\";\n";
  template+="FG_PRIMARY=\"${fg_primary}\";\n";
  template+="FG_TERTIARY=\"${fg_tertiary}\";\n";
  template+="BG_TERTIARY=\"${bg_tertiary}\";\n";
  template+="RED=\"${red}\";\n";
  template+="ORANGE=\"${orange}\";\n";
  template+="YELLOW=\"${yellow}\";\n";
  template+="GREEN=\"${green}\";\n";
  template+="CYAN=\"${cyan}\";\n";
  template+="BLUE=\"${blue}\";\n";
  template+="PURPLE=\"${purple}\";\n";
  template+="PINK=\"${pink}\";";

  patch_file ${start_separator} ${end_separator} ${template} ${1};
}

patch_xresources_syntax() {
  local start_separator='! start colors';
  local end_separator='! end colors';
  local template='';

  template+="#define BG_PRIMARY ${bg_primary}\n";
  template+="#define BG_SECONDARY ${bg_secondary}\n";
  template+="#define BG_SELECTION ${bg_selection}\n";
  template+="#define FG_COMMENTS ${fg_comments}\n";
  template+="#define FG_SECONDARY ${fg_secondary}\n";
  template+="#define FG_PRIMARY ${fg_primary}\n";
  template+="#define FG_TERTIARY ${fg_tertiary}\n";
  template+="#define BG_TERTIARY ${bg_tertiary}\n";
  template+="#define RED ${red}\n";
  template+="#define ORANGE ${orange}\n";
  template+="#define YELLOW ${yellow}\n";
  template+="#define GREEN ${green}\n";
  template+="#define CYAN ${cyan}\n";
  template+="#define BLUE ${blue}\n";
  template+="#define PURPLE ${purple}\n";
  template+="#define PINK ${pink}";

  patch_file ${start_separator} ${end_separator} ${template} ${1};
}

patch_lua_syntax() {
  local start_separator='-- start colors';
  local end_separator='-- end colors';
  local template='';

  template+="local bg_primary = \"${bg_primary}\" -- base00\n";
  template+="local bg_secondary = \"${bg_secondary}\" -- base01\n";
  template+="local bg_selection = \"${bg_selection}\" -- base02\n";
  template+="local fg_comments = \"${fg_comments}\" -- base03\n";
  template+="local fg_secondary = \"${fg_secondary}\" -- base04\n";
  template+="local fg_primary = \"${fg_primary}\" -- base05\n";
  template+="local fg_tertiary = \"${fg_tertiary}\" -- base06\n";
  template+="local bg_tertiary = \"${bg_tertiary}\" -- base07\n";
  template+="local red = \"${red}\" --base08\n";
  template+="local orange = \"${orange}\" -- base09\n";
  template+="local yellow = \"${yellow}\" -- base0A\n";
  template+="local green = \"${green}\" -- base0B\n";
  template+="local cyan = \"${cyan}\" -- base0C\n";
  template+="local blue = \"${blue}\" -- base0D\n";
  template+="local purple = \"${purple}\" -- base0E\n";
  template+="local pink = \"${pink}\" -- base0F";

  # patch_file ${start_separator} ${end_separator} ${template} ${1};
  echo $template;
}

# patch_shell_syntax "${HOME}/.tmux.conf";
# patch_shell_syntax "${HOME}/.config/zsh/prompt.zsh";
# patch_xresources_syntax "${HOME}/.Xresources.colors";
# patch_lua_syntax "${HOME}/.config/nvim/plugins/themes/lua/colors-definitions.lua";
patch_lua_syntax
