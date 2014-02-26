package com.wes.compontents.Buttons
{
	import com.asual.swfaddress.SWFAddress;
	import com.greensock.TweenMax;
	import com.wes.compontents.Fonts;
	import com.wes.objects.HomeBtnObj;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class HomeButton extends Fonts {
		
		public var beginX :Number;
		public var beginY :Number;
		public var futureX :Number;
		public var futureY :Number;
		
		private var _tf : TextFormat;
		private var _txt : TextField;
		
		private var bit : Bitmap;
		private var masker : Shape;
		private var con : Sprite;
		private var bitCon :Sprite;
		
		private var kind : String;
		
		public function HomeButton(obj : HomeBtnObj) {
			super();
			
			this.name = obj.name;
			this.kind = obj.kind;
			
			this.buttonMode = true;
			
			
			
			masker = new Shape;
			masker.graphics.lineStyle();
			masker.graphics.beginFill(0x000000, 1);
			masker.graphics.drawRect(0,0, obj.image.width, obj.image.height);
			masker.graphics.endFill();
			addChild(masker);
			
			con = new Sprite;
			con.mask = masker;
			addChild(con);
			
			bitCon = new Sprite;
			bitCon.x = obj.image.width*.5;
			bitCon.y = obj.image.height*.5;
			con.addChild(bitCon);
			
			var bd : BitmapData = Bitmap(obj.image).bitmapData;
			bd.draw(obj.image);
			bit = new Bitmap(bd);
			bit.x = 0 - (bit.width*.5);
			bit.y = 0 - (bit.height*.5);
			bitCon.addChild(bit);
			
			
			var borader : Sprite = new Sprite;
			borader.graphics.lineStyle(3,0xd79532);
			borader.graphics.drawRect(0,0, obj.image.width, obj.image.height);
			borader.graphics.endFill();
			addChild(borader);
			
			_tf = new TextFormat();
			_tf.color = 0x000000;
			_tf.size = 28;
			_tf.font ="caviarDreamBI";
			
			_txt = new TextField();
			_txt.embedFonts = true;
			_txt.defaultTextFormat = _tf;
			_txt.text = obj.txt;
			_txt.autoSize = TextFieldAutoSize.RIGHT;
			_txt.selectable = false;
			_txt.mouseEnabled = false;
			_txt.x = obj.image.width - _txt.width;
			_txt.y = obj.image.height - _txt.height;
			_txt.alpha = 0;
			
			this.addEventListener(MouseEvent.CLICK, click);
			this.addEventListener(MouseEvent.MOUSE_OVER, over);
			this.addEventListener(MouseEvent.MOUSE_OUT, out);
			
			
			addChild(_txt);
		}
		
		
		private function click( event : MouseEvent ) : void {
			if (kind == "page"){
				SWFAddress.setValue(name);
			} else { 
				SWFAddress.setValue(kind);
			}
			
		}
		
		private function out( event : MouseEvent ) : void {
			TweenMax.to(bitCon, .7, {scaleX:1, scaleY:1});
			TweenMax.to(_txt, 1, {alpha:0});
		}
		
		private function over( event : MouseEvent ) : void {
			TweenMax.to(bitCon, .4, {scaleX:1.2, scaleY:1.2});
			TweenMax.to(_txt, 1, {alpha:1})
		}
		
		
	}
}