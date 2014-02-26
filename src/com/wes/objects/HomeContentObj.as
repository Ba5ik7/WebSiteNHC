package com.wes.objects
{
	public class HomeContentObj
	{
		
		public var name :String = new String();
		public var btn : Array = new Array();
		public var slider : Array = new Array();
		
		
		public function HomeContentObj(_name:String, _btn : Array, _slider : Array) {
			name = _name;
			btn = _btn;
			slider = _slider;
		}
		
	}
}