mode(0);  // Montrer les valeurs des variables si besoin

clear all;
// @TODO: Changer au repertoire du fichier
ROOT_DIR = pwd();
inc_dir = ROOT_DIR+'/inc';
getd(inc_dir);

global Win;
global world;
global plugins_info;

world = world_init(world);
plugins_info = plugins_load_plugins_info()
win_init();

// colormap = [1 1 1;
//             1 0 0;
//             1 0 1];

// colormap = hsvcolormap(64);
// colormap = colormap($:-1:1,:)


// A = testmatrix('magi', 8);
// fig = figure();
// fig.color_map = colormap;
// // colorbar(min(A), max(A));
// // axes = gca()
// Matplot(A);
