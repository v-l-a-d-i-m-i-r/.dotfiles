# https://www.sglavoie.com/posts/2019/11/10/using-dmenu-to-optimize-common-tasks/

set -e

# filesContent=$(rg '^Name=|^Exec=|^Comment=|^GenericName=|^Terminal=|^Type=|^\[' /usr/share/applications --no-line-number --no-filename --no-heading);
filesContent=$(rg '^Name=|^Exec=|^Comment=|^GenericName=|^\[' /usr/share/applications --no-line-number --no-filename --no-heading);
linesCount=$(echo "$filesContent" | rg '' -c);

name='';
exec='';
genericName='';

declare -A hashTable;
menuList='';
ignore=true;

function addToHashTable () {
  [[ ! -z $genericName ]] && key="${name}:(${genericName}):${exec}" || key="${name}::${exec}";
  menuList+="$key\n";
  hashTable["$key"]="$exec";
  # echo "${name} (${genericName})";
}

while read -r line; do
  # echo "$line";
  if [[ $line == '[Desktop Entry]' && "$ignore" = true ]]; then
    # echo "********** ignore false"
    ignore=false;
    # continue;
  fi

  if [[ $line =~ ^'[Desktop Action' ]]; then
    # echo "********** ignore true";
    ignore=true;
    continue;
  fi

  if [[ $line == "[Desktop Entry]" && ! -z "$name" ]]; then
    # echo $name;
    # echo "write to hash $name"
    addToHashTable;

    name='';
    exec='';
    genericName='';
    # echo $name;
    continue;
  fi

  if [[ $line =~ ^'Name=' && "$ignore" = false ]]; then
    name="${line:5}";
    # echo "write to var $line";
    # menuList+="$name\n";
    # echo $name;
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

# echo -e $menuList;
# echo $linesCount;
# echo -e "$menuList"| dmenu -i
n=$(echo -e "$menuList" | sort | column --table --separator ':' --output-separator ' ' | dmenu -i "$@");
echo $n;
e="${hashTable[$n]}"
eval "$e" 
