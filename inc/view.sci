function fig = fig_controls(fig)

  huibutton=uicontrol(fig,"style","pushbutton");
  huibutton.Position = [0 0 500 30]; // [x y w h]
  huibutton.String = "Start";
  huibutton.BackgroundColor=[0.9 0.9 0.9];
  huibutton.Callback = "start_callback";
endfunction

function world = plot_world(world)
  if isempty(world.fig)
    fig = scf();
    world.fig = fig_controls(fig);
  end

  scf(world.fig);
// colormap_size = 25;
// fig1 = scf(0); // Create/Set current figure
// fig1.color_map = jetcolormap(colormap_size);
// fig1.event_handler = 'gol_events_handler';

  Matplot(world.data, '081');
endfunction

function gol_events_handler(win, x, y, ibut)
  mode(1);
  if ibut==-1000 then return,end
  [x,y]=xchange(x,y,'i2f');
  x = round(x);
  y = round(y);
  xinfo(msprintf('Event code %d at mouse position is (%f,%f)',ibut,x,y))
endfunction

function [A] = toggleCell(x, y, A)
  if (A(x, y) == 0) then
    A(x, y) = 1;
  else
    A(x, y) = 0;
  end
endfunction

function start_callback()
  global world;

  world.data = 10.*rand(world.rows, world.cols);
  world = plot_world(world);

endfunction
