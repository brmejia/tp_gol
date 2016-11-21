// Window Parameters initialization
function win_init()
  global Win;
  Win = tlist([
    'T_WINDOW',
    'fig',
    'width',
    'height',
    'margin_x',
    'margin_y',
    'frame_w',
    'frame_h',
    'plot_w',
    'plot_h',
  ]);

  // Horizontal and vertical margin for elements
  Win.margin_x = 25;
  Win.margin_y = 25;
  // Frame width and height
  Win.frame_w  = 300;
  Win.frame_h  = 640;
  // Plot width and heigh
  Win.plot_w   = 640;
  Win.plot_h   = 640;
  // defaultfont = "arial"; // Default Font
  Win.width = 3*Win.margin_x + Win.frame_w + Win.plot_w;
  Win.height = 2*Win.margin_y + Win.frame_h;

  Win.fig = scf();
  // Win.fig.figure_position = [100 100]; //position in pixel of the graphic window on the screen
  Win.fig.figure_name = gettext("Jeux de la Vie! =D");
  Win.fig.axes_size = [Win.width Win.height];
  Win.fig.dockable = "off";
  Win.fig.default_axes = "off";
  Win.fig.visible = "on";
  // Win.fig.auto_resize = 'off';
  // Win.fig.resize = 'off';

  // Remove Scilab graphics menus & toolbar
  Win.fig.toolbar_visible = "off";
  Win.fig.toolbar = "none";
  Win.fig.menubar_visible = "off";
  Win.fig.menubar = "none";
  Win.fig.infobar_visible = "off";

  Win.fig.layout = "border";
  Win.fig.layout_options = createLayoutOptions("border", [10 10]);
  // Win.fig.layout_options = createLayoutOptions("gridbag", 'padding', [50 50]);

  // Win.fig.event_handler = 'win_events_handler';
  Win.fig.event_handler_enable = "off" ; //suppress the event handler

  Win = win_left_frame_form(Win);
  Win = win_right_frame_form(Win);
  // Se modifica el estado de los componentes del formulario
  win_update_buttons_state();
endfunction

// This function is executed when the start button is pressed
function start_btn_callback()
  global world;
  world.state = 1;
  win_update_buttons_state();

  while world.state == 1,
    // @todo: Reemplazar este llamado aleatorio por la función del juego deseado
    world.rows = world.rows - 1;
    world.cols = world.cols + 1;
    world_data_reset();
    world.data = 10*rand(world.rows, world.cols);
    world = plot_world(world);
    sleep(world.speed);
  end
endfunction

// This function is executed when the stop button is pressed
function stop_btn_callback()
  global world;
  world.state = 0;
  win_update_buttons_state();
  abort(); // Stop all callback's execution
endfunction

// This function is executed when the reset button is pressed
function reset_btn_callback()
  global world;
  world.state = 0;
  win_update_buttons_state();
  // Se utilizan los valores por defecto del mundo
  // world_set_default_values();
  world_data_reset();
  world = plot_world(world);
  abort(); // Stop all callback's execution
endfunction

// This function is executed when the speed input field change its value
function speed_input_callback()
  global world;
  this = gcbo;
  new_speed = strtod(this.string);
  if ~isnum(this.string) | new_speed < 50
    new_speed = world.default_speed;
  end
  this.string = string(new_speed);
  world.speed = new_speed;
endfunction

// This function is executed when the rows input field change its value
function rows_input_callback()
  global world;
  this = gcbo;
  new_rows = strtod(this.string);
  if ~isnum(this.string) | new_rows < 20 | new_rows > 2500
    new_rows = world.default_speed;
  end
  this.string = string(new_rows);
  // Si el tamaño de la matriz cambia
  if (world.rows ~= new_rows)
    world.rows = new_rows; // Se actualiza el valor de rows
    world_data_reset(); // Se reinicia el mundo
    world = plot_world(world);
  end
endfunction

// This function is executed when the cols input field change its value
function cols_input_callback()
  global world;
  this = gcbo;
  new_cols = strtod(this.string);
  if ~isnum(this.string) | new_cols < 20 | new_cols > 25000
    new_cols = world.default_speed;
  end
  this.string = string(new_cols);
  // Si el tamaño de la matriz cambia
  if (world.cols ~= new_cols)
    world.cols = new_cols; // Se actualiza el valor de cols
    world_data_reset(); // Se reinicia el mundo
    world = plot_world(world);
  end
endfunction

// function win_events_handler(win, x, y, ibut)
//   mode(1);
//   if ibut==-1000 then return,end
//   xinfo(msprintf('Event code %d at mouse position is (%f,%f)',ibut,x,y))
// endfunction

// This function change the form components state based in  the world current state.
function win_update_buttons_state()
  global world;

  btn_start   = get('btn_start');
  btn_stop    = get('btn_stop');
  btn_reset   = get('btn_reset');
  input_speed = get('input_speed');
  input_rows  = get('input_rows');
  input_cols  = get('input_cols');

  if world.state == 0
    btn_start.Enable   = 'on';
    btn_stop.Enable    = 'off';
    btn_reset.Enable   = 'on';
    input_speed.Enable = 'on';
    input_rows.Enable  = 'on';
    input_cols.Enable  = 'on';
  elseif world.state == 1
    btn_start.Enable   = 'off';
    btn_stop.Enable    = 'on';
    btn_reset.Enable   = 'on';
    input_speed.Enable = 'off';
    input_rows.Enable  = 'off';
    input_cols.Enable  = 'off';
  elseif world.state == -1
  end
endfunction

