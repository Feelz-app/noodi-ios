(function () {
  "use strict";

  var launchScreen = document.getElementById("launchScreen");
  var enterScreen = document.getElementById("enterScreen");
  var comingSoonScreen = document.getElementById("comingSoonScreen");
  var ageGate = document.getElementById("ageGate");
  var confirmAge = document.getElementById("confirmAge");
  var exitGate = document.getElementById("exitGate");
  var enterNoodi = document.getElementById("enterNoodi");
  var toast = document.getElementById("toast");
  var toastTimer = null;

  function showScreen(screen) {
    [launchScreen, enterScreen, comingSoonScreen].forEach(function (item) {
      item.classList.toggle("active", item === screen);
    });
  }

  function showToast(message) {
    toast.textContent = message;
    toast.classList.add("show");
    clearTimeout(toastTimer);
    toastTimer = setTimeout(function () {
      toast.classList.remove("show");
    }, 2200);
  }

  function openComingSoon(button) {
    button.classList.add("loading");
    button.textContent = "Opening...";
    window.setTimeout(function () {
      showScreen(comingSoonScreen);
      showToast("Web experience is coming soon");
    }, 220);
  }

  window.setTimeout(function () {
    ageGate.hidden = false;
    confirmAge.focus();
  }, 1800);

  confirmAge.addEventListener("click", function () {
    ageGate.hidden = true;
    showScreen(enterScreen);
  });

  exitGate.addEventListener("click", function () {
    ageGate.hidden = true;
    showToast("Confirmation is required to continue");
  });

  enterNoodi.addEventListener("click", function () {
    openComingSoon(enterNoodi);
  });

  if ("serviceWorker" in navigator) {
    window.addEventListener("load", function () {
      navigator.serviceWorker.register("./sw.js?v=44").catch(function () {});
    });
  }
})();
