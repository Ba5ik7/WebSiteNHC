package com.wes.events
{
	import com.wes.objects.EventsEventObj;
	
	import flash.events.Event;
	
	public class CalendarEvent extends Event
	{
		
		public static var OPENEVENT : String = "openEvent";
		public static var CLOSEVENT : String = "closeEvent";
		
		public var eventObj : EventsEventObj;
		
		public function CalendarEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}