package  com.wes.compontents.ComboBox
{

	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Fonts;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ComboBox extends Fonts{
		
		private var arrListItems : Array = new Array();
		private var item : ComboBoxListItem;
		private var b:Boolean = false;
		
		private var _tf : TextFormat;
		private var _selectedItemLabeltf : TextFormat;
		private var title : TextField;
		
		public var selectedItemLabel : TextField;
		
		private var  masker : Sprite;
		private var scroller : ComboBoxScroller;

		public function ComboBox(_title:String, _arr:Array) {
			var i : int;
			for each (var strg : String in _arr) {
				item = new ComboBoxListItem(strg);
				item.y = 0;
				item.name = "item" + i;
				item.mouseChildren = false;
				item.buttonMode = true;
				item.addEventListener(MouseEvent.CLICK, itemClick);
				arrListItems.push(item);
				++i;
			}
			
			scroller = new ComboBoxScroller(300, 101, arrListItems);
			scroller.y = -scroller.height;
			
			buildMasker();
			createTitleTxt(_title);
			createSelectedItemLabel("----- Select One -----");
		}
		
		private function buildMasker() : void {
			masker = new Sprite;
			masker.graphics.beginFill(0x000000, 1);
			masker.graphics.drawRect(0,0, 425, 126);
			masker.graphics.endFill();
			masker.x = -199;
			//Mabe Fix
			this.mask = masker;
			addChild(masker);
		}
		
		private function createSelectedItemLabel(_txt:String):void{
			var cb : Sprite = new Sprite();
			cb.buttonMode = true;
			cb.addEventListener(MouseEvent.CLICK, checkDropDown);
			cb.mouseChildren = false;
			cb.graphics.lineStyle(1, 0x000000);
			cb.graphics.beginFill(0xFFFFFF, 1);
			cb.graphics.drawRect(0,0, 200, 25);
			cb.graphics.endFill();
			addChild(cb);
			
			_selectedItemLabeltf = new TextFormat();
			_selectedItemLabeltf.color = 0x000000;
			_selectedItemLabeltf.size = 16;
			_selectedItemLabeltf.bold = true;
			_selectedItemLabeltf.font ="verdana";
			_selectedItemLabeltf.align = "center";
			
			
			selectedItemLabel = new TextField();
			selectedItemLabel.defaultTextFormat = _selectedItemLabeltf;
			selectedItemLabel.text =  _txt;
			selectedItemLabel.wordWrap = selectedItemLabel.multiline = selectedItemLabel.selectable = false;
			selectedItemLabel.width = 200;
			selectedItemLabel.height = 25;
			cb.addChild(selectedItemLabel);
		}		
		
		private function createTitleTxt(_title:String) : void {
			_tf = new TextFormat();
			_tf.color = 0x000000;
			_tf.size = 18;
			_tf.font ="caviarDreamBI";
			
			title = new TextField();
			title.embedFonts = true;
			title.defaultTextFormat = _tf;
			title.text = _title;
			title.selectable = false;
			title.autoSize = TextFieldAutoSize.LEFT;
			title.x = 0-title.width-5;
			addChild(title);
			
		}
		
		private function checkDropDown(event:MouseEvent):void{;
			if(b == false){downDrop();
			}else{upDrop();}
		}
		
		private function closeDropDown():void{
			if(b == false){downDrop();
			}else{upDrop();}
		}
		
		private function upDrop():void{
			TweenMax.to(scroller.thumb, .3, {alpha:0, ease:Expo.easeOut});
			TweenMax.to(scroller.track, .3, {alpha:0, ease:Expo.easeOut});
			TweenMax.to(scroller, .5, {y:-100, ease:Expo.easeOut, onComplete:this.removeChild, onCompleteParams:[scroller]});
			b = false;
		}
		
		
		private function downDrop():void{
			
			addChildAt(scroller, 0);
			TweenMax.to(scroller.thumb, .3, {alpha:1, ease:Expo.easeOut});
			TweenMax.to(scroller.track, .3, {alpha:1, ease:Expo.easeOut});
			TweenMax.to(scroller, .3, {y:25, ease:Expo.easeOut});
			b = true;
		}
		
		
		private function itemClick(event:MouseEvent):void  {
			selectedItemLabel.text = event.target._txt.text;
			closeDropDown();
			
		}

	}
	
}

