function world = plot_world(world)
  global Win;
  Win.fig.immediate_drawing = "off";
  Matplot(world.data, '022');
  Win.fig.immediate_drawing = "on";
endfunction
