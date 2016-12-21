function [Win, world] = ants_plugin_init(Win, world)
  colormap = [1 1 1;
              1 0 0;
              1 0 1];

  Win.fig.color_map = colormap;

  world.data = ones(world.rows, world.cols);
  world.plugin.pos = floor(size(world.data)/2);
  world.plugin.val = world.data(world.plugin.pos(1), world.plugin.pos(2));
  world.plugin.old_pos = world.plugin.pos + [1 0];
endfunction

function world = ants_plugin_main(world)
  current_value   = world.plugin.val;
  // Se calcula la distancia entre posiciones
  d = [1 -1].*(world.plugin.pos - world.plugin.old_pos);
  d = d($:-1:1);
  op = 0;
  if current_value == 1
    op = -1;
  elseif current_value == 0
    op = 1;
  end

  // Se guarda la posición actual cómo la posición vieja
  world.plugin.old_pos = world.plugin.pos;
  // Se restablece el valor de la posición donde estaba la hormiga antes de moverla
  world.data(world.plugin.pos(1), world.plugin.pos(2)) = ~world.plugin.val;
  // Se calcula la nueva posición de la hormiga
  world.plugin.pos = (op*d) + world.plugin.pos;
  // Se allmacena el valor de la nueva posicíón
  world.plugin.val = world.data(world.plugin.pos(1), world.plugin.pos(2));
  // Se actualiza el color de la posición de la hormiga
  world.data(world.plugin.pos(1), world.plugin.pos(2)) = 2;
endfunction

function parent = ants_plugin_form(parent, world)
  // Speed input
  input_speed = uicontrol(parent, "style","edit", ...
    'constraints', createConstraints("gridbag", [1 5 2 1], [1 1], 'none', 'upper', [0 0], [80, 20]));
    // 'constraints', createConstraints("gridbag", [1 5 2 1], [1 1], 'none', 'upper', [0 0], [0.5*max_w btn_h]));
  input_speed.String = string(world.speed);
  input_speed.Callback = "speed_input_callback";
  input_speed.Tag = "input_speed";
endfunction
