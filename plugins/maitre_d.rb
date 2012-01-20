require 'json'
require 'httpi'
class Plugin::MaitreD < Plugin

  def add_routes(rp, opts)

    rp.route(/is (?<environment>alpha|beta|gamma|delta) available\?/i, :noprefix => true) do |act|

      response = JSON.parse(HTTPI.get(HTTPI::Request.new("http://maitred.bleacherreport.com/reservations/show?environment=#{act.environment}")).body)

      case response["status"]
      when "available"
        act.say "It's free, go ahead (cap #{act.environment} deploy:patch)"
      when "reserved"
        expires = Time.at(response['expires'].to_i - 28800).strftime("%m/%d/%Y %H:%M")
        act.say "Sorry, #{response['user']} reserved this environment until #{expires}"
      end
    end
  
end

end