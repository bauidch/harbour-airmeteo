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


    Storage {
        id: metarBank
    }

    ListModel {
        id: metarModel
    }

    function checkForDBMaitanance() {
       metarBank.checkDB()
    }

    function loadMETARSFromStorageToModel() {
        var metars = metarBank.getMETARS()
        for (var i = 0; i < metars.length; ++i) {
            metarModel.append(
            {
                station_id: metars[i].station_id,
                name: metars[i].name,
                location: metars[i].location,
                country: metars[i].country,
                view_position:  metars[i].view_position,
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
        loadMETARSFromStorageToModel()
    }

    function updateMetarsToStorage() {
        var metars = metarBank.getMETARS()
        for (var i = 0; i < metars.length; ++i) {
            var station_id = metars[i].station_id
            python.call('airdata.getMetar', [station_id], function(result) {
                if (result.length <= 0) {
                   console.log('QML Debug: No Data')
                }

                for (var a=0; a<result.length; a++) {
                    if (result[a].type === "station_id")
                        var station_id = result[a].value
                    if (result[a].type === "raw_text") {
                        var raw_text = result[a].value
                    }
                    if (result[a].type === "temp_c") {
                        var temp_c = result[a].value
                    }
                    if (result[a].type === "dewpoint_c") {
                        var dewpoint_c = result[a].value
                    }
                    if (result[a].type === "wind_dir_degrees") {
                        var wind_dir_degrees = result[a].value
                    }
                    if (result[a].type === "wind_speed_kt") {
                        var wind_speed_kt = result[a].value
                    }
                    if (result[a].type === "observation_time") {
                        var observation_time = result[a].value
                    }
                }
                metarBank.updateMETAR(station_id, raw_text, observation_time, temp_c, dewpoint_c, wind_dir_degrees, wind_speed_kt)

            });
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

            metarBank.saveMETAR(station_id, data[0].name, data[0].location, data[0].country, raw_text, observation_time, temp_c, dewpoint_c, wind_dir_degrees, wind_speed_kt)

            metarModel.append(
            {
                station_id: station_id,
                name: data[0].name,
                location: data[0].location,
                country:  data[0].country,
                view_position: 0,
                raw_text: raw_text,
                observation_time: observation_time,
                temp_c: temp_c,
                dewpoint_c: dewpoint_c,
                wind_dir_degrees: wind_dir_degrees,
                wind_speed_kt: wind_speed_kt
            }
            )

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
