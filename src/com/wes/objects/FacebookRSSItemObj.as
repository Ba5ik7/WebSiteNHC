package com.wes.objects
{
	public class FacebookRSSItemObj
	{
		public var title : String;
		public var description :String;
		public var pubDate : Date;
		
		public function FacebookRSSItemObj(_title:String, _description:String, _date:String)
		{
			title = _title;
			description = _description;
			pubDate = new Date(_date);
		}
	}
}