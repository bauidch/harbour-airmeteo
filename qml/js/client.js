function httpGet(url) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", url, false);
    xmlHttp.send(null);
    return xmlHttp;
}

function get_metar() {
    var locationsRAW = httpGet("https://www.aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&stationString=LSZH&hoursBeforeNow=1&format=xml&mostRecent=true")

    console.log(locationsRAW)
    if (locationsRAW.status >= 200 && locationsRAW.status < 400) {
        console.log(locationsRAW)
        var domParser = new DOMParser();
        var xmlDocument = domParser.parseFromString(locationsRAW.responseText, "text/xml");
        console.log(xmlDocument)
    } else {
        console.log('error or no locations')
    }
}
