require 'date'
class DataController < ApplicationController
  def view
    #@data=Datum.where(:date=>1.day.ago.to_i..Time.now.to_i)
    @data=Datum.where(1400536800..1400622300)
    

  end
  
  
  def getData
    render json: Datum.where(:date=>params[:from]..params[:to])
  end
end
