package com.scenes
{
	import com.global.TextAndNarration;
	import com.scenes.components.AnimatedSprite;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.natives.NativeSignal;

	public class Scene_6 extends AbstractScreen
	{
		
		private var _man:DisplayObject;
		private var _cat:AnimatedSprite;
		private var _clickSignal:NativeSignal;
		private var _miauSound:SoundPlayer;
		private var _bang:DisplayObject;
		private var thatHurtsSound:SoundPlayer;
		private var _bangSound:SoundPlayer;
		private var _touchHere:TouchHere;
		public function Scene_6(){
			narationer=new NarationPlayer("narration/scene 6 a.mp3");
			_bangSound=new SoundPlayer("WAKING MAN HIT BED.mp3");
			narationer.soundComplete.add(playNaration2);
		}
		
		override public function start():void{
			if(!inited){
				addChildAt(AssetsManager.getAssetByName("F6_1024x768_background.jpg"),0);
				_man = AssetsManager.getAssetByName("F6_1024x768_man_above_x387_y299.png");
				addChild(_man);
				var keyFrames:Vector.<DisplayObject> = new Vector.<DisplayObject>();
				keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat0_x440_y493.png"))
				keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat1_x440_y493.png"))
				keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat2_x440_y493.png"))
				keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat3_x440_y493.png"))
				keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat4_x440_y493.png"))
				_bang=AssetsManager.getAssetByName("F6_1024x768_bang_x329_y322.png");
				addChild(_bang);
				_cat = new AnimatedSprite(keyFrames);
				addChild(_cat);
				_miauSound = new SoundPlayer("yawn and cat.mp3");
				thatHurtsSound=new SoundPlayer("narration/scene 6 b.mp3");
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F6_1024x768_x139_y150.png"),139,150));
				
				var hotSpot:DisplayObject=AssetsManager.getAssetByName("F6_1024x768_hotspot_x379_y310.png");
				var hotspotWidth:uint=hotSpot.width;
				var hotspotHeight:uint=hotSpot.height;
				_clickSignal = activateClickSignal("F6_1024x768_hotspot_x379_y310.png",518,310,stretch);
				_touchHere=new TouchHere();
				addChild(_touchHere);
				_touchHere.x=379+(hotspotWidth-_touchHere.width)/2-_touchHere.width/2;
				_touchHere.y=310+(hotspotHeight-_touchHere.height)/2-100;
				
				inited=true;
			}else{
				_clickSignal.add(stretch);
			}
			initMan();
			initCat();
			narationer.play(1);
			_touchHere.activate();
			
		}
		
		private function playNaration2():void{
			thatHurtsSound.play();
		}
		
		override public function stop():void{
			super.stopAllDelayers();
			_miauSound.stop();
			narationer.stop();
			thatHurtsSound.stop();
			_touchHere.deActivate();
			if(_cat.isShowen){
				_cat.stop();
				_cat.hide();
				_cat.reset();
			}
		}
		
		private function initMan():void{
			_man.visible = false;
			_man.x = 387;
			_man.y = 299;
		}
		
		private function initCat():void{
			
			_cat.x = 440;
			_cat.y = 493;
			_bang.x=329;
			_bang.y=322;
			_bang.visible=false;
		}
		
		private function stretch(e:Event):void{
			_touchHere.deActivate();
			_man.visible = true;
			_bang.visible=true;
			_bangSound.play();
			_clickSignal.remove(stretch);
			setDelay(500,peep);
			_miauSound.play();
		}
		
		private function peep(e:Event):void{
			Timer(e.target).removeEventListener(TimerEvent.TIMER_COMPLETE,peep);
			_cat.show();
			_cat.play(50);
			_cat.animationComplete.add(animation4);
		}
		
		private function animation4():void{
			_cat.animationComplete.remove(animation4);
			setDelay(1500,animation5);
		}
		private function animation5(e:Event):void{
			Timer(e.target).removeEventListener(TimerEvent.TIMER_COMPLETE,animation5);
			_cat.reverse();
			_cat.play(50);
			_cat.animationComplete.addOnce(animation6);
		}
		
		private function animation6():void{
			_man.visible = false;
			_bang.visible=false;
			_cat.reverse();
			_cat.reset();
			_clickSignal.add(stretch);
		}
		
	}
}