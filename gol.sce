mode(0);  // Montrer les valeurs des variables si besoin

clear all;
// @TODO: Changer au repertoire du fichier
ROOT_DIR = pwd();
inc_dir = ROOT_DIR+'/inc';
getd(inc_dir);
plugins_dir = ROOT_DIR+'/plugins';
getd(plugins_dir);

global Win;
global world;
global plugins_info;
global context;

context = struct();

world = world_init(world);
plugins_info = plugins_load_plugins_info();
win_init();
