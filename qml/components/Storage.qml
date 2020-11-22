import QtQuick 2.5
import QtQuick.LocalStorage 2.0

ListModel {
     id: model

     function __db()
     {
         return LocalStorage.openDatabaseSync("AirMeteoStation", "1.0", "METAR Offline Storage", 1000);
     }
     function __ensureTables(tx)
     {
         tx.executeSql('CREATE TABLE IF NOT EXISTS metars(station_id TEXT, name TEXT, location TEXT, country TEXT, raw_text TEXT, observation_time TEXT, temp_c TEXT, dewpoint_c TEXT, wind_dir_degrees TEXT, wind_speed_kt TEXT)', []);
     }

     function getMETARS() {
         var metars = [];
         __db().transaction(
             function(tx) {
                 __ensureTables(tx);
                 try {
                    var rs = tx.executeSql("SELECT * FROM metars", []);
                 }
                 catch(e) {
                    if(e.code === SQLException.DATABASE_ERR) {
                        console.warn('Database error:', e.message);
                    } else if(e.code === SQLException.SYNTAX_ERR) {
                        console.warn('Database version error:', e.message);
                    } else {
                        console.warn('Database unknown error:', e.message);
                    }

                  return false;
                 }
                 if (rs.rows.length > 0) {
                    for (var i = 0; i < rs.rows.length; ++i) {
                        var row = rs.rows.item(i);
                        metars.push(
                            {station_id: row.station_id, name: row.name, location: row.location, country: row.country, raw_text: row.raw_text, observation_time: row.observation_time, temp_c: row.temp_c, dewpoint_c: row.dewpoint_c, wind_dir_degrees: row.wind_dir_degrees, wind_speed_kt: row.wind_speed_kt}
                        );
                    }
                } else {
                    console.debug("Storage: No values for metars. Table existed?", tableExisted);
                }
             }
         )
         return metars;
     }

     function getMETAR(station_id) {
         var metars = [];
         __db().transaction(
             function(tx) {
                 __ensureTables(tx);
                 try {
                    var rs = tx.executeSql("SELECT * FROM metars WHERE station_id=?", [station_id]);
                 }
                 catch(e) {
                    if(e.code === SQLException.DATABASE_ERR) {
                        console.warn('Database error:', e.message);
                    } else if(e.code === SQLException.SYNTAX_ERR) {
                        console.warn('Database version error:', e.message);
                    } else {
                        console.warn('Database unknown error:', e.message);
                    }

                  return false;
                 }
                 if (rs.rows.length > 0) {
                    for (var i = 0; i < rs.rows.length; ++i) {
                        var row = rs.rows.item(i);
                        metars.push(
                            {station_id: row.station_id, name: row.name, location: row.location, country: row.country, raw_text: row.raw_text, observation_time: row.observation_time, temp_c: row.temp_c, dewpoint_c: row.dewpoint_c, wind_dir_degrees: row.wind_dir_degrees, wind_speed_kt: row.wind_speed_kt}
                        );
                    }
                } else {
                    console.debug("Storage: No values for metar. Table existed?", tableExisted);
                }
             }
         )
         return metars;
     }

     function cleanTable(table) {
         __db().transaction(
             function(tx) {
                 __ensureTables(tx);
                 try {
                    var rs = tx.executeSql('DELETE FROM ' + table);
                 }
                 catch(e) {
                    console.log('DB error in cleanTable function')
                    if(e.code === SQLException.DATABASE_ERR) {
                        console.warn('Database error:', e.message);
                    } else if(e.code === SQLException.SYNTAX_ERR) {
                        console.warn('Database syntax error:', e.message);
                    } else {
                        console.warn('Database unknown error:', e.message);
                    }

                    return false;
                }
             }
         )
         return true;
     }

     function saveMETAR(station_id, name, location, country, raw_text, observation_time, temp_c, dewpoint_c, wind_dir_degrees, wind_speed_kt) {
              __db().transaction(
                  function(tx) {
                      __ensureTables(tx);
                      tx.executeSql("INSERT OR REPLACE INTO metars VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [station_id, name, location, country, raw_text, observation_time, temp_c, dewpoint_c, wind_dir_degrees, wind_speed_kt]);
                  }
              )
          }
     function deleteMETARS(station_id) {
              __db().transaction(
                  function(tx) {
                      tx.executeSql("DELETE FROM metars WHERE station_id=?", [station_id]);
                  }
              )
          }
     function saveMETARS(metars) {
         if(!cleanTable('metars')) {
            return false;
         }
         for (var i = 0; i < metars.length; ++i) {
            var metar = metars[i];
            saveMETAR(metar.station_id, metar.name, metar.location, metar.country, metar.raw_text, metar.observation_time, metar.temp_c, metar.dewpoint_c, metar.wind_dir_degrees, metar.wind_speed_kt);
         }
         return true;
     }
}
