package com.scenes
{
	import com.constants.Dimentions;
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.components.AnimatedSprite;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class Scene_25 extends AbstractScreen
	{
		private var _people:DisplayObject;
		private var _soundPlayer:SoundPlayer;
		private var _bubble:AnimatedSprite;
		private var _letters:Vector.<DisplayObject>;
		private var _randomArr:Vector.<DisplayObject>;
		private var _clickSignal:NativeSignal;
		private var _popPlayer:SoundPlayer;
		private var _displayedArr:Vector.<DisplayObject>=new Vector.<DisplayObject>();
		private var _touchHere:TouchHere = new TouchHere();
		private var _bubbleTouchHere:TouchHere = new TouchHere();
		private var _peopleTween:GTween;
		public function Scene_25()
		{
			super();
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F25_1024x768_background.jpg"));
				var txt:DisplayObject=(AssetsManager.getAssetByName("Text_F25_1024x768_x59_y380.png"));
				TextAndNarration.registerText(addChild(txt));
				txt.x=59
				txt.y=380;
				
				var frames:Vector.<DisplayObject> = new Vector.<DisplayObject>();
				frames.push(AssetsManager.getAssetByName("F25_1024x768_ballon_x274_y33.png"));
				frames.push(AssetsManager.getAssetByName("F25_1024x768_lines_x274_y33.png"));
				
				initLetters();
				_bubble = new AnimatedSprite(frames);
				addChild(_bubble);
				_people = AssetsManager.getAssetByName("F25_1024x768_people.png");
				addChild(_people);
				_soundPlayer = new SoundPlayer("SEA AND SHOUTS-FOR SCENE 25.mp3");
				_soundPlayer.ready.add(playSound);
				
				_popPlayer = new SoundPlayer("miau and pop 1.mp3");
				narationer=new NarationPlayer("narration/scene 25 a.mp3","narration/scene 25 b.mp3");
				
				addChild(_touchHere);
				_touchHere.x=Dimentions.WIDTH/2-_touchHere.width/2;
				_touchHere.y=Dimentions.HEIGHT/2-_touchHere.height/2;
				addChild(_bubbleTouchHere);
				_bubbleTouchHere.x=274+222
				_bubbleTouchHere.y=244;
				inited=true;
			}else{
				playSound();
			}
			_touchHere.activate();
			narationer.soundComplete.add(playNaration2);
			narationer.play(2);
			_people.alpha=1;
			_bubble.alpha=0;
			addEventListener(MouseEvent.CLICK,onPeopleClick);
		}
		
		private function playNaration2():void{
			narationer.soundComplete.remove(playNaration2);
			narationer.play();
		}

		private function onBubbleClick(e:MouseEvent):void{
			_bubble.animationComplete.addOnce(showLetters);
			_bubble.play();
			_clickSignal.remove(onBubbleClick);
			_bubbleTouchHere.deActivate();
			_popPlayer.play();
		}
		private function onUnClick(e:MouseEvent):void{
			_bubble.visible=true;
			_bubble.reset();
			_bubble.show();
			removeLetters();
			_clickSignal.add(onBubbleClick);
			_clickSignal.remove(onUnClick);
		}
		
		override public function stop():void{
			_bubble.visible=false;
			_soundPlayer.stop();
			narationer.stop();
			narationer.reset();
			narationer.soundComplete.remove(playNaration2);
			//narationer.soundComplete.remove(playNaration3);
			_bubble.reset();
			_bubble.show();
			removeLetters();
			_touchHere.deActivate();
			_bubbleTouchHere.deActivate();
			if(_peopleTween){
				_peopleTween.onComplete=null;
				_peopleTween.end();
			}
		}
		private function removeLetters():void{
			var lngt:uint=_displayedArr.length;
			for(var i:uint=0;i<lngt;i++){
				removeChild(_displayedArr.pop());
			}
		}
		private function playSound():void{
			_soundPlayer.play(true);
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
		private function showLetters():void{
			_bubble.visible=false;
			_randomArr = getRandomArray();
			
			_randomArr[0].x = 403;
			_randomArr[0].y = 197;
			_randomArr[1].x = 537;
			_randomArr[1].y = 215;
			_randomArr[2].x = 668;
			_randomArr[2].y = 117;
			_randomArr[3].x = 676;
			_randomArr[3].y = 282;
			_randomArr[4].x = 513;
			_randomArr[4].y = 76;
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
		protected function shuffle(arr:Vector.<DisplayObject>):Vector.<DisplayObject>{
			var arr2:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			while (arr.length > 0) {
				arr2.push(arr.splice(Math.round(Math.random() * (arr.length - 1)), 1)[0]);
			}
			return arr2;
		}
		
		private function addLetter(e:TimerEvent):void{
			var letter:DisplayObject=addChild(_randomArr.pop());
			_displayedArr.push(letter);
		}
		private function onPeopleClick(e:MouseEvent):void{
			_peopleTween = new GTween(_people,2,{alpha:0});
			_peopleTween.onComplete=showBubble;
			_soundPlayer.mute(2);
			removeEventListener(MouseEvent.CLICK,onPeopleClick);
			_touchHere.deActivate();
			
		}
		
		private function showBubble(t:GTween):void{
			_peopleTween.onComplete=null;
			_bubble.visible=true;
			_bubble.x=274;
			_bubble.y=33;
			_bubble.show();
			_bubble.alpha=0;
			var tween:GTween=new GTween(_bubble,0.5,{alpha:1});
			tween.onComplete=activateBubble;
			_bubbleTouchHere.activate();
		}
		private function activateBubble(t:GTween):void{
			_clickSignal = activateClickSignal("F8_1024x768_hotspot_x321_y28.PNG",274,33,onBubbleClick);
			
		}
		
		
	}
}