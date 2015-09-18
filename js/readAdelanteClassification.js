WorkerScript.onMessage = function () {
    var xht = new XMLHttpRequest();
    var url = "http://www.football-data.co.uk/mmz4281/1516/SP2.csv";
    xht.open("GET", url, true);
    xht.send(null);

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

    xht.onreadystatechange = function (){
        //console.log(xht.readyState+"-"+xht.status);
        //console.log(xht.responseText)
        if (xht.readyState==4 && xht.status == 200){
            var resp = xht.responseText;
            var rows = resp.split("\n");
            //console.log(rows);
            for (var i=0; i<rows.length; i++){
//                console.log("linea");
                var items = rows[i].split(",");
                var Date = items[1];
                var HomeTeam = items[2];
                var AwayTeam = items[3];
                var FTHG = Number(items[4]);
                var FTAG = Number(items[5]);
                var FTR = items[6];// Full Time Result (H=Home Win, D=Draw, A=Away Win)
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

//                        console.log(equipos[e]);
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
//                        console.log(equipos[e]);
                    }
                }
            }
           /* var clasifica =[];
            for (e = 0; e<equipos.length; e++){
                clasifica[e]=[equipos[e][1], equipos[e]];
            }
            clasifica.sort(compareFunction(a,b));*/
            var clasifica = equipos;
            //console.log("a ordenar");
            clasifica.sort(function compareFunction(a, b){
               // console.log(a+"-"+b);
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
                WorkerScript.sendMessage({'clasifica': clasifica});
            }
        }

    }

}

