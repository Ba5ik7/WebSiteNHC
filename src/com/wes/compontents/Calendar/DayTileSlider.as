package com.wes.compontents.Calendar
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.objects.EventsEventObj;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class DayTileSlider extends Sprite
	{
		
		private var _t : Timer;
		
		private var _counter : int;
		
		private var _slideArr : Array;
		
		private var _currentSlide : EventsEventObj;
		
		private var _currentImage : Bitmap;
		
		private var _oldImage : Bitmap;
		
		private var _masker : Shape;
		
		private var _width : int;
		
		private var _height : int;
		
		
		public function DayTileSlider(_array : Array, _widthW:int, _hieghtD:int)
		{
			super();
			_slideArr = _array;
			_width = _widthW;
			_height = _hieghtD;

			_currentSlide = _array[_counter];
			
			buildMasker();
			_currentImage = new Bitmap(_currentSlide.image.bitmapData);
			_currentImage.width = _width;
			_currentImage.height = _height;
			addChild(_currentImage);
			
			_t = new Timer(4500);
			_t.addEventListener(TimerEvent.TIMER, changeSlide);
			_t.start();
		}
		
		private function buildMasker() : void {
			_masker = new Shape;
			_masker.graphics.lineStyle();
			_masker.graphics.beginFill(0x000000, 1);
			_masker.graphics.drawRect(0,0, _width, _height);
			_masker.graphics.endFill();
			addChild(_masker);
			this.mask = _masker;
		}
		
		private function changeSlide (event : TimerEvent) : void {
			
			_oldImage = new Bitmap(_currentSlide.image.bitmapData);
			_oldImage.width = _width;
			_oldImage.height = _height;
			addChildAt(_oldImage, 0);
			
			removeChild(_currentImage);
			
			if (_counter >= _slideArr.length - 1){ _counter = 0;
			} else { ++_counter; }
			_currentSlide = _slideArr[_counter];
			
			_currentImage = new Bitmap(_currentSlide.image.bitmapData);
			_currentImage.width = _width;
			_currentImage.height = _height;
			addChildAt(_currentImage, 0);

			TweenMax.to(_oldImage, .5, {x:-1*(_width), onComplete:cleanOldImage, ease:Expo.easeIn});
		}
		
		private function cleanOldImage () : void {
			removeChild(_oldImage);
		}
		
		
		public function stop () : void {_t.stop();}
		public function start() : void {_t.start();}
	}
}