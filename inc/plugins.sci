function plugins = plugins_load_directory()
  mode(0);
  plugins_dir = ROOT_DIR+'/plugins/*.plugin.sci';
  // Se listan los archivos que existen en el directorio de plugins
  plugin_files = ls(plugins_dir);

  plugins = list();
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
      new_plugin = tlist([
        'GOL_PLUGIN',
        'path',
        'info'
      ]);
      new_plugin.path = plugin_file;
      new_plugin.info = plugin;
      // Se añade el objeto a la lista de plugins
      plugins($+1) = new_plugin;
    end
  end
endfunction
