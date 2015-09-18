WorkerScript.onMessage = function(message){
    console.log("empezamos");
    var xhr = new XMLHttpRequest();
    var url = message.url;//"http://www.football-data.co.uk/mmz4281/1516/SP2.csv";
    xhr.open("GET", url, true);
    xhr.send(null);

    xhr.onreadystatechange = function(){
        console.log(xhr.readyState+"-"+xhr.status);
        if (xhr.readyState == 4 && xhr.status == 200){
            console.log("vamos");
            var allText = xhr.responseText;
            //processData(msg);
            var allTextLines = allText.split('\n');
            var headers = allTextLines[0].split(',');
            console.log(headers)
            console.log("------------------------------");
            console.log("------------------------------");
            var results ='[';

            for (var i=1; i<allTextLines.length; i++) {
                var data = allTextLines[i].split(',');
                if (typeof data[1] != "undefined"){
                    if (i>1)
                        results = results.concat(",");
                    results = results.concat("{");
                    results = results.concat('"div":"'+data[0]+'",');
                    results = results.concat('"date":"'+data[1]+'",');
                    results = results.concat('"homeTeam":"'+data[2]+'",');
                    results = results.concat('"awayTeam":"'+data[3]+'",');
                    results = results.concat('"fthg":"'+data[4]+'",');
                    results = results.concat('"ftag":"'+data[5]+'",');
                    results = results.concat('"ftr":"'+data[6]+'"');
                    results = results.concat("}")
                }
            }
            results = results.concat("]");
            console.log(results);
            //results = '[{"date":"22/08/15","homeTeam":"Alcorcon","awayTeam":"Mallorca","fthg":2,"ftag":0},{"date":"22/08/15","homeTeam":"Cordoba","awayTeam":"Valladolid","fthg":1,"ftag":0}]';
            var jsonResults = JSON.parse(results);
            console.log(jsonResults);
            WorkerScript.sendMessage({'matches': jsonResults});
        }
    }

}

function processData(allText) {
    var allTextLines = allText.split(/\r\n|\n/);
    var headers = allTextLines[0].split(',');
    var lines = [];

    for (var i=1; i<allTextLines.length; i++) {
        var data = allTextLines[i].split(',');
        if (data.length == headers.length) {

            var tarr = [];
            for (var j=0; j<headers.length; j++) {
                tarr.push(headers[j]+":"+data[j]);
            }
            lines.push(tarr);
        }
    }
    // alert(lines);
}
