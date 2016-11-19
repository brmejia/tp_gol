function Win = win_left_frame_form(Win)
  mode(1);
  global world;

  btn_height = 30;
  btn_width = 125;
  btn_bg_color = [.95 .95 .95];

  // LEFT FRAME
  frame_left = uicontrol('parent', Win.fig, "style", "frame", ...
    "constraints", createConstraints("border", "left", [Win.frame_w, Win.frame_h]));
  frame_left.BackgroundColor = [1 1 1];
  frame_left.Border = createBorder("titled", createBorder("line", "lightGray", 1), _("Contrôle de FLux"), "center", "below_top");
  frame_left.layout = "gridbag";
  frame_left.Tag = "frame_left";

  // Start button
  btn_start = uicontrol(frame_left, "style","pushbutton", ...
    'constraints', createConstraints("gridbag", [1 1 4 1], [2 .025], 'none', 'center', [0 0], [2.15*btn_width 1.5*btn_height]));
  btn_start.String = "Start";
  btn_start.Relief = "groove";
  btn_start.BackgroundColor = btn_bg_color;
  btn_start.Callback = "start_btn_callback";
  btn_start.Tag = "btn_start";

  // Stop Button
  btn_stop = uicontrol(frame_left, "style","pushbutton", ...
    'constraints', createConstraints("gridbag", [1 2 2 1], [.9 .025], 'none', 'center', [0 0], [btn_width btn_height]));
  btn_stop.String = "Stop";
  btn_stop.Relief = "groove";
  btn_stop.BackgroundColor = btn_bg_color;
  btn_stop.Callback = "stop_btn_callback";
  btn_stop.Callback_Type = 10;
  btn_stop.Tag = "btn_stop";

  // Reset Button
  btn_reset = uicontrol(frame_left, "style","pushbutton", ...
    'constraints', createConstraints("gridbag", [3 2 2 1], [.9 .025], 'none', 'center', [0 0], [btn_width btn_height]));
  btn_reset.String = "Reset";
  btn_reset.Relief = "groove";
  btn_reset.BackgroundColor = btn_bg_color;
  btn_reset.Callback = "reset_btn_callback";
  btn_reset.Callback_Type = 10;
  btn_reset.Tag = "btn_reset";

  // Speed input Label
  lb_input_speed = uicontrol(frame_left, "style","text", ...
    'constraints', createConstraints("gridbag", [1 3 1 1], [.25 .025], 'none', 'center', [0 0], [0.5*btn_width btn_height]));
  lb_input_speed.String = 'Vitesse';
  lb_input_speed.BackgroundColor = [1 1 1];

  // Speed input
  input_speed = uicontrol(frame_left, "style","edit", ...
    'constraints', createConstraints("gridbag", [1 4 1 1], [.25 1], 'none', 'upper', [0 0], [0.5*btn_width btn_height]));
  input_speed.String = string(world.speed);
  input_speed.ForegroundColor = [1 0 0];
  // input_speed.BackgroundColor = btn_bg_color;
  input_speed.Callback = "speed_input_callback";
  input_speed.Tag = "input_speed";
endfunction

function Win = win_right_frame_form(Win)
  global world;
  // RIGHT FRAME
  frame_right = uicontrol('parent', Win.fig, "style", "frame", ...
    "constraints", createConstraints("border", "center", [Win.plot_w, Win.plot_h]));
  frame_right.BackgroundColor = [1 1 1];
  frame_right.Border = createBorder("titled", createBorder("line", "lightGray", 1), _("WORLD"), "center", "below_top");
  frame_right.Tag = "frame_right";
endfunction
