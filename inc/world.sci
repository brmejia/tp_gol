// This function clear the data array and creates a new one whit the new size
function world = world_data_reset(world)
  clear world.data;
  world.initialized = %f;
  world.data = zeros(world.rows, world.cols);
endfunction

// This function sets the world properties whit their default values
function world = world_set_default_values(world)
  world.rows     = world.default_rows;
  world.cols     = world.default_cols;
  world.speed    = world.default_speed; // miliseconds
  world.colormap = world.default_colormap; // miliseconds
  // Se crea el array vacio data con el tamaño del mundo
  world = world_data_reset(world);
endfunction

function world = world_init(world)
  world = tlist([
    'T_WORLD',
    'rows',
    'default_rows',
    'cols',
    'default_cols',
    'speed',
    'default_speed',
    'data',
    'axes',
    'plugin',
    'colormap',
    'default_colormap',
    'state',
    'initialized',
  ])

  world.default_rows     = 90;
  world.default_cols     = 90;
  world.default_speed    = 100; // miliseconds
  world.default_colormap = jetcolormap(25); // miliseconds
  world.axes             = '';
  world.plugin           = '';
  world.initialized      = %f;
  world.state            = -1; // Run 1
                              // Stop 0
                              // Unset -1

  // Se utilizan los valores por defecto del mundo
  world = world_set_default_values(world);

endfunction
