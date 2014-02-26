package com.wes.objects
{
	import com.wes.events.ModelEvent;
	import com.wes.models.Model;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.events.Event;

	
	public class MenuFoodObj extends Model
	{
		public var name : String = new String();
		public var title : String = new String();
		public var txt : String = new String();
		public var image : Bitmap = new Bitmap();
		public var menuTxt : String = new String();
		public var kind : String = new String();
		
		public var _imageBMD : BitmapData;
		
		public function MenuFoodObj(_name : String, _title : String, _txt : String, _imgUrl : String, _menuTxt : String = "", _kind : String = "") {
			
			name = _name;
			title = _title;
			txt = _txt;
			menuTxt = _menuTxt;
			kind = _kind;
			
			super.loadImage(_imgUrl);
		}
		
		override protected function imageLoaded(event:Event):void {
			//Draw the bitmapdata
			_imageBMD = new BitmapData(event.target.content.width, 
										event.target.content.height, 
										false, 0x0000FF);
			_imageBMD.draw(event.target.content, null, null, null, null, false);
			image = new Bitmap(_imageBMD, PixelSnapping.AUTO, false);
			_imageBMD = null;
			
			//Clean up
			super.imageLoaded(event);
			dispatchEvent(new ModelEvent(ModelEvent.IMAGE_READY ));
		}
		
	}
}