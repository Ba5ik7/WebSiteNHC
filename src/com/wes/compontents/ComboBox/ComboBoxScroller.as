package com.wes.compontents.ComboBox
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ComboBoxScroller extends Sprite
	{
		
		private var _width : Number;
		private var _height : Number;
		
		private var masker : Sprite;
		
		public var thumb : Sprite;
		public var track : Sprite;

		private var yOffset:Number;
		private var yMin:Number = 0;
		private var yMax:Number = 0;
		
		private var _con : Sprite;
		private var _array : Array;
		
		public function ComboBoxScroller(w : Number , h : Number , _arr : Array) {
			super();
			_width = w;
			_height = h;
			_array = _arr;
			
			buildCon();
			buildScrollBar();
			buildMasker();
			
			yMax = track.height - thumb.height;

			thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			RootLevel.stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
		}
		
		private function buildCon():void
		{
			_con = new Sprite();
			addChild(_con);
			var i : int = 0;
			for each (var _tile : ComboBoxListItem in _array) {
				_tile.y = i;
				_con.addChild(_tile);
				i += 25;
			}
		}	
		
		private function buildMasker() : void {
			masker = new Sprite;
			masker.graphics.beginFill(0x000000, 1);
			masker.graphics.drawRect(0,0, _width, _height);
			masker.graphics.endFill();
			//Mabe Fix
			this.mask = masker;
			addChild(masker);
		}
		
		private function buildScrollBar():void {
			track = new Sprite();
			track.graphics.beginFill(0x666666, 1);
			track.graphics.drawRoundRect(0, 0, 10, _height, 30);
			track.graphics.endFill();
			track.mouseEnabled = false;
			track.x = 205;
			track.alpha = 0;
			addChild(track);

			thumb = new Sprite();
			thumb.graphics.beginFill(0x000000, 1);
			//Try find a way to ajusted the height based on the how much text there is
			thumb.graphics.drawRoundRect(0, 0, 10, 25, 20);
			thumb.graphics.endFill();
			thumb.buttonMode = true;
			thumb.x = 205;
			thumb.alpha = 0;
			//thumb.alpha = 0;
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