package com.wes.compontents
{
	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	
	
	public class TextScroller extends Fonts
	{
		private var _width : Number;
		private var _height : Number;

		private var masker : Shape;
		
		private var thumb : Sprite;
		private var track : Sprite;
		
		private var txt : TextField;
		
		private var yOffset:Number;
		private var yMin:Number = 0;
		private var yMax:Number = 0;

		
		private var _con : Sprite;
		
		public function TextScroller(w : Number , h : Number , _txt : String = null) {
			super();
			_width = w;
			_height = h;
			
			_con = new Sprite();
			addChild(_con);
			
			buildTextField(_txt);
			buildScrollBar();
			buildMasker();
			yMax = track.height - thumb.height;

			thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			txt.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			RootLevel.stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);

			
		}
		
		
		private function buildMasker() : void {
			masker = new Shape;
			masker.graphics.beginFill(0x000000, 1);
			masker.graphics.drawRect(0,0, _width, _height);
			masker.graphics.endFill();
			_con.mask = masker;
			addChild(masker);
		}
		
		private function buildTextField(htmlTxt:String) : void {
			txt = new TextField();
			txt.styleSheet = RootLevel.css;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.multiline = true;
			txt.htmlText = htmlTxt;
			txt.autoSize = "left";
			txt.width = _width;
			txt.wordWrap = true;
			txt.selectable = false;
			_con.addChild(txt);
			
			
		}
		
		public function render (htmlTxt:String) : void {
			txt.htmlText = htmlTxt;
		}
		
		private function buildScrollBar():void {
			track = new Sprite();
			track.graphics.beginFill(0x000000, 0);
			track.graphics.drawRoundRect(0, 0, 10, _height, 30);
			track.graphics.endFill();
			track.mouseEnabled = false;
			track.x = _width;
			addChild(track);
			
			thumb = new Sprite();
			thumb.graphics.beginFill(0x000000, 1);
			//Try find a way to ajusted the height based on the how much text there is
			thumb.graphics.drawRoundRect(0, 0, 10, 100, 20);
			thumb.graphics.endFill();
			thumb.buttonMode = true;
			thumb.x = _width;
			//thumb.alpha = 0;
			addChild(thumb);
			
		}		
		
		private function thumbDown(event:MouseEvent):void {
			//TweenMax.to(thumb, .5,{alpha:1});
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
			TweenMax.to(_con, 1, {y:(-sp*(txt.height-masker.height))});
			event.updateAfterEvent();
		}
		
		private function thumbUp(e:MouseEvent):void {
			//TweenMax.to(thumb, .5,{alpha:0});
			RootLevel.stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
	}
}