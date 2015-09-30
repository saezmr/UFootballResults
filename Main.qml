import QtQuick 2.0
import Ubuntu.Components 1.2
import U1db 1.0 as U1db

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "ufootballresults.andprsoft"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true


    width: units.gu(45)
    height: units.gu(78)

    PageStack{
        id:pageStack
        Component.onCompleted: push(mainPage);
    }

    Page {
        id:mainPage
        title: i18n.tr("uResultadosFutbol")

        Item {
            id: columnaPrincipal
            anchors.fill:parent
            Button{
                id:btnResultBBVA
                anchors{
                    left: parent.left
                    right: parent.right
                    margins: units.gu(1)
                    //topMargin: units.gu(1)
                    //bottomMargin: units.gu(1)
                }

                text: "Resultados BBVA"
                color:UbuntuColors.blue
                font.bold: true
                onClicked: pageStack.push(Qt.resolvedUrl("qml/ResultadosBBVA.qml"));
            }
            Button{
                id: btnTableBBVA
                anchors{
                    top: btnResultBBVA.bottom
                    left: parent.left
                    right: parent.right
                    margins: units.gu(1)
                }
                color:UbuntuColors.blue
                text: "Clasificacion BBVA"
                font.bold: true
                onClicked: pageStack.push(Qt.resolvedUrl("qml/ClasificacionBBVA.qml"));
            }
            Button{
                id:btnResultsAdelante
                anchors{
                    top: btnTableBBVA.bottom
                    left: parent.left
                    right: parent.right
                    margins: units.gu(1)
                }
                text: "Resultados Adelante"
                color:UbuntuColors.orange
                font.bold: true
                onClicked: pageStack.push(Qt.resolvedUrl("qml/LigaAdelante.qml"));
            }
            Button{
                id:btnTableAdelante
                anchors{
                    top: btnResultsAdelante.bottom
                    left: parent.left
                    right: parent.right
                    margins: units.gu(1)
                }
                text: "Clasificacion Adelante"
                color:UbuntuColors.orange
                font.bold: true
                onClicked: pageStack.push(Qt.resolvedUrl("qml/ClasificacionAdelante.qml"));
            }
            Button{
                id:btnClearDatabase
                anchors{
                    top:btnTableAdelante.bottom
                    left: parent.left
                    right: parent.right
                    topMargin: units.gu(10)
                    margins: units.gu(1)
                }
                text: "Clear Database"
                onClicked: clearDatabase();
            }
        }

    }


    ////////////////////
    ///   DATABASE   ///
    ////////////////////
    function clearDatabase(){
        console.log("borramos database");
        var documentIDs = resultadosFutbolDB.listDocs();
        for (var x = 0; x< documentIDs.length; x++) {
            var doc = documentIDs[x];
            resultadosFutbolDB.deleteDoc(doc);
        }
        console.debug("borrada");
    }

    function addTableAdelante(rank, team, points, play, wins, draws, losses, GF, GA){
        console.log(rank+","+team+","+points+","+play+","+wins+","+draws+","+losses+","+GF+","+GA);
        resultadosFutbolDB.putDoc({"table": {"rank": rank,
                                          "team":team,
                                          "points":points,
                                          "play":play,
                                          "wins":wins,
                                          "draws":draws,
                                          "losses":losses,
                                          "GF":GF,
                                          "GA":GA}});
        console.log("row table added");
        return true;
    }

    function addResult(league, date, homeTeam, awayTeam, fthg, ftag, ftr){
        console.log(league+", "+date+", "+homeTeam+", "+awayTeam+", "+fthg+", "+ftag+", "+ftr);
        if (!resultExists(league, date, homeTeam, awayTeam)){
            resultadosFutbolDB.putDoc({"result": {"league":league,"date":date,"homeTeam":homeTeam,"awayTeam":awayTeam,"fthg":fthg,"ftag":ftag,"ftr":ftr}});
            console.debug("añadido!!");
        } else {
            console.debug("ya existe");
        }

        return true;
    }

    function resultExists(league, date, homeTeam, awayTeam){
        if (resultExistsAdelante(league, date, homeTeam, awayTeam) || resultExistsBBVA(league, date, homeTeam, awayTeam)){
            return true;
        } else {
            return false;
        }
    }

    function resultExistsBBVA(league, date, homeTeam, awayTeam){
        var existe = false;
        var index = 0;
        while (typeof resultsBBVAModelSinOrden.get(index).docId !== "undefined"){
            var sResult = JSON.stringify(resultsBBVAModelSinOrden.get(index));
            var result= JSON.parse(sResult);
            console.debug(result.contents.league+" == "+league+" && "+result.contents.date+" == "+date+" && "+result.contents.homeTeam+" == "+homeTeam+" && "+result.contents.awayTeam+" == "+awayTeam);
            if (typeof result.contents === "undefined"){
                break;
            } else if (result.contents.league == league && result.contents.date == date
                       && result.contents.homeTeam == homeTeam && result.contents.awayTeam == awayTeam){
                existe= true;
                break;
            }
            index++;
        }
        return existe;
    }

    function resultExistsAdelante(league, date, homeTeam, awayTeam){
        var existe = false;
        var index = 0;
        while (typeof resultsAdelanteModelSinOrden.get(index).docId !== "undefined"){
            var sResult = JSON.stringify(resultsAdelanteModelSinOrden.get(index));
            var result= JSON.parse(sResult);
            console.debug(result.contents.league+" == "+league+" && "+result.contents.date+" == "+date+" && "+result.contents.homeTeam+" == "+homeTeam+" && "+result.contents.awayTeam+" == "+awayTeam);
            if (typeof result.contents === "undefined"){
                break;
            } else if (result.contents.league == league && result.contents.date == date
                       && result.contents.homeTeam == homeTeam && result.contents.awayTeam == awayTeam){
                existe= true;
                break;
            }
            index++;
        }
        return existe;
    }

    function reloadTable(){
        console.log("caguendiox");
        var documents = clasificacionAdelanteQuery.results;
        for (var i = 0; i< documents.length; i++){
            console.log(i+"-"+documents[i].team);
        }

       // console.log("clasifica:"+documents);
    }

    // U1DB backend to record the last-picked station. Makes it faster for users to get information for their usual station.
     U1db.Database {
         id: resultadosFutbolDB
         path: "resultadosFutbolApp.u1db"
     }

     U1db.Index {
        database: resultadosFutbolDB
        id: tableIdx //row de clasificacion
        expression: ["table.rank", "table.team", "table.points", "table.play", "table.wins", "table.draws", "table.losses", "table.GF", "table.GA"]
    }

     U1db.Index {
        database: resultadosFutbolDB
        id: resultIdx //row de resultado
        expression: ["result.league", "result.date", "result.homeTeam", "result.awayTeam", "result.fthg", "result.ftag", "result.ftr"]
    }

     U1db.Query {
         id: resultsBBVAQuery
         index: resultIdx
         query: ["SP1", "*", "*", "*", "*", "*", "*"]
     }

     SortFilterModel {
         id:resultsBBVAModelSinOrden
         model: resultsBBVAQuery
     }

     U1db.Query {
         id: resultsAdelanteQuery
         index: resultIdx
         query: ["SP2", "*", "*", "*", "*", "*", "*"]
     }

     SortFilterModel {
         id:resultsAdelanteModelSinOrden
         model: resultsAdelanteQuery
     }

    U1db.Query {
        id: clasificacionAdelanteQuery
        index: tableIdx
        //query: "*"
    }

}


