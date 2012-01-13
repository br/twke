class Plugin::Tungy < Plugin

  def add_routes(rp, opts)
    rp.route /tungy/i do |act|
      act.say "http://memegenerator.net/cache/instances/400x/12/12859/13167654.jpg"
    end
  end
end