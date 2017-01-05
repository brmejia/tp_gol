// @TODO: Créer une fonction pour mettre à jour le statu des champs du formulaire
// @TODO: Créer un monde circulaire

function [world, ant] = ants_new_ant(pos, world)
  global context;
  ant = struct();

  if world.data(pos(1), pos(2)) > 1
    return;
  end

  // On enregistre la position de la fourmi [row, column]
  ant.pos = pos;

  // On génère de manière pseudo-aléatoire la position précédente de la fourmi
  delta = grand(1, "prm", [-1 1]);
  old_pos = [delta(1), 0];
  ant.old_pos = pos + grand(1, "prm", old_pos);
  // On enregistre la valeur du monde à la position de la fourmi
  ant.val = world.data(ant.pos(1), ant.pos(2));
  // On insert la fourmi dans le monde
  k = length(context.anthill()) + 1;
  context.anthill(k) = ant;
  context.num_ants = length(context.anthill);
  // On place la fourmi dans la graphique
  world.data(ant.pos(1), ant.pos(2)) = k + 1;
endfunction

function [world, anthill] = ants_populate_anthill(num_ants, world)
  global context;
  context.anthill = [];
  grand("setsd",getdate("s"));
  for i = 1:num_ants
    // @TODO: Générer des positions qui ne se répètent pas
    rand_x = grand(1, "prm", (1/4)*size(world.data, 1):(3/4)*size(world.data, 1));
    rand_y = grand(1, "prm", (1/4)*size(world.data, 2):(3/4)*size(world.data, 2));
    pos = [rand_x(1), rand_y(1)];
    world = ants_new_ant(pos, world);
  end
endfunction

function ants_update_colormap(world)
  global context;
  n = 1;
  colormap = [.9 .9 .9];
  if ~isempty(context.anthill)
    n = length(context.anthill);
  end
  global Win;
  Win.fig.color_map = [colormap; hsvcolormap(n)];
endfunction

function [Win, world] = ants_plugin_init(Win, world)
  global context;

  fig = gcf();
  fig.event_handler = 'ants_new_ant_btn_callback';
  fig.event_handler_enable = "on" ;

  // // Valeurs prédéfinis
  world.speed = 1;
  world = world_data_reset(world);

  if (~isfield(context, 'anthill'))
    context.anthill = [];
  end
  if (~isfield(context, 'num_ants') | context.num_ants < 1)
    context.num_ants = 1;
  end

  // On ajoute au monde toutes les fourmis
  world = ants_populate_anthill(context.num_ants, world);

  ants_update_colormap(world)
  world = plot_world(world);
endfunction

function world = ants_plugin_main(world)
  global context;
  for k = 1:length(context.anthill)
    ant = context.anthill(k);

    // Se calcula la distancia entre posiciones
    d = [1 -1].*(ant.pos - ant.old_pos);
    d = d($:-1:1);
    op = 0;
    if ant.val >= 1
      new_val = 0;
      op = -1;
    else
      new_val = 1;
      op = 1;
    end

    // Se guarda la posición actual cómo la posición vieja
    ant.old_pos = ant.pos;
    // Se restablece el valor de la posición donde estaba la hormiga antes de moverla
    world.data(ant.pos(1), ant.pos(2)) = new_val;
    // Se calcula la nueva posición de la hormiga
    ant.pos = (op*d) + ant.pos;
    // Se allmacena el valor de la nueva posicíón
    ant.val = world.data(ant.pos(1), ant.pos(2));
    // Se actualiza el color de la posición de la hormiga
    world.data(ant.pos(1), ant.pos(2)) = k+1;

    context.anthill(k) = ant;
  end

endfunction

function parent = ants_plugin_form(parent, world)
  global context;
  // Nombre de fourmis input
  if ~isfield(context, 'num_ants') || isempty(context.num_ants)
    context.num_ants = 1;
  end

  // Speed input Label
  lb_input_num_ants = uicontrol(parent, "style","text", ...
    'constraints', createConstraints("gridbag", [1 1 1 1], [1 1], 'horizontal', 'upper_right', [0 0], [180 30]));
  lb_input_num_ants.String = ['Nombre de fourmis'];
  lb_input_num_ants.BackgroundColor = [1 1 1];

  input_num_ants = uicontrol(parent, "style","edit", ...
    'constraints', createConstraints("gridbag", [2 1 1 1], [1 1], 'horizontal', 'upper_left', [0 0], [50 30]));
  input_num_ants.String = string(context.num_ants);
  input_num_ants.Callback = "ants_num_ants_input_callback";
  input_num_ants.Callback_Type = 10;
  input_num_ants.Tag = "ants_num_ants";

endfunction

function ants_plugin_form_update(world)
  global context;

  if isfield(context, 'num_ants')
    input_num_ants  = get('ants_num_ants');
    input_num_ants.String = string(context.num_ants);
  end
endfunction

function ants_plugin_form_state(world)
  global context;

  input_num_ants  = get('ants_num_ants');

  if world.state == 0 //STOPED
    input_num_ants.Enable = 'on';
  elseif world.state == 1 // RUNNING
    input_num_ants.Enable = 'off';
  elseif world.state == -1 // UNSET
    input_num_ants.Enable = 'off';
  end
endfunction

function ants_num_ants_input_callback()
  global context;

  this = gcbo;
  // On vérifie si le texte est un nombre superieur à 1
  num_ants = strtod(this.string);
  if ~isnum(this.string) | num_ants < 1
    num_ants = 1;
  end

  if context.num_ants ~= num_ants
    global world;
    global Win;
    world = world_data_reset(world);

    this.string = string(num_ants);
    context.num_ants = num_ants;
    world = ants_populate_anthill(num_ants, world);

    ants_update_colormap(world);
    win_update_buttons_state();
    world = plot_world(world);
  end
endfunction

function ants_new_ant_btn_callback(win, column, row, ibut)
  if ibut==-1000
    return;
  end

  global world;
  [column, row]=xchange(column, row,'i2f');

  column = column - 0.5;
  row    = row - 0.5;
  // Si on fait click
  if ibut == 0 || ibut == 3 || ibut == -10000
    // Si la position est dans la figure, on continue
    if (0 <= column && column <= world.cols) && (0 <= row && row <= world.rows)
      global Win;
      // On calcule la position de la fourmi
      pos = ceil([world.rows - row, column]);
      // On crée la nouvelle fourmi
      [world, ant] = ants_new_ant(pos, world);
      // On actualise la valeur du formulaire
      ants_plugin_form_update(world);
      // On actualise la figure
      Win.fig.immediate_drawing = "off";
      ants_update_colormap(world);
      world = plot_world(world);
      Win.fig.immediate_drawing = "on";
    end
  end
endfunction

