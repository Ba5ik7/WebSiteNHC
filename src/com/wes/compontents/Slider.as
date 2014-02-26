package com.wes.compontents
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.objects.HomeSliderPageObj;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class Slider extends Sprite
	{
		
		
		
		private var t : Timer;
		
		private var counter : int;
		
		private var slideArr : Array;
		
		private var currentSlide : HomeSliderPageObj;
		
		private var currentImage : Bitmap;
		
		private var oldImage : Bitmap;
		
		private var masker : Shape;
		
		private var txtFieldTitle : TextField;
		
		private var txtFieldContent : TextField;
		
		private var txtFormatTitle : TextFormat;
		
		private var txtFormatContent : TextFormat;
		
		private var txtBox : Sprite;
		
		private var con : Sprite;
		
		
		public function Slider(_arr : Array) {
			super();
			slideArr = _arr;
			
			
			con = new Sprite;
			addChild(con);
			
			currentSlide = _arr[counter];
			buildMasker();
			currentImage = new Bitmap(currentSlide.image.bitmapData);
			con.addChild(currentImage);
			buildTxtBox();
			
			var borader : Sprite = new Sprite;
			borader.graphics.lineStyle(3,0xd79532);
			borader.graphics.drawRect(0,0, currentImage.width, currentImage.height);
			borader.graphics.endFill();
			addChild(borader);

			t = new Timer(4500);
			t.addEventListener(TimerEvent.TIMER, changeSlide);
			t.start();
		}
		
		private function buildTxtBox() : void {
			txtBox = new Sprite();
			txtBox.graphics.beginFill(0x000000, .7);
			txtBox.graphics.drawRect(0,0, currentImage.width, 100);
			txtBox.graphics.endFill();
			txtBox.y = currentImage.height;
			con.addChild(txtBox);
			
			txtFormatTitle = new TextFormat();
			txtFormatTitle.color = 0xFFFFFF;
			txtFormatTitle.size = 28;
			txtFormatTitle.font = "caviarDreamBI";
			
			txtFieldTitle = new TextField();
			txtFieldTitle.embedFonts = true;
			txtFieldTitle.defaultTextFormat = txtFormatTitle;
			txtFieldTitle.text = currentSlide.title;
			txtFieldTitle.width = currentImage.width - 20;
			txtFieldTitle.selectable = false;
			txtFieldTitle.autoSize = TextFieldAutoSize.LEFT;
			txtFieldTitle.x = 10;
			txtBox.addChild(txtFieldTitle);
			
			
			txtFormatContent = new TextFormat();
			txtFormatContent.color = 0xFFFFFF;
			txtFormatContent.size = 20;
			txtFormatContent.font = "caviarDream";
			
			txtFieldContent = new TextField();
			txtFieldContent.embedFonts = true;
			txtFieldContent.defaultTextFormat = txtFormatContent;
			txtFieldContent.text = currentSlide.txt;
			txtFieldContent.width = currentImage.width - 20;
			txtFieldContent.wordWrap = true;
			txtFieldContent.selectable = false;
			txtFieldContent.autoSize = TextFieldAutoSize.LEFT;
			txtFieldContent.x = 10;
			txtFieldContent.y = 30;
			txtBox.addChild(txtFieldContent);
			
			TweenMax.to(txtBox, .5, {y:currentImage.height - txtBox.height, ease:Expo.easeInOut});
		}
		
		private function buildMasker() : void {
			masker = new Shape;
			masker.graphics.lineStyle();
			masker.graphics.beginFill(0x000000, 1);
			masker.graphics.drawRect(0,0, currentSlide.image.width, currentSlide.image.height);
			masker.graphics.endFill();
			addChild(masker);
			con.mask = masker;
		}
		
		
		private function changeSlide (event : TimerEvent) : void {
			TweenMax.to(txtBox, .5, {y:currentImage.height, onComplete:showTxtBox, ease:Expo.easeOut});
			
			oldImage = new Bitmap(currentSlide.image.bitmapData);
			con.addChildAt(oldImage, 0);
			con.removeChild(currentImage);
			if (counter >= slideArr.length - 1){ counter = 0;
			} else { ++counter; }
			currentSlide = slideArr[counter];
			currentImage = new Bitmap(currentSlide.image.bitmapData);
			currentImage.x = currentImage.width;
			con.addChildAt(currentImage, 0);
			
			
			TweenMax.to(currentImage, .5, {x:0, ease:Expo.easeOut});
			TweenMax.to(oldImage, .5, {x:-1*(currentSlide.image.width), onComplete:cleanOldImage, ease:Expo.easeOut});
		}
		
		
		private function showTxtBox () : void {
			txtFieldTitle.text = currentSlide.title;
			txtFieldContent.text = currentSlide.txt;
			TweenMax.to(txtBox, .5, {y:currentImage.height - txtBox.height, ease:Expo.easeOut});
		}
		
		private function cleanOldImage () : void {
			con.removeChild(oldImage);
		}
		
	}
}