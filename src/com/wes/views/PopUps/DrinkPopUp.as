package com.wes.views.PopUps
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Buttons.FoodMenuButton;
	import com.wes.compontents.MenuTextScroller;
	import com.wes.objects.MenuFoodObj;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class DrinkPopUp extends PopUp
	{
		
		private var arrBtn : Array = new Array();
		private var txtScroll : MenuTextScroller;
		private var delayTick : Number;
		
		private var isMenuUp : Boolean = false;
		
		public function DrinkPopUp(_data:*)
		{
			super(_data);
			super.intro();
			createBtn();
			
		}
		
		private function createBtn():void
		{
			var yoD : Number = new Number();
			
			//@Hardcoded
			yoD = (RootLevel.stage.width*.5) - 420;
			
			
			for each ( var drinkBtn : MenuFoodObj in data) { 
				var btn : FoodMenuButton = new FoodMenuButton(drinkBtn, false);
				btn.menuTxt = drinkBtn.menuTxt;
				
				btn.x = yoD;
				btn.y = (RootLevel.stage.height - RootLevel.stage.height) - btn.height;
				

				btn.futureX = yoD;
				btn.futureY = (RootLevel.stage.height*.5) - 227.5;
				btn.mouseChildren = true;
				btn.addEventListener(MouseEvent.CLICK, showMenu);
				addChild(btn);
				arrBtn.push(btn);
				
				yoD += 220;
			}
		}
		
		private function showMenu(event:MouseEvent):void
		{
			isMenuUp = true;
			txtScroll = new MenuTextScroller(955, RootLevel.stage.stageHeight, event.target.menuTxt);
			txtScroll.x = (RootLevel.stage.stageWidth/2)- 476;
			addChild(txtScroll);
		}
		
		override protected function intro () : void {
			delayTick = 0;
			for each (var i:* in arrBtn) {
				TweenMax.to(i, .5,{ 
					x:i.futureX,
					y:i.futureY,
					delay:delayTick,
					ease:Expo.easeInOut});
				delayTick += .15;
			}
		}
		
		override protected function outro () : void {
			if (isMenuUp){
				txtScroll.alpha = 0;
			}
			delayTick = 0;
			for each (var i:* in arrBtn) {
				TweenMax.to(i, .5,{
					x:i.futureX,
					y:RootLevel.stage.height + i.height,
					delay:delayTick, 
					onComplete:clean, 
					onCompleteParams:[i],
					ease:Expo.easeInOut});
				delayTick += .15;	
			}
			
		}
		
		
		private function clean(i : Sprite) : void {
			if (isMenuUp){
				isMenuUp = false;
				removeChild(txtScroll);
			}
			
			
			removeChild(i);
			super.outro();
		}
	}
}