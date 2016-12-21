function plugins_info = plugins_load_plugins_info()
  mode(0);
  global ROOT_DIR;
  plugins_pattern = ROOT_DIR+'/plugins/*.plugin.info';
  // Se listan los archivos que existen en el directorio de plugins
  plugin_files = ls(plugins_pattern);

  plugins_info = list();
  num_files = size(plugin_files, 1); // Número de archivos

  for index = 1:size(plugin_files,1)
    plugin_file = plugin_files(index);
    // Se vacía la variable plugin si existe para evitar errores
    if isdef('plugin')
      clear plugin;
    end
    // Se ejecuta el archivo del plugin
    exec(plugin_file);
    // Si el archivo del plugin contiene una lista plugin con la información básica
    // Se guarda la información del plugin.
    if isdef('plugin')
      // Se crea el nuevo plugin con la información del plugin y el path del archivo
      plugin.path = ROOT_DIR+'/plugins/'+plugin.name+'.plugin.sci';
      // Se añade el objeto a la lista de plugins
      plugins_info($+1) = plugin;
    end
  end
endfunction

function plugin = plugins_load_plugin(plugin)
  mode(0);
  // On vérifie si le fichier du plugin existe
  if isfile(plugin.path)
    exec(plugin.path);
    // On ajoute le fonctions principales à la structure du plugin
    base_names = ['init' 'main' 'form'];
    for base_name = base_names
      fn_name = plugin.name+'_plugin_'+base_name;
      // On vérifie s'il existe un élément avec le nom de la fonction et si cet élément est une fonction
      if isdef(fn_name) & type(eval(fn_name)) == 13
        plugin(base_name) = eval(fn_name);
      end
    end
  else
    // Se muestra mensaje de alerta cuando se produce un error en la ejecución
    msg = msprintf(_("Not plugin founded in ''%s''."), path);
    messagebox(msg, _("Error"), "info", "modal");
    stop_btn_callback();
  end
endfunction
