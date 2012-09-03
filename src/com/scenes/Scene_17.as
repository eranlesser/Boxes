package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Scene_17 extends AbstractScreen
	{
		private var _boat:DisplayObject;
		private var _tween1:GTween;
		private var _tween2:GTween;
		private var _tween3:GTween;
		private var _tween4:GTween;
		private var _tween5:GTween;
		private var _soundPlayer:SoundPlayer;
		private var _touchHere:TouchHere;
		public function Scene_17()
		{
			narationPlayer=new NarationPlayer("narration/scene 17.mp3");
		}
		
		override public function start():void{
			if(!inited){
				bg = AssetsManager.getAssetByName("F17_1024x768_background.jpg");
				_boat = AssetsManager.getAssetByName("F17_1024x768_boat.png");
				addChild(_boat);
				
				addChild(AssetsManager.getAssetByName("F17_1024x768_foreground.png"));
				//initTweens();
				_soundPlayer = new SoundPlayer("sea and birds louder.mp3");
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F17_1024x768_x34_y481.png"),34,481));
				_touchHere=new TouchHere();
				addChild(_touchHere);
				_touchHere.x=250;
				_touchHere.y=150;
				inited=true;
			}
			_touchHere.activate();
			_boat.scaleX = 1;
			_boat.y=195;
			_boat.x = 534;
			narationPlayer.play();
			this.addEventListener(MouseEvent.CLICK,onClick);
			//initTweens();
		}
		
		private function onClick(e:Event):void{
			this.removeEventListener(MouseEvent.CLICK,onClick);
			initTweens();
			_touchHere.deActivate();
		}
		
		override public function stop():void{
			//_tween5.onComplete=null;
			_touchHere.deActivate();
			this.removeEventListener(MouseEvent.CLICK,onClick);
			_soundPlayer.stop();
			narationPlayer.stop();
			if(_tween1){
				_tween1.end();
				_tween2.end();
				_tween3.end();
				_tween4.end();
				_tween5.onComplete = null;
				_tween5.end();
			}
		}
		
		private function initTweens():void{
			_soundPlayer.play();
			_boat.scaleX = 1;
			_tween5 = new GTween(_boat,2, {x:-143,y:200}, {autoPlay:false});
			_tween4 = new GTween(_boat,2, {x:-10,y:195}, {nextTween:_tween5,autoPlay:false});
			_tween3 = new GTween(_boat,2, {x:126,y:200}, {nextTween:_tween4,autoPlay:false});
			_tween2 = new GTween(_boat,2, {x:262,y:195}, {nextTween:_tween3,autoPlay:false});
			_tween1 = new GTween(_boat,2, {x:398,y:200}, {nextTween:_tween2});
			_tween5.onComplete = reverse;
		}
		
		private function reverse(tween:GTween):void{
			_boat.scaleX = -1;
			_tween5 = new GTween(_boat,2, {x:534,y:195}, {autoPlay:false});
			_tween4 = new GTween(_boat,2, {x:398,y:200}, {nextTween:_tween5,autoPlay:false});
			_tween3 = new GTween(_boat,2, {x:262,y:195}, {nextTween:_tween4,autoPlay:false});
			_tween2 = new GTween(_boat,2, {x:126,y:200}, {nextTween:_tween3,autoPlay:false});
			_tween1 = new GTween(_boat,2, {x:-10,y:195}, {nextTween:_tween2});
			//_tween5.onComplete = initTweens;
			
		}
	}
}