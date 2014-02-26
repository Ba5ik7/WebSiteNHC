package com.wes.objects
{
	public class TableObj
	{
		public var id : Number;
		public var x : Number;
		public var y : Number;
		public var type : String;
		public var rotation : Number;
		
		
		
		
		public function TableObj( _id : Number, _x : Number, _y : Number, _type : String, _rotation : Number ) {
			id = _id;
			type = _type;
			x = _x;
			y = _y;

			rotation = _rotation;
		}
	}
}