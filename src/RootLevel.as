package {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	/*
	 * TopLevel class
	 * have all document classes extend this
	 * class instead of Sprite or MovieClip to
	 * allow global stage and root access through
	 * TopLevel.stage and TopLevel.root
	 */
	public class RootLevel extends Sprite {
		
		public static var stage:Stage;
		public static var root:DisplayObject;
		public static var css:StyleSheet;
		public static var menuText:String;
		public static var eventsArr:Array;
		
		public function RootLevel() {
			if (this.stage){
				setupTopLevel();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, setupTopLevel);
			}
		}
		
		private function setupTopLevel(event:Event = null):void {
			if (event){
				removeEventListener(Event.ADDED_TO_STAGE, setupTopLevel);
			}
			RootLevel.stage = this.stage;
			RootLevel.root = this;
			loadStyleSheet();
		}
		
		private function loadStyleSheet():void
		{
			var css_loader : URLLoader = new URLLoader();
			css_loader.addEventListener(Event.COMPLETE, onCssComplete);
			css_loader.load(new URLRequest("css/main.css"));
		}		
		
		private function onCssComplete(event:Event):void
		{
			RootLevel.css = new StyleSheet();
			RootLevel.css.parseCSS(event.target.data);
		}		
		
	}
}