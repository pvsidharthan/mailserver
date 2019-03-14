var pageTracker = _gat._getTracker(hc_urchin);
pageTracker._setCookiePath(cookie_path);
var vidList = {}; 
var vidFirstPlayList = new Array(); //track only first time user clicks play

/**
  * Backwards-compatibility w/ urchinTracker
  *
  * @param {string} url The URL to track
  */

function urchinTracker(url) {
  pageTracker._trackPageview(url);
  cookiePathCopy();
}


/**
  * General function for tracking outgoing links
  * Category is set to 'Outgoing' so that they all show up under
  * the 'Outgoing' category in Analytics
  *
  * @param {string} link The link to track
  * @param {string} opt_url URL to get after tracking
  */
function trackOutgoing(link, opt_url) {
  track('Outgoing', link, opt_url);
}


/**
  * General function for tracking links
  *
  * @param {string} category The category for the link (i.e., 'Left Nav')
  * @param {string} link The link to track
  * @param {string} opt_url URL to get after tracking
  */
function track(category, link, opt_url) {
  pageTracker._trackEvent(category, link, hc_page_info + ' hl=' + hc_lang);
  cookiePathCopy();

  // If URL is specified, redirect to that URL
  if(opt_url) {
    setTimeout('document.location = "' + opt_url + '"', 100);
  }

  if (window.this_url === undefined) {
    var this_url = document.location.href;
  }
  if (this_url.indexOf("debug=eventtracking") > 1 && internal) {
    alert("category: " + category + "\naction: " + link + "\n" +
        "hc_page_info: " + hc_page_info + "\n" +
        "hl: " + hc_lang);
  }
}


/**
  * Tracking a click on the play button in an embedded YouTube video
  * Called from the YouTube player
  *
  * @param {string} trackingId The id of the video to track
  */
function onYouTubePlayerReady(trackingId) { 
  var ytplayer = document.getElementById(trackingId); 
  vidFirstPlayList[trackingId] = 0;
  vidList[trackingId] = function(newState) { 
    if(newState == 1 && !vidFirstPlayList[trackingId]) { 
      track('Videos', trackingId);
      vidFirstPlayList[trackingId] = 1;
    }
  };
  ytplayer.addEventListener('onStateChange', 'vidList.' + trackingId); 
}

/**
  * Helper function for copying Analytics cookie data to other paths
  * Call after pageTracker tracking events.
  */
function cookiePathCopy() {
  // cookiePathArray is set in urchin_util.cs
  for (var i = 0; i < cookiePathArray.length; i++) {
    pageTracker._cookiePathCopy(cookiePathArray[i]);
  }
}
