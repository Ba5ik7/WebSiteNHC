package com.wes.views
{
	import com.wes.events.ModelEvent;

	import com.wes.models.Model;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class View extends Sprite
	{
		public var _model : Model;
		
		
		public function View() {
			super();
		}

		public function set model(m : Model) : void {
			_model = m;
			_model.addEventListener(ModelEvent.MODEL_COMPLETE, modelComplete);
		}
		
		// When you add data from the model
		protected function modelComplete(event : ModelEvent) : void {
			stage.dispatchEvent(new Event(Event.RESIZE));
		}
		
	}
}