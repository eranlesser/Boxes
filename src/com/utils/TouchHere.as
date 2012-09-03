package com.utils
{
	import com.gskinner.motion.GTween;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class TouchHere extends Sprite
	{
		private var _icon1:DisplayObject;
		private var _icon2:DisplayObject;
		private var _glowTween:GTween;
		private var _delayTimer:Timer;
		public function TouchHere(){
			_icon1=AssetsManager.getAssetByName("touch_here_bright.png");
			_icon2=AssetsManager.getAssetByName("touch_here_dark.png");
			addChild(_icon1);
			addChild(_icon2);
			_delayTimer=new Timer(5000,1);
			_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			this.mouseEnabled=false;
			this.mouseChildren=false;
			this.alpha=0;
		}
		
		private function glow(t:GTween):void{
			if(t){
				t.onComplete=null;
			}
			var newAlpha:uint;
			if(_icon2.alpha==0){
				newAlpha=1;
			}else{
				newAlpha=0;
			}
			_glowTween=new GTween(_icon2,0.5,{alpha:newAlpha});
			_glowTween.onComplete=glow;
		}
		
		private function onTimer(e:Event):void{
			var gt:GTween=new GTween(this,0.5,{alpha:1})
			gt.onComplete=glow;
		}
		
		public function activate(delayTime:uint=5000):void{
			_delayTimer.delay=delayTime;
			_delayTimer.start();
			this.visible=true;
		}
		
		public function deActivate():void{
			if(_glowTween){ // delay time
				_glowTween.onComplete=null;
				_glowTween.end();
			}
			if(_delayTimer.running){
				_delayTimer.reset();
			}
			this.alpha=0;
			this.visible=false;
			
		}
	}
}