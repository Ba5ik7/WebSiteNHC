package com.wes.compontents
{
	import com.wes.objects.EventsEventObj;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class HomeEventTile extends Fonts
	{
		private var txt : TextField;
		private var title : TextField;
		private var titleTF: TextFormat;
		private var txtTF: TextFormat;
		
		private var _image :Bitmap;
		
		private var _con : Sprite;
		
		public var beginX :Number;
		public var beginY :Number;
		public var futureX :Number;
		public var futureY :Number;
		
		
		
		//Add _image :Bitmap
		public function HomeEventTile(eventObj:EventsEventObj)
		{
			super();
			this.graphics.lineStyle(3, 0xe08c1f);
			this.graphics.beginFill(0x000000,1);
			this.graphics.drawRect(0,0, 900,175);
			this.graphics.endFill();
			
			_con = new Sprite();
			_con.graphics.beginFill(0xFFFFFF,1);
			_con.graphics.drawRect(0,0, 880,155);
			_con.graphics.endFill();
			_con.x = 10;
			_con.y = 10;
			addChild(_con);
			
			var bd : BitmapData = Bitmap(eventObj.image).bitmapData;
			bd.draw(eventObj.image);
			_image = new Bitmap(bd);
			_image.x = 10;
			_image.y = 10;
			_image.scaleX = _image.scaleY = .6;
			_con.addChild(_image);
			
			var borader : Sprite = new Sprite;
			borader.graphics.lineStyle(3,0xd79532);
			borader.graphics.drawRect(0,0, _image.width, _image.height);
			borader.graphics.endFill();
			borader.x = 10;
			borader.y = 10;
			_con.addChild(borader);
			
			titleTF = new TextFormat();
			titleTF.color = 0x000000;
			titleTF.size = 28;
			titleTF.font ="caviarDreamBI";
			
			
			title = new TextField();
			title.embedFonts = true;
			title.defaultTextFormat = titleTF;
			title.text = (eventObj.date.month+1)+"/"+eventObj.date.date+"/"+eventObj.date.fullYear+" - "+eventObj.title ;
			title.selectable = false;
			title.autoSize = TextFieldAutoSize.RIGHT;
			title.x = 200;
			title.y = 10;
			_con.addChild(title);
			
			
			txtTF = new TextFormat();
			txtTF.color = 0x000000;
			txtTF.size = 20;
			txtTF.font ="caviarDreamB";
			
			txt = new TextField();
			txt.embedFonts = true;
			txt.defaultTextFormat = txtTF;
			txt.htmlText = eventObj.txt;
			txt.width = 600;
			txt.height = 75;
			txt.multiline = true;
			txt.wordWrap = true;
			txt.selectable = false;
			txt.x = 200;
			txt.y = 40;
			_con.addChild(txt);
			
		}
	}
}