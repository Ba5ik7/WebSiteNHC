package {
	import flash.display.StageQuality;
	import com.wes.models.DataModel;
	import com.wes.models.Model;
	import com.wes.views.Away3D;
	import com.wes.views.BackgroundAway3D;
	import com.wes.views.ContentView;
	import com.wes.views.MenuView;
	import com.wes.views.View;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	[SWF( backgroundColor="#190f36", widthPercent="100", heightPercent="100", frameRate="70", quality="HIGH")]	
	public class Main extends RootLevel {
		private var _model : Model;
		private var _menuView : View;
		private var _contentView : View;
		private var _backgroundView : Away3D;
		
		public function Main(){
			addEventListener(Event.ADDED_TO_STAGE, initz);
		}
		
		private function initz (event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initz);

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			
			_model = new DataModel();
			_model.loadXML(new URLRequest("xml/test.xml"));
			
			buildContent();
			buildMenu();
			buildBackground();
			
			stage.addEventListener(Event.RESIZE, stageResize); 
			stage.dispatchEvent(new Event(Event.RESIZE));
		}
		
		private function buildBackground() : void {
			_backgroundView = new BackgroundAway3D();			
			addChildAt(_backgroundView, 0);
		}
		
		
		private function buildMenu() : void {
			_menuView = new MenuView();
			_menuView.model = _model;
			_menuView.x = (stage.stageWidth/2)-(_menuView.width/2);
			_menuView.y = 25;
			addChildAt(_menuView, 0);
		}
		
		private function buildContent() : void {
			_contentView = new ContentView();
			_contentView.model = _model;
			addChild(_contentView);
			_contentView.x = (stage.stageWidth /2)-560;
			_contentView.y = 100;
			
		}
		
		private function stageResize (event : Event) : void {
			_menuView.x = (stage.stageWidth * .5)-(_menuView.width * 0.5);
			_contentView.x = (stage.stageWidth * .5)-560;
			_backgroundView.x = 0;
			_backgroundView.y = 0;
			_backgroundView.resize();
		}
	}
}