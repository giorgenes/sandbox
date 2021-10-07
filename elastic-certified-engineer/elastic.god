%w{master-1}.each do |node|
  God.watch do |w|
    w.name = "elastic-#{node}"

    w.start = "elasticsearch"

    w.env = { 'ES_PATH_CONF' => File.join(File.dirname(__FILE__), "config", node) }

    w.keepalive
  end
end