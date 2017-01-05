// This function clear the data array and creates a new one whit the new size
function world = world_data_reset(world)
  clear world.data;
  world.data = int16(zeros(world.rows, world.cols));
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
  world = struct();

  world.default_rows     = 80;
  world.default_cols     = 80;
  world.default_speed    = 500; // miliseconds
  world.default_colormap = jetcolormap(25); // miliseconds
  world.axes             = '';
  world.plugin           = struct();
  world.initialized      = %f;
  world.state            = -1; // Run 1
                              // Stop 0
                              // Unset -1

  global context;
  context      = struct();

  // On utilise les valeurs prédéfinis du monde
  world = world_set_default_values(world);

endfunction

// This function helps to call the plugin inicialization function
function world = world_init_plugin(world)
  // Se inicializa el plugin
  if ~world.initialized
    global context;
    global win;
    // Plugin init
    disp('==> Initializing plugin');
    // Se verifica si la función de init del plugin existe
    if type(world.plugin.init) == 13
      [Win, world] = world.plugin.init(Win, world);
    end
    world.initialized = %t;
    context.step = 1;
  end
endfunction
