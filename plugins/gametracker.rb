require 'open-uri'

class Plugin::GameTracker < Plugin
  GameTracker = "http://gametracker.heroku.com/ranks"

  def add_routes(rp, opts)
    rp.pingpong do
      rp.route 'first' do |act|
        act.say first
      end

      rp.route 'last' do |act|
        act.say last
      end
    end
  end

  private

  def rankings
    rankings = JSON(open(GameTracker).read)
  end

  def first
    team = rankings.first
    "#{team['p1']} and #{team['p2']} are the best!"
  end

  def last
    team = rankings.last
    "#{team['p1']} and #{team['p2']} are the worst!"
  end

end
