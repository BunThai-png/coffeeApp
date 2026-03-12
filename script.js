const songs = [
  "jYKftSF9U5M",
  "m_XUClQCOUc",
  "bu3xKd3sJO4",
  "C4NkCKGXJ44",
  "X7OUf6EOCzY",
  "sUKD_ul8H1g"
];

function playSong(){
  let random = songs[Math.floor(Math.random()*songs.length)];
  document.getElementById("player").innerHTML = `
    <iframe width="560" height="315"
      src="https://www.youtube.com/embed/${random}?autoplay=1"
      frameborder="0"
      allow="autoplay; encrypted-media"
      allowfullscreen>
    </iframe>`;
}