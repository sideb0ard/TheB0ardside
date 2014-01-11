function nav() {
  alert("I am an alert box!");
}


var images = [
  "/static/img/cs/babbage.jpg",
  "/static/img/cs/adalovelace.jpg",
  "/static/img/cs/alanturing.jpg",
  "/static/img/cs/claudeshannon.jpg",
  "/static/img/cs/konradzuze.jpg",
  "/static/img/cs/vannevar_bush.jpg",
  "/static/img/cs/dougengelbart.jpg",
  "/static/img/cs/johnmccarthy.jpg",
  "/static/img/cs/dennisritchie.jpg",
  "/static/img/cs/kenthompson.jpg",
  "/static/img/cs/tednelson.jpg",
  "/static/img/cs/seymourcray.jpg",
  ];

var imgNum = 0;
var imgLength = images.length - 1;

function changeImage(direction) {
  imgNum = imgNum + direction;
  if (imgNum > imgLength) {
    imgNum = 0;
  }
  if (imgNum < 0) {
    imgNum = imgLength;
  }
  document.getElementById('cardboardscience').src = images[imgNum];
  return false;
}

Mousetrap.bind('right',  function() { changeImage(1); } );
Mousetrap.bind('left',  function() { changeImage(-1); } );
