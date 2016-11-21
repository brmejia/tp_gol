mode(0);  // Montrer les valeurs des variables si besoin

inc_dir = pwd()+'/inc';
exec(inc_dir+'/world.sci');
exec(inc_dir+'/view.sci');
exec(inc_dir+'/window.sci');
exec(inc_dir+'/window_forms.sci');

global Win;
global world

world_init();


win_init();

// fig1.event_handler_enable = "on" ;
//fig.event_handler_enable = "off" ; //suppress the event handler

