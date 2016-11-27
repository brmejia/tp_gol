function world = plot_world(world)
  global Win;
  Win.fig.immediate_drawing = "off";
  Matplot(world.data, '022');
  Win.fig.immediate_drawing = "on";
endfunction

function [A] = toggleCell(x, y, A)
  if (A(x, y) == 0) then
    A(x, y) = 1;
  else
    A(x, y) = 0;
  end
endfunction

