# Start tmux automatically on login shell (WSL)
if command -v tmux >/dev/null 2>&1; then
  # Prevent nested tmux sessions
  if [ -z "$TMUX" ]; then
    tmux attach || tmux new
  fi
fi

