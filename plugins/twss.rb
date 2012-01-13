require 'twss'

class Plugin::Twss < Plugin

  def add_routes(rp, opts)
    rp.route /(?<phrase>.+)$/ do |act|
      if TWSS(act.phrase)
        act.say "that's what she said!"
      end
    end
  end
end