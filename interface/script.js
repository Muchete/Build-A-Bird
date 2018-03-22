//special Parts
var specialParts = ["waldkauz" , "storchkopf", "helmspechtkopf", "palmkakadubeine", "bekassineschwanz", "schnurrvogelfluegel", "blaukopfschmetterlingbeine"]
var timer = 0;
var receivedString = ["wings","none","none","0"];
var lastReceivedString = ["yomoma"];




function findSpecialPart(column, bird, part) {
  if (specialParts.indexOf(bird + part) > -1) {
    console.log("is Special Part")
    //$(column).children(".iconBox").css("background-color", "#6CC7B4")

  } else {
    console.log("is not Special Part")
    $(column).children(".iconBox").css("background-color", "white")

  }
}


function getContent(bird, part) {
  if (bird == "helmspecht") {

    if (part == "kopf") {
      return ("Mit erheblichem Kraftaufwand und Ausdauer klopfen Spechte mit dem Schnabel gegen Baumstämme um Futter zu finden, Nisthöhlen zu zimmern, ihr Revier zu markieren oder Geschlechtspartner anzuziehen.");
    }
  }
  else if (bird == "storch"){
    if (part == "kopf") {
      return ("Er verständigt sich durch Klappern mit dem Schnabel, deshalb wird er auch Klapperstorch genannt. Geklappert wird zur Begrüßung des Partners am Nest und zur Verteidigung gegen Nestkonkurrenten. Auch beim Balzritual wird geklappert.");
    }
  }

  else if (bird == "blaukopfschmetterling"){
    if (part == "beine") {
      return ("«Dribbeln» – Die Schnurrvögel machen einen Paartanz, Zweige im Schnabel haltend. Hochgeschwindigkeitskameras zeigen, dass Ihre Füsse zwischen fünfundzwanzig und fünfzig Mal pro Sekunde klopfen.");
    }
  }

  else if (bird == "schnurrvogel"){
    if (part == "fluegel") {
      return ("«Flügeltöne» – Der Schnurrvogel erzeugt die hohen, «pieps»-artigen Töne mit seinen extrem modifizierten Sekundärschwingungen einen mechanischen Klang. Dieser Effekt ist als Sonation bekannt.");
    }
  }

  else if (bird == "waldkauz"){
    if (part == "fluegel") {
      return ("«Schnabelknappen» – Waldkäuze verfügen über ein grosses Lautrepertoire mit stark variierender Lautstärke und Klangfarbe. Sie verfügen über wenige Instrumentallaute wie das Schnabelknappen bei aggressiver Erregung.");
    }
  }

  else if (bird == "bekassine"){
    if (part == "schwanz") {
      return ("«Wummern» oder «Meckern» – ist ein Instrumentallaut, der durch die speziell versteiften, äusseren Steuerfedern erzeugt wird. Er ist während der Balzflüge vor allem in der Morgen- und Abenddämmerung zu hören.");
    }
    else if (part == "kopf") {
      return ("Mit ihrem langen Schnabel stochern die Bekassinen tief im Untergrund oder Wasser und schreiten dabei langsam vorwärts.");
    }
    else if (part == "beine") {
      return ("Die Bekassine mit ihren kräftigen Beinen haltet sich gerne in Hochmooren, Sumpfland, Nassbrachen und Feuchtwiesen auf.");
    }
    else if (part == "fluegel") {
      return ("Bekassinen sind sowohl Kurz- und Langstreckenzieher. Sie halten sich im Sommer in Nordeuropa auf und im Winter in Mitteleuropa oder sie ziehen sogar weiter bis zum Äquator.");
    }
  }

  else if (bird == "palmkakadu"){
    if (part == "schwanz") {
      return ("Der Palmkakadu hat einen langen Schwanz. Insgesamt hat er ein schwarzes Gefieder. Er bedeckt sein Körperkleid aber häufig mit Puder, so erscheint sein Gefieder blaugrau.");
    }
    else if (part == "kopf") {
      return ("Die Schwarzfärbung des Kakadus erfolgt erst in einem Lebensalter von achtzehn bis vierundzwanzig Monaten. Vorher ist er hornfarben. Seine Zunge ist auffällig rot-schwarz.");
    }
    else if (part == "beine") {
      return ("«Klopfgeräusche» – Mit Hilfe von Ästen, Steinen oder einem großen Samen schlagen sie auf einen abgestorbenen Baum und erzeugen damit hallende Klopfgeräusche. Es ist ein Markierverhalten.");
    }
    else if (part == "fluegel") {
      return ("Sein Flug wirkt schwerfällig. Dies ist auf die weit ausholenden Flügelschläge zurückzuführen. Er ist außerdem ein guter Segler und biegt im Segelflug die Flügel abwärts.");
    }
  }





  else {
    return ("vogel nicht gefunden")

  }
}



