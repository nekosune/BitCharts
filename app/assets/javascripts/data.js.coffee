# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


BAR_WIDTH = 8;
candlePlotter=(e) ->
  if e.seriesIndex != 0 
    return;

  setCount = e.seriesCount;
  if setCount != 4
    throw "Exactly 4 prices each point must be provided for candle chart (open close high low)";

  prices = [];
  sets = e.allSeriesPoints;
  for p in [0...sets[0].length]
    prices.push({
      open : sets[0][p].yval,
      close : sets[1][p].yval,
      high : sets[2][p].yval,
      low : sets[3][p].yval,
      openY : sets[0][p].y,
      closeY : sets[1][p].y,
      highY : sets[2][p].y,
      lowY : sets[3][p].y
    }) 

  area = e.plotArea;
  ctx = e.drawingContext;
  ctx.strokeStyle = '#202020';
  ctx.lineWidth = 0.6;
  for p in [0...prices.length]
    ctx.beginPath();

    price = prices[p];
    topY = area.h * price.highY + area.y;
    bottomY = area.h * price.lowY + area.y;
    centerX = area.x + sets[0][p].x * area.w;
    ctx.moveTo(centerX, topY);
    ctx.lineTo(centerX, bottomY);
    ctx.closePath();
    ctx.stroke();
    if price.open > price.close 
      ctx.fillStyle ='rgba(244,44,44,1.0)';
      bodyY = area.h * price.openY + area.y;
    else 
      ctx.fillStyle ='rgba(44,244,44,1.0)';
      bodyY = area.h * price.closeY  + area.y;
    bodyHeight = area.h * Math.abs(price.openY - price.closeY);
    ctx.fillRect(centerX - BAR_WIDTH / 2, bodyY, BAR_WIDTH,  bodyHeight);
        
ticker=(x) ->
    return 1000*parseInt(x);
    
$(document).ready ->
  placeholder = document.getElementById("TestGraph")
  pusher = new Pusher('de504dc5763aeef9ff52');
  trades_channel = pusher.subscribe('live_trades');
  i = 0;
  data=[[1,10,100],
        [2,20,80],
        [3,50,60],
        [4,70,80]]
  g = new Dygraph(placeholder,
                candleData,
                {plotter: candlePlotter,labels: [ "dateTime", "Open", "Close","Min","Max" ] })
