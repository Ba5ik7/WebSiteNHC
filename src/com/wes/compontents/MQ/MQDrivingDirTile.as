package com.wes.compontents.MQ
{
	import com.wes.compontents.Fonts;
	import com.wes.objects.DrivingDirTileObj;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class MQDrivingDirTile extends Fonts
	{
		
		
		private var list : TextField;
		private var de:TextFormat;
		
		public function MQDrivingDirTile(item:DrivingDirTileObj)
		{
			super();
			
			de = new TextFormat("caviarDreamB", 18, 0x000000, true);
			de.align = "left";
			
			list = new TextField();
			list.embedFonts = true;
			list.defaultTextFormat = de;
			list.text = item.maneuver + " - " + item.distance + " - " + item.time;
			list.selectable = false;
			list.wordWrap = list.multiline = true;
			list.width = 870;
			list.autoSize = TextFieldAutoSize.LEFT;
			

			addChild(list);
			
		}
		
	}
}