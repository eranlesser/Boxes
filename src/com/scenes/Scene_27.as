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
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Scene_27 extends AbstractScreen
	{
		private var _clouds:Sprite;
		private var _baloon:Sprite;
		private var _baloonFire:AnimatedSprite;
		private var _baloonBucket:DisplayObject;
		private var _tween:GTween;
		private var _baloonIdleTween:GTween;
		private var _pressTimer:Timer = new Timer(1000,1);
		private var _soundPlayer:SoundPlayer;
		private var _deltaY:uint=0;
		private var _touchHere:TouchHere=new TouchHere();
		public function Scene_27()
		{
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F27_1024x768_background.jpg"));
				addClouds();
				cloudTween();
				addBaloon();
				var sea:DisplayObject = AssetsManager.getAssetByName("F27_1024x768_sea_x0_y674.png");
				addChild(sea);
				sea.y=674;
				_soundPlayer = new SoundPlayer("BALOON HOT AIR-FOR SCENE 27.mp3");
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F27_1024x768_x315_y101.png"),315,101));
				narationer=new NarationPlayer("narration/scene 27.mp3");
				addChild(_touchHere);
				inited=true;
			}
			narationer.play();
			_touchHere.activate();
			
		}
		override public function stop():void{
			narationer.stop();
			_touchHere.deActivate();
			_baloon.y=-304;
			_deltaY=0;
			_baloonIdleTween.end();
		}
		
		//_________________________________________________
		//________________________________________BALOON
		private function addBaloon():void{
			_baloon = new Sprite();
			_baloon.addChild(AssetsManager.getAssetByName("F27_1024x768_baloon_x187_y-304.png"));
			var frames:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			frames.push(AssetsManager.getAssetByName("F27_1024x768_fire1_x397_y342.png"));
			frames.push(AssetsManager.getAssetByName("F27_1024x768_fire2_x397_y342.png"));
			frames.push(AssetsManager.getAssetByName("F27_1024x768_fire3_x397_y342.png"))
			_baloonFire = new AnimatedSprite(frames);
			_baloon.addChild(_baloonFire);
			_baloonFire.x = 397-187;
			_baloonFire.y = 342+304;
			_baloonBucket = AssetsManager.getAssetByName("F27_1024x768_firebucket_x496_y391.png");
			_baloonBucket.x = 496-187;
			_baloonBucket.y = 391+304;
			_baloon.addChild(_baloonBucket);
			_baloon.x=187;
			_baloon.y=-304;
			_baloon.addChild(AssetsManager.getAssetByName("F27_1024x768_baloon_hotspot_x187_y-304.png"));
			_baloon.cacheAsBitmap = true;
			addChild(_baloon);
			_baloon.addEventListener(MouseEvent.MOUSE_DOWN,baloonPressed);
			idleTweenBaloon();
			_touchHere.x=_baloon.x+_baloon.width/2-_touchHere.width/2+20;
			_touchHere.y=_baloon.y+_baloon.height/2-_touchHere.height/2+200;
		}
		
		private function baloonPressed(e:MouseEvent):void{
			_baloonFire.show();
			addEventListener(MouseEvent.MOUSE_UP,baloonUnPressed);
			
			_pressTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onBaloonPressedForOneSecond);
			_pressTimer.start();
			_soundPlayer.play(true);
			//_baloon.y-=15;
			_deltaY+=25;
			_touchHere.deActivate();
		}
		
		private function onBaloonPressedForOneSecond(e:Event):void{
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function baloonUnPressed(e:MouseEvent):void{
			_baloonFire.hide();
			_pressTimer.stop();
			removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			removeEventListener(MouseEvent.MOUSE_UP,baloonUnPressed);
			_pressTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,onBaloonPressedForOneSecond);
			_soundPlayer.stop();
		}
		
		private function onEnterFrame(e:Event):void{
			if(_baloonFire.done){
				_baloonFire.reset();
			}
			//_baloon.y-=2;
			_deltaY+=2;
			_baloonFire.progress();
		}
		
		private function idleTweenBaloon():void{
			var tweenTo:int = -299-_deltaY;
			if(_baloon.y==-299-_deltaY){
				tweenTo = -309-_deltaY;
			}
			_baloonIdleTween = new GTween(_baloon,1.4,{y:tweenTo});
			_baloonIdleTween.onComplete = onBaloonIdleDone;
		}
		
		private function onBaloonIdleDone(t:GTween):void{
			idleTweenBaloon();
		}
		
		//________________________________________BALOON
		//_________________________________________________
		
		//___________________________________________
		//_____________________________________CLOUDS
		
		private function addClouds():void{
			_clouds = new Sprite();
			var cloud1:DisplayObject = AssetsManager.getAssetByName("F27_1024x768_clouds_x-403_y132.png");
			var cloud2:DisplayObject = AssetsManager.getAssetByName("F27_1024x768_clouds_x-403_y132.png");
			_clouds.addChild(cloud1);
			_clouds.addChild(cloud2);
			cloud2.x = cloud2.width;
			addChild(_clouds);
			_clouds.x=-403;
			_clouds.y=132;
			_clouds.cacheAsBitmap = true;
		}
		private function cloudTween():void{
			_tween = new GTween(_clouds,12,{x:-_clouds.width/2-403});
			_tween.onComplete = onTweenComplete;
		}
		private function onTweenComplete(tween:GTween):void{
			_clouds.x=-403;
			cloudTween();
		}
		//_____________________________________CLOUDS
		//___________________________________________
		
		
	}
}