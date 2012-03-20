require 'hpricot'
require 'open-uri'

class Plugin::RonSwanson < Plugin

  def add_routes(rp, opts)
    rp.route /#(?<id>\d+)/ do |act|
      act.say "That would be the following Lighthouse URL: https://bleacherreport.lighthouseapp.com/projects/6296-bug-reporting/tickets/#{act.id}"
    end
  end


end
