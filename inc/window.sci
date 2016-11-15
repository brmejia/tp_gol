function Win = win_frame_form(Win)
  global world;
  // FRAME
  frame = uicontrol("parent", Win.fig, "style", "frame");
  frame.relief = "groove";
  frame.Position = [ Win.margin_x Win.margin_y Win.frame_w Win.frame_h];
  frame.BackgroundColor = [1 1 1];
  frame.tag = "frame_control";
  frame.units = "pixels";
  frame.horizontalalignment = "center";
  // // Frame title
  frame_title = uicontrol("parent",Win.fig, "style","text");
  frame_title.string = "Contrôle de Flux";
  frame_title.Position = [30+Win.margin_x Win.margin_y+Win.frame_h-10 Win.frame_w-60 20];
  frame_title.fontsize = 16;
  frame_title.BackgroundColor = [1 1 1];
  frame_title.tag = "title_frame_control";
  frame_title.units = "pixels";
  frame_title.horizontalalignment = "center";

  // Start button
  btn_start = uicontrol(Win.fig, "style","pushbutton");
  btn_start.units = "pixels";
  btn_start.Position = [110 100 100 20];
  btn_start.String = "Start";
  btn_start.BackgroundColor = [.9 .9 .9];
  btn_start.fontsize = 14;
  btn_start.Callback = "start_callback";
  btn_start.tag = "btn_start_control";
    // "Callback_Type",    0;

  // Stop Button
  btn_stop = uicontrol(Win.fig, "style","pushbutton");
  btn_stop.Position = [110 70 100 20];
  btn_stop.String = "Stop";
  btn_stop.BackgroundColor = [.9 .9 .9];
  btn_stop.fontsize = 14;
  btn_stop.Callback = "stop_callback";
  btn_stop.Callback_Type = 10;
  btn_stop.tag = "btn_stop_control";

  // Speed input Label
  lb_input_speed = uicontrol("parent",Win.fig, "style","text");
  lb_input_speed.string = 'Vitesse';
  lb_input_speed.Position = [0 0 50 25];
  lb_input_speed.horizontalalignment = "left";
  lb_input_speed.fontsize = 14;
  lb_input_speed.BackgroundColor = [1 1 1];
  lb_input_speed.tag = "lb_input_speed_control";
  // Speed input
  input_speed = uicontrol("parent",Win.fig, "style","edit");
  input_speed.string = string(world.speed);
  input_speed.Position = [0 30 50 25];
  input_speed.horizontalalignment = "left";
  input_speed.fontsize = 14;
  input_speed.BackgroundColor = [.9 .9 .9];
  input_speed.tag = "input_speed_control";

endfunction


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
  Win.margin_x = 20;
  Win.margin_y = 20;
  // Frame width and height
  Win.frame_w  = 250;
  Win.frame_h  = 540;
  // Plot width and heigh
  Win.plot_w   = 540;
  Win.plot_h   = 540;
  // defaultfont = "arial"; // Default Font
  Win.width = 3*Win.margin_x + Win.frame_w + Win.plot_w;
  Win.height = 2*Win.margin_y + Win.frame_h;

  Win.fig = scf();
  Win.fig.background = -2;
  Win.fig.figure_position = [100 100]; //position in pixel of the graphic window on the screen
  Win.fig.figure_name = gettext("Jeux de la Vie! =D");
  Win.fig.axes_size = [Win.width Win.height];
  // Win.fig.event_handler = 'win_events_handler';
  // Win.fig.event_handler_enable = "on" ;

  // Remove Scilab graphics menus & toolbar
  delmenu(Win.fig.figure_id,gettext("&File"));
  delmenu(Win.fig.figure_id,gettext("&Tools"));
  delmenu(Win.fig.figure_id,gettext("&Edit"));
  delmenu(Win.fig.figure_id,gettext("&?"));
  toolbar(Win.fig.figure_id,"off");

  Win = win_frame_form(Win);



endfunction


function start_callback()
  disp('start_callback');
  global world;
  world.state = 1;

  while world.state == 1,
    world.data = 10*rand(world.rows, world.cols);
    world = plot_world(world);
    sleep(world.speed);
  end
endfunction

function stop_callback()
  disp('stop_callback()');
  global world;
  world.state = 0;
endfunction

// function win_events_handler(win, x, y, ibut)
//   mode(1);
//   if ibut==-1000 then return,end
//   xinfo(msprintf('Event code %d at mouse position is (%f,%f)',ibut,x,y))
// endfunction
