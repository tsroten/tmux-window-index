#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

window_index_interpolation_string="\#{window_index}"
window_index_string="#($CURRENT_DIR/scripts/window-index #I)"

do_interpolation() {
  local string="$1"
  local interpolated="${string/$window_index_interpolation_string/$window_index_string}"
  echo "$interpolated"
}

update_tmux_option() {
  local option="$1"
  local option_value=$(tmux show-option -gqvw "$option")
  local new_option_value="$(do_interpolation "$option_value")"
  tmux set-option -gqw "$option" "$new_option_value"
}

main() {
  update_tmux_option "window-status-format"
  update_tmux_option "window-status-current-format"
}

main
