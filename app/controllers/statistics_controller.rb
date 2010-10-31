class StatisticsController < ApplicationController
  def index
    @online_chart = generate_online_chart
    @growth_chart = generate_growth_chart
  end
  
  protected
  
  def generate_online_chart
    # format the tooltips
    pie_tooltip_formatter = '
      function() {
        return "<strong>" + this.point.name + "</strong>: " + this.y + " %";
      }'

    chart = 
        Highchart.pie({
        :chart => {
              :renderTo => "online-chart-container",
              :defaultSeriesType => "line",
              :margin => [50, 30, 0, 30]
            },
        :xAxis => {
                     :categories => ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                  },
        :yAxis => {
              :title => {
                     :text => 'Temperature'
                  },
                  :plotLines => {
                     :value => 0,
                     :width => 1,
                     :color => '#808080'
                  }
              },
          :series => [
              {
                  :name => 'Test',
                  :data => [3.57, 4.00, 4.78, 5.23, 6.34]
              }
            ],
            :subtitle => {
              :text => 'January 2010'
            },
            :title => {
              :text => 'Browser Market Share'
            },
            :tooltip => {
              :formatter => pie_tooltip_formatter
            },
        })
  end
  
  def generate_growth_chart
    # format the tooltips
    pie_tooltip_formatter = '
      function() {
        return "<strong>" + this.point.name + "</strong>: " + this.y + " %";
      }'

    chart = 
        Highchart.pie({
        :chart => {
              :renderTo => "growth-chart-container",
              :defaultSeriesType => "line",
              :margin => [50, 30, 0, 30]
            },
        :xAxis => {
                     :categories => ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                  },
        :yAxis => {
              :title => {
                     :text => 'Temperature'
                  },
                  :plotLines => {
                     :value => 0,
                     :width => 1,
                     :color => '#808080'
                  }
              },
          :series => [
              {
                  :name => 'Test',
                  :data => [3.57, 4.00, 4.78, 5.23, 6.34]
              }
            ],
            :subtitle => {
              :text => 'January 2010'
            },
            :title => {
              :text => 'Browser Market Share'
            },
            :tooltip => {
              :formatter => pie_tooltip_formatter
            },
        })
  end
end