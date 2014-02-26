package com.wes.models
{
	import com.wes.events.ModelEvent;
	import com.wes.objects.TableObj;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class UserPortfolio extends EventDispatcher
	{
		
		private var _urlLoader : URLLoader;
		
		private var _data : XML;
		
		private var _dataList : XMLList = new XMLList();
		
		public var tabArray : Array;
		
		public function UserPortfolio(target:IEventDispatcher=null)
		{
			super(target);
			
			
			
		}
		
		//XML Loader**********************************************************//
		public function loadXML(req : String) : void {
			trace(req);
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, dataLoaded);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader.load(new URLRequest(req));
		}
		
		private function dataLoaded(event : Event) : void {
			_data = new XML(event.target.data);
			_urlLoader.removeEventListener(Event.COMPLETE, dataLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader = null;
			
			
			trace(_data);
			
			_dataList = _data.tables.table;
			
			
			tabArray = new Array();
			var k : int;
			for (k = 0; k < _dataList.length(); ++k) {
				var tabObj : TableObj = new TableObj(
					_dataList[k].@id,
					_dataList[k].@x,
					_dataList[k].@y,
					_dataList[k].@type,
					_dataList[k].@rotation);
				
				tabArray.push(tabObj);
			}
			
			
			
			
			xmlReady();
		}
		
		private function xmlReady():void {
			dispatchEvent(new ModelEvent(ModelEvent.XML_READY));
		}
		
		private function URLLOADER_IOERROR(event : IOErrorEvent) : void {
			trace(event.target.data);
			_urlLoader.removeEventListener(Event.COMPLETE, dataLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, URLLOADER_IOERROR);
			_urlLoader = null;
			throw(new Error(event.target.data));
		}
		
		
	}
}