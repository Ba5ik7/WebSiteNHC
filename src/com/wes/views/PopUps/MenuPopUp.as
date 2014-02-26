package com.wes.views.PopUps
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.MenuTextScroller;


	public class MenuPopUp extends PopUp
	{
		
		private var txtScroll : MenuTextScroller;
		
		
		public function MenuPopUp(_data:*)		
		{	
			super(_data);
			txtScroll = new MenuTextScroller(955, RootLevel.stage.stageHeight, _data);
			txtScroll.x = (RootLevel.stage.stageWidth/2)- 476;
			txtScroll.alpha = 0;
			addChild(txtScroll);
		}
		
		override protected function intro () : void {
			super.intro();
			TweenMax.to(txtScroll, .5,{alpha:1, ease:Expo.easeOut});
		}
		
		override protected function outro () : void {
			super.outro();
			TweenMax.to(txtScroll, .5,{alpha:0, ease:Expo.easeOut, onComplete:clean});
		}
		
		
		private function clean() : void {
			removeChild(txtScroll);
			
		}
	}
}