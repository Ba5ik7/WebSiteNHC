package com.wes.views.Pages
{
	import com.greensock.TweenMax;
	import com.wes.compontents.Calendar.Calendar;

	
	public class Events extends Page
	{
		private var calendar:Calendar;
		
		public function Events(_data : *)
		{
			name = "events";
			super(_data);
			var _date:Date = new Date();
			
			calendar = new Calendar(_data);
			
			calendar.alpha =0;
			addChild(calendar);
			
			calendar.month = _date.getMonth();
			calendar.year = _date.getFullYear();
			calendar.Render();
		}
		
		override protected function render(_month : uint, _year : uint):void {
			calendar.month = _month;
			calendar.year = _year;
			calendar.Render();
		}
		
		override protected function intro () : void {
			TweenMax.to(calendar, .5,{alpha:1});
		}
		
		override protected function outro () : void {
			TweenMax.to(calendar, .5,{alpha:0, onComplete:clean});
		}
		
		private function clean():void{
			super.outro();
		}
	}
}