// Window Parameters initialization
function win_init()
  disp('==========> win_init');
  global Win;
  Win = struct();

  // Frame width and height
  Win.frame_w  = 300;
  Win.frame_h  = 640;
  // Plot width and heigh
  Win.plot_w   = 640;
  Win.plot_h   = 640;
  // defaultfont = "arial"; // Default Font
  Win.width = Win.frame_w + Win.plot_w;
  Win.height = Win.frame_h;

  Win.fig = scf(1000);

  Win.fig.figure_position = [230 100]; //position in pixel of the graphic window on the screen
  Win.fig.figure_name = _("Jeu de la Vie");
  Win.fig.axes_size = [Win.width Win.height];
  Win.fig.dockable = "off";
  Win.fig.default_axes = "off";
  // Win.fig.visible = "off";
  // Win.fig.auto_resize = 'on';
  // Win.fig.resize = 'off';

  // Remove Scilab graphics menus & toolbar
  Win.fig.toolbar_visible = "off";
  Win.fig.toolbar = "none";
  Win.fig.menubar_visible = "off";
  Win.fig.menubar = "none";
  Win.fig.infobar_visible = "on";

  Win.fig.layout          = "border";
  Win.fig.layout_options  = createLayoutOptions("border", [10 10]);
  Win.fig.background      = -2; // Always White
  Win.fig.color_map       = jetcolormap(128);

  Win.fig.event_handler_enable = "off" ; //suppress the event handler

  Win = win_left_frame_form(Win);

  a = newaxes();
  a_bound_w = Win.plot_w/Win.width
  a.axes_bounds = [1-a_bound_w,0,a_bound_w,1];

  a.tag             = "plot";
  a.title.text      = "";
  a.title.font_size = 5;
  a.isoview         = 'on';
  a.margins         = [.01 .01 .01 .01]; // [L R U D]
  a.auto_ticks      = ['off' 'off' 'off']; // Se eliminan la numeración de los ejes.

  // High level properties
  a.auto_clear = 'on';

  // Se modifica el estado de los componentes del formulario
  win_update_buttons_state();
  Win.fig.visible = "on";
endfunction

// This function is executed when the start button is pressed
function start_btn_callback()
  disp('==========> start_btn_callback');
  global world;
  global Win;
  global context;

  // On initialise le plugin
  world = world_init_plugin(world);
  global times;
  times = zeros(11000, 1);

  if world.initialized
    // Se verifica si la función principal del plugin existe
    if type(world.plugin.main) == 13
      // Se cambia el estado del mundo a 1 (Running)
      world.state = 1;
      win_update_buttons_state();

      while world.state == 1,
        xinfo(msprintf('Iteration %d', context.step));
        // Se ejecuta la función del plugin
        try
          tic();
          [world] = world.plugin.main(world);
          times(context.step) = toc();
        catch
          [str,n,line,func] = lasterror();
          disp([str,n,line,func]);
          error(n, str);
          disp('[mean(times) stdev(times)]');
          disp([mean(times) stdev(times)]);
          // Se muestra mensaje de alerta cuando se produce un error en la ejecución
          msg = msprintf(_("Execution error at step ''%d''."), context.step);
          messagebox(msg, _("Error"), "info", "modal");
          stop_btn_callback();
        end
        // Sólo se ejecuta el sleep si la duración es mayor que cero
        if world.speed > 0
          world = plot_world(world);
          // sleep(world.speed);
        end
        context.step = context.step + 1;
      end
      world = plot_world(world);
      world.state = 0;
    else
      // Se muestra mensaje de alerta si la función del plugin no existe
      msg = msprintf(_("Undefined function ''%s''."), world.plugin.main);
      messagebox(msg, _("Plugin function error"), "info", "modal");
      world.state = -1;
    end
  end
  // Se actualiza el estado del formulario al finalizar la ejecución.
  win_update_buttons_state();
endfunction

// This function is executed when the stop button is pressed
function stop_btn_callback()
  disp('==========> stop_btn_callback');
  global world;
  world.state = 0;
  win_update_buttons_state();
  plot_world(world);
  abort; // Stop all callback's execution
endfunction

// This function is executed when the reset button is pressed
function reset_btn_callback()
  disp('==========> reset_btn_callback');
  global world;
  world.state = 0;
  win_update_buttons_state();
  // Se utilizan los valores por defecto del mundo
  world = world_data_reset(world);
  // On initialise le plugin
  world.initialized = %f;
  world = world_init_plugin(world);
  world = plot_world(world);
  abort; // Stop all callback's execution
endfunction

// This function is executed when the speed input field change its value
function speed_input_callback()
  disp('==========> speed_input_callback');
  global world;
  this = gcbo;
  new_speed = strtod(this.string);
  if ~isnum(this.string) | new_speed < 0
    new_speed = world.default_speed;
  end
  this.string = string(new_speed);
  world.speed = new_speed;
