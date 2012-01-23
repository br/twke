require 'httpi'
require 'nokogiri'

class Plugin::Newrelic < Plugin

  def add_routes(rp, opts)

    rp.route 'newrelic' do |act|
      metrics = get_newrelic
      act.say "Here is how we do: #{metrics['Response Time']} at #{metrics['Throughput']} with an error rate of #{metrics['Error Rate']}. That gives us an Apdex score of #{metrics['Apdex']}."
    end

    rp.route 'start error watcher' do |act|
      act.say "Starting error watcher"
      @error_watcher && Thread.kill(@error_watcher)
      @error_watcher = Thread.new do
        told_em_at = 0
        loop do
          if told_em_at < Time.now.to_i - 1800
            error_rate = get_newrelic["Error Rate"]
            if error_rate.to_f > 0.05
              act.say "Sorry to interrupt but our error rate is at #{error_rate}. Do something!"
              told_em_at = Time.now.to_i
            end
          end
          sleep 300
        end
      end
    end

    rp.route 'check error watcher' do |act|
      act.say "Error watcher is #{@error_watcher.status}"
    end

    rp.route 'stop error watcher' do |act|
      @error_watcher && Thread.kill(@error_watcher)
      act.say "Killed it!"
    end
  end

  private

  def get_newrelic
    account_id                   = 59
    application_id               = 136960
    request                      = HTTPI::Request.new "https://api.newrelic.com/accounts/#{account_id}/applications/#{application_id}/threshold_values.xml"
    request.headers["x-api-key"] = "b2751da5c301d17265b23fba34da4cd7829b9120b46e96d"
    request.auth.ssl.verify_mode = :none
    html                         = HTTPI.get(request).body
    xml                          = Nokogiri::XML.parse html

    metrics = {}
    ["Throughput", "Response Time", "Apdex", "Error Rate"].each do |measure|
      metrics[measure] = xml.at_css("threshold_value[name='#{measure}']")["formatted_metric_value"]
    end
    metrics
  end

end
