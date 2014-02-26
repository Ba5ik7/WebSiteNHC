package com.wes.objects
{
	import com.wes.events.ModelEvent;
	import com.wes.models.Model;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.events.Event;

	
	public class AboutPageObj extends Model
	{
		
		public var name : String;
		public var title : String;
		public var txt : String;
		public var image : Bitmap;
		
		private var _imageBMD : BitmapData;
		
		public function AboutPageObj(_name : String, _title : String, _txt : String, _imgUrl : String) {
			name = _name;
			title = _title;
			txt = _txt;
			
			super.loadImage(_imgUrl);
		}
		
		
		
		override protected function imageLoaded(event:Event):void {
			//Draw BitmapData
			_imageBMD = new BitmapData(event.target.content.width, 
				event.target.content.height, 
				false, 0x0000FF);
			_imageBMD.draw(event.target.content, null, null, null, null, true);
			image = new Bitmap(_imageBMD, PixelSnapping.AUTO, true);
			_imageBMD = null;
			
			//Clean up
			super.imageLoaded(event);
			//Send an event out ModelEvent.IMAGE_READY 
			dispatchEvent(new ModelEvent(ModelEvent.IMAGE_READY));
		}
	}
}