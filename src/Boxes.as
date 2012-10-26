package
{
	import com.container.Book;
	import com.container.Home;
	import com.freshplanet.nativeExtensions.Flurry;
	import com.freshplanet.nativeExtensions.PushNotification;
	import com.readToMe.Reader;
	import com.utils.AssetsManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Boxes extends Sprite
	{
		private var _preloader:ZuukaLoader;
		private var _book:Book;
		private var _home:Home;
		private var _reader:Reader;
		private var _timerDone:Boolean=false;
		private var _assetsLoaded:Boolean=false;
		
		public function Boxes()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.FULL_SCREEN;
			addNativeExtensions();
			init();
		}
		
		private function init():void{
			_preloader=new ZuukaLoader();
			addChild(_preloader);
			var tmr:Timer = new Timer(2000,1);
			tmr.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			tmr.start();
			
			addEventListener("go_home",goHome);
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, orientationChange);
			
		}
		
		private function addNativeExtensions():void{
			//8R342X54FKMXSYP793P9
			Flurry.getInstance().setIOSAPIKey("8R342X54FKMXSYP793P9");
			Flurry.getInstance().startSession();
			Flurry.getInstance().setUserId("");//eran
			//Flurry.getInstance().setUserId("XZHJ33295CF73CMTZW9R");
			PushNotification.getInstance().registerForPushNotification();
		}
		
		private function goHome(e:Event):void{
			removeChildAt(0);
			addChild(_home);
			if(_book){
				_book.stopCurrentScene();
			}
		}
		
		private function onTimer(e:Event):void{
			_timerDone = true;
			var assetManager:AssetsManager = new AssetsManager();
			assetManager.complete.add(onAssetsLoaded);
		}
		
		private function onAssetsLoaded():void{
			_assetsLoaded = true;
			start();
		}
		private function start():void{
			if(!_timerDone||!_assetsLoaded){
				return;
			}
			_home=new Home();
			addChild(_home);
			_home.addEventListener("readToMe",readToMe);
			_home.addEventListener("readByMyself",readByMyself);
			removeChild(_preloader);
		}
		
		private function readByMyself(e:Event):void{
			removeChild(_home);
			if(!_book){
				_book=addChild(new Book()) as Book;
			}else{
				_book.reset();
			}
			addChild(_book);
		}
		
		private function readToMe(e:Event):void{
			removeChild(_home);
			if(!_reader){
				_reader=new Reader();
			}
			addChild(_reader);
			_reader.play();
		}
		
		private function orientationChange(e:StageOrientationEvent):void{
			//onOrientationChanged(e.afterOrientation);
			if (e.afterOrientation != StageOrientation.ROTATED_LEFT && e.afterOrientation != StageOrientation.ROTATED_RIGHT)
			{
				e.preventDefault();
			}
		}
		
	
	}
}