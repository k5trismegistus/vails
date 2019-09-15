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

  $('#tag-input-button').off('click.tagsubmit')
  $('#tag-input-button').on('click.tagsubmit', (e) => {
    $('#tag-input-content')[0].value = ''
  })

  $('#video-player').on('loadedmetadata', (e) => {
    $('#video-height')[0].textContent = videoPlayer.videoHeight
    $('#video-width')[0].textContent = videoPlayer.videoWidth
  })
}

$(document).ready(init)
document.addEventListener("turbolinks:load", init)