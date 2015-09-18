import QtQuick 2.0
import Ubuntu.Components 1.2

Page {
    id:mainPage
    title: i18n.tr("Clasificacion Adelante")

    Component.onCompleted: calculateTable();

    ListView{
        anchors.fill:parent
        model: clasificaModel;
        //model: clasificacionAdelanteModel //query de UDB1
        delegate: delegateClasifica;
        header: delegateHeader;

        footer: Rectangle {
            width: parent.width
            height: units.gu(1)
            color: "#333333"
        }
    }

    ListModel {
        id:clasificaModel;
    }

    Component {
        id:delegateHeader
        Item{
            anchors{
                left: parent.left
                right: parent.right
            }
            height: units.gu(3)
            Rectangle {
               width: parent.width
               height: units.gu(3)
               color: "#333333"
           }
            Label {
                id:hrRank
                text: " "
                width: units.gu(3)
                fontSize: "small"
                color: "white"
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:hrTeam
                text:"Team"
                fontSize: "small"
                color: "white"
                width: units.gu(12)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: hrRank.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:hrPoints
                text: "Pts"
                fontSize: "small"
                color: "white"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: hrTeam.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:hrPlay
                text: "P"
                fontSize: "small"
                color: "white"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: hrPoints.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:hrWins
                text: "W"
                fontSize: "small"
                color: "white"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: hrPlay.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:hrDraws
                text: "D"
                fontSize: "small"
                color: "white"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: hrWins.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:hrLosses
                text: "L"
                fontSize: "small"
                color: "white"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: hrDraws.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:hrGF
                text: "GF"
                fontSize: "small"
                color: "white"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: hrLosses.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:hrGA
                text: "GA"
                fontSize: "small"
                color: "white"
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: hrGF.right
                    right: parent.right
                    margins: units.gu(0.5)
                }
            }
        }
    }

    Component{
        id:delegateClasifica;
        Item{
            anchors{
                left: parent.left
                right: parent.right
            }
            height: units.gu(3)
            Label {
                id:txtRank
                text: rank;
                width: units.gu(3)
                fontSize: "small"
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    margins: units.gu(0.5)
                }
                color: {
                    if (index < 2) return "green";
                    else if (index < 6) return "blue";
                    else if (index > 17) return "red";
                    else txtTeam.color;
                }
            }
            Label {
                id:txtTeam
                text: team
                fontSize: "small"
                width: units.gu(12)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtRank.right
                    margins: units.gu(0.5)
                }
                color: {
                    if (index < 2) return "green";
                    else if (index < 6) return "blue";
                    else if (index > 17) return "red";
                    else txtTeam.color;
                }
            }
            Label {
                id:txtPoints
                text: points
                fontSize: "small"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtTeam.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:txtPlay
                text: play
                fontSize: "small"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtPoints.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:txtWins
                text: wins
                fontSize: "small"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtPlay.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:txtDraws
                text: draws
                fontSize: "small"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtWins.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:txtLosses
                text: losses
                fontSize: "small"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtDraws.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:txtGF
                text: GF
                fontSize: "small"
                width: units.gu(3)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtLosses.right
                    margins: units.gu(0.5)
                }
            }
            Label {
                id:txtGA
                text: GA;
                //width: units.gu(3)
                fontSize: "small"
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtGF.right
                    right: parent.right
                    margins: units.gu(0.5)
                }
            }
        }
    }

    function calculateTable(){
        console.debug("calculamos tabla");
        var equipos = [["Alcorcon",0,0,0,0,0,0,0],
                       ["Mallorca",0,0,0,0,0,0,0],
                       ["Cordoba",0,0,0,0,0,0,0],
                       ["Valladolid",0,0,0,0,0,0,0],
                       ["Huesca",0,0,0,0,0,0,0],
                       ["Alaves",0,0,0,0,0,0,0],
                       ["Llagostera",0,0,0,0,0,0,0],
                       ["Osasuna",0,0,0,0,0,0,0],
                       ["Almeria",0,0,0,0,0,0,0],
                       ["Leganes",0,0,0,0,0,0,0],
                       ["Gimnastic",0,0,0,0,0,0,0],
                       ["Albacete",0,0,0,0,0,0,0],
                       ["Mirandes",0,0,0,0,0,0,0],
                       ["Zaragoza",0,0,0,0,0,0,0],
                       ["Numancia",0,0,0,0,0,0,0],
                       ["Tenerife",0,0,0,0,0,0,0],
                       ["Oviedo",0,0,0,0,0,0,0],
                       ["Lugo",0,0,0,0,0,0,0],
                       ["Ponferradina",0,0,0,0,0,0,0],
                       ["Elche",0,0,0,0,0,0,0],
                       ["Ath Bilbao B",0,0,0,0,0,0,0],
                       ["Girona",0,0,0,0,0,0,0]];



        var resultados = resultsAdelanteQuery.results;
        for (var i = 0; i<resultados.length; i++){
            var Date = resultados[i].date;
            var HomeTeam = resultados[i].homeTeam;
            var AwayTeam = resultados[i].awayTeam;
            var FTHG = Number(resultados[i].fthg);
            var FTAG = Number(resultados[i].ftag);
            var FTR = resultados[i].ftr;// Full Time Result (H=Home Win, D=Draw, A=Away Win)
            for (var e = 0; e<equipos.length; e++){
                //0 nombre, 1 puntos, 2 jugados, 3 ganados, 4 empatados, 5 perdidos, 6 goles favor, 7 goles contra;
                if (equipos[e][0] === HomeTeam){
                    equipos[e][2] =equipos[e][2] +1;//jugados
                    if (FTR === 'H'){
                        equipos[e][1] = equipos[e][1] +3;
                        equipos[e][3] =equipos[e][3] +1;//ganados
                    } else if (FTR === 'D'){
                        equipos[e][1] = equipos[e][1] +1;
                        equipos[e][4] =equipos[e][4] +1;//empatados
                    } else {
                        equipos[e][5] =equipos[e][5] +1;//perdidos;
                    }

                    equipos[e][6] = equipos[e][6]+FTHG;
                    equipos[e][7] = equipos[e][7]+FTAG;

                } else if (equipos[e][0] === AwayTeam){
                    equipos[e][2] =equipos[e][2] +1;//jugados
                    if (FTR === 'A'){
                        equipos[e][1] = equipos[e][1] +3;
                        equipos[e][3] =equipos[e][3] +1;//ganados
                    } else if (FTR === 'D'){
                        equipos[e][1] = equipos[e][1] +1;
                        equipos[e][4] =equipos[e][4] +1;//empatados
                    } else {
                        equipos[e][5] =equipos[e][5] +1;//perdidos;
                    }
                    equipos[e][6] = equipos[e][6]+FTAG;
                    equipos[e][7] = equipos[e][7]+FTHG;
                }
            }
        }
        var clasifica = equipos;
        clasifica.sort(function compareFunction(a, b){
                    if (typeof a == 'undefined' || typeof b=='undefined')
                        return 0;
                    else if (a[1]>b[1]){
                        return -1;
                    } else if (a[1] < b[1]){
                        return 1;
                    } else {
                        var difA = a[6]-a[7];
                        var difB = b[6]-b[7];
                        if (difA > difB) return -1;
                        else if (difA < difB) return 1;
                        else if (a[6] > b[6]) return -1;//goles favor
                        else if (a[6] < b[6]) return 1;
                        else if (a[3] > b[3]) return -1;//ganados
                        else if (a[3] < b[3]) return 1;
                        else return 0;
                    }
                }
            );
        if (typeof clasifica != "undefined") {
            for (var i = 0; i<clasifica.length; i++){
                clasificaModel.append({"rank": i+1,
                                      "team": clasifica[i][0],
                                      "points": clasifica[i][1],
                                      "play":clasifica[i][2],
                                      "wins":clasifica[i][3],
                                      "draws":clasifica[i][4],
                                      "losses":clasifica[i][5],
                                      "GF": clasifica[i][6],
                                      "GA": clasifica[i][7]
                                  });
            }


        }

    }
/*
    WorkerScript{
        id:readCSV
        source: "../js/readAdelanteClassification.js"
        onMessage: {
            clearDatabase();
            var clasifica = messageObject.clasifica;
            //console.log("clasifica:"+clasifica);
            for (var i = 0; i<clasifica.length; i++){
                addTableAdelante(//rank, team, points, play, wins, draws, losses, GF, GA){
                                          i+1,
                                          clasifica[i][0],
                                          clasifica[i][1],
                                          clasifica[i][2],
                                          clasifica[i][3],
                                          clasifica[i][4],
                                          clasifica[i][5],
                                          clasifica[i][6],
                                          clasifica[i][7]);
                clasificaModel.append({
                                      "rank": i+1,
                                          "team": clasifica[i][0],
                                          "points": clasifica[i][1],
                                          "play":clasifica[i][2],
                                          "wins":clasifica[i][3],
                                          "draws":clasifica[i][4],
                                          "losses":clasifica[i][5],
                                          "GF": clasifica[i][6],
                                          "GA": clasifica[i][7]
                                      });
            }
        }

    }*/
}
