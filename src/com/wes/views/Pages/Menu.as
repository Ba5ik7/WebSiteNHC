package com.wes.views.Pages
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Buttons.FoodMenuButton;
	import com.wes.objects.MenuFoodObj;

	public class Menu extends Page
	{
		
		private var arrBtn : Array = new Array();
		private var cleanCount : int;
		
		public function Menu(_data : *)
		{
			super(_data);
			cleanCount = 0;
			var yoD : Number = new Number();
			
			for each (var menuBtn: MenuFoodObj in data) {
				var btn : FoodMenuButton = new FoodMenuButton(menuBtn);
				btn.x = Math.random()*RootLevel.stage.width;
				btn.y = Math.random()*RootLevel.stage.height;
				btn.rotation = Math.random()*180-180;
				btn.z = Math.random()*500;
				btn.futureX = yoD;
				btn.futureY = 0;
				btn.alpha =0;
				btn.mouseChildren = true;
				
				addChild(btn);
				arrBtn.push(btn);
				
				yoD += 220;
			}
		}
		
		override protected function intro () : void {
			for each (var i:* in arrBtn) {
				
				//onComplete:aminamtionComplete("intro"),
				TweenMax.to(i, .5,{alpha:1, 
					x:i.futureX,
					y:0,
					z:0,
					rotation:0,
					ease:Expo.easeInOut});
			}
		}
		
		override protected function outro () : void {
			for each (var i:* in arrBtn) {
				TweenMax.to(i, .5,{alpha:0, x:Math.random()*RootLevel.stage.width,
					y:Math.random()*RootLevel .stage.height,
					z:Math.random()*200-400,
					rotation:Math.random()*180-90,
					onComplete:clean,
					ease:Expo.easeInOut});
			}
		}
		
		private function clean() : void {
			++cleanCount;
			if (cleanCount >= data.length){
				super.outro();
			}
			
		}
	}
}