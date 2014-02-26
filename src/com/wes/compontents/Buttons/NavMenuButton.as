package com.wes.compontents.Buttons
{
	import com.asual.swfaddress.SWFAddress;
	import com.wes.compontents.Fonts;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class NavMenuButton extends Fonts {
		
		private var _tf : TextFormat;
		private var _txt : TextField;
		
		public var beginX :Number;
		public var beginY :Number;
		public var futureX :Number;
		public var futureY :Number;
		
		public function NavMenuButton(text : String, textSize : Number, textColor : uint) {
			super();
			
			_tf = new TextFormat();
			_tf.color = textColor;
			_tf.size = textSize;
			_tf.kerning = true;
			//_tf.bold = true;
			_tf.font ="HANAB";
			
			_txt = new TextField();
			_txt.embedFonts = true;
			_txt.defaultTextFormat = _tf;
			_txt.text = text;
			_txt.selectable = false;
			_txt.autoSize = TextFieldAutoSize.LEFT;

			this.addEventListener(MouseEvent.CLICK, click);
			_txt.mouseEnabled = false;
			
			addChild(_txt);
		}
		
		private function click( event : MouseEvent ) : void {
			var _date : Date = new Date();
			if (name != "events") {
				SWFAddress.setValue(name);
			} else {
				SWFAddress.setValue("events/?month="+(_date.getMonth()+1)+"&year="+_date.getFullYear());
			}
		}
		
		
	}
}