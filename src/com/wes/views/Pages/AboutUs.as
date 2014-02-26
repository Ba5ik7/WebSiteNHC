package com.wes.views.Pages
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.TextScroller;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class AboutUs extends Page
	{
		private var tileBL : Sprite;
		private var tileR : Sprite;
		private var imgCon : Sprite;
		private var _tf : TextFormat;
		private var _txt : TextField;
		
		private var textScroller : TextScroller;
		
		
		[Embed(source = "../../../../images/aboutUsOrb.jpg")]
			private var Orb:Class;
		[Embed(source = "../../../../images/logoFlag.png")]
			private var LogoFlag:Class;
		
		public function AboutUs(_data : *)
		{
			name = "aboutUs";
			super(_data);
			//Right Backgroud Tile
			tileR = new Sprite;
			tileR.graphics.clear();
			tileR.graphics.lineStyle(3,0xd79532);
			tileR.graphics.beginFill(0xFFFFFF);
			tileR.graphics.drawRect(0,0, 875, 455);
			tileR.graphics.endFill();
			tileR.alpha = 0;
			tileR.x = 250 + 15;
			tileR.y = -800;
			//Add Text Scroller to Backgroud
			textScroller = new TextScroller(845, 355, _data.txt);
			textScroller.x = 10;
			textScroller.y = 95;
			tileR.addChild(textScroller);
			//Add Title to Backgroud
			_tf = new TextFormat();
			_tf.color = 0x000000;
			_tf.size = 32;
			_tf.font ="HANAB";
			_txt = new TextField();
			_txt.embedFonts = true;
			_txt.defaultTextFormat = _tf;
			_txt.text = data.title;
			_txt.autoSize = TextFieldAutoSize.RIGHT;
			_txt.x = 100;
			_txt.y = 25;
			_txt.selectable = false;
			tileR.addChild(_txt);
			
			var orb : BitmapData = new Orb().bitmapData;
			var orbCon : Sprite = new Sprite();
			orbCon.graphics.beginBitmapFill(orb);
			orbCon.graphics.drawRect(0,0, orb.width, orb.height);
			orbCon.graphics.endFill();
			orbCon.x = 500;
			orbCon.y = 30;
			tileR.addChild(orbCon);
			
			var logoFlag : BitmapData = new LogoFlag().bitmapData;
			var logoFlagCon : Sprite = new Sprite();
			logoFlagCon.graphics.beginBitmapFill(logoFlag);
			logoFlagCon.graphics.drawRect(0,0, logoFlag.width, logoFlag.height);
			logoFlagCon.graphics.endFill();
			logoFlagCon.x = 20;
			logoFlagCon.y = 15;
			tileR.addChild(logoFlagCon);
			
			addChild(tileR);
			
			//Image
			var bd : BitmapData = Bitmap(data.image).bitmapData;
			bd.draw(_data.image);
			var img : Bitmap = new Bitmap(bd);
			
			imgCon = new Sprite();
			
			var imgConLine : Sprite = new Sprite();
			imgConLine.graphics.lineStyle(3,0xd79532);
			imgConLine.graphics.drawRect(0,0, bd.width, bd.height);
			imgConLine.graphics.endFill();
			
			
			imgCon.alpha = 0;
			imgCon.x = Math.random()*RootLevel.stage.width;
			imgCon.y = Math.random()*RootLevel.stage.height;
			imgCon.rotation = Math.random()*180-180;
			imgCon.z = Math.random()*500;
			addChild(imgCon);
			imgCon.addChild(img);
			imgCon.addChild(imgConLine);
			
			
			//Bottom Left Tile
			tileBL = new Sprite;
			tileBL.graphics.clear();
			tileBL.graphics.lineStyle(3,0xd79532);
			tileBL.graphics.beginFill(0xFFFFFF);
			tileBL.graphics.drawRect(0,0, 250, 80);
			tileBL.graphics.endFill();
			tileBL.alpha = 0;
			tileBL.x = Math.random()*RootLevel.stage.width;
			tileBL.y = Math.random()*RootLevel.stage.height;
			tileBL.rotation = Math.random()*180-180;
			tileBL.z = Math.random()*500;
			addChild(tileBL);
		}
		
		override protected function intro () : void {
			TweenMax.to(tileBL, .5,{alpha:1, 
				x:890,
				y:0,
				z:0,
				rotation:0,
				ease:Expo.easeInOut});
			
			TweenMax.to(tileR, .5,{alpha:1, 
				x:0,
				y:0,
				z:0,
				rotation:0,
				ease:Expo.easeInOut});
			
			TweenMax.to(imgCon, .5,{alpha:1, 
				x:890,
				y:95,
				z:0,
				rotation:0,
				ease:Expo.easeInOut});
		}
		
		override protected function outro () : void {
			TweenMax.to(tileBL, .5,{alpha:0, 
									x:Math.random()*RootLevel.stage.width,
									y:Math.random()*RootLevel.stage.height,
									z:Math.random()*200-400,
									rotation:Math.random()*180-90,
									ease:Expo.easeInOut});
			
			TweenMax.to(tileR, .5,{alpha:0, 
									y:400,
									ease:Expo.easeInOut});
			
			TweenMax.to(imgCon, .5,{alpha:0, 
									x:Math.random()*RootLevel.stage.width,
									y:Math.random()*RootLevel.stage.height,
									z:Math.random()*200-400,
									rotation:Math.random()*180-90,
									onComplete:clean,
									ease:Expo.easeInOut});
		}
		
		private function clean() : void {
			super.outro();
		}
	}
}