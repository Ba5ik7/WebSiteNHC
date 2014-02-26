package com.wes.compontents.Calendar
{
	import com.asual.swfaddress.SWFAddress;
	import com.wes.objects.EventsEventObj;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Calendar extends Sprite
	{
		/** TEXT FORMAT */
		private var month_tf:TextFormat;
		private var week_tf:TextFormat;
		private var button_tf:TextFormat;
		
		/** LANGUAGE CONFIG */
		private var _months:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		private var _days:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		
		/** DAYS PER MONTH */
		private var _monthTotal:Array = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		
		/** CALENDAR */
		private var _today:Date = new Date();
		private var _events:Array = new Array();
		private var _currentEvents:Array = new Array();
		
		private var _targetMonth:uint = _today.getMonth();
		private var _targetYear:uint = _today.getFullYear();
		
		/** VISUAL ASSETS */
		private var _selectedMonth:TextField;
		private var _daysWeek:Sprite = new Sprite();
		
		private var _nextBT:Sprite = new Sprite();
		private var _prevBT:Sprite = new Sprite();
		
		/** HOLDER FOR DAYS OF THE MONTH */
		private var _holder:Sprite = new Sprite();
		
		public function Calendar(_data:* = null) {
			_events = _data;
			configStyle();
			build();
		}
		
		
		/**
		 * Style Configurations
		 * */
		private function configStyle():void
		{
			month_tf = new TextFormat("caviarDreamBI", 28, 0xFFFFFF, true);
			month_tf.align = "center";
			
			week_tf = new TextFormat("caviarDreamB", 18, 0xFFFFFF, true); 
			week_tf.align = "center";
			
			button_tf = new TextFormat("caviarDreamB", 15, 0xFFFFFF); 
			button_tf.align = "center";
		}
		
		
		/**
		 * Builds interface
		 * */
		private function build():void
		{
			/** Month and Year TextField */
			_selectedMonth = new TextField();
			_selectedMonth.embedFonts = true;
			_selectedMonth.text = "";
			_selectedMonth.border = _selectedMonth.selectable = false;
			_selectedMonth.width = 250;
			_selectedMonth.height = 40;
			_selectedMonth.x = 435;
			_selectedMonth.defaultTextFormat = TextFormat(month_tf);
			addChild(_selectedMonth);
		
			/** Days of the week */
			addChild(_daysWeek);
			for(var i:uint = 0; i<7;++i)
			{
				var temp:Sprite = new Sprite();
				temp.graphics.lineStyle(1, 0xd79532);
				temp.graphics.beginFill(0);
				temp.graphics.drawRect(0,0, 150, 30);
				temp.graphics.endFill();
				
				temp.x = (160 * i);
				temp.y = _selectedMonth.y + _selectedMonth.height;
				addChild(temp);
				writeText(_days[i], week_tf, temp, 150);
			}
			
			/** Buttons */
			_prevBT.graphics.beginFill(1);
			_prevBT.graphics.drawRect(0, 0, 200, 25);
			_prevBT.graphics.endFill();
			
			_nextBT.graphics.beginFill(1);
			_nextBT.graphics.drawRect(0, 0, 200, 25);
			_nextBT.graphics.endFill();
			
			addChild(_prevBT);
			addChild(_nextBT);
			
			writeText("<<", button_tf, _prevBT, 200, 25);
			writeText(">>", button_tf, _nextBT, 200, 25);
			
			_prevBT.x = 0;
			_prevBT.y = 5;
			
			//_nextBT.x = RootLevel.stage.width;
			_nextBT.x = 1110 - _nextBT.width;
			_nextBT.y = 5;
			
			_nextBT.buttonMode = _prevBT.buttonMode = true;
			
			_prevBT.addEventListener(MouseEvent.CLICK, prevMonth);
			_nextBT.addEventListener(MouseEvent.CLICK, nextMonth);
			
			/** Holder for days of the month */
			addChild(_holder);
			_holder.y = 0;
		}
		
		
		/**
		 * decreases current month and year if necessary
		 * */
		private function prevMonth(e:MouseEvent):void
		{
			_targetMonth = _targetMonth == 0 ? 12 : _targetMonth % 12;
			_targetMonth--;
				_targetMonth % 12 == 11 ? _targetYear-- : null;
			SWFAddress.setValue("events/?month="+(_targetMonth+1)+"&year="+_targetYear);
			
		}
		
		
		/**
		 * increments current month and year if necessary
		 * */
		private function nextMonth(e:MouseEvent):void
		{
			_targetMonth++;
				_targetMonth = _targetMonth == 12 ? 0 : _targetMonth % 12;
			_targetMonth % 12 == 0 ? _targetYear++ : null;
			SWFAddress.setValue("events/?month="+(_targetMonth+1)+"&year="+_targetYear);
			
		}
		
		
		/**
		 * Write Text in some sprite
		 * */
		private function writeText(_text:String, _textFormat:TextFormat, _target:Sprite, _width:int = 0, _height:int=0):void
		{
			var label_txt:TextField = new TextField();
			label_txt.embedFonts = true;
			label_txt.text = _text;
			label_txt.border = label_txt.selectable = label_txt.mouseEnabled = false;
			
			_width == 0 ? label_txt.autoSize = "left" : label_txt.width == _width;
			
			_height != 0 ? label_txt.height = _height : null;
			
			
			label_txt.defaultTextFormat = TextFormat(_textFormat);
			label_txt.setTextFormat(_textFormat);
			_target.addChild(label_txt);
		}
		
		
		/**
		 * remove all month days (sprites)
		 * */
		private function cleanGraphics():void
		{
			var total:uint = _holder.numChildren;
			for(var i:uint = 0; i < total;++i)
			{
				_holder.removeChildAt(0);
			}
		}
		
		
		/**
		 * Renders Calendar info
		 * */
		public function Render():void
		{
			/** removes all unnecessary assets */
			cleanGraphics();
			
			
			/** changes calendar month and year */
			_selectedMonth.text = _months[_targetMonth % 12] + " " + _targetYear; //?
			
			/** draws calendar based on year and month */
			var daysNo:uint = (_targetYear % 4 == 0 && _targetMonth % 12 == 1 ? 29 : _monthTotal[_targetMonth % 12]);
			
			
			/** gets 1 day of the week in current selected month */
			var temp : Date = new Date(_targetYear, _targetMonth);
			var startDay : uint = temp.getDay();
			
			/**Add events to _currentEvents if there are any**/ 
			var _hasEvents : Boolean = new Boolean(_events.length);
			if ( _hasEvents ) {
				_currentEvents = [];
				for each (var _evt:EventsEventObj in _events){
					if(_evt.date.month == _targetMonth && _evt.date.fullYear == _targetYear)
						_currentEvents.push(_evt);
				}
				_hasEvents = (_currentEvents.length ? true : false) ;
			} 
			
			
			/** Adds sprite with days */
			
			var isCurrentDate : Boolean ;
			var row : Number = 0;
			var i : uint;
			var tempArray : Array;
			var eventSwitch : Boolean;
			
			for (i = 1; i < daysNo + 1; ++i) {
				tempArray = new Array();
				eventSwitch =false;
				
				isCurrentDate = (_targetMonth == _today.month && i ==  _today.date && _targetYear == _today.fullYear ?  true : false);
				
				if(_hasEvents){
					for each(var evt : EventsEventObj in _currentEvents){
						if(evt.date.date == i){
							tempArray.push(evt);
							eventSwitch = true;
						}
					}
				}
				
				
				var sp:DayTile = new DayTile(i.toString(), isCurrentDate, tempArray);
					sp.x = startDay * 160;
					sp.y = (row+1) * 80;
				
				_holder.addChild(sp);
				
				startDay++;
				
				/** changes row on saturdays */
				if( startDay >= 7 ) {
					startDay = 0;
					row++;
				}
			}
		}
		

		/**
		 * SETTERS GETTERS
		 * */
		public function set month(_value:uint):void {_targetMonth = _value;}
		public function set year(_value:uint):void {_targetYear = _value;}
		public function get month():uint {return _targetMonth;}
		public function get year():uint {return _targetYear;}
		
	}
}