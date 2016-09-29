var myJSTestApp = Elm.Main.fullscreen();

myJSTestApp.ports.setUpdatedData.subscribe(function(items) {
    chart.dataProvider = items;
    chart.validateData();
});