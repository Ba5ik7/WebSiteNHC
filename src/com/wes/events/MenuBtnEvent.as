package com.wes.events {
	import flash.events.Event;

	/**
	 * @author root
	 */
	public class MenuBtnEvent extends Event {
		public static var BTNCLICK : String = "btnClick";
		
		public static var PAGECLOSE : String = "pageClose";
		public static var POPUPMENU : String = "popUpMenu";
		public static var POPUPOUTRO: String = "popUpOutro";
		public static var POPUPCLOSE : String = "popUpClose";
		
		public var name : String = "";
		public var menuText : String = "";
		public var kind : String = "";
		public var array : Array;
		
		public function MenuBtnEvent(type : String, 
									 bubbles : Boolean = true, 
									 cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}
}
