// This function clear the data array and creates a new one whit the new size
function world = world_data_reset(world)
  clear world.data;
  world.initialized = %f;
  world.context = struct();
  world.data = zeros(world.rows, world.cols);
endfunction

// This function sets the world properties whit their default values
function world = world_set_default_values(world)
  world.rows     = world.default_rows;
  world.cols     = world.default_cols;
  world.speed    = world.default_speed; // miliseconds
  world.colormap = world.default_colormap; // miliseconds
  // On crée une matrice vide de la taille du monde
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
    'context',
  ])

  world.default_rows     = 90;
  world.default_cols     = 90;
  world.default_speed    = 500; // miliseconds
  world.default_colormap = jetcolormap(25); // miliseconds
  world.axes             = '';
  world.plugin           = '';
  world.initialized      = %f;
  world.state            = -1; // Run 1
                              // Stop 0
                              // Unset -1
  world.context      = struct();

  // On utilise les valeurs prédéfinis du monde
  world = world_set_default_values(world);

endfunction

// This function helps to call the plugin inicialization function
function world = world_init_plugin(world)
  global win;

  // Se inicializa el plugin
  // Se verifica si la función de init del plugin existe
  if ~world.initialized type(world.plugin.init) == 13
    // Plugin init
    [Win, world] = world.plugin.init(Win, world);
    world.initialized = %t;
    world.context.step = 0;
  end
endfunction
