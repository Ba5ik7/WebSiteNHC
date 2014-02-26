package com.wes.objects
{
	import com.wes.events.ModelEvent;
	import com.wes.models.Model;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.events.Event;

	public class EventsEventObj extends Model {
		public var date:Date;
		public var name : String = new String();
		public var title : String = new String();
		public var txt : String = new String();
		public var image : Bitmap = new Bitmap();
		
		private var _imageBMD : BitmapData;
		
		public function EventsEventObj(_name:String, _date:String, _title:String, _txt : String, _imgUrl : String) {
			date = new Date(_date);
			name = _name;
			title = _title;
			txt = _txt;
			
			super.loadImage(_imgUrl);
		}
		
		override protected function imageLoaded(event:Event):void{
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
	
	