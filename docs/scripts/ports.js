var myJSTestApp = Elm.Main.fullscreen();
var chart = null;

myJSTestApp.ports.showChart.subscribe(function(items) {
    chart = AmCharts.makeChart( "chartdiv", {
      "type": "serial",
      "theme": "light",
      "dataProvider": items,
      "valueAxes": [ {
        "gridColor": "#FFFFFF",
        "gridAlpha": 0.2,
        "dashLength": 0
      } ],
      "gridAboveGraphs": true,
      "startDuration": 1,
      "graphs": [ {
        "balloonText": "[[category]]: <b>[[value]]</b>",
        "fillAlphas": 0.8,
        "lineAlpha": 0.2,
        "type": "column",
        "valueField": "visits"
      } ],
      "depth3D": 20,
        "angle": 30,
      "chartCursor": {
        "categoryBalloonEnabled": false,
        "cursorAlpha": 0,
        "zoomable": false
      },
      "categoryField": "country",
      "categoryAxis": {
        "gridPosition": "start",
        "gridAlpha": 0,
        "tickPosition": "start",
        "tickLength": 20
      },
      "export": {
        "enabled": true
      }

    } );

});

myJSTestApp.ports.setUpdatedData.subscribe(function(items) {
    chart.dataProvider = items;
    chart.validateData();
});