package com.utils
{
	import flash.display.DisplayObject;

	public class Asset{
		public var name:String;
		public var image:DisplayObject;
		public function Asset(nme:String,img:DisplayObject){
			name=nme.slice(nme.lastIndexOf("/")+1,nme.length);
			image=img;
		}
		
		
	}
}