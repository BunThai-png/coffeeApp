const songs = [
  "jYKftSF9U5M",
  "m_XUClQCOUc",
  "bu3xKd3sJO4",
  "C4NkCKGXJ44",
  "X7OUf6EOCzY",
  "sUKD_ul8H1g"
];

function playSong(){
  // random pick song
  let random = songs[Math.floor(Math.random()*songs.length)];

  // open YouTube video in new tab → autoplay works
  let url = `https://www.youtube.com/watch?v=${random}&autoplay=1`;
  window.open(url, "_blank");
}