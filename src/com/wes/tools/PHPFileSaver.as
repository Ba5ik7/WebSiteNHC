﻿package com.wes.tools{	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
			public class PHPFileSaver extends EventDispatcher	{		private var phpFile:String;		private var saveToFile:String;		private var req:URLRequest;		private var loader:URLLoader = new URLLoader();		public var vars:URLVariables = new URLVariables();		public var success:Boolean = false;				public function PHPFileSaver()		{					}				public function save(php:String, saveFile:String, saveContent:String):void		{			phpFile = php;			saveToFile = saveFile;			req = new URLRequest(phpFile);			vars.content = saveContent;			vars.fileName = saveToFile;			req.data = vars;			req.method = URLRequestMethod.POST;			loader.load(req);			loader.addEventListener(Event.COMPLETE, checkStatus);		}				private function checkStatus(event:Event):void		{			if(loader.data == vars.content)			{				success = true;			}			dispatchEvent(new Event(Event.COMPLETE));		}	}}