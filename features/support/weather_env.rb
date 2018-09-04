$LOAD_PATH.unshift(File.dirname(__FILE__))

$site_manager = SiteManager.new($config['site'], $config['site_api'])