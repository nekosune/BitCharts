require 'date'
class DataController < ApplicationController
  def view
  end
  
  
  def getData
    render json: Datum.where(:date=>DateTime.strptime(params[:from],"%s")..DateTime.strptime(params[:to],"%s"))
  end
end
