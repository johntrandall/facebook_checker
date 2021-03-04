class HomeController < ApplicationController
  def index
    @date_range = 14.days.ago.to_date...Time.current.to_date

    @graph_file_name = "#{controller_name}_#{action_name}.png"
    render_chart_image("app/assets/images/#{@graph_file_name}")

    @resuts_to_render_in_table = CheckResult.where(created_at: @date_range)
  end

  private

  def render_chart_image(graph_image_location)
    g = Gruff::StackedBar.new

    array_of_dates = (@date_range).uniq
    g.labels = array_of_dates
                 .each_with_index.map { |x, i| [i, x] }.to_h
                 .transform_values.each { |v| v = v&.strftime('%d') }
    g.data("found logged in to Facebook",
           array_of_dates.map { |date| CheckResult.where(created_at: [date.beginning_of_day..date.end_of_day]).count })
    g.data('total checks',
           array_of_dates.map { |date| CheckResult.where(created_at: [date.beginning_of_day..date.end_of_day]).count })
    g.write(graph_image_location)
  end

end
