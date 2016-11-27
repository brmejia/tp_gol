
plugin = tlist([
  'GOL_PLUGIN_DEF',
  'name',
  'title',
  'init_function',
  'main_function',
  'radio_btn_callback',
]);

plugin.name               = 'example_plugin';
plugin.title              = 'Test Plugin';
plugin.init_function      = 'example_plugin_init';
plugin.main_function      = 'example_plugin_main';
plugin.radio_btn_callback = 'example_plugin_radio_btn_callback';

function [Win, world] = example_plugin_init(Win, world)
  colormap_size = 25;
  colormap = graycolormap(colormap_size);
  Win.fig.color_map = colormap;
  // world.axes.color_map = colormap;
endfunction

function world = example_plugin_main(world)
  world = world_data_reset(world);
  world.data = 10*rand(world.rows, world.cols);
endfunction
