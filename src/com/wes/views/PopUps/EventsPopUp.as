package com.wes.views.PopUps
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.HomeEventTile;
	import com.wes.objects.EventsEventObj;
	
	public class EventsPopUp extends PopUp
	{
		private var tileArr : Array = new Array;
		private var _delay : Number;
		private var done :int = 0;
		
		
		public function EventsPopUp(_data:*)
		{	
			super(_data);
			var i : int;
			for each ( var eventObj : EventsEventObj in data){
				
				var tile : HomeEventTile = new HomeEventTile(eventObj);
				tile.beginX = (RootLevel.stage.stageWidth/2)-(tile.width/2);
				tile.x = 0-tile.width;
				tile.y = 25+i*(tile.height+20);
				tileArr.push(tile);
				addChild(tile);
				++i;
			}
		}
		
		
		override protected function intro () : void {
			_delay = 0;
			for each(var tile : HomeEventTile in tileArr) {
				TweenMax.to(tile, .5,{x:tile.beginX, delay:_delay, ease:Expo.easeOut});
				_delay += .3;
			}
			super.intro();
		}
		
		override protected function outro () : void {
			_delay = 0;
			for each(var tile : HomeEventTile in tileArr) {
				TweenMax.to(tile, .5,{x:RootLevel.stage.stageWidth, delay:_delay, ease:Expo.easeOut, onComplete:checkIfDone});
				_delay += .2;
			}
		}
		
		private function checkIfDone() : void {
			++done;
			if(done >= tileArr.length){
				for each(var tile : HomeEventTile in tileArr) {
					removeChild(tile);
				}
				super.outro();
			}
		}
	}
}