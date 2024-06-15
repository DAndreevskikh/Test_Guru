document.addEventListener('turbolinks:load', function() {
  const timerElement = document.getElementById('timer');

  if (timerElement) {
    let timeLeft = parseInt(timerElement.dataset.timeLeft, 10);
    const timeLeftTextTemplate = JSON.parse(timerElement.dataset.timeLeftText);
    const timeOutText = JSON.parse(timerElement.dataset.timeOutText);

    const timerInterval = setInterval(function() {
      if (timeLeft <= 0) {
        clearInterval(timerInterval);
        alert(timeOutText);
        document.forms[0].submit();
      } else {
        timeLeft -= 1;
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;
        timerElement.textContent = timeLeftTextTemplate.replace('%{minutes}', minutes).replace('%{seconds}', seconds < 10 ? '0' + seconds : seconds);
      }
    }, 1000);
  }
});
