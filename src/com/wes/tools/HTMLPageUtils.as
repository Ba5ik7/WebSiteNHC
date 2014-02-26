package com.wes.tools
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class HTMLPageUtils
	{
		
		public static function viewPopup(_address:String, _wname:String = "popup", _width:int = 400, _height:int = 400, _toolbar:String = "no", _scrollbar:String = "no", _resizeable:String = "no"):void {
			var address:String = _address;
			var wname:String = _wname;
			var w:int = _width;
			var h:int = _height;
			var t:String = _toolbar;
			var s:String = _scrollbar;
			var r:String = _resizeable;
			var top:String = new String((RootLevel.stage.fullScreenHeight * .5) - (w*.5));
			var left:String = new String((RootLevel.stage.fullScreenWidth * .5) - (h*.5));

			var jscommand:String = "window.open('" + address + "','" + wname + "','height=" + h + ",width=" + w + ",toolbar=" + t + ",scrollbars=" + s + ",resizable=" + r + ",top="+ top + ",left=" + left + "' );";
			var url:URLRequest = new URLRequest("javascript:" + jscommand + " void(0);");
			try{
				navigateToURL(url,"_self");
			} catch (e:Error) {
				trace("Popup failed", e.message);
			}			
		}
		
	}
}