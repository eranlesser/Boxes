package
{
	import com.container.Book;
	import com.container.Home;
	import com.readToMe.Reader;
	import com.utils.AssetsManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Boxes extends Sprite
	{
		private var _preloader:PreLoader;
		private var _book:Book;
		private var _home:Home;
		private var _reader:Reader;
		
		public function Boxes()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.FULL_SCREEN;
			init();
		}
		
		private function init():void{
			_preloader=new PreLoader();
			addChild(_preloader);
			var assetManager:AssetsManager = new AssetsManager();
			assetManager.complete.add(onAssetsLoaded);
			addEventListener("go_home",goHome);
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, orientationChange);
		}
		
		private function goHome(e:Event):void{
			removeChildAt(0);
			addChild(_home);
			if(_book){
				_book.stopCurrentScene();
			}
		}
		
		private function onAssetsLoaded():void{
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