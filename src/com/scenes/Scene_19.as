package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class Scene_19 extends AbstractScreen
	{
		private var _manBefore:DisplayObject;
		private var _manAfter:DisplayObject;
		private var _sea:DisplayObject;
		private var _sea2:DisplayObject;
		private var _drops:DisplayObject;
		private var _clickSignal:NativeSignal;
		private var _soundPlayer:SoundPlayer;
		private var _ohSound:SoundPlayer;
		private var _narrationPlayer:NarationPlayer;
		private var _touchHere:TouchHere;
		public function Scene_19(){
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F19_1024x768_background.jpg"));
				
				initSea();
				initMan();
				_soundPlayer = new SoundPlayer("WAVES-FOR SCENE 19.mp3");
				_ohSound=new SoundPlayer("BEACH MAN OH.mp3");
				var txt:DisplayObject=AssetsManager.getAssetByName("Text_F19_1024x768_x49_y50.png");
				txt.x=49;
				txt.y=50;
				addChild(txt);
				TextAndNarration.registerText(txt);
				_narrationPlayer=new NarationPlayer("narration/scene 19.mp3");
				
				inited=true;
			}
			_touchHere.activate();
			_manAfter.visible=false;
			_manBefore.visible=true;
			_narrationPlayer.play();
			_soundPlayer.play(true);
		}
		
		override public function stop():void{
			_soundPlayer.stop();
			_narrationPlayer.stop();
			_touchHere.deActivate();
		}
		
		private function initMan():void{
			_manBefore = AssetsManager.getAssetByName("F19_1024x768_man_reg_x479_y237.png");
			_manAfter = AssetsManager.getAssetByName("F19_1024x768_man_after_x473_y237.png");
			addChild(_manBefore);
			_manBefore.x=479;
			_manBefore.y=237;
			addChild(_manAfter);
			_manAfter.x=473;
			_manAfter.y=237;
			
			
			
			_clickSignal=activateClickSignal("F19_1024x768_man_hotspot_x493_y255.png",493,255,onManClick);
			
			_touchHere=new TouchHere();
			addChild(_touchHere);
			_touchHere.x=_manBefore.x+_manBefore.width/2;
			_touchHere.y=_manBefore.y+_manBefore.height/2;
			
		}
		
		private function onManClick(e:MouseEvent):void{
			_manBefore.visible=!_manBefore.visible;
			_manAfter.visible=!_manAfter.visible;
			_ohSound.play();
			_touchHere.deActivate();
			//_clickSignal.remove(onManClick);
		}
		
		private function initSea():void{
			_sea = AssetsManager.getAssetByName("F19_1024x768_sea_x0_y528.png");
			_sea2 = AssetsManager.getAssetByName("F19_1024x768_sea_x0_y528.png");
			_drops = AssetsManager.getAssetByName("F19_1024x768_drops_x0_y519.png");
			addChild(_drops);
			addChild(_sea);
			addChild(_sea2);
			_sea.y=528;
			_sea2.y=720;
			_sea2.visible=false;
			_drops.y=519;
			onSeaUpComplete(null);
			setDelay(10,init2);
		}
		
		
		
		private function init2(e:Event):void{
			_sea2.visible=true;;
			onSeaDownComplete2(null);
		}
		private function animateDown(e:Event):void{
			var seaTween:GTween = new GTween(_sea,1.5,{y:720},{ease:Sine.easeIn});
			_drops.alpha=1;
			var dropsTween:GTween = new GTween(_drops,1.5,{alpha:0},{ease:Sine.easeIn});
			seaTween.onComplete=onSeaDownComplete;
		}
		private function animateUp(e:Event):void{
			var seaTween:GTween = new GTween(_sea,1.5,{y:528},{ease:Sine.easeInOut});
			seaTween.onComplete=onSeaUpComplete;
			addChild(_sea);
		}
		
		private function onSeaDownComplete(g:GTween):void{
			setDelay(500,animateUp);
		}
		private function onSeaUpComplete(g:GTween):void{
			setDelay(500,animateDown);
		}
		private function animateDown2(e:Event):void{
			var seaTween:GTween = new GTween(_sea2,1.5,{y:720},{ease:Sine.easeIn});
			_drops.alpha=1;
			var dropsTween:GTween = new GTween(_drops,1.5,{alpha:0},{ease:Sine.easeIn});
			seaTween.onComplete=onSeaDownComplete2;
		}
		private function animateUp2(e:Event):void{
			addChild(_sea2);
			var seaTween:GTween = new GTween(_sea2,1.5,{y:528},{ease:Sine.easeOut});
			seaTween.onComplete=onSeaUpComplete2;
		}
		
		private function onSeaDownComplete2(g:GTween):void{
			setDelay(500,animateUp2);
		}
		private function onSeaUpComplete2(g:GTween):void{
			setDelay(500,animateDown2);
		}
	}
}