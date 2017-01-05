function world = plot_world(world)
  global Win;
  Win.fig.immediate_drawing = "off";
  Matplot(world.data, '022');
  // On change le type d'image pour la représentation de la figure
  e = gce(); // get current entity
  e.image_type = 'index';
  Win.fig.immediate_drawing = "on";
endfunction
