import QtQuick 2.5
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
import "pages"
import "components"
import "./js/client.js" as Client

ApplicationWindow
{
    initialPage: Component { OverviewPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    Component.onCompleted: {
       loadMETARSFromStorageToModel()
    }

    Storage {
        id: metarBank
    }

    ListModel {
        id: metarModel
    }

    function loadMETARSFromStorageToModel() {
        var metars = metarBank.getMETARS()
        for (var i = 0; i < metars.length; ++i) {
            console.log("Load Metars to Model: ",  metars[i].station_id)
            metarModel.append(
            {
                station_id: metars[i].station_id,
                name: metars[i].name,
                location: metars[i].location,
                country: metars[i].country,
                raw_text: metars[i].raw_text,
                observation_time: metars[i].observation_time,
                temp_c: metars[i].temp_c,
                dewpoint_c: metars[i].dewpoint_c,
                wind_dir_degrees: metars[i].wind_dir_degrees,
                wind_speed_kt: metars[i].wind_speed_kt
            }
            )
       }
    }

    function reloadMetarsData() {
        metarModel.clear()
        loadMETARSFromStorage()
    }

    function updateMetarsToStorage() {
        var metars = metarBank.getMETARS()
        for (var i = 0; i < metars.length; ++i) {
           loadDataToStorage(metars[i].station_id)
       }
    }

    function loadDataToStorage(station_id) {
        python.call('airdata.getMetar', [station_id], function(result) {
            if (result.length <= 0) {
               console.log('QML Debug: No Data')
            }

            for (var i=0; i<result.length; i++) {
                if (result[i].type === "raw_text") {
                    var raw_text =  result[i].value
                }

                if (result[i].type === "temp_c") {
                    var temp_c =  result[i].value
                }
                if (result[i].type === "dewpoint_c") {
                    var dewpoint_c = result[i].value
                }
                if (result[i].type === "wind_dir_degrees") {
                    var wind_dir_degrees = result[i].value
                }
                if (result[i].type === "wind_speed_kt") {
                    var wind_speed_kt = result[i].value
                }

                if (result[i].type === "observation_time") {
                    var observation_time = result[i].value
                }
            }

            var data = Client.getAirportData(station_id)

            var metars = []
            metars.push({
                station_id: station_id,
                name: data[0].name,
                location: data[0].location,
                country: data[0].country,
                raw_text: raw_text,
                observation_time: observation_time,
                temp_c: temp_c,
                dewpoint_c: dewpoint_c,
                wind_dir_degrees: wind_dir_degrees,
                wind_speed_kt: wind_speed_kt
            })
            console.log(metars)
            console.log(metars[0].station_id, metars[0].name, metars[0].raw_text)
            metarBank.saveMETARS(metars)

        });

    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./pages/.'));
            importModule('airdata', function () {});
        }

        onError: {
            console.log('python error: ' + traceback);
        }

    }
}
