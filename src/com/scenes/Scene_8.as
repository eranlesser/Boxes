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
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.natives.NativeSignal;

	public class Scene_8 extends AbstractScreen
	{
		private var _bubble:AnimatedSprite;
		private var _letters:Vector.<DisplayObject>;
		private var _randomArr:Vector.<DisplayObject>;
		private var _clickSignal:NativeSignal;
		private var _soundPlayer:SoundPlayer;
		private var _displayedArr:Vector.<DisplayObject>=new Vector.<DisplayObject>();
		private var _touchHere:TouchHere;
		private var _lettersLayer:Sprite;
		public function Scene_8()
		{
			narationer=new NarationPlayer("narration/scene 8.mp3");
		}
		
		override public function start():void{
			if(!inited){
				var frames:Vector.<DisplayObject> = new Vector.<DisplayObject>();
				frames.push(AssetsManager.getAssetByName("F8_1024x768_background_1.jpg"));
				frames.push(AssetsManager.getAssetByName("F8_1024x768_background_2.jpg"));
				frames.push(AssetsManager.getAssetByName("F8_1024x768_background_3.jpg"));
				_lettersLayer=new Sprite();
				_bubble = new AnimatedSprite(frames);
				
				initLetters();
				_soundPlayer = new SoundPlayer("miau and pop 1.mp3");
				addChild(_bubble);
				_bubble.show();
				addChild(_lettersLayer);
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F8_1024x768_x59_y265.PNG"),59,265));
				_clickSignal = activateClickSignal("F8_1024x768_hotspot_x321_y28.PNG",490,38,onClick);
				_touchHere=new TouchHere();
				addChild(_touchHere);
				_touchHere.x=321+390;
				_touchHere.y=28+150;
				inited=true;
			}
			_touchHere.activate();
			narationer.play();
		}
		
		override public function stop():void{
			_touchHere.deActivate();
			onUnClick(null);
			_soundPlayer.stop();
			narationer.stop();
		}
		
		private function initLetters():void{
			_letters = new Vector.<DisplayObject>();
			_letters.push();
			_letters.push(AssetsManager.getAssetByName("F8_1024x768_bell.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_bird.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_bluebird.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_boat.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_bottle.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_bubles.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_bulb.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_cat.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_dish.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_dog.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_eye.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_fish.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_flower.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_hat.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_heart.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_key.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_lightning.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_mouse.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_omlet.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_paw.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_plant.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_roach.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_star.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_string.PNG"))
				_letters.push(AssetsManager.getAssetByName("F8_1024x768_window.PNG"))
		}
		
		private function onClick(e:MouseEvent):void{
			_bubble.animationComplete.addOnce(showLetters);
			_bubble.play();
			_clickSignal.remove(onClick);
			_soundPlayer.play();
			_touchHere.deActivate();
		}
		
		private function onUnClick(e:MouseEvent):void{
			_bubble.reset();
			_bubble.show();
			removeLetters();
			_clickSignal.add(onClick);
			_clickSignal.remove(onUnClick);
		}
		
		private function getRandomArray():Vector.<DisplayObject>{
			var arr:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			while(arr.length<5){
				var rand:uint = Math.random()*(_letters.length-1);
				if(arr.indexOf(_letters[rand])<0){
					arr.push(_letters[rand]);
				}
			}
			return arr;
		}
		
		private function showLetters():void{
			_randomArr = getRandomArray();
			
			_randomArr[0].x = 573;
			_randomArr[0].y = 197;
			//addChild(_randomArr[0]);
			_randomArr[1].x = 707;
			_randomArr[1].y = 215;
			//addChild(_randomArr[1]);
			_randomArr[2].x = 838;
			_randomArr[2].y = 117;
			//addChild(_randomArr[2]);
			_randomArr[3].x = 846;
			_randomArr[3].y = 282;
			//addChild(_randomArr[3]);
			_randomArr[4].x = 683;
			_randomArr[4].y = 76;
			//addChild(_randomArr[4]);
			_randomArr = shuffle(_randomArr);
			var timer:Timer = new Timer(80,_randomArr.length);
			timer.addEventListener(TimerEvent.TIMER,addLetter);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onAllLettersShown);
			timer.start();
		}
		private function onAllLettersShown(e:TimerEvent):void{
			_clickSignal.add(onUnClick);
			Timer(e.target).removeEventListener(TimerEvent.TIMER_COMPLETE,onAllLettersShown);
			
		}
		protected function shuffle(arr:Vector.<DisplayObject>):Vector.<DisplayObject>{
			var arr2:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			while (arr.length > 0) {
				arr2.push(arr.splice(Math.round(Math.random() * (arr.length - 1)), 1)[0]);
			}
			return arr2;
		}
		
		private function addLetter(e:TimerEvent):void{
			var letter:DisplayObject=_randomArr.pop();
			_displayedArr.push(letter);
			_lettersLayer.addChild(letter);
		}
		
		private function removeLetters():void{
			var lngt:uint=_displayedArr.length;
			for(var i:uint=0;i<lngt;i++){
				_lettersLayer.removeChild(_displayedArr.pop());
			}
		}
	}
}