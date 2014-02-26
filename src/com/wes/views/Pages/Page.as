package com.wes.views.Pages
{
	import com.wes.compontents.Fonts;
	import com.wes.events.MenuBtnEvent;
	
	public class Page extends Fonts
	{
		public var data : *;
		private var _evt : MenuBtnEvent;
		
		public function Page(_data : *)
		{
			data = _data;
			super();
		}
		
		public function _intro () : void{
			intro();
		}
		
		public function _outro () : void {
			outro();
		}
		
		protected function intro () : void{
			
		}
		
		protected function outro () : void {
			_evt = new MenuBtnEvent("pageClose");
			dispatchEvent(_evt);
		}
		
		public function _render (_month : uint, _year : uint) : void {
			render(_month, _year);
		}
		
		protected function render (_month : uint, _year : uint) : void {
			
		}
		
		
	}
}