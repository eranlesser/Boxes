package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.components.AnimatedSprite;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.natives.NativeSignal;

	public class Scene_15 extends AbstractScreen
	{
		
		private var _man:DisplayObject;
		private var _cat:AnimatedSprite;
		private var _clickSignal:NativeSignal;
		private var _soundPlayer:SoundPlayer;
		private var _bg:Sprite;
		private var _bang:DisplayObject;
		private var _bangSound:SoundPlayer;
		private var _touchHere:TouchHere=new TouchHere();
		public function Scene_15(){
			narationer=new NarationPlayer("narration/scene 15 a.mp3","narration/scene 15 b.mp3");
			_bangSound=new SoundPlayer("WAKING MAN HIT BED.mp3");
		}
		
		override public function start():void{
			if(!inited){
				_bg=new Sprite();
				_bg.addChild(AssetsManager.getAssetByName("F6_1024x768_background.jpg"));
				addChild(_bg);
				initMan();
				initCat();
				_soundPlayer = new SoundPlayer("yawn and cat.mp3");
				//thatHurtsSound=new SoundPlayer("narration/23.mp3");
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F15_1024x768_x139_y151.PNG"),139,151));
				_clickSignal = activateClickSignal("F6_1024x768_hotspot_x379_y310.png",518,310,stretch);
				addChild(_touchHere);
				_touchHere.x=530;
				_touchHere.y=330;
				inited=true;
			}else{
				_clickSignal.add(stretch);
			}
			_touchHere.activate();
			narationer.reset();
			narationer.play();
			narationer.soundComplete.add(playNaration2)
		}
		
		private function playNaration2():void{
			narationer.soundComplete.remove(playNaration2)
			narationer.play();
		}
		
		
		override public function stop():void{
			_soundPlayer.stop();
			narationer.stop();
			_touchHere.deActivate();
			//thatHurtsSound.stop();
		}
		
		private function initMan():void{
			_man = AssetsManager.getAssetByName("F6_1024x768_man_above_x387_y299.png");
			_bg.addChild(_man);
			_man.visible = false;
			_man.x = 387;
			_man.y = 299;
		}
		
		private function initCat():void{
			var keyFrames:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat0_x440_y493.png"))
			keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat1_x440_y493.png"))
			keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat2_x440_y493.png"))
			keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat3_x440_y493.png"))
			keyFrames.push(AssetsManager.getAssetByName("F6_1024x768_cat4_x440_y493.png"))
			_cat = new AnimatedSprite(keyFrames);
			addChild(_cat);
			_cat.x = 440;
			_cat.y = 493;
			_bang=AssetsManager.getAssetByName("F6_1024x768_bang_x329_y322.png");
			addChild(_bang);
			_bang.x=329;
			_bang.y=322;
			_bang.visible=false;
		}
		
		private function stretch(e:Event):void{
			_touchHere.deActivate();
			_man.visible = true;
			_clickSignal.remove(stretch);
			setDelay(500,peep);
			_soundPlayer.play();
			_bang.visible=true;
			_bangSound.play();
			var shake1:GTween=new GTween(_bg,0.1,{x:-10},{nextTween:shake2});
			var shake2:GTween=new GTween(_bg,0.1,{x:7},{delay:0.1});
			var shake3:GTween=new GTween(_bg,0.1,{x:-5},{delay:0.2});
			var shake4:GTween=new GTween(_bg,0.1,{x:6},{delay:0.3});
			var shake5:GTween=new GTween(_bg,0.1,{x:-4},{delay:0.4});
			var shake6:GTween=new GTween(_bg,0.1,{x:0},{delay:0.5});
			
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
			_cat.reverse();
			_cat.reset();
			_bang.visible=false;
			_clickSignal.add(stretch);
		}
		
	}
}