function ch_log(f, l) { // Creates an image pointing to the log URL
	im = new Image();
	im.src = "http://labs.chitika.net/log.php?l=" + l + "&cl=" + escape(window.ch_client) + "&f=" + f;
	im.rem = function() {	// Creates a function for deleting log images
		try{
			delete im;
		}catch(e){} // We could try to log this case, but it would probably create an infinite loop.
	};
	window.onload = append_func(window.onload, im.rem); // Wait until the DOM is done loading, then delete
}

function append_func(o, a)
{
	return function (e) {
		if (typeof(o) == "function") { o(e); }
		return a(e);
	};
}


function Hash()
{
	this.length = 0;
	this.items = new Array();

	for(var i = 0; i < arguments.length; i += 2){
		if(typeof(arguments[i+1]) != "undefined"){
			this.items[arguments[i]] = arguments[i+1];
			this.length++
		}
	}

	this.remove = function(_k){
		var _p;
		if(typeof(this.items[_k]) != "undefined")
		{
			this.length--;
			_p = this.items[_k];
			delete this.items[_k];
		}

		return _p;
	}
	this.get = function(_k){
		return this.items[_k];
	}
	this.set = function(_k, _v){
		var _p;
		if(typeof(_v) != "undefined")
		{
			if(typeof(this.items[_k]) == "undefined")
			{
				this.length++;
			}else{
				_p = this.items[_k];
			}

			this.items[_k] = _v;
		}

		return _p;
	}
	this.has = function(_k){
		return (typeof(this.items[_k]) != "undefined");
	}
	this.clear = function(){
		for(var i in this.items)
		{
			delete this.items[i];
		}

		this.length = 0;
	}
}

_dictionary = {
	'alturl': "alturl",
	'w': "width",
	'h': "height",
	'type': "type",
	'nump': "nump",
	'sid': "sid",
	'cl_site_link': "color_site_link",
	'cl_title': "color_title",
	'cl_border': "color_border",
	'cl_text': "color_text",
	'cl_bg': "color_bg",
	'client': "publisher",
	'fluidH' : "fluidH",
	'cpm_floor' : "cpm_floor"
};

function aue(_k, _v)
{
	return _k + "=" + escape(_v);
}

function ch_ad_render_search()
{
	if(g_oPreview)
	{
		g_oPreview.Draw();
	}
}

////////////////////////////////////////////////////////////////
// ch_create_iframe
//
// Creates an iframe object with some standard settings, along
// with a handful of useful parameters that can be passed in.
//
function ch_create_iframe(sSrc, nWidth, nHeight, sName, sClass, sDisplay)
{
	if(typeof(sDisplay) == "undefined") sDisplay = "block";
	if(typeof(sClass) == "undefined") sClass = "";
	if(typeof(sName) == "undefined") sName = "";
	if(typeof(nHeight) == "undefined" || typeof(nHeight) == "string") nHeight = 0;
	if(typeof(nWidth) == "undefined") nWidth = 0;
	if(typeof(sSrc) == "undefined") sSrc = "about:blank";

	var _f = document.createElement("iframe");
	_f.src = sSrc;
	_f.width = nWidth;
	_f.height = nHeight;
	_f.frameborder = 0;
	_f.style.width = "" + nWidth + "px";
	_f.style.height = "" + nHeight + "px";
	if(sName) _f.name = sName;
	if(sClass) _f.className = sClass;
	_f.style.display = sDisplay;

	_f.style.border = "0";
	_f.style.margin = "0";
	_f.style.padding = "0";
	_f.setAttribute("vspace", "0");
	_f.setAttribute("hspace", "0");
	_f.setAttribute("scrolling", "no");
	_f.setAttribute("marginWidth", "0");
	_f.setAttribute("marginHeight", "0");
	_f.setAttribute("border", "0");
	_f.setAttribute("frameborder", "0");
	_f.setAttribute("frameBorder", "0");
	_f.setAttribute("allowTransparency", "allowTransparency");

	return _f;
}

function dq(_s)
{
	return "\"" + _s + "\"";
}

