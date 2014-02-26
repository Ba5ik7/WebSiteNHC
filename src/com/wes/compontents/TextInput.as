package com.wes.compontents
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TextInput extends Fonts
	{
		public var textInput : TextField;
		private var _tf : TextFormat;
		private var title : TextField;
		
		public function TextInput(_title : String, _width : Number, _height : Number = 0)
		{
			super();
			createTitleTxt(_title);
			createInputField(_width, _height);
			
		}
		
		
		private function createTitleTxt(_title:String) : void {
			_tf = new TextFormat();
			_tf.color = 0x000000;
			_tf.size = 18;
			_tf.font ="caviarDreamBI";
			
			title = new TextField();
			title.embedFonts = true;
			title.defaultTextFormat = _tf;
			title.text = _title;
			title.selectable = false;
			title.autoSize = TextFieldAutoSize.LEFT;
			title.x = 0-title.width - 5;
			addChild(title);
			
			
		}
		
		private function createInputField(_width:Number, _height:Number) : void{
			var txtITF : TextFormat = new TextFormat();
			txtITF.color = 0x000000;
			txtITF.size = 16;
			txtITF.font ="verdana";
			
			textInput = new TextField();
			textInput.defaultTextFormat = txtITF;
			
			textInput.background = true;
			textInput.backgroundColor = 0xFFFFFF;
			textInput.border = true;
			 
			textInput.borderColor = 0x000000;
			textInput.type = "input";
			textInput.multiline = false;
			if(_height != 0 ){
				textInput.width = _width;
				textInput.height = _height;
				textInput.wordWrap = true;
				textInput.multiline = true;
				textInput.maxChars = 400;
			} else {
				textInput.multiline = false;
				textInput.maxChars = 50;
				textInput.width = _width;
				//@Hardcoded
				textInput.height = 23;
			}
			addChild(textInput);
		}		
		
	}
}