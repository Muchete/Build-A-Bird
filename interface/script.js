//special Parts
var specialParts = ["storchkopf","helmspechtkopf","palmkakadubeine","bekassineschwanz","schnurrvogelfluegel","blaukopfschmetterlingbeine"]







function findSpecialPart(column,bird,part){
  if (specialParts.indexOf(bird+part) > -1){
    console.log("is Special Part")
    $(column).children(".iconBox").css("background-color","#6CC7B4")

  }
  else{
    console.log("is not Special Part")
    $(column).children(".iconBox").css("background-color","white")

  }
}


function getContent(bird,part){
  if (bird == "helmspecht"){

    if(part == "kopf"){
      return("DER KOPF VOM SPECHT IST SPEZIELL");
    }
    else {
      return("DER SPECHT SELBST IST NICHT SPEZIELL");
    }
  }
  else {
    return("vogel nicht gefunden")

  }
}

function changePart(connector,bird,part){



  console.log("changePart with "+bird+part+" on "+connector);

  if (connector = "head"){
    var column = ".birdHead";
  }
  else if(connector = "feet"){
    var column = ".birdFeet";
  }
  else if(connector = "wings"){
    var column = ".birdWings";
  }
  else if(connector = "tail"){
    var column = ".birdTail";
  }
  else{
    console.log("!! connector name not recognized !!")
  }

  if (part=="none") {
    $(column).hide();
  }
  else{
    $(column).show();
  }

  console.log(column);
  findSpecialPart(column,bird,part);
  $(column).children(".iconBox").children("img").attr("src","icons/"+bird+"_"+part+".png");
  $(column).children(".nameBox").children("h1").text(bird);
  $(column).children(".partBox").children("p").text(part);
  $(column).children(".contentBox").children("p").text(getContent(bird,part));
  $(column).children(".iconBox").children("img").attr("src","icons/"+bird+"_"+part+".png");
  $(column).children(".videoBox").children("video").children("source").attr("src","videos/"+bird+".mp4");
  $(column).children(".videoBox").children("video")[0].load();





}

//shiftr
var client = mqtt.connect('mqtt://webInterfaceReceiver:5cb2b5dcd6b32723@broker.shiftr.io', {
  clientId: 'interface'
});

client.on('connect', function(){
  console.log('client has connected!');

  client.subscribe('connector');
  client.subscribe('part');
  client.subscribe('bird');
  // client.unsubscribe('/example');

  // setInterval(function(){
  //   client.publish('/hello', 'world');
  // }, 1000);
});

client.on('message', function(topic, message) {
  if (topic == "connector") {
    var receivedConnector = message.toString();
  }
  if (topic == "bird") {
    var receivedBird = message.toString();
  }
  if (topic == "part") {
    var receivedPart = message.toString();
  }

  changePart(receivedConnector,receivedBird,receivedPart);
  console.log('new message:', topic, message.toString());
});


//shiftr fertig.
