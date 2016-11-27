mode(0);  // Montrer les valeurs des variables si besoin

ROOT_DIR = pwd();
inc_dir = ROOT_DIR+'/inc';
exec(inc_dir+'/world.sci');
exec(inc_dir+'/view.sci');
exec(inc_dir+'/window.sci');
exec(inc_dir+'/window_forms.sci');
exec(inc_dir+'/plugins.sci');

global Win;
global world;
global plugins;

world = world_init(world);
plugins = plugins_load_directory();
win_init();
