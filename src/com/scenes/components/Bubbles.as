package com.scenes.components
{
	import com.gskinner.motion.GTween;
	import com.utils.AssetsManager;
	import com.utils.SequanceUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Bubbles extends Sprite
	{
		private var _assets:Vector.<String>;
		private var _timer:Timer = new Timer(1000);
		public function Bubbles(){
			init();
		}
		private function init():void{
			_assets=SequanceUtil.createStringVector(1,15,"F7_1024x768_bubble",".png");
			_timer.addEventListener(TimerEvent.TIMER,addBubbles);
		}
		
		public function start():void{
			//addBubbles();
			_timer.start();
		}
		
		public function stop():void{
			_timer.stop();
		}
		
		private function addBubbles(e:TimerEvent):void{
			var count:uint = 5 + Math.round(Math.random()*2);
			for(var i:uint=0;i<count;i++){
				addBubble();
			}
		}
		
		private function addBubble():void{
			var bubble:DisplayObject = AssetsManager.getAssetByName(_assets[Math.round(Math.random()*(_assets.length-1))]);
			addChild(bubble);
			bubble.x = Math.random()*410;
			bubble.y = 258;
			var tween:GTween = new GTween(bubble,2+2*Math.random(),{y:0});
			tween.onComplete = onBubbleComplete;
		}
		
		private function onBubbleComplete(tween:GTween):void{
			removeChild(DisplayObject(tween.target))
		}
	}
}