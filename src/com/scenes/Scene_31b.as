package com.scenes
{
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class Scene_31b extends AbstractScreen{
		private var _mouth:DisplayObject;
		private var _jiggle:SoundPlayer;
		private var _touchHere:TouchHere=new TouchHere();
		public function Scene_31b(){

		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F31_5_1024x768_BG.jpg"));
				_mouth=AssetsManager.getAssetByName("F31_5_1024x768_mouth_x618_y506.png");
				_jiggle=new SoundPlayer("giggle.mp3");
				_jiggle.soundComplete.add(unSmile);
				addChild(_mouth);
				_mouth.x=618;
				_mouth.y=506;
				this.addEventListener(MouseEvent.CLICK,smile);
				addChild(_touchHere);
				_touchHere.x=660;
				_touchHere.y=500;
				inited=true;
			}
			_mouth.alpha=0;
			_touchHere.activate();
		}
		
		override public function stop():void{
			_jiggle.stop();
			_touchHere.deActivate();
		}
		
		private function smile(e:MouseEvent):void{
			_mouth.alpha=1;
			_jiggle.play();
			_touchHere.deActivate();
		}
		
		private function unSmile():void{
			_mouth.alpha=0;
		}
	}
}