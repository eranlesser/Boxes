package com.scenes.components
{
	import com.utils.AssetsManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class TextBox extends Sprite
	{
		public function TextBox(bg:String,text:String,xx:int,yy:int){
			addChild(AssetsManager.getAssetByName(bg));
			var txt:DisplayObject=AssetsManager.getAssetByName(text);
			addChild(txt);
			txt.x=xx;
			txt.y=yy;
		}
	}
}