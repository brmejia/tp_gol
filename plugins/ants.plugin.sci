
plugin = tlist([
  'GOL_PLUGIN_DEF',
  'name',
  'title',
  'init_function',
  'main_function',
  'radio_btn_callback',
]);

plugin.name               = 'ants_plugin';
plugin.title              = 'Ants Plugin';
plugin.init_function      = 'ants_plugin_init';
plugin.main_function      = 'ants_plugin_main';
plugin.radio_btn_callback = 'ants_plugin_radio_btn_callback';

function [Win, world] = ants_plugin_init(Win, world)
  colormap_size = 25;
  colormap = hotcolormap(colormap_size);
  Win.fig.color_map = colormap;
  // world.axes.color_map = colormap;
endfunction

function world = ants_plugin_main(world)
  world = world_data_reset(world);
  world.data = 24*rand(world.rows, world.cols);
endfunction
