mode(0);  // Montrer les valeurs des variables si besoin

inc_dir = pwd()+'/inc';
exec(inc_dir+'/world.sci');
exec(inc_dir+'/view.sci');
exec(inc_dir+'/window.sci');

global world
world_init();

// world = plot_world(world);

global Win;
win_init();


// world_size = [10, 10];
// world = zeros(world_size);
// state = 0;  // Run 1
//             // Stop 0
//             // reset -1
// speed = 2500; // Miliseconds

// fig = scf(0); // Create/Set current figure








// colormap_size = 25;
// fig1 = scf(0); // Create/Set current figure
// fig1.color_map = jetcolormap(colormap_size);
// fig1.event_handler = 'gol_events_handler';

// rows = 10;
// cols = 10;

// world = zeros(rows,cols);

// world(1,1) = 1;
// world(rows,cols) = 1;

// // world(4,4) = 2;
// // world(4,5) = 2;
// // world(4,6) = 2;
// // world(4,7) = 1;
// // world(4,8) = 1


// colorbar(0,colormap_size/2)

// while 1,
//   world = testmatrix('magi', sqrt(colormap_size));
//   Matplot(world, '081');
// end


// huibutton=uicontrol(fig1,"style","pushbutton");
// huibutton.Position = [50 50 500 30]; // [x y w h]
// huibutton.String = "Update";
// huibutton.BackgroundColor=[0.9 0.9 0.9];
// huibutton.Callback = "pushmybutton";
// //
// fig1.event_handler_enable = "on" ;
// //fig.event_handler_enable = "off" ; //suppress the event handler
// //

