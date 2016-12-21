function [Win, world] = example_plugin_init(this, Win, world)
  colormap_size = 25;
  colormap = graycolormap(colormap_size);
  Win.fig.color_map = colormap;
  // world.axes.color_map = colormap;
endfunction

function world = example_plugin_main(this, world)
  world = world_data_reset(world);
  world.data = 10*rand(world.rows, world.cols);
endfunction
