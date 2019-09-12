const init = () => {
  const videoPlayer = $('#video-player')[0]

  $('.player-control-button.back').off('click.playback')
  $('.player-control-button.back').on('click.playback', (e) => {
    videoPlayer.currentTime -= parseInt(e.target.value)
  })

  $('.player-control-button.forward').off('click.playforward')
  $('.player-control-button.forward').on('click.playforward', (e) => {
    videoPlayer.currentTime += parseInt(e.target.value)
  })
}

$(document).ready(init)
document.addEventListener("turbolinks:load", init)