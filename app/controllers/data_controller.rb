require 'date'
class DataController < ApplicationController
  def view
  end
  
  
  def getData
    render json: Datum.where(:date=>params[:from]..params[:to])
  end
end
