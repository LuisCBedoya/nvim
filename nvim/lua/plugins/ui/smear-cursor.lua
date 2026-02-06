require('smear_cursor').setup({
  smear_between_buffers = true,
  smear_between_neighbor_lines = true,

  scroll_buffer_space = true,
  smear_insert_mode = false,

  cursor_color = 'none',
  legacy_computing_symbols_support = false,

  smear_duration_ms = 120,
  max_smear_distance = 20,
  min_horizontal_distance_smear = 1,
  min_vertical_distance_smear = 1,

  enable_particles = true,
  particle_count = 3,
  particle_max_duration_ms = 300,
  particle_distance_from_cursor = 2,

  vertical_bar_cursor_insert_mode = true,
  distance_stop_animating_vertical_bar = 5,
})

require('smear_cursor').enabled = true
