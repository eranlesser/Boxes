package com.scenes.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	public class AnimatedSprite extends Sprite{
		
		private var _keyframes:Vector.<DisplayObject>;
		private var _frameIndex:uint = 0;
		private var _timer:Timer;
		private var _loop:Boolean=false;
		private var _playFrames:Array;
		private var _playFrameIndex:uint;
		public var animationComplete:Signal = new Signal();
		
		public function AnimatedSprite(keyFrames:Vector.<DisplayObject>){
			_keyframes = keyFrames;
		}
		
		public function show():void{
			while(numChildren>0){
				removeChildAt(0);
			}
			addChild(_keyframes[_frameIndex]);
		}
		
		public function hide():void{
			removeChild(_keyframes[_frameIndex]);
		}
		
		public function reset():void{
			_frameIndex = 0;
		}
		
		public function get isShowen():Boolean{
			return numChildren>0;
		}
		
		public function get done():Boolean{
			return _frameIndex == _keyframes.length-1;
		}
		
		public function progress():void{
			_frameIndex++;
			removeChildAt(0);
			addChild(_keyframes[_frameIndex]);
		}
		
		public function jumpToStart():void{
			_frameIndex=0;
			removeChildAt(0);
			addChild(_keyframes[_frameIndex]);
		}
		
		public function jumpToLast():void{
			_frameIndex=_keyframes.length-1;
			removeChildAt(0);
			addChild(_keyframes[_frameIndex]);
		}
		
		public function play(delay:uint=200,loop:Boolean=false):void{
			if(_timer&&_timer.running){
				throw new Error("animation is running")
			}
			_frameIndex=0;
			_timer = new Timer(delay,_keyframes.length-1);
			_timer.addEventListener(TimerEvent.TIMER,onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			_timer.start();
			_loop = loop;
		}
		
		public function playFrames(frames:Array,delay:uint,cycles:uint):void{
			if(_timer&&_timer.running){
				return;
				trace("animation is running")
			}
			_playFrames=frames;
			_playFrameIndex=0;
			_timer = new Timer(delay,cycles);
			_timer.addEventListener(TimerEvent.TIMER,onPlayFrames);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,onPlayFramesComplete);
			_timer.start();
		}
		
		private function onPlayFrames(e:Event):void{
			removeChildAt(0);
			addChild(_keyframes[_playFrames[_playFrameIndex]]);
			_playFrameIndex++;
			if(_playFrameIndex>=_playFrames.length){
				_playFrameIndex=0;
			}
		}
		private function onPlayFramesComplete(e:Event):void{
			removeChildAt(0);
			addChild(_keyframes[0]);
			_playFrameIndex=0;
			Timer(e.target).removeEventListener(TimerEvent.TIMER,onTimer);
			Timer(e.target).removeEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			
		}
		
		public function stop():void{
			if(!_timer){
				return;
			}
			_timer.removeEventListener(TimerEvent.TIMER,onTimer);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			_timer.stop();
		}
		
		public function reverse():void{
			_keyframes.reverse();
		}
		
		private function onTimerComplete(e:TimerEvent):void{
			
			if(_loop){
				_frameIndex = 0;
				_timer.reset();
				_timer.start();
			}else{
				animationComplete.dispatch();
				Timer(e.target).removeEventListener(TimerEvent.TIMER,onTimer);
				Timer(e.target).removeEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			}
		}
		
		private function onTimer(e:Event):void{
			progress();
		}
		
		
	}
}