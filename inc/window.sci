function Win = win_frame_form(Win)
  // Frames creation [LHY parameters]
  frame = uicontrol("parent",Win.fig, "relief","groove", ...
  "style","frame", "units","pixels", ...
  "position",[ Win.margin_x Win.margin_y Win.frame_w Win.frame_h], ...
  "horizontalalignment","center", "background",[1 1 1], ...
  "tag","frame_control");
  // Frame title
  frame_title = uicontrol("parent",Win.fig, "style","text", ...
  "string","Contrôle de Flux", "units","pixels", ...
  "position",[30+Win.margin_x Win.margin_y+Win.frame_h-10 Win.frame_w-60 20], ...
  "fontsize",16, "horizontalalignment","center", ...
  "background",[1 1 1], "tag","title_frame_control");

  btn_start = uicontrol(Win.fig, "style","pushbutton", ...
  "Position",[110 100 100 20], "String","Start", ...
  "BackgroundColor",[.9 .9 .9], "fontsize",14, ...
  "Callback","start_callback", "Callback_Type", 0);

  btn_stop = uicontrol(Win.fig, "style","pushbutton", ...
  "Position",[110 70 100 20], "String","Stop", ...
  "BackgroundColor",[.9 .9 .9], "fontsize",14, ...
  "Callback","stop_callback", "Callback_Type", 10);

endfunction


// Window Parameters initialization
function win_init()
  disp('=D');
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

  // Remove Scilab graphics menus & toolbar
  delmenu(Win.fig.figure_id,gettext("&File"));
  delmenu(Win.fig.figure_id,gettext("&Tools"));
  delmenu(Win.fig.figure_id,gettext("&Edit"));
  delmenu(Win.fig.figure_id,gettext("&?"));
  toolbar(Win.fig.figure_id,"off");

  Win = win_frame_form(Win);



endfunction


function start_callback()
  global world;
  world.state = 1;

  while world.state == 1,
    world.data = 10*rand(world.rows, world.cols);
    world = plot_world(world);

    sleep(1000);
    disp(world.state);
  end
endfunction

function stop_callback()
  global world;
  world.state = 0;
  disp('stop_callback()');
endfunction
