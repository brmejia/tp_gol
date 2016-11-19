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
  // Win.fig.event_handler_enable = "on" ;

  Win = win_left_frame_form(Win);
  Win = win_right_frame_form(Win);
endfunction


function start_btn_callback()
  global world;
  world.state = 1;
  win_check_buttons_state();

  while world.state == 1,
    world.data = 10*rand(world.rows, world.cols);
    world = plot_world(world);
    sleep(world.speed);
  end
endfunction

function stop_btn_callback()
  global world;
  world.state = 0;
  win_check_buttons_state();
endfunction

function reset_btn_callback()
  global world;
  stop_btn_callback();
  world_init();
  world = plot_world(world)
endfunction

function speed_input_callback()
  global world;
  this = gcbo;
  disp(this.string);
  new_speed = strtod(this.string);
  disp(new_speed);
  if ~isnum(this.string) | new_speed < 50
    new_speed = world.default_speed;
  end
  this.string = string(new_speed);
  world.speed = new_speed;
endfunction


// function win_events_handler(win, x, y, ibut)
//   mode(1);
//   if ibut==-1000 then return,end
//   xinfo(msprintf('Event code %d at mouse position is (%f,%f)',ibut,x,y))
// endfunction

function win_check_buttons_state()
  global world;

  btn_start   = get('btn_start');
  btn_stop    = get('btn_stop');
  btn_reset   = get('btn_reset');
  input_speed = get('input_speed');

  if world.state == 0
    btn_start.Enable   = 'on';
    btn_stop.Enable    = 'off';
    btn_reset.Enable   = 'on';
    input_speed.Enable = 'on';
  elseif world.state == 1
    btn_start.Enable   = 'off';
    btn_stop.Enable    = 'on';
    btn_reset.Enable   = 'on';
    input_speed.Enable = 'off';
  elseif world.state == -1
  end
endfunction

