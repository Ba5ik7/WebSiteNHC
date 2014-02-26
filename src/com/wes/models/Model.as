package com.wes.models {
	import com.wes.events.ModelEvent;
	import com.wes.objects.AboutPageObj;
	import com.wes.objects.ContactPageObj;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;

	/**
	 * @author Wesley DuSell
	 */
	public class Model extends EventDispatcher {
		
		public var menuDataArray : Array;
		
		public var homeDataArray : Array;
		public var aboutDataObj : AboutPageObj;
		public var menuFoodDataArray : Array;
		public var drinkMenuDataArray : Array;
		public var eventsCalendarArray : Array;
		public var contactDataObj : ContactPageObj;
		public var partyDataArray : Array;
		public var facebookArray : Array;

		public var upComingEvents : Array;
		
		public var styleSheet : StyleSheet;
		
		private var _urlLoader : URLLoader;
		private var _imageLoader : Loader;
		
		

		protected var data : XML;
		
		
		
		


		public function Model(target : IEventDispatcher = null) {
			super(target);
		}


		//XML Loader**********************************************************//
		public function loadXML(req : URLRequest) : void {
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, dataLoaded);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader.load(req);
		}

		private function dataLoaded(event : Event) : void {
			data = new XML(event.target.data);
			_urlLoader.removeEventListener(Event.COMPLETE, dataLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader = null;
			
			
			xmlReady();
		}

		protected function xmlReady():void {
			dispatchEvent(new ModelEvent(ModelEvent.XML_READY));
		}

		private function URLLOADER_IOERROR(event : IOErrorEvent) : void {
			trace(event.target.data);
			_urlLoader.removeEventListener(Event.COMPLETE, dataLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader = null;
			throw(new Error(event.target.data));
		}
		
		//Image Loader**************************************************************//
		public function loadImage(urlRequest : String) : void {
			_imageLoader = new Loader();
			_imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			_imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IMAGELOADER_IOERROR);
			_imageLoader.load(new URLRequest(urlRequest));

		}
		
		protected function imageLoaded(event : Event) : void {
			event.target.removeEventListener(Event.COMPLETE, imageLoaded);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, IMAGELOADER_IOERROR);
			
		}

		private function IMAGELOADER_IOERROR(event : IOErrorEvent) : void {
			_imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoaded);
			_imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, IMAGELOADER_IOERROR);
			//_imageLoader = null;
			throw(new Error(event.target + " " + event.target.content));
		}
		
	}
}