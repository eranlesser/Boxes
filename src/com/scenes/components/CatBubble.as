package com.scenes.components
{
	import com.gskinner.motion.GTween;
	import com.utils.AssetsManager;
	import com.utils.SoundPlayer;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class CatBubble extends Sprite{
		private var _bubble:AnimatedSprite;
		private var _letters:Vector.<DisplayObject>;
		private var _randomArr:Vector.<DisplayObject>;
		private var _clickSignal:NativeSignal;
		private var _popPlayer:SoundPlayer;
		private var _bubbleLetters:Vector.<DisplayObject>;
		public function CatBubble(){
			_popPlayer = new SoundPlayer("miau and pop 1.mp3");
		}
		
		private function initLetters():void{
			_bubbleLetters=new Vector.<DisplayObject>();
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
		private function showLetters():void{
			//_bubble.visible=false;
			_randomArr = getRandomArray();
			
			_randomArr[0].x = 403;
			_randomArr[0].y = 197;
			//addChild(_randomArr[0]);
			_randomArr[1].x = 537;
			_randomArr[1].y = 215;
			//addChild(_randomArr[1]);
			_randomArr[2].x = 668;
			_randomArr[2].y = 117;
			//addChild(_randomArr[2]);
			_randomArr[3].x = 676;
			_randomArr[3].y = 282;
			//addChild(_randomArr[3]);
			_randomArr[4].x = 513;
			_randomArr[4].y = 76;
			//addChild(_randomArr[4]);
			_randomArr = shuffle(_randomArr);
			var timer:Timer = new Timer(80,_randomArr.length);
			timer.addEventListener(TimerEvent.TIMER,addLetter);
			timer.start();
		}
		
		private function getRandomArray():Vector.<DisplayObject>{
			var arr:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			while(arr.length<5){
				var rand:uint = Math.random()*_letters.length-1;
				if(arr.indexOf(_letters[rand])<0){
					arr.push(_letters[rand]);
				}
			}
			return arr;
		}
		protected function shuffle(arr:Vector.<DisplayObject>):Vector.<DisplayObject>{
			var arr2:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			while (arr.length > 0) {
				arr2.push(arr.splice(Math.round(Math.random() * (arr.length - 1)), 1)[0]);
			}
			return arr2;
		}
		
		private function addLetter(e:TimerEvent):void{
			_bubbleLetters.push(addChild(_randomArr.pop()))
		}
		
		public function clearBubble():void{
			while(_bubbleLetters.length>0){
				removeChild(_bubbleLetters.pop());
			}
		}
		private function onBubbleClick(e:MouseEvent):void{
			_bubble.animationComplete.addOnce(showLetters);
			_bubble.play();
			_clickSignal.remove(onBubbleClick);
			_popPlayer.play();
		}
		
		private function showBubble(t:GTween):void{
			//_bubble.visible=true;
			_bubble.x=274;
			_bubble.y=33;
			_bubble.show();
			_bubble.alpha=0;
			var tween:GTween=new GTween(_bubble,0.5,{alpha:1});
			tween.onComplete=activateBubble;
		}
		private function activateBubble(t:GTween):void{
			//_clickSignal = activateClickSignal("F8_1024x768_hotspot_x321_y28.PNG",274,33,onBubbleClick);
			
		}
	}
}