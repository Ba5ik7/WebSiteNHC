package com.wes.views.PopUps
{
	import com.greensock.TweenMax;
	import com.wes.compontents.Fonts;
	import com.wes.events.MenuBtnEvent;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PopUp extends Fonts
	{
		private var background : Sprite;
		private var _evt : MenuBtnEvent;
		public var data : *;
		
		[Embed(source = "../../../../images/deck-background.jpg")]
			private var Img:Class;
		
		public function PopUp(_data : *)
		{
			data = _data;
			super();
			
			var pat : BitmapData = new Img().bitmapData;
			background = new Sprite();
			background.graphics.beginBitmapFill(pat);
			background.graphics.drawRect(0,0, RootLevel.stage.stageWidth, RootLevel.stage.stageHeight);
			background.graphics.endFill();
			background.alpha = 0;
			
			addChild(background);
			background.addEventListener(MouseEvent.CLICK, clicked);
				
		}
		
		public function _intro () : void{
			intro();
		}
		
		public function _outro () : void {
			outro();
		}
		
		protected function intro () : void{
			TweenMax.to(background, 1, {alpha:1});
		}
		
		protected function outro () : void {
			TweenMax.to(background, .5, {alpha:0, onComplete:dispatchClean});
		}
			
		private function clicked (event: MouseEvent) : void {
			_evt = new MenuBtnEvent("popUpOutro");
			dispatchEvent(_evt);
		}
		
		private function dispatchClean () : void {
			_evt = new MenuBtnEvent("popUpClose");
			dispatchEvent(_evt);
		}
		
		
	}
}