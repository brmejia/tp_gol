// @TODO: Créer une fonction pour mettre à jour le statu des champs du formulaire

function [world, ant] = ants_new_ant(pos, world)
  global context;
  ant = struct();
  // On enregistre la position de la fourmi
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

  // Valeurs prédéfinis
  world.speed = 1000;
  world.rows  = 15;
  world.cols  = 15;

  if (~isfield(context, 'anthill'))
    context.anthill = [];
  end
  if (~isfield(context, 'num_ants') | context.num_ants < 1)
    context.num_ants = 1;
  end

  // On ajoute au monde toutes les fourmis
  world = ants_populate_anthill(context.num_ants, world);

  ants_update_colormap(world)
  // [world] = world.plugin.main(world);
  world = plot_world(world);
endfunction

function world = ants_plugin_main(world)
  global context;
  for k = 1:length(context.anthill)
    ant = context.anthill(k);
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

    context.anthill(k) = ant;
  end

endfunction

function parent = ants_plugin_form(parent, world)
  global context;
  // Nombre de fourmis input
  if isempty(context.num_ants)
    context.num_ants = 1;
  end

  input_speed = uicontrol(parent, "style","edit", ...
    'constraints', createConstraints("gridbag", [1 1 1 1], [1 1], 'none', 'upper', [0 0], [80, 20]));
  input_speed.String = string(context.num_ants);
  input_speed.Callback = "ants_num_ants_input_callback";
  input_speed.Tag = "ants_num_ants";

  // Start button
  btn_place_ant = uicontrol(parent, "style","pushbutton", ...
    'constraints', createConstraints("gridbag", [2 1 1 1], [1 1], 'none', 'upper', [0 0], [100 25]));
  btn_place_ant.String = _("Nouvelle fourmi");
  btn_place_ant.Relief = "groove";
  btn_place_ant.Callback = "ants_place_ant_btn_callback";
  btn_place_ant.Tag = "btn_place_ant";

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

// function ants_place_ant_btn_callback()
//   global world;
//   // On obtient la position du click
//   [b,x,y]=xclick(); //get a point
//   x = floor(x);
//   y = floor(y);

//   // Si la position est dans la figure, on continue
//   if (0 <= x && x <= world.cols) && (0 <= y && y <= world.rows)
//     // On crée la nouvelle fourmi
//     world.data()
//   end
//   // disp(xcoord);
//   // disp(yxcoord);
//   // disp(iwin);
//   // disp(cbmenu);
//   disp('btn_place_ant_callback');
// endfunction

