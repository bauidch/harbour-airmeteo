function httpGet(url) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", url, false);
    xmlHttp.send(null);
    return xmlHttp;
}

function get_location_length() {
    var locationsRAW = httpGet("https://themachine.jeremystucki.com/coop/api/v2/locations")

    try {
        var locations = JSON.parse(locationsRAW.responseText);
    } catch (e) {
        console.log("error: failed to parse week overview json");
    }
    if (locationsRAW.status >= 200 && locationsRAW.status < 400) {
        return locations.results.length;
    } else {
        console.log('error or no locations')
    }
}

function get_all_locations() {
    var locationsRAW = httpGet("https://themachine.jeremystucki.com/coop/api/v2/locations")

    try {
        var locations = JSON.parse(locationsRAW.responseText);
    } catch (e) {
        console.log("error: failed to parse json");
    }
    if (locationsRAW.status >= 200 && locationsRAW.status < 400) {

        var ret = [];
        for (var i = 0; i < locations.results.length; i++) {
            var cordi = locations.results[i].coordinates.coordinates
            ret.push({"name":locations.results[i].name, "id":locations.results[i].id, "zip":locations.results[i].address.zip, "city":locations.results[i].address.city, "longitude":cordi[0], "latitude":cordi[1]});
        }

        return ret;

    } else {
        console.log('error or no locations')
    }
}
