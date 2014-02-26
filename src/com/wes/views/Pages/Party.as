package com.wes.views.Pages
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Buttons.Button;
	import com.wes.compontents.SlideShow;
	import com.wes.compontents.TextInput;
	import com.wes.compontents.TextScroller;
	import com.wes.compontents.floorplanner.FloorPlanner;
	import com.wes.events.AMFServiceEvent;
	import com.wes.events.ModelEvent;
	import com.wes.models.AMFServices;
	import com.wes.models.UserPortfolio;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Party extends Page
	{
		
		//
		private var _service : AMFServices = new AMFServices;
		private var  userLoad : UserPortfolio;
		
		private var _con : Sprite;
		private var _conHeader : Sprite;
		private var _conLoginForm : Sprite;
		private var _conPartyForm : Sprite;
		private var _conPassForm : Sprite;
		private var slider:SlideShow;
		
		private var _tfTitle : TextFormat;
		private var _txt : TextField;
		private var _title : TextField;
		
		private var _infoTxt : TextField;
		private var _infoPassTxt : TextField;
		private var _infoPartyTxt : TextField;
		private var infoEmailTxt : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Invalid E-mail address</font></span>";
		private var infoPassBlank : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Please use your password</font></span>";
		private var infoEmailBlank : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Please use your E-mail address</font></span>";
		private var infoMessUnCompTxt : String = "<span class='caviarDream'><font size='22' color='#FF0000'>All fields are required</font></span>";
		private var infoLoadingTxt: String = "<span class='caviarDream'><font size='22' color='#FF0000'>Loading plaese wait</font></span>";
		private var infoUseEmailTxt: String = "<span class='caviarDream'><font size='22' color='#FF0000'>Use your E-mail and we will send your password to you.</font></span>";
		private var infoWelPartyTxt: String = "<span class='caviarDream'><font size='22' color='#FF0000'>Fill this form out as best as you can and we will get in touch with you as soon as possible.</font></span>";
		private var infoPassSent : String = "<span class='caviarDream'><font size='22' color='#FF0000'>I sent your password to the email address you gave.</font></span>";
		private var infoPassNot : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Sorry I counld find your E-mail.</font></span>";
		private var infoReqNot : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Sorry something fishy is going please try later.</font></span>";
		private var infoReqSent : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Thank you I sent and email to you and North Harbor Club.</font></span>";
		
		//private var _loader : EasyLoader = new EasyLoader();
		
		private var scrollText : String;
		private var proTextScroller : TextScroller;
		
		private var email : TextInput = new TextInput("Email : ", 200);
		private var password : TextInput = new TextInput("Password : ", 200);
		private var loginBtn : Button = new Button("Login", 18, 0x000000, 75, 20, 0xFFFFFF, 1, 0x000000, false);
		private var partyReqBtn : Button = new Button("Request a Party Form", 18, 0xFF0000, 150, 20, 0xFFFFFF, 1, 0xFFFFFF, false);
		
		private var partyNameTI : TextInput = new TextInput("Name : ", 250);
		private var partyEmailTI : TextInput = new TextInput("E-Mail : ", 250);
		private var partyPhoneTI : TextInput = new TextInput("Phone : ", 250);
		private var partyDateTI : TextInput = new TextInput("Date : ", 250);
		private var partyGuestTI : TextInput = new TextInput("Guest Count : ", 250);
		private var partyTimeTI : TextInput = new TextInput("Arrival Time : ", 250);
		private var partyTypeTI : TextInput = new TextInput("Party Type : ", 250);
		private var partyContactTI : TextInput = new TextInput("Contact Parson : ", 250);
		private var partyNotesTI : TextInput = new TextInput("Notes :", 450, 225);
		private var reqBtn : Button = new Button("Request", 18, 0x000000, 75, 20, 0xFFFFFF, 1, 0x000000, false);
		
		
		
		private var passEmail : TextInput = new TextInput("Email : ", 200);
		private var reqPassBtn : Button = new Button("Request", 18, 0x000000, 75, 20, 0xFFFFFF, 1, 0x000000, false);
		private var forPassBtn : Button = new Button("Forgot Password", 18, 0xFF0000, 100, 20, 0xFFFFFF, 1, 0xFFFFFF, false);
		
		
		private var floorPlanner : FloorPlanner;
		private var saveFloorBtn : Button = new Button("Save", 22, 0X000000, 100, 30, 0XFFFFFF, 1, 0X000000, false);
		private var editFloorBtn : Button = new Button("Edit", 22, 0X000000, 100, 30, 0XFFFFFF, 1, 0X000000, false); 
		private var userFilePath:String;
		private var saveXmlData:String;

		
		public function Party(_data : *) {
			name = "party";
			super(_data);
			
			createCons();
			createLoginForm();
			createPassForm();
			createPartyFrom();
			createSlideShow();
			buildHeaderContent();
				
		}
		
		private function createPassForm():void {
			
			passEmail.y = 100;
		  	_conPassForm.addChild(passEmail);
			
			reqPassBtn.x = 125;
			reqPassBtn.y = passEmail.y + 35;
			_conPassForm.addChild(reqPassBtn);
			
			_infoPassTxt = new TextField();
			_infoPassTxt.embedFonts = true;
			_infoPassTxt.styleSheet = RootLevel.css;
			_infoPassTxt.htmlText = infoUseEmailTxt;
			_infoPassTxt.multiline = true;
			_infoPassTxt.autoSize = "left";
			_infoPassTxt.width = 450;
			_infoPassTxt.selectable = false;
			_infoPassTxt.wordWrap = true;
			_infoPassTxt.x = -150;
			_infoPassTxt.y = 175;
			_conPassForm.addChild(_infoPassTxt);
		}
		private function reqPass(event:MouseEvent):void{
			if (!passEmail.textInput.text.length || 
				passEmail.textInput.text.indexOf("@") == -1 || 
				passEmail.textInput.text.indexOf(".") == -1) {
				_infoPassTxt.text = infoEmailTxt;
			} else {
				reqPassBtn.removeEventListener(MouseEvent.CLICK, reqPass);
				_infoPassTxt.text = infoLoadingTxt;
				RootLevel.stage.addEventListener(AMFServiceEvent.ONCOMPLETE, passChecked);
				_service.callService("AMFServices.passwordReset", passEmail.textInput.text); 
			}
			
		}
		
		private function passChecked(event:AMFServiceEvent):void {
			RootLevel.stage.removeEventListener(AMFServiceEvent.ONCOMPLETE, passChecked);
			trace(event.data);
			if(event.data == false ){
				reqPassBtn.addEventListener(MouseEvent.CLICK, reqPass);
				passEmail.textInput.text = "";
				_infoPassTxt.text = infoPassNot;
			} else {
				_infoPassTxt.text = infoPassSent;
			}
		}

		
		private function createPartyFrom():void {
			
			_conPartyForm.addChild(partyNameTI);
			
			partyContactTI.y = partyNameTI.y + 35;
			_conPartyForm.addChild(partyContactTI);
			
			partyEmailTI.y = partyContactTI.y + 35;
			_conPartyForm.addChild(partyEmailTI);
			
			partyPhoneTI.y = partyEmailTI.y + 35;
			_conPartyForm.addChild(partyPhoneTI);
			
			partyDateTI.y = partyPhoneTI.y + 35;
			_conPartyForm.addChild(partyDateTI);
			
			partyGuestTI.y = partyDateTI.y + 35;
			_conPartyForm.addChild(partyGuestTI);
			
			partyTimeTI.y = partyGuestTI.y +35;
			_conPartyForm.addChild(partyTimeTI);
			
			partyTypeTI.y = partyTimeTI.y + 35;
			_conPartyForm.addChild(partyTypeTI);
			
			partyNotesTI.x = 400;
			_conPartyForm.addChild(partyNotesTI);
			
			reqBtn.y = partyNotesTI.y + 245;
			reqBtn.x = 775;
			_conPartyForm.addChild(reqBtn);		
			
			_infoPartyTxt = new TextField();
			_infoPartyTxt.embedFonts = true;
			_infoPartyTxt.styleSheet = RootLevel.css;
			_infoPartyTxt.text = infoWelPartyTxt;
			_infoPartyTxt.multiline = true;
			_infoPartyTxt.autoSize = "left";
			_infoPartyTxt.width = 800;
			_infoPartyTxt.selectable = false;
			_infoPartyTxt.wordWrap = true;
			_infoPartyTxt.y = 300;
			_conPartyForm.addChild(_infoPartyTxt);
		}		
		private function reqParty(event:MouseEvent):void {
			if (partyNameTI.textInput.text == "" || partyContactTI.textInput.text == "" || partyEmailTI.textInput.text == "" || 
				partyPhoneTI.textInput.text == "" || partyDateTI.textInput.text == "" || partyGuestTI.textInput.text == "" ||
				partyTimeTI.textInput.text == "" || partyTypeTI.textInput.text == "" || partyNotesTI.textInput.text == ""){
				_infoPartyTxt.htmlText = infoMessUnCompTxt;
				
			} else if (!partyEmailTI.textInput.text.length || 
				partyEmailTI.textInput.text.indexOf("@") == -1 || 
				partyEmailTI.textInput.text.indexOf(".") == -1){
				
				_infoPartyTxt.htmlText = infoEmailTxt;
				
			} else {
				reqBtn.removeEventListener(MouseEvent.CLICK, reqParty);
				_infoPartyTxt.htmlText = infoLoadingTxt;
				RootLevel.stage.addEventListener(AMFServiceEvent.ONCOMPLETE, partyReqChecked);
				_service.callService("AMFServices.addReqParty", partyNameTI.textInput.text, 
															partyContactTI.textInput.text,
															partyEmailTI.textInput.text,
															partyPhoneTI.textInput.text,
															partyDateTI.textInput.text,
															partyGuestTI.textInput.text,
															partyTimeTI.textInput.text,
															partyTypeTI.textInput.text,
															partyNotesTI.textInput.text);
																
			}
			
		}
		
		private function partyReqChecked(event:AMFServiceEvent):void {
			RootLevel.stage.removeEventListener(AMFServiceEvent.ONCOMPLETE, partyReqChecked);
			if ( event.data == true) {
				_infoPartyTxt.htmlText = infoReqSent;
			} else {
				_infoPartyTxt.htmlText = infoReqNot;
			}
		}
		
		private function buildHeaderContent():void{
			_tfTitle = new TextFormat();
			_tfTitle.color = 0x000000;
			_tfTitle.size = 32;
			_tfTitle.font ="HANAB";
			_title = new TextField();
			_title.embedFonts = true;
			_title.defaultTextFormat = _tfTitle;
			_title.text = data[0].title;
			_title.autoSize = "left";
			_title.selectable = false;
			_title.mouseEnabled = false;
			_title.x = 10;
			_title.y = 10;
			_conHeader.addChild(_title);
			

			_txt = new TextField();
			_txt.styleSheet = RootLevel.css;
			_txt.embedFonts = true;
			_txt.multiline = true;
			_txt.htmlText = data[0].txt;
			_txt.autoSize = "left";
			_txt.width = 450;
			_txt.selectable = false;
			_txt.wordWrap = true;
			_txt.x = 10;
			_txt.y = 50;
			_conHeader.addChild(_txt);
			
			//
			_infoTxt = new TextField();
			_infoTxt.embedFonts = true;
			_infoTxt.styleSheet = RootLevel.css;
			_infoTxt.multiline = true;
			_infoTxt.autoSize = "left";
			_infoTxt.width = 510;
			_infoTxt.selectable = false;
			_infoTxt.wordWrap = true;
			_infoTxt.x = 10;
			_infoTxt.y = 250;
			_conLoginForm.addChild(_infoTxt);
		}
		
		private function createSlideShow() : void {
			slider = new SlideShow(data[1]);
			slider.x = 530;
			slider.y = 0;
			_con.addChild(slider);
		}
		
		private function createLoginForm() : void {
			email.x = 150;
			email.y = 150;
			_conLoginForm.addChild(email);
			
			password.textInput.displayAsPassword = true;
			password.x = 150;
			password.y = email.y + 35;
			_conLoginForm.addChild(password);
			
			loginBtn.addEventListener(MouseEvent.CLICK, checkAccount);
			loginBtn.x = 275;
			loginBtn.y = password.y + 35;
			_conLoginForm.addChild(loginBtn);
			
			partyReqBtn.addEventListener(MouseEvent.CLICK, showPartyForm);
			partyReqBtn.x = 333;
			partyReqBtn.y = 400;
			_conLoginForm.addChild(partyReqBtn);
			
			forPassBtn.addEventListener(MouseEvent.CLICK, showPassForm);
			forPassBtn.x = 375;
			forPassBtn.y = 430;
			_conLoginForm.addChild(forPassBtn);
		}
		
		private function showPassForm(event:MouseEvent):void {
			loginBtn.removeEventListener(MouseEvent.CLICK, checkAccount);
			partyReqBtn.removeEventListener(MouseEvent.CLICK, showPartyForm);
			forPassBtn.removeEventListener(MouseEvent.CLICK, showPassForm);
			_con.removeChild(_conLoginForm);
			_con.removeChild(_conHeader);
			
			_conPassForm.x = 200;
			_conPassForm.y = 50;
			_con.addChild(_conPassForm);
			reqPassBtn.addEventListener(MouseEvent.CLICK, reqPass);
		}
		
		private function showPartyForm(event:MouseEvent):void {
			loginBtn.removeEventListener(MouseEvent.CLICK, checkAccount);
			partyReqBtn.removeEventListener(MouseEvent.CLICK, showPartyForm);
			forPassBtn.removeEventListener(MouseEvent.CLICK, showPassForm);
			_con.removeChild(_conLoginForm);
			_con.removeChild(_conHeader);
			_con.removeChild(slider);
			
			_conPartyForm.x = 200;
			_conPartyForm.y = 50;
			_con.addChild(_conPartyForm);
			reqBtn.addEventListener(MouseEvent.CLICK, reqParty);
		}
		
		private function checkAccount(event:MouseEvent) : void {
			if(email.textInput.text == "" ) {
				_infoTxt.text = infoEmailBlank;
			} else if (password.textInput.text == "") {
				_infoTxt.text = infoPassBlank;
			} else if (!email.textInput.text.length || 
				email.textInput.text.indexOf("@") == -1 || 
				email.textInput.text.indexOf(".") == -1) {
				_infoTxt.text = infoEmailTxt;
			} else {
				_infoTxt.text = infoLoadingTxt;
				//_loader.x = 265;
				//_loader.y = 230;
				//_con.addChild(_loader);
				email.alpha = 0;
				email.textInput.mouseEnabled = false;
				password.alpha = 0;
				password.textInput.mouseEnabled = false;
				loginBtn.alpha = 0;
				loginBtn.buttonMode = false;
				loginBtn.removeEventListener(MouseEvent.CLICK, checkAccount);
				partyReqBtn.removeEventListener(MouseEvent.CLICK, showPartyForm);
				forPassBtn.removeEventListener(MouseEvent.CLICK, showPassForm);
				RootLevel.stage.addEventListener(AMFServiceEvent.ONCOMPLETE, accountChecked);
				_service.callService("AMFServices.checkForUser", email.textInput.text, password.textInput.text);
			}			
		}
		
		private function accountChecked(event:AMFServiceEvent):void {
			//_con.removeChild(_loader);
			if (event.data == false) {
				email.alpha = 1;
				email.textInput.mouseEnabled = true;
				password.alpha = 1;
				password.textInput.mouseEnabled = true;
				loginBtn.alpha = 1;
				loginBtn.buttonMode = true;
				_infoTxt.text = "** Sorry ethier the password or email is wrong";
				loginBtn.addEventListener(MouseEvent.CLICK, checkAccount);
				partyReqBtn.addEventListener(MouseEvent.CLICK, showPartyForm);
				forPassBtn.addEventListener(MouseEvent.CLICK, showPassForm);
			} else {
				RootLevel.stage.removeEventListener(AMFServiceEvent.ONCOMPLETE, accountChecked);
				createProfile(event.data);
			}
		}
		
		
		
		
		private function createProfile(obj : Object) : void {
			_con.removeChild(_conLoginForm);
			_con.removeChild(_conHeader);
			_con.removeChild(slider);
			
			userFilePath = obj.path;
			trace(userFilePath);
			
			userLoad = new UserPortfolio();
			userLoad.addEventListener(ModelEvent.XML_READY, userDataLoaded);
			userLoad.loadXML(obj.path+"?"+Math.round(Math.random()*5000).toString());
			
			
			
			scrollText = new String();
			var dataMY : Array = new Array(obj.username, obj.email, obj.phone, obj.guestCount, obj.dateTime, obj.eventType, obj.request, obj.drinks, obj.menu);
			var titleMY : Array = new Array("Name", "E-mail", "Phone", "Guest Count", "Date and Time", "Event Type", "Request", "Drinks", "Menu");
			var i : int;
			for (i = 0; i < titleMY.length; ++i) {
				scrollText += "<span class='caviarDreamB'><font size='28'>" + titleMY[i] + "<br></font></span>";
				(dataMY[i].toString().substr(0,5)) as String != "<span" ? scrollText += "<span class='caviarDreamB'><font size='20'>" + dataMY[i].toString() + "<br><br></font></span>" : scrollText += dataMY[i].toString() + "<span><br><br>WESTEr</span>";
			}
			
			proTextScroller = new TextScroller(500, 450, scrollText);
			proTextScroller.y = 5;
			_con.addChild(proTextScroller);
		}
		
		
		
		private function userDataLoaded(event:ModelEvent):void {
			userLoad.removeEventListener(ModelEvent.XML_READY, userDataLoaded);
			
			editFloorBtn.addEventListener(MouseEvent.CLICK, editFloor);
			editFloorBtn.x = 550;
			editFloorBtn.y = 25;
			_con.addChild(editFloorBtn);
			
			saveFloorBtn.x = 550;
			saveFloorBtn.y = 25;
			
			
			
			floorPlanner = new FloorPlanner(userLoad.tabArray, 350, 220);
			floorPlanner.x = 550;
			floorPlanner.y = 100;
			_con.addChild(floorPlanner);
		}
		
		private function editFloor(event:MouseEvent):void
		{
			editFloorBtn.removeEventListener(MouseEvent.CLICK, editFloor);
			floorPlanner.edit();
			saveFloorBtn.addEventListener(MouseEvent.CLICK, saveFloor);
			_con.removeChild(editFloorBtn);
			_con.addChild(saveFloorBtn);

		}
		
		private function saveFloor(event:MouseEvent):void
		{
			_con.removeChild(saveFloorBtn);
			_con.addChild(editFloorBtn);
			saveFloorBtn.removeEventListener(MouseEvent.CLICK, saveFloor);	
			floorPlanner.notEdit();
			editFloorBtn.addEventListener(MouseEvent.CLICK, editFloor);

			var tempString : String =new String();
			for (var i : int = 0 ; i < floorPlanner.tabArray.length; ++i) {
				tempString += "          <table id='"+i+"' x='"+floorPlanner.tabArray[i].x+"' y='"+floorPlanner.tabArray[i].y+"' rotation='"+floorPlanner.tabArray[i].rotation+"' type='"+floorPlanner.tabArray[i].type+"' /> \n";	
			}
			
			
			saveXmlData = "<xml>\n     <userData>\n     </userData>\n     <tables>\n" + tempString + "     </tables>\n</xml>";
			
			RootLevel.stage.addEventListener(AMFServiceEvent.ONCOMPLETE, floorSaved);
			_service.callService("AMFServices.saveFloorPlan", userFilePath, saveXmlData);
		}
		
		private function floorSaved(event:AMFServiceEvent):void
		{
			RootLevel.stage.removeEventListener(AMFServiceEvent.ONCOMPLETE, floorSaved);
			trace(event.data);
		}		
		
		
		
		private function createCons() : void {
			_con = new Sprite;
			_con.graphics.clear();
			_con.graphics.lineStyle(3,0xd79532);
			_con.graphics.beginFill(0xFFFFFF);
			_con.graphics.drawRect(0,0, 1125, 460);
			_con.graphics.endFill();
			_con.alpha = 0;
			_con.y = -800;
			addChild(_con);
			
			_conHeader = new Sprite;
			_conLoginForm = new Sprite;
			_conPartyForm = new Sprite;
			_conPassForm = new Sprite;
			
			_con.addChild(_conHeader);
			_con.addChild(_conLoginForm);
		}
		
		override protected function intro () : void {
			TweenMax.to(_con, .5,{alpha:1,
				y:0,
				ease:Expo.easeInOut});
		}
		
		override protected function outro () : void {
			TweenMax.to(_con, .5,{alpha:0, 
				y:400,
				onComplete:clean,
				ease:Expo.easeInOut});
		}
		
		private function clean() : void {
			super.outro();
		}
	}
}