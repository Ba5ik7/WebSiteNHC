package com.wes.compontents.ComboBox
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ComboBoxListItem extends Sprite
	{
		
		public var val : String;
		
		public var _txt : TextField;
		private var _tf : TextFormat;
		
		
		
		public function ComboBoxListItem( txt:String)
		{
			super();
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xFFFFFF, 1);
			graphics.drawRect(0,0, 200, 25);
			graphics.endFill();
			
			_tf = new TextFormat();
			_tf.color = 0x000000;
			_tf.size = 16;
			_tf.bold = true;
			_tf.font ="verdana";
			_tf.align = "center";
			
			_txt = new TextField();
			_txt.defaultTextFormat = _tf;
			_txt.text =  txt;
			_txt.wordWrap = _txt.multiline = _txt.selectable = false;
			_txt.width = 200;
			_txt.height = 25;
			addChild(_txt);
		}
	}
}