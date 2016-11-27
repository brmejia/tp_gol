function world = plot_world(world)
  mode(0)
  global Win;
  if isempty(world.axes)
    disp('================== NEW AXES ==================');
    frame_right = get('frame_right');
    world.axes = newaxes(frame_right);

    world.axes.tag             = "plot";
    world.axes.title.text      = "";
    world.axes.title.font_size = 5;
    world.axes.isoview         = 'on';
    world.axes.margins         = [.05 .05 .08 .05]; // [L R U D]
    world.axes.auto_ticks      = ['off' 'off' 'off']; // Se eliminan la numeración de los ejes.

    // High level properties
    world.axes.auto_clear = 'on';
  end

  // fig1.event_handler = 'gol_events_handler';

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

