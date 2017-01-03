function [Win, world] = example_plugin_init(Win, world)
  colormap_size = 10;
  colormap = hsvcolormap(colormap_size);
  Win.fig.color_map = colormap;
  world.speed = 300;
endfunction

function world = example_plugin_main(world)
  world.data = 10*abs(rand(world.rows, world.cols));
endfunction
