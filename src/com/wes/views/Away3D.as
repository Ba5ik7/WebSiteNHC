package com.wes.views
{
	import away3d.cameras.Camera3D;
	import away3d.containers.View3D;

	
	import com.wes.events.PageEvents;
	import com.wes.models.Model;
	
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * This is basic template for away3d scene setup
	 * 
	 * */
	public class Away3D extends Sprite
	{
		
		public var _model : Model;
		
		protected var _view:View3D;
		protected var _cam:Camera3D;
		
		public function Away3D()
		{
			initAway();
			initMaterials();
			initGeometry();
			initListeners();
		}
		private function initAway():void{
			_view = new View3D();
			_view.backgroundColor = 0x190f36;

			//_view.antiAlias = 4;
			this.addChild(_view);
			
			_view.camera.y = 800;
			

			//addChild(new AwayStats(_view));
			//new HoverDragController(_view.camera);
			//_view.scene.addChild(new WireframeAxesGrid(4,1000));
		}
		protected function initListeners():void{
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			RootLevel.stage.addEventListener(PageEvents.OUTRO_COMPLETE, moveCam);
			
		}
		protected function initMaterials():void{
			
		}
		protected function initGeometry():void{
			
		}
		protected function onEnterFrame(e:Event):void{
			_view.render();
		}
		
		public function resize():void {
			_view.width = RootLevel.stage.stageWidth;
			_view.height = RootLevel.stage.stageHeight;
		}
		
		
		// When you add data from the model
		protected function moveCam (event:PageEvents) : void {
			//trace("moving");
		}
	}
}