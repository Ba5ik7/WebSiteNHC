package com.wes.compontents.Calendar
{
	import com.wes.compontents.Fonts;
	import com.wes.events.CalendarEvent;
	import com.wes.objects.EventsEventObj;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	public class EventTile extends Fonts
	{
		private var _con : Sprite;
		
		private var _titleTF : TextFormat;
		private var _titleTextField : TextField;
		
		private var _image : Bitmap;
		
		private var _evt : CalendarEvent;
		private var _eventObj : EventsEventObj;
		
		public function EventTile(eventObj:EventsEventObj)
		{
			super();
			_eventObj = eventObj;
			buildBg();
			
			
			var bd : BitmapData = Bitmap(eventObj.image).bitmapData;
			bd.draw(eventObj.image);
			_image = new Bitmap(bd);
			addChild(_image);
			_image.x = 10;
			_image.y = 10;
			_image.scaleX = _image.scaleY = .25;
			addChild(_image);
			
			var borader : Sprite = new Sprite;
			borader.graphics.lineStyle(3,0xd79532);
			borader.graphics.drawRect(0,0, _image.width, _image.height);
			borader.graphics.endFill();
			borader.x = 10;
			borader.y = 10;
			addChild(borader);
			
			_titleTF = new TextFormat("caviarDreamBI", 28, 0x000000, true);
			_titleTF.align = "left";
			
			_titleTextField = new TextField();
			_titleTextField.embedFonts = true;
			_titleTextField.defaultTextFormat = _titleTF;
			_titleTextField.text = eventObj.date.month + "/"+ eventObj.date.date+ "/"+ eventObj.date.fullYear + " - " + eventObj.title;
			_titleTextField.selectable = false;
			_titleTextField.x = _image.width + 25;
			_titleTextField.y = 5;
			_titleTextField.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(_titleTextField);
			
			
		}
		
		private function buildBg():void
		{
			_con = new Sprite();
			_con.graphics.lineStyle(3,0xd79532);
			_con.graphics.beginFill(0xFFFFFF, 1);
			_con.graphics.drawRect(0, 0, 715, 75);
			_con.graphics.endFill();
			addChild(_con);
			
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, clicked);
		}
		
		private  function clicked(event:MouseEvent):void
		{
			_evt = new CalendarEvent("openEvent");
			_evt.eventObj = _eventObj;
			dispatchEvent(_evt);
		}		
		
	}
}