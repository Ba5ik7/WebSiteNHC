package com.wes.compontents
{
	import flash.display.Sprite;

	public class Fonts extends Sprite
	{
		
		
		// to embed a font file that's relative to your project
		[Embed(source="../../../font/HANA____.ttf", 
			    fontName="HANA", 
				fontStyle="normal",
				fontWeight="normal",
			    mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-007E")]
		public var HANA:Class;
		
		[Embed(source="../../../font/HANAB___.ttf", 
			    fontName="HANAB", 
				fontStyle="normal",
				fontWeight="normal",
			    mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-007E")]
		public var HANAB:Class;
		
		[Embed(source="../../../font/HANAI___.ttf", 
			    fontName="HANAI", 
				fontStyle="normal",
				fontWeight="normal",
			    mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-007E")]
		public var HANAI:Class;
		
		[Embed(source="../../../font/HANABI__.ttf", 
			    fontName="HANABI", 
				fontStyle="normal",
				fontWeight="normal",
			    mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-007E")]
		public var HANABI:Class;
		
		
		/****/
		// to embed a font file that's relative to your project
		[Embed(source="../../../font/CaviarDreams.ttf", 
			    fontName="caviarDream", 
				fontStyle="normal",
				fontWeight="normal",
			    mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-007E")]
		public var caviarDream:Class;
		
		
		[Embed(source="../../../font/CaviarDreams_Bold.ttf", 
			    fontName="caviarDreamB", 
				fontStyle="normal",
				fontWeight="normal",
			    mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-007E")]
		public var caviarDreamBold:Class;
		
		
		[Embed(source="../../../font/CaviarDreams_Italic.ttf", 
			    fontName="caviarDreamI", 
				fontStyle="normal",
				fontWeight="normal",
			    mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-007E")]
		public var caviarDreamItalic:Class;
		
		
		[Embed(source="../../../font/CaviarDreams_BoldItalic.ttf", 
			    fontName="caviarDreamBI", 
				fontStyle="normal",
				fontWeight="normal",
			    mimeType="application/x-font-truetype",
				embedAsCFF="false",
				unicodeRange="U+0020-007E")]
		public var myEmbeddedFont:Class;
		
		public function Fonts() { }
	}
}