function changePart(connector, bird, part) {



  console.log("changePart with " + bird + part + " on " + connector);

  if (connector == "head") {
    var column = ".birdHead";
  } else if (connector == "feet") {
    var column = ".birdFeet";
  } else if (connector == "wings") {
    var column = ".birdWings";
  } else if (connector == "tail") {
    var column = ".birdTail";
  } else {
    console.log("!! connector name not recognized !!")
  }

  if (part == "none") {
    $(column).fadeOut("fast");


  } else {
    $(column).fadeIn("fast");
    makeChanges(column, bird, part);
  }

}

function makeChanges(column, bird, part) {
  console.log(column);
  findSpecialPart(column, bird, part);
  $(column).children(".iconBox").children("img").attr("src", "icons/" + bird + "_" + part + ".png");
  $(column).children(".contentBox").children("p").text(getContent(bird, part));


  $(column).children(".videoBox").children("video").children("source").attr("src", "videos/" + bird + ".mp4");
  $(column).children(".videoBox").children("video")[0].load();

  if (bird == "blaukopfschmetterling") {
    bird = "blaukopf-\nschmetterling";
  }
  if (bird == "storch") {
    bird = "weissstorch";
  }
  $(column).children(".nameBox").children("h1").text(bird);


  if (part == "fluegel") {
    part = "flügel";
  }
  $(column).children(".partBox").children("p").text(part);

}


//shiftr
var client = mqtt.connect('mqtt://webInterfaceReceiver:5cb2b5dcd6b32723@broker.shiftr.io', {
  clientId: 'interface'
});

client.on('connect', function() {
  console.log('client has connected!');

  client.subscribe('eventString');
  client.subscribe('activeSound');
  // client.unsubscribe('/example');

  // setInterval(function(){
  //   client.publish('/hello', 'world');
  // }, 1000);
});

client.on('message', function(topic, message) {
  if (topic == "eventString") {
    receivedString = message.toString().split(",");
    resetTimer();
    console.log(receivedString);
  }
  else if (topic == "activeSound") {
    soundVisual(message.toString());

  }

});

function resetTimer(connector, bird, part) {
  timer = 0;
};

//shiftr fertig.

setInterval(timerCount, 20);

function timerCount() {
  timer++;
  //console.log(timer);
  if (timer == 4 && receivedString != lastReceivedString) {
    client.publish("filteredString", receivedString[0] + "," + receivedString[1] + "," + receivedString[2] + "," + receivedString[3]);
    changePart(receivedString[0], receivedString[1], receivedString[2]);
    lastReceivedString = receivedString;


  }
};

function soundVisual(connector){
  if (connector == "head") {
    var column = ".birdHead";
  } else if (connector == "body") {
    var column = ".birdBody";
  } else if (connector == "feet") {
    var column = ".birdFeet";
  } else if (connector == "wings") {
    var column = ".birdWings";
  } else if (connector == "tail") {
    var column = ".birdTail";
  } else {
    console.log("!! connector name not recognized !!")
  }
  console.log(connector);
  $(column).children(".iconBox").children(".backgroundIcon").fadeIn(500).delay(200).fadeOut(1000);


}

changePart("head", "none", "none");
changePart("feet", "none", "none");
changePart("wings", "none", "none");
changePart("tail", "none", "none");
