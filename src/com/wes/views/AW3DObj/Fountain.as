package com.wes.views.AW3DObj
{
	import com.wes.views.Away3D;
	
	public class Fountain extends Away3D
	{
		
		[Embed(source="../../../../assets/Fountain.3DS", mimeType="application/octet-stream")]
			private var FountainModel:Class;
		
			
		public function Fountain() {
			super();
			
			var test :* = new FountainModel();
			addChild(test);
		}
		
		
		
		
		
		
	}
}