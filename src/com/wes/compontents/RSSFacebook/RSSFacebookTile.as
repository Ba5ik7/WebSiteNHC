package com.wes.compontents.RSSFacebook
{
	import com.wes.objects.FacebookRSSItemObj;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import com.wes.compontents.Fonts;

	public class RSSFacebookTile extends Fonts
	{
		
		private var title : TextField;
		private var date : TextField;
		private var content : TextField;
		
		private var title_tf:TextFormat;
		private var date_tf:TextFormat;
		private var content_tf:TextFormat;
		
		public function RSSFacebookTile(item:FacebookRSSItemObj)
		{
			super();
			
			configStyle();
				date = new TextField();
				date.embedFonts = true;
				date.defaultTextFormat = date_tf;
				date.text = item.pubDate.month + "/"+item.pubDate.date+"/"+item.pubDate.fullYear;
				date.selectable = false;
				date.x = 10;
				date.y = 10;
				date.autoSize = TextFieldAutoSize.LEFT;
				
				title = new TextField();
				title.embedFonts = true;
				title.defaultTextFormat = title_tf;
				title.text = (item.title == null ? "NULL" :item.title);
				title.selectable = false;
				title.wordWrap = title.multiline = true;
				title.x = 10;
				title.y =  date.y + date.height+10;
				title.width = 870;
				title.autoSize = TextFieldAutoSize.LEFT;
				
				content = new TextField();
				content.embedFonts = true;
				content.defaultTextFormat = content_tf;
				content.htmlText = (item.description == null ? "NULL" : "<table width='200' border='1' cellspacing='0'><tr><td width='200'>"+item.description+"</td></tr></table>");
				content.selectable = false;
				content.wordWrap = content.multiline = true;
				content.x = 10;
				content.y = title.y + title.height+10;
				content.width = 870;
				content.autoSize = TextFieldAutoSize.LEFT;
				
				addChild(title);
				addChild(date);
				addChild(content);
			

			var bgHeight : Number = new Number();
			bgHeight = title.height+date.height+content.height+40;
			
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(0, 0, 880, bgHeight);
			this.graphics.endFill();
		}
		
		private function configStyle():void
		{
			title_tf = new TextFormat("caviarDreamBI", 28, 0x000000, true);
			title_tf.align = "left";
			
			date_tf = new TextFormat("caviarDreamBI", 18, 0x000000, true); 
			date_tf.align = "left";
			
			content_tf = new TextFormat("caviarDreamB", 22,  0x000000);
			content_tf.align = "left";
		}
		
		
	}
}