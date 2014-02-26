package com.wes.compontents.Calendar
{
	import com.wes.compontents.Buttons.Button;
	import com.wes.compontents.Fonts;
	import com.wes.compontents.TextScroller;
	import com.wes.events.CalendarEvent;
	import com.wes.objects.EventsEventObj;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class EventInfoPage extends Fonts
	{
		private var _con : Sprite;
		
		private var _evt : CalendarEvent;
		
		private var _backBtn : Button = new Button("Back", 18, 0xFFFFFF, 100, 40, 0x000000, 1, 0xe08c1f, false);
		
		private var txt : TextField;
		private var title : TextField;
		private var tf : TextFormat;
		
		private var txtScroller : TextScroller;
		
		private var image : Bitmap;
		
		public function EventInfoPage()
		{
			super();
			_con = new Sprite();
			_con.graphics.beginFill(0xFFFFFF, 1);
			_con.graphics.drawRect(0, 0, 730, 380);
			_con.graphics.endFill();
			addChild(_con);
			
			_backBtn.x = _con.width - _backBtn.width - 10;
			_backBtn.y = 10;
			_con.addChild(_backBtn);
			
			_backBtn.buttonMode = true;
			_backBtn.addEventListener(MouseEvent.CLICK, clicked);

			
			tf = new TextFormat();
			tf.color = 0x000000;
			tf.size = 32;
			tf.kerning = true;
			tf.bold = true;
			tf.font ="caviarDreamBI";
			
			title = new TextField();
			title.embedFonts = true;
			title.defaultTextFormat = tf;
			title.autoSize = TextFieldAutoSize.LEFT;
			title.selectable = false;
			title.x = 270;
			title.y = 10;
			_con.addChild(title);
			
			tf.size = 18;
			txt = new TextField();
			txt.embedFonts = true;
			txt.defaultTextFormat = tf;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.selectable = false;
			txt.x = 270;
			txt.y = (title.y + title.height) + 35;
			_con.addChild(txt);
			
			txtScroller = new TextScroller(440, 285, " "); 
			txtScroller.x = 270;
			txtScroller.y = (txt.y + txt.height) + 30;
			_con.addChild(txtScroller);
			
			image = new Bitmap;
		}
		
		private function clicked(event:MouseEvent):void {
			_evt = new CalendarEvent("closeEvent");
			dispatchEvent(_evt);
		}
		
		public function render (eventObj : EventsEventObj=null) : void { 
			title.text = eventObj.title;
			txt.htmlText = "<i>"+eventObj.date.month + "-"+eventObj.date.date+"-"+eventObj.date.fullYear+"</i>";
			txtScroller.render(eventObj.txt);
			image = eventObj.image;
			if(image != null){
				image.x = 10;
				image.y = 10;
				_con.addChild(image);
				
				var borader : Sprite = new Sprite;
				borader.graphics.lineStyle(3,0xd79532);
				borader.graphics.drawRect(0,0, image.width, image.height);
				borader.graphics.endFill();
				borader.x = 10;
				borader.y = 10;
				_con.addChild(borader);
			}
			
		}
		
	}
}