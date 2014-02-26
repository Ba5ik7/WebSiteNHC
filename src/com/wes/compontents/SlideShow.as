package com.wes.compontents
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.wes.objects.HomeSliderPageObj;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class SlideShow extends Sprite
	{
		
		
		
		private var t : Timer;
		
		private var counter : int;
		
		private var slideArr : Array;
		
		private var currentSlide : HomeSliderPageObj;
		
		private var currentImage : Bitmap;
		
		private var oldImage : Bitmap;
		
		private var txtFieldTitle : TextField;
		
		private var txtFieldContent : TextField;
		
		private var txtFormatTitle : TextFormat;
		
		private var txtFormatContent : TextFormat;

		private var con : Sprite;
		
		
		public function SlideShow(_arr : Array) {
			super();
			slideArr = _arr;
			
			
			con = new Sprite;
			addChild(con);
			
			currentSlide = _arr[counter];
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
			con.addChild(txtFieldTitle);
			
			
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
			con.addChild(txtFieldContent);
		}
		
		
		private function changeSlide (event : TimerEvent) : void {
			
			oldImage = new Bitmap(currentSlide.image.bitmapData);
			con.addChild(oldImage);
			con.removeChild(currentImage);
			
			counter >= slideArr.length - 1 ? counter = 0 : ++counter ;
			
			currentSlide = slideArr[counter];
			currentImage = new Bitmap(currentSlide.image.bitmapData);
			con.addChildAt(currentImage, 0);
			
			TweenMax.to(oldImage, 1, {alpha:0, ease:Sine.easeOut, onComplete:cleanOldImage});
			
			txtFieldTitle.text = currentSlide.title;
			txtFieldContent.text = currentSlide.txt;
		}
		
		private function cleanOldImage () : void {
			con.removeChild(oldImage);
		}
		
	}
}