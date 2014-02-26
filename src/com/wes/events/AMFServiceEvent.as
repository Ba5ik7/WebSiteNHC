package com.wes.events
{
	import flash.events.Event;
	
	public class AMFServiceEvent extends Event
	{
		
		public static var ONCOMPLETE : String = "onComplete";
		
		public var data : Object;
		
		public function AMFServiceEvent(type : String, 
										bubbles : Boolean = false, 
										cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		
	}
}