function Preview()
{
	/*this.m_uriHost;
	this.m_uriAd;
	this.m_htParams;
	this.m_htColors;
	this.m_dTarget;
	this.m_rCB;
	this.m_sPrev;
	this.m_fPrev;
	this.m_sCode;*/

	this.Init = function(_id)
	{
		this.m_uriHost = document.location.protocol + "//" + document.location.host;
		this.m_uriAd = this.m_uriHost + "/ad-setup/preview?";
		this.m_htParams = new Hash();
		this.m_htColors = new Hash();
		this.m_dTarget = document.getElementById(_id);
		this.m_rCB = 0;
		this.m_sPrev = null;
		this.m_fPrev = null;
		this.m_sCodePre = "<script type=\"text/javascript\"> "
            + "\n  ( function() {"
            + "\n    if (window.CHITIKA === undefined) {"
            + "\n      window.CHITIKA = { 'units' : [] };"
            + "\n    };"
            + "\n    var unit = {\n";
		this.m_sCodePost = "    };"
            + "\n    var placement_id = window.CHITIKA.units.length;"
            + "\n    window.CHITIKA.units.push(unit);"
            + "\n    document.write('<div id=\"chitikaAdBlock-' + placement_id + '\"></div>');"
            + "\n    var s = document.createElement('script');"
            + "\n    s.type = 'text/javascript';"
            + "\n    s.src = 'http://scripts.chitika.net/getads.js';"
            + "\n    try {"
            + "\n      document.getElementsByTagName('head')[0].appendChild(s);"
            + "\n    } catch(e) {"
            + "\n      document.write(s.outerHTML);"
            + "\n    }"
            + "\n}());"
            + "\n</script>";
    }

	this.Fetch = function()
	{
		this.m_dTarget.style.width = this.m_htParams.get("w") + "px";

		if(this.m_fPrev)
		{
			_prev = document.getElementById(this.m_fPrev);
			if(_prev){
				this.m_dTarget.removeChild(_prev);
			}
		}

		if(this.m_htParams.get("type") != "mobile")
		{
			_head = document.getElementsByTagName("head")[0];
			_uri = this.m_uriAd;
			_b = false;
			for(var _k in this.m_htParams.items)
			{
				if(typeof(this.m_htParams.get(_k)) == "function") continue;
				if(_b)
				{
					_uri += "&";
				}
				_uri += aue(_k, this.m_htParams.get(_k));
				_b = true;
			}
			if(this.m_sPrev) _head.removeChild(this.m_sPrev);
			var _s = document.createElement("script");
			_s.type = "text/javascript";
			_s.src = _uri;
			_head.appendChild(_s);
			this.m_sPrev = _s;
		}else{
			this.m_htParams.set("w", 320);
			this.m_htParams.set("h", 50);
			_id = "mobilePreview";
			_ctr = document.createElement("div");
			_ctr.setAttribute("id", _id);
			_img = document.createElement("img");
			_img.setAttribute("src", "/img/ad_setup/mobile.jpg");
			_ctr.appendChild(_img);
			this.m_dTarget.appendChild(_ctr);
			this.m_fPrev = _id;
		}
	}

	this.Code = function()
	{
		_s = this.m_sCode;
		_cl = "";
		var unit_params = [];

		
		for(var _k in this.m_htParams.items)
		{
			if(typeof(this.m_htParams.get(_k)) == "function") continue;
			if(typeof(_dictionary[_k]) != "undefined")
			{
				_v = this.m_htParams.get(_k);
				if(typeof(_v) == "string") _v = dq(_v);
				unit_params.push("      '" + _dictionary[_k] + "'" + " : " + _v);
			}
		}

		return this.m_sCodePre + unit_params.join(",\r\n") + "\r\n" + this.m_sCodePost;
	}

	this.Draw = function()
	{
		_id = "chitikaPreview";
		if(!document.getElementById(_id)) {
		_f = ch_create_iframe("about:blank", this.m_htParams.get("w"), this.m_htParams.get("h"));
		_f.setAttribute("id", _id);
		_f.bResizeSet = false;
		}else{
			_f = document.getElementById(_id);
		}
		try{
			_f.contentWindow.document.designMode = "on";
		}catch(e){
		}

		var w = window;
		var ch_resize_height = function() {

			try{
				if(!_f.bResizeSet) {
					if(window.addEventListener){
						_f.contentWindow.onresize = append_func(_f.contentWindow.onresize, _f.onload);
					}else{
						_f.contentWindow.attachEvent("onresize", _f.onload);
					}
					_f.bResizeSet = true;
				}
				_f.style.height = "" + (_f.contentWindow.document.body.scrollHeight) + "px";
			}catch(e){
				//ch_log(("" + wpx + "xAuto"), e);
			}
			return true;
		};

		if(this.m_htParams.get("fluidH")) {
			if(window.addEventListener){ // This is the standardized method, but...
				_f.onload = append_func(_f.onload, ch_resize_height); // We can assign functions directly
				w.onresize = append_func(w.onresize, ch_resize_height);
			}else{ // IE doesn't use the standardized function
				_f.attachEvent("onload", append_func(_f.onload, ch_resize_height)); // And we have to use attachEvent, because it doesn't like
				_f.resize = ch_resize_height;
				w.attachEvent("onresize",  append_func(w.onreszize, ch_resize_height)); // direct assignment of onload.
			}
		}


		this.m_dTarget.appendChild(_f);
		if(this.m_htParams.get("type") == "mobile") {
			return false;
		}else{
			_code = window.ch_mmhtml['output'];
			_code = _code.replace(/\"http:\/\/scripts\.chitika\.net\/screenshots\/thumbnail\.php\?(.*)\"/mg, '"/ad-setup/thumbnail?$1"');
		}

		var _d = _f.contentWindow.document; // Acquire a reference to it's inner document
		_d.open(); // Presumably allows us to edit the contents of the iframe
		_d.write(_code); // So we do
		_d.close(); // Disable the editing of the document.
		if(_f.resize) _f.resize();

		this.m_fPrev = _id;
	}

	this.Set = function(_k, _v)
	{
		this.m_htParams.set(_k, _v);
	}
	this.SetColor = function(_k, _v)
	{
		this.m_htColors.set(_k, _v);
	}

	this.Clear = function()
	{
		this.m_htParams.clear();
		this.m_htColors.clear();
	}
}

function ParseForm(_f, _o, _b)
{
	if(_f && _o)
	{
		_o.Clear();

		if(typeof(_f.slcFormat) != "undefined")
		{
			_t = _f.slcType.value;
			_fmt = _f.slcFormat.value;
			if(_t == "mobile")
			{
				if(!this.m_bMobileSelected);
				this.m_bMobileSelected = true;
				_f.slcFormat.disabled = true;
				_f.slcFormat.selectedIndex = 0;
			}else if(_t == "map"){
				if(this.m_prevType != _t) {
					_f.slcFormat.disabled = false;
					_f.slcFormat.options.length = 0;

					_c = 0;
					for(_k in g_aMaps)
					{
						if(typeof(g_aStandard[_k]) != "string") continue;
						_f.slcFormat.options[_c] = new Option(g_aMaps[_k], _k);
						if(g_aMaps[_k] == "") _f.slcFormat.options[_c].disabled = true;
						_c++;
					}
				}
			}else{
				_f.slcFormat.disabled = false;
				if(this.m_prevType != _t)
				{
					_f.slcFormat.options.length = 0;

					_c = 0;
					for(_k in g_aStandard)
					{
						if(typeof(g_aStandard[_k]) != "string") continue;
						_f.slcFormat.options[_c] = new Option(g_aStandard[_k], _k);
						if(g_aStandard[_k] == "") _f.slcFormat.options[_c].disabled = true;
						_c++;
					}
				}
			}
			this.m_prevType = _t;
			if(_t == "map" && !this.m_bMapAlert) {
				this.m_bMapAlert = true;
			}
			_fmt = _f.slcFormat.value;
			_w = 1 * (_fmt.replace(/([0-9]+)x([0-9]+)/, "$1"));
			_h = 1 * (_fmt.replace(/([0-9]+)x([0-9]+)/, "$2"));
		}else{
			_w = 1 * (_f.txtWidth.value.replace(/[^0-9]/g, ''));
			if(_w < 200) _w = 200;
			if(_w > 600) _w = 600;
			_h = "auto";
			_t = "mpu";
			_o.Set("fluidH", 1);
			_o.Set("nump", _f.slcAds.value);
		}

		this.m_rCB = Math.round(Math.random() * 1000);

		_o.Set("client", _f.txtUser.value);
		_o.Set("w", _w);
		_o.Set("h", _h);
		_o.Set("type", _t);
		_o.Set("sid", _f.txtChannel.value);
		_o.Set("output", "simplejs");
		_o.Set("callback", "ch_ad_render_search");
		_o.Set("ip", "us");
		_o.Set("test", 1);
		_o.Set("ref", "http://www.google.com/search?q="+encodeURIComponent(_f.query.value));
		_o.Set("url", "www.lipsum.com");
		_o.Set("demomode", 1);
		_o.Set("cb", this.m_rCB)
		_o.Set("provider", "yahoosearch");

		if(_t == "mobile")
		{
			_o.Set("w", 320);
			_o.Set("h", 480);
		}

		if(_f.txtLink && _f.txtLink.value != "")
		{
			_o.Set("cl_site_link", _f.txtLink.value);
			_o.Set("cl_title", _f.txtLink.value);
		}

		if(_f.txtBorder && _f.txtBorder.value != "")
		{
			_o.Set("cl_border", _f.txtBorder.value);
		}

		if(_f.txtText && _f.txtText.value != "")
		{
			_o.Set("cl_text", _f.txtText.value);
		}

		if(_f.txtBackground && _f.txtBackground.value != "")
		{
			_o.Set("cl_bg", _f.txtBackground.value);
		}
		if(_f.txtAlternate && _f.txtAlternate.value != "")
		{
			_o.Set("alturl", _f.txtAlternate.value);
		}
		if(_f.cpm_floor && _f.cpm_floor.value != "" && _f.cpm_floor.value != "0.00")
		{
			_o.Set("cpm_floor", _f.cpm_floor.value);
		}

		if(!_b)
		{
			_o.Fetch();
		}
		_f.txtCode.value = _o.Code();
		//document.getElementById('widgetContent').value = _o.Code();
		if(_f.txtWidth) _f.txtWidth.value = _w;
	}
}
