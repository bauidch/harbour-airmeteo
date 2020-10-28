function httpGet(url) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", url, false);
    xmlHttp.send(null);
    return xmlHttp;
}

function get_metar() {
    var locationsRAW = httpGet("https://www.aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&stationString=LSZH&hoursBeforeNow=1&format=xml&mostRecent=true")
    console.log(locationsRAW.responseText)

}

function getAirportData() {
    var airportdataRAW = httpGet("https://www.airport-data.com/api/ap_info.json?icao=LSZH")

    try {
        var location = JSON.parse(airportdataRAW.responseText);
        console.log(location.location)
    } catch (e) {
        console.log("error: failed to parse json");
    }
}
