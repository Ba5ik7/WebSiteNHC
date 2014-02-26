package com.wes.models
{	
	import com.wes.events.ModelEvent;
	import com.wes.objects.AboutPageObj;
	import com.wes.objects.BtnObj;
	import com.wes.objects.ContactPageObj;
	import com.wes.objects.EventsEventObj;
	import com.wes.objects.FacebookRSSItemObj;
	import com.wes.objects.HomeBtnObj;
	import com.wes.objects.HomeSliderPageObj;
	import com.wes.objects.MenuFoodObj;
	import com.wes.tools.PHPFileGrabber;

	import com.wes.tools.RSSReader;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	
	public class DataModel extends Model 
	{
		
		private static const GRABBER_URL : String = "http://frugi.org/tools/php/nhc/grabber.php";
		//private static const SAVER_URL : String = "http://frugi.org/tools/php/nhc/saver.php";
		
		private var grabber : PHPFileGrabber;
		private var reader : RSSReader;
		
		private var dataList : XMLList = new XMLList();
		
		private var whatImagesNeedToLoad : int = new int(0);
		private var whatImagesHaveLoaded : int = new int(0);
		
		private var whatIsDone : int = new int(0);
		private var whatNeedsToBeDone : int = new int();
		
		public function DataModel(target : IEventDispatcher = null) {
			super(target);
		}
		
		override protected function xmlReady() : void {
			
			///READ ME??????????????????????
			//Add up all the whatImagesNeedToLoad
			//Homebtn
			
			dataList = data.homeContent.buttons.btn;
			whatImagesNeedToLoad += dataList.length();
			
			//HomeSlider
			dataList = data.homeContent.slider.page;
			whatImagesNeedToLoad += dataList.length();
			
			//AboutUsObj
			dataList = data.aboutContent.page;
			whatImagesNeedToLoad += dataList.length();
			
			//MenuTypeArray
			dataList = data.menuContent.type;
			whatImagesNeedToLoad += dataList.length();
			
			//Events
			dataList =  data.eventsContent.event;
			whatImagesNeedToLoad += dataList.length();
			
			//PartySliderArray
			dataList = data.partyContent.slider.page;
			whatImagesNeedToLoad += dataList.length();
			
			
			
		
			//whatNeedsToBeDone needs to be = the num of parsar methods with no image to load
			whatNeedsToBeDone = 7;
			parsarMenuData();
			parsarHomeData();
			parsarAboutData();
			parsarMenuFoodData();
			parsarEventCalendarData();
			parsarContactData();
			parsarPartyData();
			loadFacebookRSS();
		} 
		
		private function parsarPartyData():void {
			partyDataArray = new Array();
			
			dataList = data.partyContent.page;
			var partyDataObj:ContactPageObj = new ContactPageObj(dataList[0].name,
				dataList[0].title,
				dataList[0].txt);
			partyDataArray.push(partyDataObj);
			
			dataList = data.partyContent.slider.page;
			//For the Slider
			var silderArray : Array = new Array();
			var k : int;
			for (k = 0; k < dataList.length(); ++k) {
				var silde : HomeSliderPageObj = new HomeSliderPageObj(dataList[k].name,
					dataList[k].title,
					dataList[k].txt,
					dataList[k].image);
				
				silde.addEventListener(ModelEvent.IMAGE_READY, checkIfImagesAreLoaded);
				silderArray.push(silde);	
			}
			partyDataArray.push(silderArray);
			
		}		
		
		
		private function loadFacebookRSS():void {
			grabber = new PHPFileGrabber();
			grabber.load(GRABBER_URL, "http://www.facebook.com/feeds/page.php?format=rss20&id=322548597302");
			grabber.addEventListener(Event.COMPLETE, facebookDataGrabbed);
		}
		
		private function facebookDataGrabbed(event:Event) : void {
			grabber.removeEventListener(Event.COMPLETE, facebookDataGrabbed);
			reader = new RSSReader();
			reader.addEventListener(Event.COMPLETE, facebookRSSProcessed);
			reader.processXML(new XML(grabber.data));
		}
			
		private function facebookRSSProcessed(event:Event) : void {
			reader.removeEventListener(Event.COMPLETE, facebookRSSProcessed);
			facebookArray = new Array();
			for each (var item : XML in reader.episodes) {
				var faceObj : FacebookRSSItemObj = new FacebookRSSItemObj(item.title, 
																		item.description, 
																		item.pubDate);
				facebookArray.push(faceObj);
			}
			++whatIsDone;
			checkIfDataModelIsDone();
		}

		
		private function parsarEventCalendarData():void
		{
			eventsCalendarArray = new Array;
			var tempArray : Array = new Array;
			var j :int;
			dataList = data.eventsContent.event;
			for (j = 0; j < dataList.length(); ++j) {
				var  evtObj: EventsEventObj = new EventsEventObj(dataList[j].name, 
																dataList[j].date,
																dataList[j].title,
																dataList[j].txt,
																dataList[j].image);
				
				evtObj.addEventListener(ModelEvent.IMAGE_READY, checkIfImagesAreLoaded);
				eventsCalendarArray.push(evtObj);
				//Really?????
				var dateNum:Number = evtObj.date.getTime();
				tempArray.push({yearW:evtObj.date.fullYear,
								monthW:evtObj.date.month,
								dayW:evtObj.date.date,
								dateNum:dateNum,
					            objW:evtObj});
			}

			tempArray.sortOn("dateNum", Array.NUMERIC);
			var toDay:Date = new Date();
			var foundEvent : int = 0;
			upComingEvents = new Array;
			for each (var obj : Object in tempArray) {
				if (obj.yearW >= toDay.fullYear && obj.monthW >= toDay.month && obj.dayW >= toDay.date) {
					if(foundEvent <= 2){
						upComingEvents.push(obj.objW);
						++foundEvent;
					}
				}
			}

			++whatIsDone;
			checkIfDataModelIsDone();
		}
		
		private function parsarContactData():void
		{
			//For About Us Object 
			dataList = data.contactContent.page;
			contactDataObj = new ContactPageObj(dataList[0].name,
												dataList[0].title,
												dataList[0].txt);
			
			
			++whatIsDone;
			checkIfDataModelIsDone();
		}
		
		private function parsarMenuFoodData():void{
			//For Menu Type Array
			menuFoodDataArray = new Array();
			drinkMenuDataArray = new Array();
			
			dataList = data.menuContent.type;
			var btn : MenuFoodObj
			var j :int;
			for (j = 0; j < dataList.length(); ++j) {
				
				if (dataList[j].kind == "drinkPopup") {
					
					btn= new MenuFoodObj(dataList[j].name, 
						dataList[j].title,
						dataList[j].txt,
						dataList[j].image,
						dataList[j].menu,
						dataList[j].kind);
					
					btn.addEventListener(ModelEvent.IMAGE_READY, checkIfImagesAreLoaded);
					menuFoodDataArray.push(btn);
					
					var tempList : XMLList = new XMLList();
					tempList = dataList[j].drinkMenu;
					whatImagesNeedToLoad += tempList.length();
					
					var k : int;
					for (k = 0; k < tempList.length(); ++k) {
						var btnDrink : MenuFoodObj = new MenuFoodObj(dataList[k].name, 
							tempList[k].title,
							tempList[k].txt,
							tempList[k].image,
							tempList[k].menu,
							tempList[k].kind);
						btnDrink.addEventListener(ModelEvent.IMAGE_READY, checkIfImagesAreLoaded);
						drinkMenuDataArray.push(btnDrink);
					}
					
				} else { 
					btn = new MenuFoodObj(dataList[j].name, 
						dataList[j].title,
						dataList[j].txt,
						dataList[j].image,
						dataList[j].menu,
						dataList[j].kind);
					
					btn.addEventListener(ModelEvent.IMAGE_READY, checkIfImagesAreLoaded);
					menuFoodDataArray.push(btn);
				}
			}
			
			++whatIsDone;
			checkIfDataModelIsDone();
			
		}
		
		private function parsarAboutData():void
		{
			//For About Us Object 
			dataList = data.aboutContent.page;
			aboutDataObj = new AboutPageObj(dataList[0].name,
											dataList[0].title,
											dataList[0].txt,
											dataList[0].image);
				
			aboutDataObj.addEventListener(ModelEvent.IMAGE_READY, checkIfImagesAreLoaded);
			
			
			++whatIsDone;
			checkIfDataModelIsDone();
		}
		
		private function parsarHomeData() : void {
			homeDataArray = new Array;
			var j:int;

			//For Home buttons
			dataList = data.homeContent.buttons.btn;
			var btnArray : Array = new Array();
			for (j = 0; j < dataList.length(); ++j) {
				var btn : HomeBtnObj = new HomeBtnObj(dataList[j].name, 
														dataList[j].txt,
														dataList[j].image,
														dataList[j].kind);
				
				btn.addEventListener(ModelEvent.IMAGE_READY, checkIfImagesAreLoaded);
				btnArray.push(btn);	
			}
			homeDataArray.push(btnArray);
			
			dataList = data.homeContent.slider.page;
			var k:int;
			//For the Slider
			var silderArray : Array = new Array();
			for (k = 0; k < dataList.length(); ++k) {
				var silde : HomeSliderPageObj = new HomeSliderPageObj(dataList[k].name,
															dataList[k].title,
															dataList[k].txt,
															dataList[k].image);
				
				silde.addEventListener(ModelEvent.IMAGE_READY, checkIfImagesAreLoaded);
				silderArray.push(silde);	
			}
			homeDataArray.push(silderArray);
		}
		
		
		
		private function parsarMenuData() : void {
			menuDataArray = new Array;
			
			var btnList : XMLList = new XMLList();
			btnList = data.buttons.btn;
			var j:int;
			for (j = 0; j < btnList.length(); ++j) {
				var btnArray : Array = new Array();
				var _btn : BtnObj = new BtnObj(btnList[j].name, btnList[j].text);
				
				btnArray.push(_btn);
				
				var _subBtnList : XMLList = new XMLList(btnList[j].subBtn);
				var k:int;
				for(k = 0; k < _subBtnList.length(); ++k){
					var _subBtn : BtnObj = new BtnObj(_subBtnList[k].name, _subBtnList[k].text);
					
					btnArray.push(_subBtn);
				}
				
				menuDataArray.push(btnArray);
				
			}
			++whatIsDone;
			checkIfDataModelIsDone();
		}
		
		
		private function checkIfImagesAreLoaded(event:ModelEvent) : void {
			++whatImagesHaveLoaded;
			if (whatImagesHaveLoaded >= whatImagesNeedToLoad) {
				++whatIsDone;
				checkIfDataModelIsDone();
			}
			
		}
		
		private function checkIfDataModelIsDone() : void {
			// Check to see if we are all done
			if (whatIsDone >= whatNeedsToBeDone){
				dispatchEvent(new ModelEvent(ModelEvent.MODEL_COMPLETE));
			}
			
		}
		
	}
}