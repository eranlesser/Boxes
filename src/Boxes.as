package
{
	import com.container.Book;
	import com.container.Home;
	import com.container.menu.Share;
	import com.readToMe.Reader;
	import com.utils.AssetsManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	
	public class Boxes extends Sprite
	{
		private var _preloader:PreLoader;
		private var _book:Book;
		private var _home:Home;
		private var _reader:Reader;
		private var _assetsLoaded:Boolean=false;
		private var _share:Share;
		private var _bg:Sprite;
		private static const WIDTH:Number = 1024;
		public function Boxes()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			addNativeExtensions();
			SoundMixer.audioPlaybackMode  =  AudioPlaybackMode.AMBIENT;
			stage.quality = StageQuality.LOW;
			init();
		}
		
		private function init():void{
			_preloader=new PreLoader();
			addChild(_preloader);
			var assetManager:AssetsManager = new AssetsManager();
			assetManager.complete.add(onAssetsLoaded);
			addEventListener("go_home",goHome);
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, orientationChange);
			setDisplaySize();
		}
		
		private function addNativeExtensions():void{
			//8R342X54FKMXSYP793P9
			//Flurry.getInstance().setIOSAPIKey("XZHJ33295CF73CMTZW9R");
			//Flurry.getInstance().startSession();
			//Flurry.getInstance().setUserId("XZHJ33295CF73CMTZW9R");
			//Flurry.startSession("8R342X54FKMXSYP793P9");
			//PushNotification.getInstance().registerForPushNotification();
			//SilentSwitch.apply();
			
		}
		
		private function goHome(e:Event):void{
			removeChildAt(0);
			addChild(_home);
			if(_book){
				_book.stopCurrentScene();
			}
		}
		
		private function setDisplaySize():void{
			var ratio:Number = Math.max(stage.fullScreenWidth,stage.fullScreenHeight) / WIDTH;
			this.scaleX=ratio;
			this.scaleY=ratio;
		}
		
		private function onAssetsLoaded():void{
			_assetsLoaded = true;
			start();
			setDisplaySize();
			//addNativeExtensions();
		}
		private function start():void{
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
//		private function openInfo(e:Event):void{
//			if(!_bg){
//				_bg=new Sprite();
//				_bg.graphics.beginFill(0xFFFFFF,0.1);
//				_bg.graphics.drawRect(0,0,Dimentions.WIDTH,Dimentions.HEIGHT);
//				
//			}
//			
//			
//			
//			if(!_share){
//				_share = new Share(_bg);
//				_share.x=268;
//				_share.y=-473;
//				_share.addEventListener("close",onShareClose);
//			}
//			_bg.visible=true;
//			addChild(_bg);
//			addChild(_share);
//			new GTween(_share,0.5,{y:37});
//			
//		}
		private function onShareClose(e:Event):void{
			_bg.visible=false;
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