package com.scenes
{
	import com.global.TextAndNarration;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Scene_21 extends AbstractScreen{
		private var _bigMagaphone:DisplayObject;
		private var _manWindow:DisplayObject;
		private var _thereHasToBe:SoundPlayer=new SoundPlayer("narration/scene 21.mp3");
		private var _touchHere:TouchHere=new TouchHere();
		public function Scene_21(){
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F21_1024x768_background.jpg"));
				_bigMagaphone = AssetsManager.getAssetByName("F21_1024x768_big_megaphone_x765_y257.jpg");
				_manWindow = AssetsManager.getAssetByName("F21_1024x768_man_window_x526_y220.jpg");
				addChild(_bigMagaphone);
				_bigMagaphone.x = 765;
				_bigMagaphone.y = 257;
				_bigMagaphone.visible=false;
				addChild(_manWindow);
				_manWindow.x=526;
				_manWindow.y=220;
				_manWindow.visible=false;
				addChild(_touchHere);
				_touchHere.x=_bigMagaphone.x+40;
				_touchHere.y=_bigMagaphone.y+40;
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F21_1024x768_x172_y438.png"),172,438));
				//=new NarationPlayer("narration/scene 21.mp3");
				
				inited=true;
			}
			_touchHere.activate();
			this.addEventListener(MouseEvent.CLICK,onClick);
			//narationer.play();
		}
		
		
		override public function stop():void{
			//narationer.stop();
			_thereHasToBe.stop();
			_manWindow.visible =false;
			_bigMagaphone.visible=false;
			_touchHere.deActivate();
			this.removeEventListener(MouseEvent.CLICK,onClick);
		}
			private function onClick(e:MouseEvent):void{
				_bigMagaphone.visible=true;
				_manWindow.visible=true;
				_thereHasToBe.play();
				_touchHere.deActivate();
				_thereHasToBe.soundComplete.add(narrate);
				this.removeEventListener(MouseEvent.CLICK,onClick);
			}
			
			private function onMegaphoneDone():void{
				this.addEventListener(MouseEvent.CLICK,onClick);
				
			}
			
			private function narrate():void{
				_thereHasToBe.soundComplete.remove(onMegaphoneDone);
				_manWindow.visible =false;
				_bigMagaphone.visible=false;
				var narration:SoundPlayer=new SoundPlayer("narration/scene 21a.mp3");
				narration.play();
				narration.soundComplete.add(onMegaphoneDone);
			}
			
	}
}