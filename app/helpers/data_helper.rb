require "pp"
module DataHelper
  def to_jsArray(data)
    newData=data.map{ |x| '[ new Date( '+(x.date*1000).to_s+'),'+x.open.to_s+','+x.close.to_s+','+x.min.to_s+','+x.max.to_s+']'}
    return "[ #{newData.join(',')}]"
    #test ="[
    #{.join(',')}
    #]".html_safe
 
  end
end
