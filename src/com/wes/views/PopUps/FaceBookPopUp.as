package com.wes.views.PopUps
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Buttons.Button;
	import com.wes.compontents.RSSFacebook.RSSFacebookTileScroller;
	import com.wes.tools.HTMLPageUtils;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class FaceBookPopUp extends PopUp
	{
		
		private var title : TextField;
		private var title_tf:TextFormat;
		
		private var _con : Sprite;
		
		private var fbLikeBtn : Button = new Button("Like", 22, 0x000000, 100, 40,0xFFFFFF, 1, 0xd79532, false);
		private var fbShareBtn : Button = new Button("Share", 22, 0x000000, 100, 40,0xFFFFFF, 1, 0xd79532, false);

		
		private var facebook : RSSFacebookTileScroller;
		
		
		[Embed(source = "../../../../images/logoFlag.png")]
			private var LogoFlag:Class;
		
		public function FaceBookPopUp(_data:*)
		{
			super(_data);
			_con = new Sprite();
			_con.graphics.lineStyle(3, 0xd79532);
			_con.graphics.beginFill(0x000000, 1);
			_con.graphics.drawRect(0, 0, 900, 500);
			_con.graphics.endFill();
			_con.x = (RootLevel.stage.stageWidth/2)-(_con.width/2);
			_con.y = -_con.height;
			addChild(_con);
			
			facebook = new RSSFacebookTileScroller(data);
			facebook.x = 10;
			facebook.y = 90;
			_con.addChild(facebook);
			
			title_tf = new TextFormat("HANAB", 32, 0xFFFFFF, true);
			title_tf.align = "left";
			
			title = new TextField();
			title.embedFonts = true;
			title.defaultTextFormat = title_tf;
			title.text = "North Harbor Club";
			title.selectable = false;
			title.wordWrap = title.multiline = false;
			title.x = 110;
			title.y =  30;
			title.autoSize = "left";
			_con.addChild(title);

			var logoFlag : BitmapData = new LogoFlag().bitmapData;
			var logoFlagCon : Sprite = new Sprite();
			logoFlagCon.graphics.beginBitmapFill(logoFlag);
			logoFlagCon.graphics.drawRect(0,0, logoFlag.width, logoFlag.height);
			logoFlagCon.graphics.endFill();
			logoFlagCon.x = 20;
			logoFlagCon.y = 15;
			_con.addChild(logoFlagCon);
			
			
			fbShareBtn.addEventListener(MouseEvent.CLICK, shareOpen);
			fbShareBtn.x = 650;
			fbShareBtn.y = 30;
			_con.addChild(fbShareBtn);
			
			fbLikeBtn.addEventListener(MouseEvent.CLICK, likeOpen);
			fbLikeBtn.x = 760;
			fbLikeBtn.y = 30;
			_con.addChild(fbLikeBtn);
			
		}
		
		private function shareOpen(event:MouseEvent):void{
			HTMLPageUtils.viewPopup("https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Fbmwz4free.com%2FSANDBOX%2FNHC%2F&t=North+Harbor+Club+Website", "popup", 675, 375);
		}
		
		private function likeOpen (event : MouseEvent ) : void {
			HTMLPageUtils.viewPopup("https://www.facebook.com/plugins/like.php?href=facebook.com/pages/North-Harbor-Club-Davidson-NC/322548597302", "popup", 300, 100);
		}
		
		override protected function intro () : void {
			super.intro();
			TweenMax.to(_con, .5, {y:(RootLevel.stage.stageHeight/2)-250, ease:Expo.easeInOut});
		}
		
		override protected function outro () : void {
			
			TweenMax.to(_con, .5, {y:RootLevel.stage.stageHeight + 250, ease:Expo.easeInOut, onComplete:clean});
		}
		
		private function clean () :void {
			removeChild(_con);
			super.outro();
		}
	}
}