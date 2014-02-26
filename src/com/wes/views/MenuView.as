package com.wes.views
{

	import com.wes.compontents.Buttons.NavMenuButton;
	import com.wes.events.ModelEvent;

	public class MenuView extends View {
		private var paddingX : Number = 50;
		private var count :Number = 0;

		
		public function MenuView()
		{
			super();
		}
		
		override protected function modelComplete(event : ModelEvent) : void {

			var menuWidth : Number = 0;
			for each(var i:Array in _model.menuDataArray) {
					var button : NavMenuButton = new NavMenuButton(i[0].txt, 
																32, 
																0xFFFFFF);
					button.name = i[0].name;
					button.x = menuWidth;
					menuWidth += button.width + paddingX;
					button.buttonMode = true;
					addChild(button);
				
				++count;
			}
			super.modelComplete(event);
		}
	}
}