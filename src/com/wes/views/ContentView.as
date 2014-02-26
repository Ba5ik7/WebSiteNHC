package com.wes.views
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.wes.events.MenuBtnEvent;
	import com.wes.events.ModelEvent;
	import com.wes.events.PageEvents;
	import com.wes.views.Pages.AboutUs;
	import com.wes.views.Pages.Contact;
	import com.wes.views.Pages.Events;
	import com.wes.views.Pages.Home;
	import com.wes.views.Pages.Menu;
	import com.wes.views.Pages.Page;
	import com.wes.views.Pages.Party;
	import com.wes.views.PopUps.CalendarPopUp;
	import com.wes.views.PopUps.DrinkPopUp;
	import com.wes.views.PopUps.EventsPopUp;
	import com.wes.views.PopUps.FaceBookPopUp;
	import com.wes.views.PopUps.MapPopUp;
	import com.wes.views.PopUps.MenuPopUp;
	import com.wes.views.PopUps.PopUp;
	public class ContentView extends View
	{
		public var pagesArray:Array = new Array();
		
		private var currentPage : Page;
		private var oldPage : Page;
		private var lastPageName : String;
		private var pageTitleStr : String;
		
		private var month : uint;
		private var year : uint;
		
		private var popUp : PopUp;
		private var kind : String;
		private var popUpIsOn : Boolean = false;
		
		private var _closePopUp : MenuBtnEvent;
		
		
		
		public function ContentView() {	
			super();
		}
		
		override protected function modelComplete(event : ModelEvent) : void {
			RootLevel.stage.addEventListener(MenuBtnEvent.BTNCLICK, changeThePage);
			RootLevel.stage.addEventListener(MenuBtnEvent.POPUPMENU, addMenuPopUp);
			RootLevel.stage.addEventListener(PageEvents.MOVEMENT_COMPLETE, camMovementDone);
			
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onAddressChange);
			currentPage = new Home(_model.homeDataArray);
			SWFAddress.setValue("home");
			
		}		
		
		private function camMovementDone(event:PageEvents):void {
			popUpIsOn ? popUp._intro() : currentPage._intro();
		}

		private function onAddressChange( event : SWFAddressEvent ):void {
			if (event.value != "/") {
				pageTitleStr = event.value.substring(1);
				SWFAddress.setTitle(pageTitleStr.substr(0,6) != "events" ? "NHC - " +  pageTitleStr : "NHC - events ");

				var _changeThePageEvt : MenuBtnEvent = new MenuBtnEvent("btnClick");
				_changeThePageEvt.name = event.value.substring(1);
				changeThePage(_changeThePageEvt);
				
			}
		}
		
		
		
		//@HARDCODED
		private function changeThePage(event : MenuBtnEvent) : void {
			if(popUpIsOn) {
				RootLevel.stage.addEventListener(MenuBtnEvent.POPUPOUTRO, outroPopUp);
				_closePopUp = new MenuBtnEvent("popUpOutro");
				dispatchEvent(_closePopUp);
			}
			
			var _evtCamMove : PageEvents = new PageEvents("outroComplete");
			RootLevel.stage.dispatchEvent(_evtCamMove);
			
			currentPage.name != "events" ? makeThePageSwitch() : null;
			
			event.name.substr(0,6) == "events" ? event.name = event.name.substr(0,6) : null;
				

			switch(event.name)
			{
				case "home":
					currentPage.name == "events" ? makeThePageSwitch() : null;
					currentPage = new Home(_model.homeDataArray);
					currentPage.name = event.name;
					break;
				case "aboutUs":
					currentPage.name == "events" ? makeThePageSwitch() : null;
					currentPage = new AboutUs(_model.aboutDataObj);
					currentPage.name = event.name;
					break;
				case "menu":
					currentPage.name == "events" ? makeThePageSwitch() : null;
					currentPage = new Menu(_model.menuFoodDataArray);
					currentPage.name = event.name;
					break;
				case "contact":
					currentPage.name == "events" ? makeThePageSwitch() : null;
					currentPage = new Contact(_model.contactDataObj);
					currentPage.name = event.name;
					break;
				case "party":
					currentPage.name == "events" ? makeThePageSwitch() : null;
					currentPage = new Party(_model.partyDataArray);
					currentPage.name = event.name;
					break;
				case "events":
					month = uint(SWFAddress.getParameter("month"));
					year = uint(SWFAddress.getParameter("year"));
					currentPage.name != "events" || year == 0 ? currentPage = new Events(_model.eventsCalendarArray) : currentPage._render(uint(SWFAddress.getParameter("month"))-1, uint(SWFAddress.getParameter("year")));
					currentPage.name = event.name;
					break;
				default:
				var _menuPopUp : MenuBtnEvent = new MenuBtnEvent("popUpMenu");
				_menuPopUp.kind = event.name;
				dispatchEvent(_menuPopUp);
				lastPageName = currentPage.name;
				return;
			}

			addChildAt(currentPage, 0);
		}
		
		private function makeThePageSwitch():void {
			oldPage = currentPage as Page;
			addChild(oldPage);
			oldPage._outro();
			RootLevel.stage.addEventListener(MenuBtnEvent.PAGECLOSE, cleanPage);
		}
		
		private function cleanPage(event:MenuBtnEvent):void{
			removeChild(oldPage);
		}		
		
		//@HARDCODED
		private function addMenuPopUp (event : MenuBtnEvent) : void {
			popUpIsOn = true;
			switch(event.kind)
			{
				case "menuPopup":
					popUp = new MenuPopUp(RootLevel.menuText);
					break;
				case "drinkPopup":
					popUp = new DrinkPopUp(_model.drinkMenuDataArray);
					break;
				case "facebookPopup":
					popUp = new FaceBookPopUp(_model.facebookArray);
					break;
				case "eventPopup":
					popUp = new EventsPopUp(_model.upComingEvents);
					break;
				case"calendarPopUp":
					popUp = new CalendarPopUp(RootLevel.eventsArr);
					break;
				case"mapPopUp":
					popUp = new MapPopUp("Hello Map");
					break;
				default:
					//SWFAddress.setValue("Error!!!!!");
					trace("Oh shit : " + kind);
			}
			
			RootLevel.stage.addChild(popUp);
			RootLevel.stage.addEventListener(MenuBtnEvent.POPUPOUTRO, outroPopUp);
			
		}
		
		private function outroPopUp (event : MenuBtnEvent) : void {
			popUpIsOn = false;
			RootLevel.stage.removeEventListener(MenuBtnEvent.POPUPOUTRO, outroPopUp);
			RootLevel.stage.addEventListener(MenuBtnEvent.POPUPCLOSE, cleanPopUp);
			
			popUp._outro();	

			if(lastPageName == "events"){
				SWFAddress.setValue("events/?month="+month+"&year="+year);
			} else { 
				SWFAddress.setValue(lastPageName);
			}
		}
		
		private function cleanPopUp(event:MenuBtnEvent):void{
			RootLevel.stage.removeChild(popUp);
		}
	}
}