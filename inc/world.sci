// This function clear the data array and creates a new one whit the new size
function world_data_reset()
  global world;
  clear world.data;
  world.data = zeros(world.rows, world.cols);
endfunction

// This function sets the world properties whit their default values
function world_set_default_values()
  global world;
  world.rows = world.default_rows;
  world.cols = world.default_cols;
  world.speed = world.default_speed; // miliseconds
  // Se crea el array vacio data con el tamaño del mundo
  world_data_reset();
endfunction

function world_init()
  global world
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
    'function',
    'colormap',
    'state',
  ])

  world.default_rows = 100;
  world.default_cols = 100;
  world.default_speed = 250; // miliseconds
  world.axes = '';
  world.function = '';
  world.state = 0;  // Run 1
                    // Stop 0
                    // reset -1

  // Se utilizan los valores por defecto del mundo
  world_set_default_values();

endfunction
