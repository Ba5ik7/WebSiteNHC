package com.wes.views.Pages
{
	import com.asual.swfaddress.SWFAddress;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.wes.compontents.Buttons.Button;
	import com.wes.compontents.ComboBox.ComboBox;
	import com.wes.compontents.TextInput;
	import com.wes.events.AMFServiceEvent;
	import com.wes.models.AMFServices;

	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Contact extends Page
	{
		
		
		private var tileBL : Sprite;
		private var tileR : Sprite;
		private var imgCon : Sprite;
		
		private var _tfTitle : TextFormat;
		private var _txt : TextField;
		private var _title : TextField;
		private var _infoTxt : TextField;
		
		//private var _loader : EasyLoader = new EasyLoader();
		
		private var infoDefultTxt : String = "<span class='caviarDream'><font size='22'>Please take the time to fill this form out to recieve our newletter.</font></span>";
		private var infoMessEmailTxt : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Invalid E-mail address</font></span>";
		private var infoMessUnCompTxt : String = "<span class='caviarDream'><font size='22' color='#FF0000'>All fields are required</font></span>";
		private var infoEmailUsed : String = "<span class='caviarDream'><font size='22' color='#FF0000'>Sorry this email is already being used.</font></span>";
		private var infoThxU: String = "<span class='caviarDream'><font size='22'>Thank you we got your email and sent you a confirm email. Please check you email account and click the link to confrim your North Harbor Club Newsletter subscription.</font></span>";

		
		private var _service : AMFServices = new AMFServices;

		
		private var _months:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		private var _monthsNA:Array = ["N/A", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

		
		private var userForm : Sprite = new Sprite();
		private var userFirstName :TextInput =new TextInput("First Name :", 200);
		private var userLastName :TextInput =new TextInput("Last Name :", 200);
		private var userEmail : TextInput = new TextInput("E-Mail :", 200);
		private var birthMonthCB : ComboBox = new ComboBox("Brith Month :", _months);
		private var spouseBirthMonthCB : ComboBox = new ComboBox("Spouse Brith Month :", _monthsNA);
		private var anniversaryBirthMonthCB : ComboBox = new ComboBox("Anniversary Month :", _monthsNA);
		private var userMessage : TextInput = new TextInput("Message :", 250, 170);
		private var userSendBtn : Button = new Button("Send", 18, 0x000000, 75, 20, 0xFFFFFF, 1, 0x000000, false);
		
		private var getDir : Button = new Button("Get Directions", 28, 0x000000, 330, 60, 0xFFFFFF, 1, 0xFFFFFF, false);
	
		
		
		public function Contact(_data : *) {
			name = "contactUs";
			super(_data);
			
			buildTiles();
			buildTxtFields();
			buildForm();
			buildContent();
			
			addChild(imgCon);
			addChild(tileBL);
			addChild(tileR);
			
		}
		
		private function buildForm():void {
			//Add Input Fields
			
			userForm.addChild(userFirstName);
			
			userLastName.y = userFirstName.y + 35;
			userForm.addChildAt(userLastName, 0);
			
			userEmail.y = userLastName.y + 35;
			userForm.addChildAt(userEmail, 0);
			
			birthMonthCB.y = userEmail.y + 35;
			userForm.addChildAt(birthMonthCB, 0);
			
			spouseBirthMonthCB.y = birthMonthCB.y + 35;
			userForm.addChildAt(spouseBirthMonthCB, 0);
			
			anniversaryBirthMonthCB.y = spouseBirthMonthCB.y + 35;
			userForm.addChildAt(anniversaryBirthMonthCB, 0);

			userMessage.x = 310;
			userForm.addChildAt(userMessage, 0);
			
			userSendBtn.y = userMessage.y + userMessage.height + 10;
			userSendBtn.x = 485;
			userSendBtn.addEventListener(MouseEvent.CLICK, regsUser);
			userForm.addChildAt(userSendBtn, 0);
			
			userForm.x = 190;
			userForm.y = 150;
			tileR.addChild(userForm);
		}
		
		private function regsUser(event:MouseEvent):void{
			
			_infoTxt.htmlText = "";
			
			if (userFirstName.textInput.text == "" || userLastName.textInput.text == "" || userEmail.textInput.text == "" || 
				birthMonthCB.selectedItemLabel.text == "----- Select One -----" ||
				anniversaryBirthMonthCB.selectedItemLabel.text == "----- Select One -----" || 
				spouseBirthMonthCB.selectedItemLabel.text == "----- Select One -----"){
				
				_infoTxt.htmlText = infoMessUnCompTxt;
				
			} else if (!userEmail.textInput.text.length || 
				userEmail.textInput.text.indexOf("@") == -1 || 
				userEmail.textInput.text.indexOf(".") == -1){
				
				_infoTxt.htmlText = infoMessEmailTxt;
				
			} else {
				
				userSendBtn.removeEventListener(MouseEvent.CLICK, regsUser);
				RootLevel.stage.addEventListener(AMFServiceEvent.ONCOMPLETE, accountChecked);
				_service.callService("AMFServices.createMailUsers", userFirstName.textInput.text,
					userLastName.textInput.text,
					userEmail.textInput.text,
					birthMonthCB.selectedItemLabel.text,
					spouseBirthMonthCB.selectedItemLabel.text,
					anniversaryBirthMonthCB.selectedItemLabel.text,
					userMessage.textInput.text);
				
			}										
		}
		
		private function accountChecked(event:AMFServiceEvent):void {
			trace(event.data);
			if ( event.data == true ) {
				tileR.removeChild(userForm);
				_infoTxt.htmlText = infoThxU;
			} else {
				userSendBtn.addEventListener(MouseEvent.CLICK, regsUser);
				_infoTxt.htmlText = infoEmailUsed;
			}
		}
		
		private function buildTxtFields():void{
			//Title
			_tfTitle = new TextFormat();
			_tfTitle.color = 0x000000;
			_tfTitle.size = 32;
			_tfTitle.font ="HANAB";
			_title = new TextField();
			_title.embedFonts = true;
			_title.defaultTextFormat = _tfTitle;
			_title.text = data.title;
			_title.autoSize = "left";
			_title.selectable = false;
			_title.mouseEnabled = false;
			_title.x = 100;
			_title.y = 25;
			tileR.addChild(_title);
			
			
			//HTML Text
			_txt = new TextField();
			_txt.styleSheet = RootLevel.css;
			_txt.embedFonts = true;
			_txt.multiline = true;
			_txt.htmlText = data.txt;
			_txt.autoSize = "left";
			_txt.width = 340;
			_txt.selectable = false;
			_txt.wordWrap = true;
			_txt.x = 5;
			_txt.y = 10;
			imgCon.addChild(_txt);
			
			//Info Txt
			_infoTxt = new TextField();
			_infoTxt.embedFonts = true;
			_infoTxt.styleSheet = RootLevel.css;
			_infoTxt.multiline = true;
			_infoTxt.htmlText = infoDefultTxt;
			_infoTxt.autoSize = "left";
			_infoTxt.width = 750;
			_infoTxt.selectable = false;
			_infoTxt.wordWrap = true;
			_infoTxt.x = 20;
			_infoTxt.y = 95;
			tileR.addChild(_infoTxt);
		}
		
		private function buildTiles():void {
			//
			tileR = new Sprite;
			tileR.graphics.clear();
			tileR.graphics.lineStyle(3,0xd79532);
			tileR.graphics.beginFill(0xFFFFFF);
			tileR.graphics.drawRect(0,0, 775, 455);
			tileR.graphics.endFill();
			tileR.alpha = 0;
			tileR.x = 365;
			tileR.y = -800;
			
			//
			tileBL = new Sprite;
			tileBL.graphics.clear();
			tileBL.graphics.lineStyle(3,0xd79532);
			tileBL.graphics.beginFill(0xFFFFFF);
			tileBL.graphics.drawRect(0,0, 350, 80);
			tileBL.graphics.endFill();
			tileBL.alpha = 0;
			tileBL.x = Math.random()*RootLevel.stage.width;
			tileBL.y = Math.random()*RootLevel.stage.height;
			tileBL.rotation = Math.random()*180-180;
			tileBL.z = Math.random()*500;
			
			//
			imgCon = new Sprite();
			imgCon.graphics.lineStyle(3,0xd79532);
			imgCon.graphics.beginFill(0xFFFFFF, 1);
			imgCon.graphics.drawRect(0, 0, 350, 360);
			imgCon.graphics.endFill();
			imgCon.alpha = 0;
			imgCon.x = Math.random()*RootLevel.stage.width;
			imgCon.y = Math.random()*RootLevel.stage.height;
			imgCon.rotation = Math.random()*180-180;
			imgCon.z = Math.random()*500;
		}
		
		private function buildContent():void{
			//MQ Popup Btn
			getDir.addEventListener(MouseEvent.CLICK, getDirPopUp);
			getDir.x = 10;
			getDir.y = 10;
			tileBL.addChild(getDir);
		}
		
		private function getDirPopUp(event:MouseEvent):void {
			SWFAddress.setValue("mapPopUp");
		}		
		
		
		override protected function intro () : void {
			TweenMax.to(tileBL, .5,{alpha:1, 
				x:0,
				y:375,
				z:0,
				rotation:0,
				ease:Expo.easeInOut});
			
			TweenMax.to(tileR, .5,{alpha:1, 
				x:365,
				y:0,
				z:0,
				rotation:0,
				ease:Expo.easeInOut});
			
			TweenMax.to(imgCon, .5,{alpha:1, 
				x:0,
				y:0,
				z:0,
				rotation:0,
				ease:Expo.easeInOut});
		}
		
		override protected function outro () : void {
			TweenMax.to(tileBL, .5,{alpha:0, 
				x:Math.random()*RootLevel.stage.width,
				y:Math.random()*RootLevel.stage.height,
				z:Math.random()*200-400,
				rotation:Math.random()*180-90,
				ease:Expo.easeInOut});
			
			TweenMax.to(tileR, .5,{alpha:0, 
				y:400,
				ease:Expo.easeInOut});
			
			TweenMax.to(imgCon, .5,{alpha:0, 
				x:Math.random()*RootLevel.stage.width,
				y:Math.random()*RootLevel.stage.height,
				z:Math.random()*200-400,
				rotation:Math.random()*180-90,
				onComplete:clean,
				ease:Expo.easeInOut});
		}
		
		private function clean() : void {
			super.outro();
		}
	}
}
	