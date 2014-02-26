package com.wes.views.PopUps
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.mapquest.LatLng;
	import com.mapquest.services.directions.Directions;
	import com.mapquest.services.directions.DirectionsEvent;
	import com.mapquest.tilemap.Size;
	import com.mapquest.tilemap.TileMap;
	import com.mapquest.tilemap.pois.Poi;
	import com.wes.compontents.Buttons.Button;
	import com.wes.compontents.MQ.MapQDrivingDirSroller;
	import com.wes.compontents.TextInput;
	import com.wes.objects.DrivingDirTileObj;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class MapPopUp extends PopUp
	{
		private var _con : Sprite;
		private var _whiteBg : Sprite;
		
		private var _infoTxt : TextField;
		private var infoDefultTxt : String = "<span class='caviarDream'><font size='22'>Just put your address where you are coming from.</font></span>";
		private var infoLoadingTxt : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Loading Please Wait</font></span>";
		private var infoThxU: String = "<span class='caviarDream'><font size='22'>See you soon</font></span>";

		
		private var fromTI :TextInput =new TextInput("From :", 300);
		private var toTI : String = "100-D North Harbor Place Davidson, NC 28036";

		private var getRouteBTN : Button = new Button("Get Route", 18, 0x000000, 100, 24, 0xFFFFFF, 1, 0x000000, false);
		private var mapListSwitchBTN : Button = new Button("Driving Directions", 22, 0x000000, 200, 30, 0xFFFFFF, 1, 0x000000, false);
		
		
		private var map:TileMap = new TileMap("Fmjtd%7Cluua25uanh%2C80%3Do5-962x5f");
		private var myPoi:Poi;
		private var testTERRY : MapQDrivingDirSroller;
		
		private var arrLocations:Array;
		private var dir:Directions;
		private var alResults:Array;
		
		public function MapPopUp(_data:*) {
			super(_data);
			
			_con = new Sprite();
			_con.graphics.lineStyle(3, 0xd79532);
			_con.graphics.beginFill(0x000000, 1);
			_con.graphics.drawRect(0, 0, 900, 500);
			_con.graphics.endFill();
			_con.x = (RootLevel.stage.stageWidth/2)-(_con.width/2);
			_con.y = -_con.height;
			addChild(_con);
			
			_whiteBg = new Sprite();
			_whiteBg.graphics.beginFill(0xFFFFFF, 1);
			_whiteBg.graphics.drawRect(0, 0, 880, 480);
			_whiteBg.graphics.endFill();
			_whiteBg.x = 10;
			_whiteBg.y = 10;
			_con.addChild(_whiteBg);
			
			//Info Txt
			_infoTxt = new TextField();
			_infoTxt.embedFonts = true;
			_infoTxt.styleSheet = RootLevel.css;
			_infoTxt.multiline = true;
			_infoTxt.htmlText = infoDefultTxt;
			_infoTxt.autoSize = "left";
			_infoTxt.width = 860;
			_infoTxt.selectable = false;
			_infoTxt.wordWrap = true;
			_infoTxt.x = 10;
			_infoTxt.y = 10;
			_whiteBg.addChild(_infoTxt);
			
			
			
			
			fromTI.x = 75;
			fromTI.y = 50;
			_whiteBg.addChild(fromTI);
			
			getRouteBTN.x = 750;
			getRouteBTN.y = 50;
			getRouteBTN.addEventListener(MouseEvent.CLICK, doRoute);
			_whiteBg.addChild(getRouteBTN);
			
			
			
			
			map.size = new Size(880, 380);
			map.y = 100;
			map.mapType = "map";
			
			map.setCenter(new LatLng(35.506292,-80.867245), 16);
			_whiteBg.addChild(map);
			
			myPoi = new Poi(map.center);
			map.addShape(this.myPoi);
			
			dir = new Directions(map);
			addDirectionsListeners();       
			
		}
		
		private function makeTheSwitch(event:MouseEvent):void {
			if(mapListSwitchBTN.txt.text == "Driving Directions"){
				mapListSwitchBTN.txt.text = "Show Map";
				map.alpha = 0;
				testTERRY.alpha = 1;
			} else {
				mapListSwitchBTN.txt.text = "Driving Directions";
				map.alpha = 1;
				testTERRY.alpha = 0;
			}
		}
		
		private function addDirectionsListeners():void {
			dir.addEventListener(DirectionsEvent.DIRECTIONS_SUCCESS, onRouteSuccess);
			dir.addEventListener(DirectionsEvent.DIRECTIONS_ERROR, onRouteError);
			dir.addEventListener(DirectionsEvent.DIRECTIONS_AMBIGUITY, onRouteAmbiguity);
			dir.addEventListener(DirectionsEvent.DIRECTIONS_IOERROR, onRouteIOError);          
		}
		
		private function onRouteSuccess(e:DirectionsEvent):void {
			if (e.routeType != "routeShape") {
				
				makeDirectionsList(e.xml);
				_infoTxt.htmlText = infoThxU;
				
				_whiteBg.removeChild(getRouteBTN);
				_whiteBg.removeChild(fromTI);
				//_whiteBg.removeChild(_loader);
				
				mapListSwitchBTN.x = 10;
				mapListSwitchBTN.y = 50;
				mapListSwitchBTN.addEventListener(MouseEvent.CLICK, makeTheSwitch);
				_whiteBg.addChild(mapListSwitchBTN);
			}
		}
		private function makeDirectionsList(x:XML):void {
			map.alpha = 1;
			
			var s:String = "";
			var legs:XMLList = x.route.legs.leg;
			var maneuvers:XMLList;
			var maneuver:XMLList;
			var dirCount:int = 1;
			
			for (var i:int = 0; i < legs.length(); i++) {
				maneuvers = legs[i].maneuvers;
				
				for (var j:int = 0; j < maneuvers.length(); j++) {
					maneuver = maneuvers[j].maneuver;
					
					for (var k:int = 0; k < maneuver.length(); k++) {                            
						s = dirCount + ". " + maneuver[k].narrative.text();
						
						var o:DrivingDirTileObj = new DrivingDirTileObj(s,
							String(Number(maneuver[k].distance.text()).toFixed(2) + " mi"),
							maneuver[k].formattedTime.text());

						
						alResults.push(o);
						
						dirCount ++;
					}
				}
			}
			
			
			
			testTERRY = new MapQDrivingDirSroller(alResults);
			testTERRY.y = 100;
			testTERRY.alpha = 0;
			_whiteBg.addChild(testTERRY);

		}
		
		
		private function onRouteAmbiguity(e:DirectionsEvent):void {
			trace(e.collectionsXml.toString());
		}
		private function onRouteIOError(e:DirectionsEvent):void {
			trace("DIRECTIONS IO ERROR");
		}
		private function onRouteError(e:DirectionsEvent):void {
			trace("DIRECTIONS ERROR");
		}
		
		
		
		private function doRoute(event : MouseEvent):void {
			
			_infoTxt.htmlText = infoLoadingTxt;
			//_loader.x = 440;
			//_loader.y = 240;
			//_whiteBg.addChild(_loader);
			
			
			//remove any existing locations
			if (dir) {
				dir.locations = null;
			}
			
			map.alpha = 0;
			
			//clean the array list
			alResults = new Array();
			

			//cretae the locations array onto which the addresses will be pushed
			arrLocations = new Array();
			
			//push the from address onto the array
			arrLocations.push(fromTI.textInput.text);
			
			//push the from address onto the array
			arrLocations.push(toTI);
			
			//assign the array to the directions object's locations 
			dir.locations = arrLocations;
			
			//make the routing call
			dir.route(); 
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