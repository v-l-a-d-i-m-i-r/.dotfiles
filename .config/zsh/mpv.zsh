function play() {
  function play_url() {
    mpv \
      --no-video \
      --ytdl-raw-options=yes-playlist= \
      "$1" \
      --term-playing-msg='\n ${media-title} \n' \
  }
 
  if [ ! -z "$1" ]; then
    play_url "$1";

    return;
  fi

  local songs='{
    "[01] Slow Blues & Blues-rock Ballads | Don`s Tunes": "https://www.youtube.com/playlist?list=PLoPLEt1InO1yqWjvZTytVAW7bVe__dM3l",
    "[02] Blues & Blues-Rock Best Of Playlist | Don`s Tunes": "https://www.youtube.com/playlist?list=PL2140A0411C65DD13",
    "[03] Красная Плесень — Памяти В. Цоя (Альбом 2021) HQ": "https://www.youtube.com/watch?v=d1SJ0o8_J2I",
    "[04] Виктор Цой и группа Кино - новое звучание 2021": "https://www.youtube.com/watch?v=qFpqlf5NsK8",
    "[05] Dan Caine Full Albums": "https://www.youtube.com/watch?v=bgdElh1EVHE&list=PLKSu0eRQUIZy8M4PBE2ZcpssywarVTZpf",
    "[06] Linkin Park Best Of": "https://www.youtube.com/watch?v=-YC8MVX3jUw",
    "[07] Песни которые не крутят по радио! Русский Хэви-метал!": "https://www.youtube.com/watch?v=oYUQX8wXIGM",
    "[08] Песни которые не крутят по радио! Русский Хэви-метал 2!": "https://www.youtube.com/watch?v=nz7v8141BmU",
    "[09] Песни которые не крутят по радио! Русский Хэви-метал 3!": "https://www.youtube.com/watch?v=PjnJBFxIaZE",
    "[10] Песни КОТОРЫЕ НЕ КРУТЯТ ПО РАДИО! Русский металл 4!": "https://www.youtube.com/watch?v=8vm1Q5VMrq4"
  }';
  local song_name=$(echo "${songs}" | jq 'keys[]' --raw-output | fzf --reverse);

  if [ -z "${song_name}" ]; then
    return;
  fi

  local song_url=$(echo "${songs}" | jq ".[\"${song_name}\"]" --raw-output);

  play_url "${song_url}";
}
