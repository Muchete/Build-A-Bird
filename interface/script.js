//special Parts
var specialParts = ["storchkopf", "helmspechtkopf", "palmkakadubeine", "bekassineschwanz", "schnurrvogelfluegel", "blaukopfschmetterlingbeine"]
var timer = 0;
var receivedString =[];
var lastReceivedString = ["yomoma"];




function findSpecialPart(column, bird, part) {
  if (specialParts.indexOf(bird + part) > -1) {
    console.log("is Special Part")
    $(column).children(".iconBox").css("background-color", "#6CC7B4")

  } else {
    console.log("is not Special Part")
    $(column).children(".iconBox").css("background-color", "white")

  }
}


function getContent(bird, part) {
  if (bird == "helmspecht") {

    if (part == "kopf") {
      return ("DER KOPF VOM SPECHT IST SPEZIELL");
    } else {
      return ("DER SPECHT SELBST IST NICHT SPEZIELL");
    }
  } else {
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
  $(column).children(".nameBox").children("h1").text(bird);
  $(column).children(".partBox").children("p").text(part);
  $(column).children(".contentBox").children("p").text(getContent(bird, part));
  $(column).children(".iconBox").children("img").attr("src", "icons/" + bird + "_" + part + ".png");
  $(column).children(".videoBox").children("video").children("source").attr("src", "videos/" + bird + ".mp4");
  $(column).children(".videoBox").children("video")[0].load();
}


//shiftr
var client = mqtt.connect('mqtt://webInterfaceReceiver:5cb2b5dcd6b32723@broker.shiftr.io', {
  clientId: 'interface'
});

client.on('connect', function() {
  console.log('client has connected!');

  client.subscribe('eventString');

  // client.unsubscribe('/example');

  // setInterval(function(){
  //   client.publish('/hello', 'world');
  // }, 1000);
});

client.on('message', function(topic, message) {
  receivedString = message.toString().split(",");
  resetTimer();
  console.log(receivedString);
});

function resetTimer(connector,bird,part){
  timer = 0;
};

//shiftr fertig.

setInterval(timerCount, 20);

function timerCount(){
  timer++;
  //console.log(timer);
  if (timer == 4 && receivedString != lastReceivedString) {
    client.publish("filteredString", receivedString[0]+","+receivedString[1]+","+receivedString[2]+","+receivedString[3]);
    changePart(receivedString[0], receivedString[1], receivedString[2]);
    lastReceivedString = receivedString;


  }
};
changePart("head", "none", "none");
changePart("feet", "none", "none");
changePart("wings", "none", "none");
changePart("tail", "none", "none");
