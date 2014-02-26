package com.wes.compontents.Buttons
{
	import com.asual.swfaddress.SWFAddress;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Fonts;
	import com.wes.objects.MenuFoodObj;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class FoodMenuButton extends Fonts  {
		
		public var beginX :Number;
		public var beginY :Number;
		public var futureX :Number;
		public var futureY :Number;
		public var menuTxt : String;
		
		private var _tfTitle : TextFormat;
		private var _tfTxt : TextFormat;
		private var _txt : TextField;
		private var _title : TextField;
		
		private var menuText : String;
		
		private var bit : Bitmap;
		private var box : Sprite;
		
		private var kind : String;
		
		public function FoodMenuButton(obj : MenuFoodObj, useEvent : Boolean = true) {
			super();
			this.name = obj.name;
			kind = obj.kind;
			this.buttonMode = true;
			
			menuText = obj.menuTxt;
			
			
			var bd : BitmapData = Bitmap(obj.image).bitmapData;
			bd.draw(obj.image);
			bit = new Bitmap(bd);
			
			
			//Txt Box
			_tfTxt = new TextFormat();
			_tfTxt.color = 0xFFFFFF;
			_tfTxt.size = 22;
			_tfTxt.kerning = false;
			_tfTxt.font ="caviarDreamBI";
			
			_txt = new TextField();
			_txt.embedFonts = true;
			_txt.defaultTextFormat = _tfTxt;
			_txt.text = obj.txt;
			_txt.selectable = false;
			_txt.mouseEnabled = false;
			_txt.multiline = true;
			_txt.wordWrap = true;
			_txt.width = bit.width;
			//Center Ver
			_txt.x = 10;
			_txt.y = 10;
			
			//Build Box
			box = new Sprite();
			box.graphics.beginFill(0x000000, .7);
			box.graphics.drawRect(0,0,bit.width, _txt.height + 5);
			box.graphics.endFill();
			box.y = bit.height - box.height;
			box.alpha = 0;
			box.addChild(_txt);
			
			
			
			
			//Title
			_tfTitle = new TextFormat();
			_tfTitle.color = 0xffffff;
			_tfTitle.size = 24;
			_tfTitle.kerning = false;
			_tfTitle.font ="caviarDreamBI";
			
			_title = new TextField();
			_title.embedFonts = true;
			_title.defaultTextFormat = _tfTitle;
			_title.text = obj.title;
			_title.autoSize = TextFieldAutoSize.RIGHT;
			_title.selectable = false;
			_title.mouseEnabled = false;
			_title.x = 10;
			_title.y = 10;
			
			var borader : Sprite = new Sprite;
			borader.graphics.lineStyle(3,0xd79532);
			borader.graphics.drawRect(0,0, bit.width, bit.height);
			borader.graphics.endFill();
			
			if (useEvent){
				this.addEventListener(MouseEvent.CLICK, click);
			}

			this.addEventListener(MouseEvent.MOUSE_OVER, over);
			this.addEventListener(MouseEvent.MOUSE_OUT, out);

			addChild(bit);
			addChild(box);
			addChild(_title);
			addChild(borader);
		}
		
		
		private function click( event : MouseEvent ) : void {
			RootLevel.menuText = menuText;
			SWFAddress.setValue(kind);
		}
		
		
		private function out( event : MouseEvent ) : void {
			TweenMax.to(box, 2, {alpha:0, ease:Expo.easeOut});
		}
		
		private function over( event : MouseEvent ) : void {
			TweenMax.to(box, .7, {alpha:1, ease:Expo.easeOut});

		}
	}
}