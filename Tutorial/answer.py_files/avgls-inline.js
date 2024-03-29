/*  
    --------------------------------------------------------------------------
    avg linkscanner inline verdict info popup
    --------------------------------------------------------------------------
*/
var avg_ls_browserDetect = {
	init: function () 
	{
		this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
		this.version = this.searchVersion(navigator.userAgent)
			|| this.searchVersion(navigator.appVersion)
			|| "an unknown version";
	},
	searchString: function (data) 
	{
		for (var i=0;i<data.length;i++)	{
			var dataString = data[i].string;
			var dataProp = data[i].prop;
			this.versionSearchString = data[i].versionSearch || data[i].identity;
			if (dataString) {
				if (dataString.indexOf(data[i].subString) != -1)
					return data[i].identity;
			}
			else if (dataProp)
				return data[i].identity;
		}
	},
	searchVersion: function (dataString) 
	{
		var index = dataString.indexOf(this.versionSearchString);
		if (index == -1) return;
		return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
	},
	dataBrowser: 
	[
		{
			string: navigator.userAgent,
			subString: "Firefox",
			identity: "Firefox"
		},
		{
			string: navigator.userAgent,
			subString: "MSIE",
			identity: "Explorer",
			versionSearch: "MSIE"
		}
	]
};

avg_ls_browserDetect.init();

var avgls_iex = (avg_ls_browserDetect.browser.indexOf("Explorer") == 0) ? true : false;
var avgls_ff = (avg_ls_browserDetect.browser.indexOf("Firefox") == 0) ? true : false;


var skin = null		        // inline popup style
var minMarginToBorder = 15;	// minimal space to the next horizontal border
var inlineWidth = 0;           // inline width, specified in stylesheet

// initialize the capture pointer
if(avgls_ff) 
    document.addEventListener("mousemove", get_mouse, true);
if(avgls_iex) 
    document.onmousemove = get_mouse;

// assign style object when not already known
function assignInlineStyle() 
{
    var inlineDiv = document.getElementById('avg_ls_inline_popup');
    if (inlineDiv == null)
       return;

    skin = inlineDiv.style;
}
  
//getting the inlineWidth - we'll get this only once, too! 
//Then it will always have the stylesheet value
function assignInlineWidth()
{
    var inlineDiv = document.getElementById('avg_ls_inline_popup');
    if (inlineDiv == null)
       return;
       
  	if (avgls_iex )
        inlineWidth = parseInt(inlineDiv.currentStyle.width); 
        
	if (avgls_ff)  
	    inlineWidth = parseInt(document.defaultView.getComputedStyle(inlineDiv,null).getPropertyValue('width'));
}

// set dynamic coords when the mouse moves
function get_mouse(e)
{

  var inlineDiv = document.getElementById('avg_ls_inline_popup');
  if (inlineDiv == null)
    return;
    
  var x,y;
  var scroll_x_y = getScrollXY();
    
  //get X
  if (avgls_iex) 
    x = scroll_x_y[0] + event.clientX;
  if (avgls_ff) 
    x = e.pageX;

  //get Y
  if (avgls_iex) 
    y = scroll_x_y[1] + event.clientY;
    
  if (avgls_ff) 
    y = e.pageY;
  
  if (inlineWidth == 0) 
    assignInlineWidth();
    
  if (null == skin) 
    assignInlineStyle();

    // move the popup away from the mouse to avoid hover flicker  
    x += 10; 
    
  var x_y = nudge(x,y); // avoids edge overflow
  if (isNaN(x_y[0])) 
    x_y[0] = 0;
  if (isNaN(x_y[1])) 
    x_y[1] = 0;
  
  //now set coordinates for our popup - n_6 wants "px", the others not
  //remember: the popup is still hidden
  if(avgls_iex) 
  {
	  skin.left = x_y[0];
	  skin.top = x_y[1];
  }
  else if(avgls_ff)
  {
	  skin.left = x_y[0] + "px";
	  skin.top = x_y[1] + "px";
  }
}


// avoid edge overflow
function nudge(x,y)
{
  var inlineDiv = document.getElementById('avg_ls_inline_popup');
  if (inlineDiv == null)
     return;

  var dims = getInnerWindowDimensions();
  scroll_x_y = getScrollXY();
  
  // right
  var xtreme = dims[0] - inlineWidth - minMarginToBorder;
  if (avgls_ff) 
    xtreme -= 25;
  if(x > xtreme) 
  {
	x -= (parseInt(inlineWidth) + minMarginToBorder + 20 );
  }

  // left - should almost never be a problem - we're drawing the window 
  // to the right of the mouse per default (maybe corrected by the code above
  // but then this has the last horizontal word)
  if(x < 1) 
    x -=  x - 1;

  // when the mouse is too close to the bottom, move it up.
  est_lines = parseInt(inlineDiv.innerHTML.length / (parseInt(skin.width)/15) );
  est_lines_to_decide = max(est_lines,2);

  if ((y + skin.height) > (dims[1] + scroll_x_y[1])) 
  {
    y -= skin.height + 20;
  }

  return [ x, y ];
}

// write verdict info and display the inline popup
function avg_ls_showinline(msg)
{
  var inlineDiv = document.getElementById('avg_ls_inline_popup');
  if (inlineDiv == null)
     return;
       
  if (inlineWidth == 0) 
    assignInlineWidth();
    
  if (null == skin) 
    assignInlineStyle();
  
  if (null != skin) 
  { // maybe the browser isn't ready
	  
	  if (!isNaN(inlineWidth)) 
	  { // fallback behaviour (for sthg that has been observed in IE7)
		if(avgls_iex)  
		    skin.width = inlineWidth;
		if(avgls_ff)  
		    skin.width = inlineWidth + "px";
	  } 
	  else 
	  {
		if(avgls_iex)  
		    skin.width = 300;
		if(avgls_ff)  
		    skin.width = 300 + "px";
	  }
					
      //write the verdict info in
      inlineDiv.innerHTML = msg;

      //make the popup visible
      skin.visibility ="visible";
      skin.display = "inline";
  }
}

// make content box invisible
function avg_ls_hideinline()
{
    if ( null != skin )
    {
        skin.visibility = "hidden";	//invisible
        skin.display = "none";	//invisible
    }
}

function getScrollXY() 
{
  var scrOfX = 0, scrOfY = 0;
  if( typeof( window.pageYOffset ) == 'number' ) 
  {
    //Netscape compliant
    scrOfY = window.pageYOffset;
    scrOfX = window.pageXOffset;
  } 
  else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) 
  {
    //DOM compliant
    scrOfY = document.body.scrollTop;
    scrOfX = document.body.scrollLeft;
  } 
  else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) 
  {
    //IE6 standards compliant mode
    scrOfY = document.documentElement.scrollTop;
    scrOfX = document.documentElement.scrollLeft;
  }
  return [ scrOfX, scrOfY ];
}

function getInnerWindowDimensions()
{
	var A;
	if (window.innerHeight !== undefined) 
	    A = [window.innerWidth,window.innerHeight]; // most browsers
	else
	{ // IE varieties
	  var D = (document.documentElement.clientWidth == 0)? document.body: document.documentElement;
	  A = [D.clientWidth,D.clientHeight];
	}
	return A;
}

function max(a,b)
{
    if (a>b) return a;
    else return b;
}

