//content

changePart("head","cockatoo","kopf");

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
  console.log(column);
  $(column).children(".iconBox").children("img").attr("src","icons/"+bird+"_"+part+".png");
  $(column).children(".nameBox").children("h1").text(bird);
  $(column).children(".partBox").children("p").text(part);
  $(column).children(".contentBox").children("p").text(getContent(bird,part));
  $(column).children(".iconBox").children("img").attr("src","icons/"+bird+"_"+part+".png");
  $(column).children(".videoBox").children("video").children("source").attr("src","videos/"+bird+".mp4");
  $(column).children(".videoBox").children("video")[0].load();





}
