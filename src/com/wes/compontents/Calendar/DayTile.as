package com.wes.compontents.Calendar
{
	import com.asual.swfaddress.SWFAddress;
	import com.wes.compontents.Fonts;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class DayTile extends Fonts {
		
		public var isCurrentDate : Boolean = false;
		
		private var hasEvents : Boolean = false;
		private var eventsArr : Array;
		
		private var tileBg : Sprite;
		private var tileWidth : int = 150;
		private var tileHeight : int = 70;
		private var dateTxt : TextField;
		
		//Text Formats
		private var dateFT : TextFormat;
		
		
		//
		public function DayTile (_date:String,  _isCurrentDate:Boolean=false, _data:Array=null) {
			super();
			isCurrentDate = _isCurrentDate;
			
			if (_data.length) { hasEvents = true; eventsArr = _data; }
				
			buildArrayTF();
			buildArrayTile(_date, _isCurrentDate);
		}
		
		private function buildArrayTF () : void {
			dateFT =  new TextFormat((hasEvents == true || isCurrentDate == true ?  "caviarDreamBI" : "caviarDreamB"), 22, 
									(hasEvents == true || isCurrentDate == true ?  0xd79532 : 0xFFFFFF), true);
		}
		
		private function buildArrayTile (_date:String, _isCurrentDate:Boolean) : void {
			if(hasEvents){this.addEventListener(MouseEvent.CLICK, click);}
			
			tileBg = new Sprite();
			
			var lineColor:uint = (_isCurrentDate == false ? 0xd79532 : 0xFF0000);
			var bgColor:uint = (hasEvents == true || _isCurrentDate == true ?  0xFFFFFF : 0x333333);

			tileBg.graphics.lineStyle(3, lineColor);
			tileBg.graphics.beginFill(bgColor, 1);
			tileBg.graphics.drawRect(0, 0, tileWidth, tileHeight);
			tileBg.graphics.endFill();
			addChild(tileBg);

			dateTxt = new TextField();
			dateTxt.embedFonts = true;
			dateTxt.defaultTextFormat = dateFT;
			dateTxt.text = _date;
			dateTxt.selectable = dateTxt.mouseEnabled = false;
			dateTxt.x = dateTxt.y = 10;
			addChild(dateTxt);
			
			this.buttonMode = this.mouseEnabled = (hasEvents == true ? true : false);
		}
		
		private function click( event : MouseEvent ) : void {
			RootLevel.eventsArr = eventsArr;
			SWFAddress.setValue("calendarPopUp");
		}
		
	}
}