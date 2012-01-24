class Plugin::Tungy < Plugin

  def add_routes(rp, opts)
    rp.route /tungy/i, :noprefix => true do |act|
      act.say [
        "http://memegenerator.net/cache/instances/400x/12/12859/13167654.jpg",
        "http://f.cl.ly/items/3D0Z2Y0i1T1W3W151C3Q/tung_mcdonalds.gif",
        "http://f.cl.ly/items/3d2u1B0s0g2O2718440B/tung_drunk.gif",
        "http://f.cl.ly/items/381z3i31172P1y1T3F2I/vK73.old%20tungy%20knocking%20on%20door.jpg"
      ][rand(a.size)]
    end
  end
end