package com.wes.views
{	
	
	
	import away3d.materials.methods.FogMethod;
	import flash.utils.getTimer;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.parsers.AWD2Parser;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	
	import com.greensock.TweenMax;
	import com.wes.events.PageEvents;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	

	public class BackgroundAway3D extends Away3D
	{
		
		/*[Embed(source="assets/Fountain.3DS",mimeType="application/octet-stream")]
			private var Fountain3DS : Class;
			
		[Embed(source="images/Material1.jpg")]
			private var FountainTexture  : Class;*/
		
		
		private var modelTexture:BitmapTexture;
		private const DemoColor:Array = [0x330099, 0x990066, 0x222233];
		private var signScale : Number = 75;
		
		//light objects
		private var sunLight:DirectionalLight;
		private var skyLight:PointLight;
		private var lightPicker:StaticLightPicker;
		
		//Models and Materials
		private var signHolder : ObjectContainer3D = new ObjectContainer3D;
		private var ground : Mesh;
		private var groundMaterial:ColorMaterial;
		
		private var signBase : Mesh;
		
		private var MESH_URL:String = "assets/BestSign.awd";
		private var SIGNBASE_TEXTURE_URL:String = "assets/flag_Cube005.jpg";

		
		//What to load
		private var assetsThatAreloaded:int = 0;
		private var assetsToLoad:int = 2;
		
		//For Cam Movement
		private var postionsArray : Array = new Array;
		private var postion : int = 0;
		private var terry : Number = 9;

		
		public function BackgroundAway3D() {
			super();
			
			setupPrimitives();
			initLights();
			initLoading();
			
			var k : int;
			for(k=0; k < terry; ++k) {
				var tempObj : Object = new Object();
				tempObj.name = k;
				tempObj.targetX = Math.random()*900+300;
				tempObj.targetY = (Math.random()*175)+175;
				tempObj.targetZ = Math.random()*900+300;
				postionsArray.push(tempObj);
				
			}
		}
		
		

		private function setupPrimitives():void {
			groundMaterial = new ColorMaterial(0x333333);
			groundMaterial.addMethod(new FogMethod(1000, 3000, DemoColor[2]));
			groundMaterial.ambient = 0.25;
			ground = new Mesh(new PlaneGeometry(50000, 50000), groundMaterial);
			ground.geometry.scaleUV(50, 50);
			_view.scene.addChild(ground);
		}
		
		
		
		private function initLights():void
		{
			//create a light for shadows that mimics the sun's position in the skybox
			sunLight = new DirectionalLight(-1, -0.4, 1);
			sunLight.color = DemoColor[0];
			sunLight.castsShadows = true;
			sunLight.ambient = 1;
			sunLight.diffuse = 1;
			sunLight.specular = 1;
			_view.scene.addChild(sunLight);
			
			/*sunLight = new PointLight();
			sunLight.y = 500;
			sunLight.color = DemoColor[1];
			sunLight.diffuse = 1;
			sunLight.specular = 0.5;
			sunLight.radius = 2000;
			sunLight.fallOff = 2500;
			_view.scene.addChild(sunLight);*/
			
			
			
			
			//create a light for ambient effect that mimics the sky
			skyLight = new PointLight();
			skyLight.y = 100;
			skyLight.color = DemoColor[1];
			skyLight.diffuse = 1;
			skyLight.specular = 0.5;
			skyLight.radius = 2000;
			skyLight.fallOff = 2500;
			_view.scene.addChild(skyLight);
			
			
			
			lightPicker = new StaticLightPicker([sunLight, skyLight]);
			
			// apply the lighting effects to the ground material
			groundMaterial.lightPicker = lightPicker;
			//groundMaterial.shadowMethod = new SoftShadowMapMetho(sunLight);
		}
		
		
		
		
		private function initLoading():void {
			AssetLibrary.enableParser(AWD2Parser);
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			AssetLibrary.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			AssetLibrary.addEventListener(LoaderEvent.LOAD_ERROR, onLoadError);
			AssetLibrary.load(new URLRequest(SIGNBASE_TEXTURE_URL));
			AssetLibrary.load(new URLRequest(MESH_URL));
		}
		
		private function onLoadError(event:LoaderEvent):void{
			trace("Error loading: " + event.url);
		}
		
		private function onAssetComplete(event:AssetEvent):void{
			// To not see these names output in the console, comment the
			// line below with two slash'es, just as you see on this line
			//trace("Loaded " + event.asset.name + " Name: " + event.asset.name);
		}
		
		private function onResourceComplete(ev:LoaderEvent):void{
			assetsThatAreloaded++;
			// check to see if we have all we need
			if (assetsThatAreloaded == assetsToLoad) {
				setupScene();
			}
		}
		
		private function setupScene():void
		{
			// request all the things we loaded into the AssetLibrary
			modelTexture = BitmapTexture(AssetLibrary.getAsset(SIGNBASE_TEXTURE_URL));
			signBase = Mesh(AssetLibrary.getAsset("flag_Cube005"));

			
			// prepare the model's texture material
			var material:TextureMaterial = new TextureMaterial(modelTexture);
			material.lightPicker = lightPicker;
			/*material.gloss = 40;
			material.specular = 0.5;
			material.ambientColor = 0xAAAAFF;
			material.ambient = 0.25;
			material.addMethod(new RimLightMethod(DemoColor[1], .4, 3, RimLightMethod.ADD));*/

			signBase.scale(signScale);
			signBase.material = material;
			signHolder.addChild(signBase);

			/**HOLDER**/
			signHolder.rotationY = 235;
			_view.scene.addChild(signHolder);
			
		}
		
		
		
		
		
		
		
		override protected function moveCam (event:PageEvents) : void {
			TweenMax.to(_view.camera, 1, {x : postionsArray[postion].targetX, 
				y : postionsArray[postion].targetY, 
				z : postionsArray[postion].targetZ,
				onComplete:camMovementDone});
			
			if(terry-1 <= postion) { postion = 0; } else { ++postion; }
		}
		private function camMovementDone () : void {
			var _evtCamMoveComplete : PageEvents = new PageEvents("movementComplete");
			RootLevel.stage.dispatchEvent(_evtCamMoveComplete);
		}

		override protected function onEnterFrame(event:Event):void {
			/*skyLight.x =  sunLight.x = _view.camera.x;
			skyLight.y = sunLight.y = _view.camera.y;
			skyLight.z = sunLight.z = _view.camera.z;*/
			sunLight.direction = new Vector3D(Math.sin(getTimer()/1500)*-2500, 1000, Math.cos(getTimer()/1500)*-2500);
			//skyLight.position = new Vector3D(Math.sin(getTimer()/1500)*+2500, 1000, Math.cos(getTimer()/1500)*+2500);
			_view.camera.lookAt( new Vector3D(0, 400, 0));//HARD CODED
			super.onEnterFrame(event);
		}
		
	}
}