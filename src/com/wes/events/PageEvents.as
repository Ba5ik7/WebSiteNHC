package com.wes.events
{
	import flash.events.Event;
	
	public class PageEvents extends Event
	{
		public static var OUTRO_COMPLETE : String = new String("outroComplete");
		public static var MOVEMENT_COMPLETE : String = new String("movementComplete");
		
		public var name : String = "";
		
		public function PageEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}