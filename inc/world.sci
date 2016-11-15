function world_init()
  global world
  world = tlist([
    'T_WORLD',
    'rows',
    'cols',
    'speed',
    'data',
    'fig',
    'function',
    'colormap',
    'state',
  ])

  world.rows = 10;
  world.cols = 10;
  world.speed = 1500; // miliseconds
  world.data = zeros(world.rows, world.cols);
  world.fig = '';
  world.function = '';
  world.state = 0;  // Run 1
                    // Stop 0
                    // reset -1

endfunction

function world_reset()

endfunction