endfunction

// This function is executed when the rows input field change its value
function rows_input_callback()
  disp('==========> rows_input_callback');
  global world;
  this = gcbo;
  new_rows = strtod(this.string);
  if ~isnum(this.string) | new_rows < 10 | new_rows > 2500
    new_rows = world.default_speed;
  end
  this.string = string(new_rows);
  // Si el tamaño de la matriz cambia
  if (world.rows ~= new_rows)
    world.rows = new_rows; // Se actualiza el valor de rows
    world = world_data_reset(world); // Se reinicia el mundo
    world = plot_world(world);
  end
endfunction

// This function is executed when the cols input field change its value
function cols_input_callback()
  disp('==========> cols_input_callback');
  global world;
  this = gcbo;
  new_cols = strtod(this.string);
  if ~isnum(this.string) | new_cols < 10 | new_cols > 25000
    new_cols = world.default_speed;
  end
  this.string = string(new_cols);
  // Si el tamaño de la matriz cambia
  if (world.cols ~= new_cols)
    world.cols = new_cols; // Se actualiza el valor de cols
    world = world_data_reset(world); // Se reinicia el mundo
    world = plot_world(world);
  end
endfunction

function popup_plugin_callback()
  disp('==========> popup_plugin_callback');
  global plugins_info;
  global world;
  global context;

  popup_plugin = gcbo; // gcbo devuelve el objeto del formulario que disparó el evento
  selected = get(popup_plugin, "Value");
  // On valide si il y a eu un changement de plugin
  if ~isfield(world.plugin, 'name') || plugins_info(selected).name ~= world.plugin.name
    world.plugin = plugins_load_plugin(plugins_info(selected));

    seteventhandler('');
    // On utilise les valeurs prédéfinis du monde
    world = world_data_reset(world);
    context = struct();

    world.initialized = %f;
    // On établie les valeurs prédéfinis du monde
    world = world_set_default_values(world);
    // On initialise le plugin
    world = world_init_plugin(world);
    world = plot_world(world);

    // On efface le formulaire du plugin précédant
    frame_plugin = get('frame_plugin');
    for child = frame_plugin.children
      delete(child);
    end
    // On vérifie si la fonction qui crée le formulaire du plugin existe
    try
      if type(world.plugin.form) == 13
        frame_plugin = world.plugin.form(frame_plugin, world)
      end
    end

    // On change le statu du monde
    world.state = 0;
    win_update_buttons_state();
  end
endfunction

// This function change the form components state based in  the world current state.
function win_update_buttons_state()
  global world;

  popup_plugin = get('popup_plugin');
  btn_start    = get('btn_start');
  btn_stop     = get('btn_stop');
  btn_reset    = get('btn_reset');
  input_speed  = get('input_speed');
  input_rows   = get('input_rows');
  input_cols   = get('input_cols');
  frame_right   = get('frame_right');

  if world.state == 0 //STOPED
    popup_plugin.Enable = 'on';
    btn_start.Enable    = 'on';
    btn_stop.Enable     = 'off';
    btn_reset.Enable    = 'on';
    input_speed.Enable  = 'on';
    input_rows.Enable   = 'on';
    input_cols.Enable   = 'on';
    frame_right.Enable   = 'on';
  elseif world.state == 1 // RUNNING
    popup_plugin.Enable = 'off';
    btn_start.Enable    = 'off';
    btn_stop.Enable     = 'on';
    btn_reset.Enable    = 'on';
    input_speed.Enable  = 'off';
    input_rows.Enable   = 'off';
    input_cols.Enable   = 'off';
    frame_right.Enable   = 'off';
  elseif world.state == -1 // UNSET
    popup_plugin.Enable = 'on';
    btn_start.Enable    = 'off';
    btn_stop.Enable     = 'off';
    btn_reset.Enable    = 'off';
    input_speed.Enable  = 'off';
    input_rows.Enable   = 'off';
    input_cols.Enable   = 'off';
    frame_right.Enable   = 'off';
  end
  // On actualise le statu du formulaire du plugin
  if isfield(world.plugin, 'form_state') && type(world.plugin.form_state) == 13
    world.plugin.form_state(world);
  end

  win_update_buttons_value()
endfunction

function win_update_buttons_value()
  global world;
  input_speed  = get('input_speed');
  input_rows   = get('input_rows');
  input_cols   = get('input_cols');

  input_speed.String = string(world.speed);
  input_rows.String = string(world.rows);
  input_cols.String = string(world.cols);

  // On actualise les valeurs du formulaire du plugin
  if isfield(world.plugin, 'form_update') && type(world.plugin.form_update) == 13
    world.plugin.form_update(world);
  end

endfunction
