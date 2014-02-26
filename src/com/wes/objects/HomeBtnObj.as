package com.wes.objects
{
	import com.wes.events.ModelEvent;
	import com.wes.models.Model;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.events.Event;

	
	public class HomeBtnObj extends Model
	{
		public var name : String = new String();
		public var txt : String = new String();
		public var image : Bitmap = new Bitmap();
		public var kind : String = new String();
		
		public var _imageBMD : BitmapData;
		
		
		
		public function HomeBtnObj(_name : String, _txt : String, _imgUrl : String, _kind : String) {
			name = _name;
			txt = _txt;
			kind = _kind;
			super.loadImage(_imgUrl);
		}
		
		
		override protected function imageLoaded(event:Event):void {
			//Draw the bitmapdata
			_imageBMD = new BitmapData(event.target.content.width, 
										event.target.content.height, 
										true, 0x0000FF);
			_imageBMD.draw(event.target.content, null, null, null, null, true);
			image = new Bitmap(_imageBMD, PixelSnapping.AUTO, true);
			_imageBMD = null;
			
			//Clean up
			super.imageLoaded(event);
			dispatchEvent(new ModelEvent(ModelEvent.IMAGE_READY ));
		}
	}
}