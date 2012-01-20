require 'httpi'
require 'nokogiri'

class Plugin::Newrelic < Plugin

  def add_routes(rp, opts)
    rp.route 'newrelic' do |act|
      act.say get_newrelic
    end
  end

  private

  def get_newrelic
    request = HTTPI::Request.new "https://api.newrelic.com/accounts/59/applications/136960/threshold_values.xml"
    request.headers["x-api-key"] = "b2751da5c301d17265b23fba34da4cd7829b9120b46e96d"
    request.auth.ssl.verify_mode       = :none
    html = HTTPI.get(request).body
    xml  = Nokogiri::XML.parse html

    metrics = {}
    ["Throughput", "Response Time", "Apdex", "Error Rate"].each do |measure|
      metrics[measure] = xml.at_css("threshold_value[name='#{measure}']")["formatted_metric_value"]
    end
    "Here is how we do: #{metrics['Response Time']} at #{metrics['Throughput']} with an error rate of #{metrics['Error Rate']}. That gives us an Apdex score of #{metrics['Apdex']}."
  end

end
