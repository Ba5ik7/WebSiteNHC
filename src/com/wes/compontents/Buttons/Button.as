package com.wes.compontents.Buttons {	
	import com.wes.compontents.Fonts;
	import com.wes.events.MenuBtnEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author Wesley
	 */
	public class Button extends Fonts {
		
		public var txt : TextField;
		
		
		private var _text : String;
		private var _textSize : Number;
		private var _textColor : uint;
		private var _width : Number;
		private var _height : Number;
		private var _bgColor : uint;
		private var _lineThinkness : Number;
		private var _lineColor : uint;
		private var _tf : TextFormat;
		private var _evt : MenuBtnEvent;
		
		
		public var beginX :Number;
		public var beginY :Number;
		public var futureX :Number;
		public var futureY :Number;
		
		public function Button(_txt : String, 
							   		textSize : Number, 
									textColor : uint, 
									width : Number, 
									height : Number, 
									bgColor : uint, 
									lineThinkness : Number, 
									lineColor : uint,
									useClick:Boolean=true) {
			super();
		
			_text = _txt;
			name = _text;
			_textSize = textSize;
			_textColor = textColor;
			_width = width;
			_height = height;
			_bgColor = bgColor;
			_lineThinkness = lineThinkness;
			_lineColor = lineColor;
	
			buildBackground();
			buildTextField();
			
			
			if(useClick){this.addEventListener(MouseEvent.CLICK, click);}
			
			this.addEventListener(MouseEvent.MOUSE_OVER, over);
			this.addEventListener(MouseEvent.MOUSE_OUT, out);
			txt.mouseEnabled = false;
			
			addChild(txt);
		}
		

		
		private function buildTextField() : void {
			_tf = new TextFormat();
			_tf.color = _textColor;
			_tf.size = _textSize;
			_tf.kerning = true;
			_tf.bold = true;
			_tf.font ="caviarDreamB";

			txt = new TextField();
			txt.embedFonts = true;
			txt.defaultTextFormat = _tf;
			txt.text = _text;
			txt.width = _width;
			txt.selectable = false;
			txt.autoSize = TextFieldAutoSize.CENTER;
			//Center Ver
			txt.y = (_height*.5) - (txt.height*.5);
		}

		private function buildBackground() : void {
			this.graphics.lineStyle(_lineThinkness, _lineColor);
			this.graphics.beginFill(_bgColor);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
			this.buttonMode = true;
		}
		
		
		private function click( event : MouseEvent ) : void {
			_evt = new MenuBtnEvent("btnClick");
			_evt.name = name;
			dispatchEvent(_evt);
		}
		
		
		private function out( event : MouseEvent ) : void {
			
		}

		private function over( event : MouseEvent ) : void {
			
		}
		
		
	}
}
