# https://www.sglavoie.com/posts/2019/11/10/using-dmenu-to-optimize-common-tasks/

set -e

# filesContent=$(rg '^Name=|^Exec=|^Comment=|^GenericName=|^Terminal=|^Type=|^\[' /usr/share/applications --no-line-number --no-filename --no-heading);
filesContent=$(rg '^Name=|^Exec=|^Comment=|^GenericName=|^\[' /usr/share/applications --no-line-number --no-filename --no-heading);
linesCount=$(echo "$filesContent" | rg '' -c);

name='';
exec='';
genericName='';

declare -A hashList;
declare -a menuList;
ignore=true;
separator='№';
outputSeparator=' ';

function addToHashList () {
  local key;
  local menuItem;

  [[ ! -z $genericName ]] && menuItem="${name}${separator}[${genericName}]${separator}${exec}" || menuItem="${name}${separator}${separator}${exec}";
  # [[ ! -z $genericName ]] && key="${name} (${genericName}) ${exec}" || key="${name} ${exec}";

  menuList+=("$menuItem");
  hashList["$menuItem"]="$exec";

  name='';
  exec='';
  genericName='';
}

while read -r line; do
  if [[ $line == '[Desktop Entry]' && "$ignore" = true ]]; then
    ignore=false;
  fi

  if [[ $line =~ ^'[Desktop Action' ]]; then
    ignore=true;
    continue;
  fi

  if [[ $line == "[Desktop Entry]" && ! -z "$name" ]]; then
    addToHashList;

    continue;
  fi

  if [[ $line =~ ^'Name=' && "$ignore" = false ]]; then
    name="${line:5}";

    continue;
  fi

  if [[ $line =~ ^'Exec=' && "$ignore" = false ]]; then
    exec="${line:5}";

    continue;
  fi

  if [[ $line =~ ^'GenericName=' && "$ignore" = false ]]; then
    genericName="${line:12}";

    continue;
  fi
done <<< "$filesContent"

declare -A hashTable;
formattedMenuList=$(IFS=$'\n'; echo -e "${menuList[*]}" | column --table --separator ${separator} --output-separator $outputSeparator);

i=0;

while read -r formattedItem; do
  hashTable["$formattedItem"]="${menuList[$i]}";

  i=$((i + 1));
done <<< ${formattedMenuList}

selectedFormattedItem=$(IFS=$'\n'; echo -e "${formattedMenuList[*]}" | sort | dmenu -i "$@");
selectedItem="${hashTable[$selectedFormattedItem]}";
executable="${hashList[$selectedItem]}";
cleanExecutable=$(echo -e "${executable}" | sed -E 's/%(u|U|f|F)//')

eval "$cleanExecutable";
