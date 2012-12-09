package com.container
{
	import com.utils.AssetsManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Home extends Sprite
	{
		public function Home(){
			init();
		}
		
		private function init():void{
			addChild(AssetsManager.getAssetByName("Open_Menu_1024x768_BG.jpg"));
			var readtome:Sprite=new Sprite();
			readtome.addChild(AssetsManager.getAssetByName("Open_Menu_1024x768_readtome_hotspot_x138_y239.png"));
			readtome.addEventListener(MouseEvent.CLICK,onReadToMe);
			addChild(readtome);
			readtome.x=138;
			readtome.y=239;
			var readbymyself:Sprite=new Sprite();
			readbymyself.addChild(AssetsManager.getAssetByName("Open_Menu_1024x768_readbymyself_hotspot_x551_y239.png"));
			readbymyself.addEventListener(MouseEvent.CLICK,readbyself);
			addChild(readbymyself);
			readbymyself.x=551;
			readbymyself.y=239;
			
		}
		
		private function onReadToMe(e:MouseEvent):void{
			dispatchEvent(new Event("readToMe"));
		}
		private function readbyself(e:MouseEvent):void{
			dispatchEvent(new Event("readByMyself"));
		}
		
	}
}