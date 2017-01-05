function [Win, world] = gol_plugin_init(Win, world)

  Win.fig.event_handler = 'gol_event_handler';
  Win.fig.event_handler_enable = "on" ;

  colormap = [1 1 1];

  // // Valeurs prédéfinis
  world.speed = 10;
  world.rows = 50;
  world.cols = 50;
  world = world_data_reset(world);

  Win.fig.color_map = colormap;

endfunction

function world = gol_plugin_main(world)
  ker = [1 1 1;
         1 0 1;
         1 1 1];
  C = int16(conv2(double(world.data), ker, "same"));
  //Règle 1. Les cellules mortes avec exactement 3 cellules voisines vivants naissent.
  m_rule1 = C == 3;
  //Règle 2. Les cellules vivantes avec deux ou trois cellules voisines restent vivants
  m_rule2 = (C == 2).*world.data;
  //Règle 3: Les celulles vivantes avec moins de 2 ou plus de 3 cellules voisines seront mortes au suivant état.
  m_rule3 = (2 < C || C < 3);

  world.data = (m_rule1 + m_rule2) .* m_rule3;
endfunction

function parent = gol_plugin_form(parent, world)
  disp('gol_plugin_form');

  global context;
  structures = gol_get_structures();
  struct_names = fieldnames(structures);

  btns = []
  for k = 1:size(struct_names, 1)
    name = struct_names(k);
    // Structure de code commun pour tous les boutons des structures
    btns(name) = uicontrol(parent, "style","pushbutton", ...
      'constraints', createConstraints("gridbag", [1 k 1 1], [1 1], 'horizontal', 'upper', [0 0], [200 30]));
    btns(name).String = _(name);
    btns(name).Relief = "groove";
    btns(name).BackgroundColor = [.95 .95 .95];
    btns(name).Callback = "gol_place_structure_callback";
    btns(name).Callback_Type = 10;
    btns(name).Tag = "gol_btn_"+name;
  end

endfunction

function gol_event_handler(win, column, row, ibut)
  if ibut==-1000
    return;
  end
  global world;
  [column, row] = xchange(column, row,'i2f');

  column = column - 0.5;
  row    = row - 0.5;
  // Si on fait click
  if ibut == 0 || ibut == 3
    // Si la position est dans la figure, on continue
    if (0 <= column && column <= world.cols) && (0 <= row && row <= world.rows)
      row = ceil(world.rows - row);
      column = ceil(column);

      if world.data(row, column) >= 1
        world.data(row, column) = 0;
      else
        world.data(row, column) = 1;
      end
      world = plot_world(world);
    end
  end
endfunction

function gol_place_structure_callback()
  global context;

  this = gcbo;
  // On vérifie si le texte est un nombre superieur à 1
  name = convstr(this.String, 'l');
  structure = gol_get_structure_by_name(name);

  if isempty(structure)
    return;
  end

  global world;
  seteventhandler('');
  [ibut,column,row] = xclick();
  seteventhandler('gol_event_handler');
  // On calcule les vrais valeurs du click
  row = ceil(world.rows - (row - 0.5));
  column = ceil(column - 0.5);

  world = gol_place_structure(world, structure, column, row);
  world = plot_world(world);

endfunction

