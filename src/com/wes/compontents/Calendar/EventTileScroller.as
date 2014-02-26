package com.wes.compontents.Calendar
{
	
	import com.wes.compontents.Calendar.EventTile;
	import com.wes.objects.EventsEventObj;

	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	
	public class EventTileScroller extends Sprite
	{
		
		private var _width : Number;
		private var _height : Number;
		
		private var masker : Shape;
		private var thumb : Sprite;
		private var track : Sprite;

		private var yOffset:Number;
		private var yMin:Number = 0;
		private var yMax:Number = 0;
		
		private var _con : Sprite;
		private var _array : Array;
		
		public function EventTileScroller(_arrayW : Array, _widthW : int = 720, _heightW : int = 380)
		{
			super();
			_array = _arrayW;
			_width = _widthW;
			_height = _heightW;

			buildCon();
			buildScrollBar();
			buildMasker();
			yMax = track.height - thumb.height;
			
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			_con.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			RootLevel.stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);

		}
		
		private function buildCon():void
		{
			_con = new Sprite();
			addChild(_con);
			var i : int;
			for each (var _tile : EventsEventObj in _array) {
				var tile : EventTile = new EventTile(_array[i]);
				tile.y = (tile.height + 10) * i ;
				_con.addChild(tile);
				++i;
			}
		}		
		
		private function buildMasker() : void {
			masker = new Shape;
			masker.graphics.beginFill(0x000000, 1);
			masker.graphics.drawRect(0,0, _width, _height);
			masker.graphics.endFill();
			_con.mask = masker;
			addChild(masker);
		}
		
		private function buildScrollBar():void {
			track = new Sprite();
			track.graphics.beginFill(0x000000, 0);
			track.graphics.drawRoundRect(0, 0, 10, _height, 30);
			track.graphics.endFill();
			track.mouseEnabled = false;
			track.x = _width + 5;
			addChild(track);
			
			thumb = new Sprite();
			thumb.graphics.beginFill(0xFFFFFF, 1);
			//Try find a way to ajusted the height based on the how much text there is
			thumb.graphics.drawRoundRect(0, 0, 10, 100, 20);
			thumb.graphics.endFill();
			thumb.buttonMode = true;
			thumb.x = _width + 5;
			addChild(thumb);
			
		}		
		
		private function thumbDown(event:MouseEvent):void {
			RootLevel.stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			yOffset = mouseY - thumb.y;
		}
		
		private function thumbMove(event:MouseEvent):void {
			thumb.y = mouseY - yOffset;
			
			if(thumb.y <= yMin){
				thumb.y = yMin;
			}
			if(thumb.y >= yMax){
				thumb.y = yMax;
			}
			
			
			var sp:Number = thumb.y / yMax;
			TweenMax.to(_con, 1, {y:(-sp*(_con.height-masker.height))});
			event.updateAfterEvent();
		}
		
		private function thumbUp(e:MouseEvent):void {
			RootLevel.stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
	}
}