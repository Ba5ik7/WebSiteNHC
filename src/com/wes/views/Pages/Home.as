package com.wes.views.Pages
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Buttons.HomeButton;
	import com.wes.compontents.Slider;
	import com.wes.objects.HomeBtnObj;
	import com.wes.objects.HomeSliderPageObj;

	
	public class Home extends Page
	{
		
		private var btnWidth : Number;
		private var slideWidth : Number;
		
		private var gridXGap : Number = 15;
		private var gridYGap : Number = 15;
		
		private var arrBtn : Array = new Array();
		private var arrSilde : Array = new Array();
		
		private var slider : Slider;
		
		
		public function Home(_data : *)
		{
			super(_data);
			
			name = "home";
			
			
			for each (var homeBtn: HomeBtnObj in data[0]) {
				var btn : HomeButton = new HomeButton(homeBtn);
				arrBtn.push(btn);
			}
			btnWidth = arrBtn[0].width;
			
			for each (var homeSlider : HomeSliderPageObj in data[1]) {
				arrSilde.push(homeSlider);
			}
			slideWidth = arrSilde[0].image.width;
			
			
			buildButtons();
			buildSlider();
		}
		
		private function buildButtons() : void {
			var index : int ;
			var col : int = 2;
			var row : int = 2;
			for (var i : int = 0; i <= col - 1; ++i) {
				for (var j : int = 0; j <= row - 1; ++j) {
					index = (i * row + j);
					var cardwidth : Number = arrBtn[index].width;
					var cardheight : Number = arrBtn[index].height;
					
					
					arrBtn[index].x = Math.random()*RootLevel.stage.width;
					arrBtn[index].y = Math.random()*RootLevel.stage.height;
					arrBtn[index].rotation = Math.random()*180-180;
					arrBtn[index].z = Math.random()*500;
					arrBtn[index].futureX = j * (cardwidth + (slideWidth + gridXGap*2));
					arrBtn[index].futureY = i * (cardheight + gridYGap);
					arrBtn[index].alpha = 0;
					addChildAt(arrBtn[index],0);
				}
			}
		}
		

		private function buildSlider() : void {
			slider = new Slider(arrSilde);
			slider.x = btnWidth + 12.5;
			slider.y = -500;
			slider.alpha = 0;
			addChild(slider);
		}
		
		
		override protected function intro () : void {
			for each (var i:HomeButton in arrBtn) {
				TweenMax.to(i, .5,{alpha:1, 
									x:i.futureX,
									y:i.futureY,
									z:0,
									rotation:0,
									ease:Expo.easeInOut});
			}
				TweenMax.to(slider, .5,{alpha:1, 
									y:0,
									ease:Expo.easeInOut});
		}
		
		override protected function outro () : void {
			
			for each (var i:HomeButton in arrBtn) {
				TweenMax.to(i, .5,{alpha:0, x:Math.random()*RootLevel.stage.width,
											y:Math.random()*RootLevel.stage.height,
											z:Math.random()*200-400,
											rotation:Math.random()*180-90,
											ease:Expo.easeInOut});
			}

			TweenMax.to(slider, .5,{alpha:0,
									y:400,
									onComplete:clean,
									ease:Expo.easeInOut});
		}
		
		private function clean() : void {
			super.outro();
		}
	}
}