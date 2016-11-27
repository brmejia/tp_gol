
plugin = tlist([
  'GOL_PLUGIN_DEF',
  'name',
  'title',
  'init_function',
  'main_function',
  'radio_btn_callback',
  // Algorithm Variables
  'pos',
  'old_pos',
  'val',
]);

plugin.name               = 'ants_plugin';
plugin.title              = _("Langtons ant");
plugin.init_function      = 'ants_plugin_init';
plugin.main_function      = 'ants_plugin_main';
plugin.radio_btn_callback = 'ants_plugin_radio_btn_callback';

function [Win, world] = ants_plugin_init(Win, world)
  // colormap_size = 4;
  // colormap = jetcolormap(colormap_size);
  // colormap = colormap($:-1:1,:);
  colormap = [1 1 1;
              1 0 0;
              1 0 1];

  Win.fig.color_map = colormap;

  world.data = ones(world.rows, world.cols);
  world.plugin.info.pos = floor(size(world.data)/2);
  world.plugin.info.val = world.data(world.plugin.info.pos(1), world.plugin.info.pos(2));
  world.plugin.info.old_pos = world.plugin.info.pos + [1 0];
endfunction

function world = ants_plugin_main(world)
  current_value   = world.plugin.info.val;
  // Se calcula la distancia entre posiciones
  d = [1 -1].*(world.plugin.info.pos - world.plugin.info.old_pos);
  d = d($:-1:1);
  op = 0;
  if current_value == 1
    op = -1;
  elseif current_value == 0
    op = 1;
  end

  // Se guarda la posición actual cómo la posición vieja
  world.plugin.info.old_pos = world.plugin.info.pos;
  // Se restablece el valor de la posición donde estaba la hormiga antes de moverla
  world.data(world.plugin.info.pos(1), world.plugin.info.pos(2)) = ~world.plugin.info.val
  // Se calcula la nueva posición de la hormiga
  world.plugin.info.pos = (op*d) + world.plugin.info.pos;
  // Se allmacena el valor de la nueva posicíón
  world.plugin.info.val = world.data(world.plugin.info.pos(1), world.plugin.info.pos(2));
  // Se actualiza el color de la posición de la hormiga
  world.data(world.plugin.info.pos(1), world.plugin.info.pos(2)) = 2
endfunction
