class Plugin::Shanan < Plugin

  def add_routes(rp, opts)
    rp.route /mani|pedi/i, :noprefix => true do |act|
      act.say "http://f.cl.ly/items/3D1r0G2q3c0J3q0w0x1R/shanan.jpg"
    end
  end
end