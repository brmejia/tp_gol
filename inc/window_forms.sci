function Win = win_left_frame_form(Win)
  mode(0);
  global world;

  btn_h = 25;
  max_w = Win.frame_w - 40;
  btn_bg_color = [.95 .95 .95];

  label_height = 0.75*btn_h;

  row_h = 0.025;

  // LEFT FRAME
  frame_left = uicontrol(Win.fig, "style", "frame", ...
    "constraints", createConstraints("border", "left", [Win.frame_w, .5*Win.frame_h]));
  frame_left.BackgroundColor = [1 1 1];
  frame_left.Border = createBorder("titled", createBorder("line", "lightGray", 1), _("Control Panel"), "center", "below_top");
  frame_left.HorizontalAlignment = 'center';
  frame_left.layout = "gridbag";
  frame_left.Tag = "frame_left";

  label_w = .4*max_w;
  popup_w = floor(max_w - label_w);

  // Plugins popup menu Label
  lb_popup_plugin = uicontrol(frame_left, "style","text", ...
    'constraints', createConstraints("gridbag", [1 1 2 1], [1 row_h], 'none', 'upper_right', [0 10], [label_w btn_h]));
  lb_popup_plugin.BackgroundColor = [1 1 1];
  lb_popup_plugin.String = _('Plugin');

  global plugins_info;
  plugin_items = "";
  for plugin = plugins_info
    plugin_items = plugin_items+'|'+plugin.title;
  end
  // Plugins popup menu
  popup_plugin = uicontrol(frame_left, "style","popupmenu", ...
    'constraints', createConstraints("gridbag", [3 1 2 1], [1 row_h], 'none', 'upper_left', [0 10], [popup_w btn_h]));
  popup_plugin.String = plugin_items;
  popup_plugin.Callback = "popup_plugin_callback";
  popup_plugin.Tag = "popup_plugin";


  // Start button
  btn_start = uicontrol(frame_left, "style","pushbutton", ...
    'constraints', createConstraints("gridbag", [1 2 4 1], [1 row_h], 'none', 'upper', [0 0], [max_w 1.5*btn_h]));
  btn_start.String = _("Start");
  btn_start.Relief = "groove";
  btn_start.BackgroundColor = btn_bg_color;
  btn_start.Callback = "start_btn_callback";
  btn_start.Tag = "btn_start";

  // Stop Button
  btn_stop = uicontrol(frame_left, "style","pushbutton", ...
    'constraints', createConstraints("gridbag", [1 3 2 1], [1 row_h], 'none', 'upper', [0 0], [.5*max_w btn_h]));
  btn_stop.String = _("Stop");
  btn_stop.Relief = "groove";
  btn_stop.BackgroundColor = btn_bg_color;
  btn_stop.Callback = "stop_btn_callback";
  btn_stop.Callback_Type = 10;
  btn_stop.Tag = "btn_stop";

  // Reset Button
  btn_reset = uicontrol(frame_left, "style","pushbutton", ...
    'constraints', createConstraints("gridbag", [3 3 2 1], [1 row_h], 'none', 'upper', [0 0], [.5*max_w btn_h]));
  btn_reset.String = _("Reset");
  btn_reset.Relief = "groove";
  btn_reset.BackgroundColor = btn_bg_color;
  btn_reset.Callback = "reset_btn_callback";
  btn_reset.Callback_Type = 10;
  btn_reset.Tag = "btn_reset";

  // Speed input Label
  lb_input_speed = uicontrol(frame_left, "style","text", ...
    'constraints', createConstraints("gridbag", [1 4 2 1], [1 row_h], 'none', 'lower', [0 0], [0.5*max_w label_height]));
  lb_input_speed.String = [_('Delay')+' (ms)'];
  lb_input_speed.BackgroundColor = [1 1 1];

  // Speed input
  input_speed = uicontrol(frame_left, "style","edit", ...
    'constraints', createConstraints("gridbag", [1 5 2 1], [1 row_h], 'none', 'upper', [0 0], [0.5*max_w btn_h]));
  input_speed.String = string(world.speed);
  input_speed.Callback = "speed_input_callback";
  input_speed.Tag = "input_speed";

  // Rows input Label
  lb_input_rows = uicontrol(frame_left, "style","text", ...
    'constraints', createConstraints("gridbag", [3 4 1 1], [1 row_h], 'none', 'lower', [0 0], [0.25*max_w label_height]));
  lb_input_rows.String = _('Rows');
  lb_input_rows.BackgroundColor = [1 1 1];

  // Rows input
  input_rows = uicontrol(frame_left, "style","edit", ...
    'constraints', createConstraints("gridbag", [3 5 1 1], [1 row_h], 'none', 'upper', [0 0], [0.25*max_w btn_h]));
  input_rows.String = string(world.rows);
  input_rows.Callback = "rows_input_callback";
  input_rows.Tag = "input_rows";

  // Cols input Label
  lb_input_cols = uicontrol(frame_left, "style","text", ...
    'constraints', createConstraints("gridbag", [4 4 1 1], [1 row_h], 'none', 'lower', [0 0], [0.25*max_w label_height]));
  lb_input_cols.String = _('Columns');
  lb_input_cols.BackgroundColor = [1 1 1];
  // Cols input
  input_cols = uicontrol(frame_left, "style","edit", ...
    'constraints', createConstraints("gridbag", [4 5 1 1], [1 row_h], 'none', 'upper', [0 0], [0.25*max_w btn_h]));
  input_cols.String = string(world.cols);
  input_cols.Callback = "cols_input_callback";
  input_cols.Tag = "input_cols";

  // PLUGIN FORM FRAME
  frame_plugin = uicontrol(frame_left, "style", "frame", ...
    'constraints', createConstraints("gridbag", [1 6 4 1], [1 1], 'horizontal', 'upper', [0 0]));
  frame_plugin.BackgroundColor = [1 1 1];
  frame_plugin.Border = createBorder("titled", createBorder("line", "lightGray", 1), [_("Parameters")], "center", "below_top");
  frame_plugin.HorizontalAlignment = 'center';
  frame_plugin.layout = "gridbag";
  frame_plugin.Tag = "frame_plugin";

endfunction

function Win = win_right_frame_form(Win)
  global world;
  // RIGHT FRAME
  frame_right = uicontrol(Win.fig, "style", "frame", ...
    "constraints", createConstraints("border", "center", [Win.plot_w, Win.plot_h]));
  frame_right.BackgroundColor = [1 1 1];
  frame_right.Border = createBorder("titled", createBorder("line", "lightGray", 1), _("WORLD"), "center", "below_top");
  frame_right.Tag = "frame_right";
endfunction
