package com.wes.views.PopUps
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Calendar.EventInfoPage;
	import com.wes.compontents.Calendar.EventTileScroller;
	import com.wes.events.CalendarEvent;
	import flash.display.Sprite;

	public class CalendarPopUp extends PopUp
	{

		private var _con : Sprite;
		
		private var eventInfopage : EventInfoPage = new EventInfoPage;
		
		private var tileSrcoll : EventTileScroller;
		
		private var eventPageOpen : Boolean = false;
	
		public function CalendarPopUp(_data:*) {
			super(_data);

			_con = new Sprite();
			_con.graphics.lineStyle(3, 0xe08c1f);
			_con.graphics.beginFill(0x000000, 1);
			_con.graphics.drawRect(0, 0, 750, 400);
			_con.graphics.endFill();
			_con.alpha = 0 ;
			_con.x = (RootLevel.stage.stageWidth/2)-(_con.width/2);
			_con.y = (RootLevel.stage.stageHeight - RootLevel.stage.stageHeight)-_con.height;
			addChild(_con);
			
			tileSrcoll = new EventTileScroller(data);
			tileSrcoll.x = 10;
			tileSrcoll.y = 10;
			_con.addChild(tileSrcoll);
			
			eventInfopage.x = 10;
			eventInfopage.y  = 10;
			eventInfopage.alpha = 0;
			
			addEventListener(CalendarEvent.OPENEVENT, openEvent);
		}
		
		private function openEvent(event:CalendarEvent):void
		{
			eventPageOpen= true;
			removeEventListener(CalendarEvent.OPENEVENT, openEvent);
			addEventListener(CalendarEvent.CLOSEVENT, closeEvent);
			_con.addChild(eventInfopage);
			TweenMax.to(tileSrcoll, .5, {alpha : 0, onComplete:clean, onCompleteParams:[tileSrcoll]});
			TweenMax.to(eventInfopage, .5, {alpha : 1});
			eventInfopage.render(event.eventObj);
			
		}
		
		private function closeEvent(event:CalendarEvent):void
		{		
			eventPageOpen = false;
			removeEventListener(CalendarEvent.CLOSEVENT, closeEvent);
			addEventListener(CalendarEvent.OPENEVENT, openEvent);
			_con.addChild(tileSrcoll);
			TweenMax.to(eventInfopage, .5, {alpha : 0, onComplete:clean, onCompleteParams:[eventInfopage]});
			TweenMax.to(tileSrcoll, .5, {alpha : 1});
		}

		
		private function clean( i : *) : void {
			_con.removeChild(i);
		}
		
		override protected function intro () : void {
			super.intro();
			TweenMax.to(_con, .5, {y:(RootLevel.stage.stageHeight/2)-(_con.height/2), alpha : 1, ease:Expo.easeOut});
		}
		
		override protected function outro () : void {
			super.outro();
			if(eventPageOpen){removeEventListener(CalendarEvent.OPENEVENT, openEvent);} else {removeEventListener(CalendarEvent.OPENEVENT, closeEvent);}
			TweenMax.to(_con, .5, {y:RootLevel.stage.stageHeight + _con.height, alpha:0, ease:Expo.easeOut, onComplete:function():void{removeChild(_con);}});
		}
		
	}
}