package com.wes.models
{
	import com.wes.events.AMFServiceEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	public class AMFServices extends EventDispatcher
	{
		private var gateway : String = "http://besik.no-ip.org/gateway.php";
		private var connection : NetConnection;
		private var responder : Responder;
		
		private var _evt : AMFServiceEvent;
		
		public function AMFServices() {
			responder = new Responder(onResult, onFault);
			connection = new NetConnection;
			connection.objectEncoding = ObjectEncoding.AMF3;
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		}
		
		
		public function callService(method:String, ... args) : void {
			connection.connect(gateway);
			connection.call(method, responder, args);
			
		}
		
		private function netStatusHandler(event : NetStatusEvent) : void {
			trace("netStatusHandler :: " + event.info.description);
			
		}
		
		private function onFault (fault : Object) : void {
			trace(String(fault.description));	
		}
		
		private function onResult (result : Object) : void {
			
			_evt = new AMFServiceEvent("onComplete");
			_evt.data = result;
			RootLevel.stage.dispatchEvent(_evt);
			connection.close();
		}
		
		
	}
}