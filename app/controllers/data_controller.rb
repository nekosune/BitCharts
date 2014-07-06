require 'date'
class DataController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def view
    #@data=Datum.where(:date=>1.day.ago.to_i..Time.now.to_i)
    @data=Datum.where(:date=>1400536800..1400622300)
    ActiveSupport.encode_big_decimal_as_string = false
    #@script=@data.map{|x| [Time.at(x.date),BigDecimal.new(x.open),BigDecimal.new(x.close),BigDecimal.new(x.min),BigDecimal.new(x.max)]}
  end
  
  
  def getData
    render json: Datum.where(:date=>params[:from]..params[:to])
  end
  
  

end
