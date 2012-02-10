class Plugin::Winton < Plugin

  def add_routes(rp, opts)
    rp.route /(.*winton.*code.*)|(.*code.*winton.*)/i, :noprefix => true do |act|
      act.say "http://f.cl.ly/items/1J2n0f2O4607083M3q00/winton%20f%20u.gif"
    end
  end
end