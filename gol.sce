mode(0);  // Montrer les valeurs des variables si besoin

ROOT_DIR = pwd();
inc_dir = ROOT_DIR+'/inc';
getd(inc_dir);

global Win;
global world;
global plugins;

world = world_init(world);
plugins = plugins_load_directory();
win_init();
