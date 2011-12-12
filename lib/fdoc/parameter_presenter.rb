class Fdoc::ParameterPresenter < Fdoc::Presenter

  def as_html
    template = ERB.new <<-EOF
      <li class="parameter <%= "deprecated" if node.deprecated? %>">
        <%= "<tt>#{node.name}</tt>" %>
        <%= "<span class=\\"deprecated\\">(deprecated)</span>" if node.deprecated? %>
        <%= "<p>#{node.description}</p>" if node.description %>
        <ul>
          <%= "<li>Type: #{node.type}</li>" if node.type %>
          <%= "<li>Values: #{values_as_html}</li>" if node.values %>
          <%= "<li>Default: <tt>#{node.default}</tt></li>" if node.default %>
          <%= "<li>Example: #{example_as_html}</li>" if node.example %>          
        </ul>
      </li>
    EOF
    template.result(binding)
  end
  
  def values_as_html
    return unless node.values and node.type
    
    if node.type.downcase == "enum"
      return "<tt>&quot;#{node.values.join("&quot;</tt>, <tt>&quot")}&quot;</tt>"
    end
  end
  
  def example_as_html
    return unless node.example
    "<tt>" +
    "#{"&quot;" if node.example.kind_of? String}" +
    "#{node.example.to_s.gsub(/\"/, "&quot;")}" +
    "#{"&quot;" if node.example.kind_of? String}" +
    "</tt>"
  end
end