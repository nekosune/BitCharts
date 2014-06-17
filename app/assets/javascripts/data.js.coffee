# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
candleData = "Date,Open,Close,High,Low\n" +
  "2011-12-06,392.54,390.95,394.63,389.38\n" + 
  "2011-12-07,389.93,389.09,390.94,386.76\n" + 
  "2011-12-08,391.45,390.66,395.50,390.23\n" + 
  "2011-12-09,392.85,393.62,394.04,391.03\n" + 
  "2011-12-12,391.68,391.84,393.90,389.45\n" + 
  "2011-12-13,393.00,388.81,395.40,387.10\n" + 
  "2011-12-14,386.70,380.19,387.38,377.68\n" + 
  "2011-12-15,383.33,378.94,383.74,378.31\n" + 
  "2011-12-16,380.36,381.02,384.15,379.57\n" + 
  "2011-12-19,382.47,382.21,384.85,380.48\n" + 
  "2011-12-20,387.76,395.95,396.10,387.26\n" + 
  "2011-12-21,396.69,396.45,397.30,392.01\n" + 
  "2011-12-22,397.00,398.55,399.13,396.10\n" + 
  "2011-12-23,399.69,403.33,403.59,399.49\n" + 
  "2011-12-27,403.10,406.53,409.09,403.02\n" + 
  "2011-12-28,406.89,402.64,408.25,401.34\n" + 
  "2011-12-29,403.40,405.12,405.65,400.51\n" + 
  "2011-12-30,403.51,405.00,406.28,403.49\n" + 
  "2012-01-03,409.50,411.23,412.50,409.00\n" + 
  "2012-01-04,410.21,413.44,414.68,409.28\n" + 
  "2012-01-05,414.95,418.03,418.55,412.67\n" + 
  "2012-01-06,419.77,422.40,422.75,419.22\n" + 
  "2012-01-09,425.52,421.73,427.75,421.35\n" + 
  "2012-01-10,425.91,423.24,426.00,421.50\n" + 
  "2012-01-11,422.59,422.55,422.85,419.31\n" + 
  "2012-01-12,422.41,421.39,422.90,418.75\n" + 
  "2012-01-13,419.53,419.81,420.45,418.66\n" + 
  "2012-01-17,424.20,424.70,425.99,422.96\n" + 
  "2012-01-18,426.87,429.11,429.47,426.30\n" + 
  "2012-01-19,430.03,427.75,431.37,426.51\n" + 
  "2012-01-20,427.49,420.30,427.50,419.75\n" + 
  "2012-01-23,422.67,427.41,428.45,422.30\n" + 
  "2012-01-24,425.10,420.41,425.10,419.55\n" + 
  "2012-01-25,454.26,446.66,454.45,443.73\n" + 
  "2012-01-26,448.45,444.63,448.79,443.14\n" + 
  "2012-01-27,444.37,447.28,448.48,443.77\n" + 
  "2012-01-30,445.71,453.01,453.90,445.39\n" + 
  "2012-01-31,455.85,456.48,458.24,453.07\n" + 
  "2012-02-01,458.49,456.19,458.99,455.55\n" + 
  "2012-02-02,455.90,455.12,457.17,453.98\n" + 
  "2012-02-03,457.30,459.68,460.00,455.56\n" + 
  "2012-02-06,458.38,463.97,464.98,458.20\n" + 
  "2012-02-07,465.25,468.83,469.75,464.58\n" + 
  "2012-02-08,470.50,476.68,476.79,469.70\n" + 
  "2012-02-09,480.95,493.17,496.75,480.56\n" + 
  "2012-02-10,491.17,493.42,497.62,488.55\n" + 
  "2012-02-13,499.74,502.60,503.83,497.09\n" + 
  "2012-02-14,504.70,509.46,509.56,502.00\n" ;
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
                { plotter: candlePlotter })
