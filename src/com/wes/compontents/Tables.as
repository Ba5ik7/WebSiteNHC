package com.wes.compontents
{
	
	import flash.display.Sprite;
	
	public class Tables extends Sprite
	{

		private var _table : Sprite = new Sprite();
		
		public var id : Number;
		public var startX : Number;
		public var startY : Number;
		public var startR : Number;
		public var type : String;
		
		
		private var _width : Number;
		private var _height : Number;
		
		public function Tables( _type:String)  {
			super();
			
			type = _type;
			
			switch(_type)
			{
				case "Small":
					_width = 30;
					_height = 30;
					break;
				case "Med":
					_width = 40;
					_height = 30;
					break;
				case "Large":
					_width = 75;
					_height = 25;
					break;
				default:
					_type = "Small";
					_width = 100;
					_height = 100;
					return;
			}
			
			_table.graphics.lineStyle(1, 0x000000);
			_table.graphics.beginFill(0xffffff);
			_table.graphics.drawRect(0,0, _width, _height);
			_table.graphics.endFill();
			
			_table.x = 0 - (_width * .5);
			_table.y = 0 - (_height * .5);
			
			addChild(_table);
			
			
		}

	}
}