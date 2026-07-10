#!/bin/bash
input=$(cat)
echo "$input" > /tmp/claude-1000/-data-projects-cli-tools/15ee2c17-6e50-4c56-b2d6-5d26782481e7/scratchpad/statusline-debug.json 2>/dev/null
echo "$input" >> /home/vladimir/.claude/log.json
cwd=$(echo "$input" | jq -r '.workspace.current_dir // empty')
[ -z "$cwd" ] && cwd="$(pwd)"
dir=$(basename "$cwd")

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')

tokens=""
if [ -n "$used_pct" ]; then
  tokens=$(printf 'ctx:%.0f%%' "$used_pct")
fi
if [ -n "$total_in" ] && [ -n "$total_out" ]; then
  total=$((total_in + total_out))
  if [ "$total" -ge 1000 ]; then
    tok_str=$(awk -v t="$total" 'BEGIN{printf "%.1fk", t/1000}')
  else
    tok_str="${total}"
  fi
  [ -n "$tokens" ] && tokens="$tokens "
  tokens="${tokens}tok:${tok_str}"
fi

model=$(echo "$input" | jq -r '.model.display_name // .model.id // empty')

effort=$(echo "$input" | jq -r '.effort.level // empty')
if [ -z "$effort" ]; then
  effort=$(jq -r '.effortLevel // empty' "$HOME/.claude/settings.json" 2>/dev/null)
fi

five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
limits=""
if [ -n "$five_pct" ]; then
  limits="5h:$(printf '%.0f' "$five_pct")%"
fi
if [ -n "$week_pct" ]; then
  [ -n "$limits" ] && limits="$limits "
  limits="${limits}7d:$(printf '%.0f' "$week_pct")%"
fi

extra=""
if [ -n "$model" ]; then
  extra="$model"
fi
if [ -n "$effort" ]; then
  [ -n "$extra" ] && extra="$extra "
  extra="${extra}eff:${effort}"
fi
if [ -n "$limits" ]; then
  [ -n "$extra" ] && extra="$extra "
  extra="${extra}${limits}"
fi

out="[$(whoami)@$(hostname -s) $dir]"
[ -n "$tokens" ] && out="$out $tokens"
[ -n "$extra" ] && out="$out $extra"
printf '%s' "$out"
