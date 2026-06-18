# 1. Exec gemini-ralph;
# 2. Sign in with Google, follow instructions, accep API key
# Models:
# gemini-3.1-pro-preview
# gemini-3-flash-preview
# gemini-3.1-flash-lite-preview
# gemini-2.5-pro
# gemini-2.5-flash
# gemini-2.5-flash-lite

gemini-ralph() {
  if [ -z "$GEMINI_API_KEY" ]; then
    echo "Error: GEMINI_API_KEY is not set.";
    return 1;
  fi

  local image_name="gemini-ralph";
  local working_dir="$HOME/.gemini-ralph";

  # Quote 'EOF' to prevent local expansion of variables inside the script
  local subshell_script=$(cat <<'EOF'
    image_name=$1
    working_dir=$2
    shift 2 # Remove the name and dir from arguments, leaving the rest for the docker run

    docker build -t "${image_name}" ~/.config/zsh/tools/gemini-ralph;

    while :; do
      echo "--------------------------------"
      echo "♻️  RESTARTING AGENT..."

      docker run \
        -it \
        --rm \
        -v "$(pwd):/app" \
        -v "${working_dir}:/root/.gemini" \
        -e "GEMINI_API_KEY=${GEMINI_API_KEY}" \
        "${image_name}" \
        "$@";

      sleep 0.5
    done
EOF
  )

  # Pass variables and original arguments ($@) into the subshell
  zsh -ci "$subshell_script" -- "$image_name" "$working_dir" "$@"
}
