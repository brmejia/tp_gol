// @TODO: Créer une fonction pour mettre à jour le statu des champs du formulaire

function ant = ants_new_ant(pos, world)
  ant = struct();
  // On enregistre la position de la fourmi
  ant.pos = pos;

  // On génère de manière pseudo-aléatoire la position précédente de la fourmi
  delta = grand(1, "prm", [-1 1]);
  old_pos = [delta(1), 0];
  ant.old_pos = pos + grand(1, "prm", old_pos);
  // On enregistre la valeur du monde à la position de la fourmi
  ant.val = world.data(ant.pos(1), ant.pos(2));
endfunction

function ants_update_colormap(world)
  n = 1;
  colormap = [.85 .85 .85];
  if ~isempty(world.context.ants)
    n = length(world.context.ants);
  end
  global Win;
  Win.fig.color_map = [colormap; hsvcolormap(n)];
  disp(Win.fig.color_map);
endfunction

function [Win, world] = ants_plugin_init(Win, world)
  world.data = zeros(world.rows, world.cols);
  world.context.ants = [];

  num_ants = 3;
  // @TODO: Remplacer le nombre de fourmis avec un champ de texte
  for i = 1:num_ants
    // grand("setsd",getdate("s"));
    rand_x = grand(1, "prm", (1/4)*size(world.data, 1):(3/4)*size(world.data, 1));
    rand_y = grand(1, "prm", (1/4)*size(world.data, 2):(3/4)*size(world.data, 2));
    pos = [rand_x(1), rand_y(1)];
    world.context.ants($+1) = ants_new_ant(pos, world);
  end

  ants_update_colormap(world)

  [world] = world.plugin.main(world);
endfunction

function world = ants_plugin_main(world)
  for k = 1:length(world.context.ants)
    ant = world.context.ants(k);
    current_value   = ant.val;

    // Se calcula la distancia entre posiciones
    d = [1 -1].*(ant.pos - ant.old_pos);
    d = d($:-1:1);
    op = 0;
    if current_value == 1
      op = -1;
    else
      op = 1;
    end

    // Se guarda la posición actual cómo la posición vieja
    ant.old_pos = ant.pos;
    // Se restablece el valor de la posición donde estaba la hormiga antes de moverla
    world.data(ant.pos(1), ant.pos(2)) = ~ant.val;
    // Se calcula la nueva posición de la hormiga
    ant.pos = (op*d) + ant.pos;
    // Se allmacena el valor de la nueva posicíón
    ant.val = world.data(ant.pos(1), ant.pos(2));
    // Se actualiza el color de la posición de la hormiga
    world.data(ant.pos(1), ant.pos(2)) = k+1;

    world.context.ants(k) = ant;
  end

endfunction

function parent = ants_plugin_form(parent, world)
  // Speed input
  input_speed = uicontrol(parent, "style","edit", ...
    'constraints', createConstraints("gridbag", [1 1 1 1], [1 1], 'none', 'upper', [0 0], [80, 20]));
    // 'constraints', createConstraints("gridbag", [1 5 2 1], [1 1], 'none', 'upper', [0 0], [0.5*max_w btn_h]));
  input_speed.String = string(world.context.num_ants);
  input_speed.Callback = "num_ants_input_callback";
  input_speed.Tag = "input_speed";

  // Start button
  btn_place_ant = uicontrol(parent, "style","pushbutton", ...
    'constraints', createConstraints("gridbag", [2 1 1 1], [1 1], 'none', 'upper', [0 0], [100 25]));
  btn_place_ant.String = _("Nouvelle fourmi");
  btn_place_ant.Relief = "groove";
  // btn_place_ant.BackgroundColor = ;
  btn_place_ant.Callback = "btn_place_ant_callback";
  btn_place_ant.Tag = "btn_place_ant";

endfunction


