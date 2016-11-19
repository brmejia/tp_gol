function world_init()
  global world
  world = tlist([
    'T_WORLD',
    'rows',
    'cols',
    'default_speed',
    'speed',
    'data',
    'axes',
    'function',
    'colormap',
    'state',
  ])

  world.rows = 1000;
  world.cols = 1000;
  world.default_speed = 2500; // miliseconds
  world.speed = world.default_speed; // miliseconds
  world.data = zeros(world.rows, world.cols);
  world.axes = '';
  world.function = '';
  world.state = 0;  // Run 1
                    // Stop 0
                    // reset -1

endfunction

function world_reset()

endfunction
