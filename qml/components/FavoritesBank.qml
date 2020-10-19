import QtQuick 2.5
import QtQuick.LocalStorage 2.0

ListModel {
     id: model

     function __db()
     {
         return LocalStorage.openDatabaseSync("AirMeteoStation", "1.0", "Favorites Stations", 1000);
     }
     function __ensureTables(tx)
     {
         tx.executeSql('CREATE TABLE IF NOT EXISTS favorites(icao_code TEXT)', []);
     }

     function fillModel() {
         __db().transaction(
             function(tx) {
                 __ensureTables(tx);
                 var rs = tx.executeSql("SELECT icao_code FROM favorites ORDER BY icao_code DESC", []);
                 model.clear();
                 if (rs.rows.length > 0) {
                     for (var i=0; i<rs.rows.length; ++i) {
                         var row = rs.rows.item(i);
                         model.append({"icao_code":row.icao_code})
                     }
                 }
             }
         )
     }

     function addItem(location, location_id) {
              __db().transaction(
                  function(tx) {
                      __ensureTables(tx);
                      tx.executeSql("INSERT INTO favorites VALUES(?, ?)", [location, location_id]);
                      fillModel();
                  }
              )
          }
     function deleteItem(index, location) {
              __db().transaction(
                  function(tx) {
                      tx.executeSql("DELETE FROM favorites WHERE icao_code=?", [location]);
                      model.remove(index);
                  }
              )
          }



     Component.onCompleted: {
         fillModel();
     }
 }