// This function returns all existent structures
function structures = gol_get_structures()
  structures = [];
  // SPACESHIPS
  structures.glider = [0 1 0;
                       0 0 1;
                       1 1 1];

  structures.lwss = [1 0 0 1 0;
                     0 0 0 0 1;
                     1 0 0 0 1;
                     0 1 1 1 1];
  // OSCILATEURS
  structures.blinker = [1 1 1];

  structures.toad = [0 1 1 1;
                     1 1 1 0];

  structures.beacon = [1 1 0 0;
                       1 0 0 0;
                       0 0 0 1;
                       0 0 1 1];

  structures.pulsar = [0 0 0 0 1 0 0 0 0 0 1 0 0 0 0;
                       0 0 0 0 1 0 0 0 0 0 1 0 0 0 0;
                       0 0 0 0 1 1 0 0 0 1 1 0 0 0 0;
                       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                       1 1 1 0 0 1 1 0 1 1 0 0 1 1 1;
                       0 0 1 0 1 0 1 0 1 0 1 0 1 0 0;
                       0 0 0 0 1 1 0 0 0 1 1 0 0 0 0;
                       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                       0 0 0 0 1 1 0 0 0 1 1 0 0 0 0;
                       0 0 1 0 1 0 1 0 1 0 1 0 1 0 0;
                       1 1 1 0 0 1 1 0 1 1 0 0 1 1 1;
                       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                       0 0 0 0 1 1 0 0 0 1 1 0 0 0 0;
                       0 0 0 0 1 0 0 0 0 0 1 0 0 0 0;
                       0 0 0 0 1 0 0 0 0 0 1 0 0 0 0];

  structures.column = [1 1 1;
                       0 1 0;
                       0 1 0;
                       1 1 1;
                       0 0 0;
                       1 1 1;
                       1 1 1;
                       0 0 0;
                       1 1 1;
                       0 1 0;
                       0 1 0;
                       1 1 1];
  // FIXES
  structures.block = [1 1;
                      1 1]

  structures.boat = [1 1 0;
                     1 0 1;
                     0 1 0];

  structures.beehive = [0 1 1 0;
                        1 0 0 1;
                        0 1 1 0];

  structures.loaf = [0 1 1 0;
                     1 0 0 1;
                     0 1 0 1;
                     0 0 1 0];

endfunction

// This function returns an structure given its name
function structure = gol_get_structure_by_name(name)
  // On obtient toutes les structures
  structures = gol_get_structures();
  // On cherche su la structure demandée existe
  if isfield(structures, name)
    structure = structures(name);
  else
    structure = [];
  end
endfunction

// This function will padding with zeros an array in a given quantity
// of rows and columns
// Arguments: [array, aU, aR, aD, aL]
function padded_array = gol_zero_padarray(array, aR, aD, varargin)
  // gol_zero_padarray(repmat(testmatrix('magi', 3), 1, 2), 1, 2)
  rhs = argn(2);
  if rhs == 5 then
    aL = varargin(1)
    aU = varargin(2);
  elseif rhs == 4 then
    aL = varargin(1)
    aU = 0;
  elseif rhs == 3 then
    aL = 0;
    aU = 0;
  elseif rhs < 3 then
    error("Expect at least three arguments");
  end

  tmp = [repmat(zeros(size(array, 1), 1), 1, aL), array, repmat(zeros(size(array, 1), 1), 1, aR)];
  padded_array = [repmat(zeros(1, size(tmp, 2)), aU, 1); tmp; repmat(zeros(1, size(tmp, 2)), aD, 1)];

endfunction

function world = gol_place_structure(world, structure, column, row)
  size_struct = size(structure);
  aU = row - 1;
  aL = column - 1;
  aR = world.cols - aL - size_struct(2);
  aD = world.rows - aU - size_struct(1);
  padded_struct = gol_zero_padarray(structure, aR, aD, aL, aU)
  world.data = world.data + padded_struct;
endfunction

function gol_plugin_form_state(world)
  global context;

  structures = gol_get_structures();
  struct_names = fieldnames(structures);

  for k = 1:size(struct_names, 1)
    btn_tag = 'gol_btn_' + string(struct_names(k));
    gol_struct_btn = findobj('tag', btn_tag);

    if world.state == 0 //STOPED
      gol_struct_btn.Enable = 'on';
    elseif world.state == 1 // RUNNING
      gol_struct_btn.Enable = 'off';
    elseif world.state == -1 // UNSET
      gol_struct_btn.Enable = 'off';
    end
  end
endfunction
