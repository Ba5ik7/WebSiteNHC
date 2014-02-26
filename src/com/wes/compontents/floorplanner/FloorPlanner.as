package com.wes.compontents.floorplanner
{
	import com.wes.compontents.Buttons.Button;
	import com.wes.compontents.Tables;
	import com.wes.objects.TableObj;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FloorPlanner extends Sprite
	{
		
		private var _con : Sprite;
		private var _tabOp : Sprite;
		private var _tarTab : Tables;
		private var _data : *;
		
		public var tabArray : Array = new Array();
		
		private var thisWidth : Number;
		private var thisHeight : Number;
				
		private var addTableBtn : Button = new Button("Add", 22, 0X000000, 100, 30, 0XFFFFFF, 1, 0X000000, false);
		private var deleteTableBtn : Button = new Button("Delete", 22, 0X000000, 100, 30, 0XFFFFFF, 1, 0X000000, false);
		private var rotateTableBtn : Button = new Button("Rotate", 22, 0X000000, 100, 30, 0XFFFFFF, 1, 0X000000, false);
		
		private var smallTableBtn : Button = new Button("Small", 22, 0X000000, 100, 30, 0XFFFFFF, 1, 0X000000, false);
		private var medTableBtn : Button = new Button("Med", 22, 0X000000, 100, 30, 0XFFFFFF, 1, 0X000000, false);
		private var largeTableBtn : Button = new Button("Large", 22, 0X000000, 100, 30, 0XFFFFFF, 1, 0X000000, false);

		public function FloorPlanner(dataW : *, _thisWidth : Number = 500, _thisHeight : Number = 500)
		{
			_data = dataW;
			thisWidth = _thisWidth;
			thisHeight = _thisHeight;
			
			
			createCon();
			createTab();
			createBtn();
			
			super();
		}
		

		
		public function edit () :void {
			addChild(addTableBtn);
			addTableBtn.addEventListener(MouseEvent.CLICK, addTab);
			
			
			for each (var tab : Tables in tabArray) {
				tab.buttonMode = true;
				tab.addEventListener(MouseEvent.MOUSE_DOWN, tabOnMouseDown);
				
			}
		}
		
		public function notEdit () :void {
			removeChild(addTableBtn);
			
			if(deleteTableBtn.stage)
			{
				removeChild(deleteTableBtn);
				removeChild(rotateTableBtn);
			}
			
			for each (var tab : Tables in tabArray) {
				tab.buttonMode = false;
				tab.removeEventListener(MouseEvent.MOUSE_DOWN, tabOnMouseDown);
				
			}
		}
		
		
		
		
		private function addTab(event:MouseEvent):void
		{
			
			
			smallTableBtn.addEventListener(MouseEvent.CLICK, tabSizeClick);
			medTableBtn.addEventListener(MouseEvent.CLICK, tabSizeClick);
			largeTableBtn.addEventListener(MouseEvent.CLICK, tabSizeClick);

			addChild(_tabOp);
			
			smallTableBtn.x = 25;
			smallTableBtn.y = 25;
			
			medTableBtn.x = 25;
			medTableBtn.y = smallTableBtn.y + (smallTableBtn.height +20);
			
			largeTableBtn.x = 25;
			largeTableBtn.y = medTableBtn.y + (medTableBtn.height +20);
			
			_tabOp.addChild(smallTableBtn);
			_tabOp.addChild(medTableBtn);
			_tabOp.addChild(largeTableBtn);
			
		}
		
		private function tabSizeClick(event:MouseEvent):void
		{
			
			removeChild(_tabOp);
			
			var table : Tables = new Tables(event.target.name);
			table.x = 50;
			table.y = 50;
			table.rotation = 0;
			tabArray.push(table);
			
			table.id = tabArray.length;
			table.startX = 50;
			table.startY = 50;
			table.startR = 0;
			
			table.mouseChildren = false;
			
			table.addEventListener(MouseEvent.MOUSE_DOWN, tabOnMouseDown);
			
			
			table.buttonMode = true;
			_tarTab = table;
			
			_con.addChild(table);
			
		}
		
		private function tabOnMouseMove(event:MouseEvent):void {
			
			
			_tarTab.x = goodX(this.mouseX);
			_tarTab.y = goodY(this.mouseY);
			
			event.updateAfterEvent();
			
		}
		
		private function goodX(inX:Number):Number {
			if (inX < 0 + (_tarTab.width * .5)) {
				return _tarTab.width * .5;
			}
			
			if (inX > _con.width - (_tarTab.width * .5)) {
				return _con.width - (_tarTab.width * .5);
			}
			
			return inX;
		}
		
		private function goodY(inY:Number):Number {
			if (inY <  0 + (_tarTab.height * .5 )) {
				return _tarTab.height * .5;
			}
			
			if (inY > _con.height - (_tarTab.height * .5)) {
				return _con.height - (_tarTab.height * .5);
			}
			
			return inY;
		}
		
		private function tabOnMouseUp(event:MouseEvent):void{
			RootLevel.stage.removeEventListener(MouseEvent.MOUSE_UP, tabOnMouseUp);
			RootLevel.stage.removeEventListener(MouseEvent.MOUSE_MOVE, tabOnMouseMove);
			_tarTab.startX = _tarTab.x;
			_tarTab.startY = _tarTab.y;
			
		}
		
		private function tabOnMouseDown(event:MouseEvent):void{
			addChild(deleteTableBtn);
			addChild(rotateTableBtn);
			
			_tarTab = event.target as Tables;
			
			RootLevel.stage.addEventListener(MouseEvent.MOUSE_MOVE, tabOnMouseMove);
			RootLevel.stage.addEventListener(MouseEvent.MOUSE_UP, tabOnMouseUp);
			
			deleteTableBtn.addEventListener(MouseEvent.CLICK, removeTarTab);
			rotateTableBtn.addEventListener(MouseEvent.CLICK, rotateTarTab);
		}
		
		
		
		
		
		private function rotateTarTab(event:MouseEvent):void
		{
			_tarTab.rotation += 15;
		}
		
		private function removeTarTab(event:MouseEvent):void
		{
			_con.removeChild(_tarTab);
			tabArray = removeArrayItem(tabArray, "id", _tarTab.id);
			_tarTab = tabArray[0] as Tables;
		}
		
		private function removeArrayItem(array: Array, propertyName: String, value: *): Array
		{
			var newArray: Array = [];
			for (var index: int = 0; index < array.length; index++) {
				var item: Object = array[index];
				if (item && item.hasOwnProperty(propertyName)) {
					if (item[propertyName] != value)
						newArray.push(item);
				}
			}
			return newArray;
		}
		
		
		
		private function createBtn():void
		{
			addTableBtn.x = thisWidth + 10;
			addTableBtn.y = 25;
			
			deleteTableBtn.x = thisWidth + 10;
			deleteTableBtn.y = addTableBtn.y + (addTableBtn.height + 20);
			
			rotateTableBtn.x = thisWidth + 10;
			rotateTableBtn.y = deleteTableBtn.y + (deleteTableBtn.height + 20);
		}
		private function createTab():void
		{
			for each (var tab : TableObj in _data){
				var table : Tables = new Tables(tab.type);
				table.x = tab.x;
				table.y = tab.y;
				table.rotation = tab.rotation;
				
				table.id = tab.id;
				table.startX = tab.x;
				table.startY = tab.y;
				table.startR = tab.rotation;
				
				table.mouseChildren = false;
				
				tabArray.push(table);
				
				_con.addChild(table);
			}
			
		}
		private function createCon():void
		{
			
			_tabOp = new Sprite;
			_tabOp.graphics.lineStyle(1, 0X000000);
			_tabOp.graphics.beginFill(0xffffff);
			_tabOp.graphics.drawRect(0,0,thisWidth,thisHeight);
			_tabOp.graphics.endFill();
			_tabOp.width = thisWidth;
			_tabOp.height = thisHeight;
			
		    _con = new Sprite;
			_con.graphics.lineStyle(1, 0X000000);
			_con.graphics.beginFill(0xffffff);
			_con.graphics.drawRect(0,0,thisWidth,thisHeight);
			_con.graphics.endFill();
			_con.width = thisWidth;
			_con.height = thisHeight;
			
			addChild(_con);
			
			
			
		}
		
		
	}
}