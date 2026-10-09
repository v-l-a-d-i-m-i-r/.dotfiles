#!/bin/bash
# block-shell-edits.sh — forces Claude to use Edit/Write instead of shell file edits

patterns=(
  'sed -i'
  'perl -pi'
  'awk -i inplace'
  'cat *>'
  'cat <<'
  'tee '
  "open\(.*'[wa]'"
  'open\(.*"[wa]"'
  '\.write\('
  'write_text\('
  'write_bytes\('
  'writeFileSync'
  'appendFileSync'
)

cmd=$(jq -r '.tool_input.command')

for p in "${patterns[@]}"; do
  if grep -Eq -- "$p" <<< "$cmd"; then
    echo "Do not edit files via Bash. Use the Edit tool to modify files and the Write tool to create new ones." >&2
    exit 2
  fi
done

exit 0
