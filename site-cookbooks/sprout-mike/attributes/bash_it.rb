node.normal['bash_it'] = {
  'custom_plugins' => {
    'sprout-osx-base' => %w[
      bash_it/custom/disable_ctrl-s_output_control.bash
      bash_it/custom/enable_ctrl-o_history_execution.bash
      bash_it/custom/ensure_usr_local_bin_first.bash
    ]
  }
}
