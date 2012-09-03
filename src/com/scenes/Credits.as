package com.scenes
{
	import com.scenes.core.AbstractScreen;
	
	import flash.events.Event;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class Credits extends AbstractScreen{
		private var _smallDog:SmallDog;
		private var _pig:Pig;
		private var _dog:Dog;
		private var _pigClickSignal:NativeSignal;
		public function Credits(){
			super();
		}
		
		override public function start():void{
			
		}
		private function initAnimals():void{
			_pig=new Pig();
			addChild(_pig);
			_pig.x=26;
			_pig.y=626;
			_pigClickSignal=activateClickSignal("F14_1024x768_pig_hotspot_x38_y640.png",38,640,pigClick);
			_smallDog=new SmallDog();
			addChild(_smallDog);
			_smallDog.x=145;
			_smallDog.y=626;
			activateClickSignal("F14_1024x768_sml_dog_hotspot_x155_y639.png",155,639,wiggleSmallDog);
			_dog=new Dog();
			addChild(_dog);
			_dog.x=250;
			_dog.y=604;
			activateClickSignal("F14_1024x768_big_dog_hotspot_x306_y616.png",306,616,wiggleDog);
		}
		private function wiggleSmallDog(e:Event):void{
			_smallDog.wiggle();
		}
		private function wiggleDog(e:Event):void{
			_dog.wiggle();
		}
		
		private function pigClick(e:Event):void{
			_pigClickSignal.remove(pigClick);
			_pig.lookAtMe();
		}
	}
}
import com.utils.AssetsManager;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import flashx.textLayout.debug.assert;

class Dog extends Sprite{
	private var _wig1:DisplayObject;
	private var _wig2:DisplayObject;
	private var _wig3:DisplayObject;
	private var _rest:DisplayObject;
	private var _currentWigImage:DisplayObject;
	private var _timer:Timer;
	public function Dog(){
		_rest=addChild(AssetsManager.getAssetByName("F14_1024x768_big_dog_rest_x250_y604.png"));	
		_wig1=AssetsManager.getAssetByName("F14_1024x768_big_dog_wig1_x250_y604.png");
		_wig2=AssetsManager.getAssetByName("F14_1024x768_big_dog_wig2_x250_y604.png");
		_wig3=AssetsManager.getAssetByName("F14_1024x768_big_dog_wig3_x250_y604.png");
		_timer=new Timer(1000/12,24);
		_timer.addEventListener(TimerEvent.TIMER,onTimer);
		_timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
	}
	public function wiggle():void{
		_timer.start();
	}
	private function onTimer(e:Event):void{
		_rest.visible=false;
		if(_currentWigImage){
			removeChild(_currentWigImage);
		}
		if(_currentWigImage==_wig1){
			_currentWigImage=_wig2;
		}else if(_currentWigImage==_wig2){
			_currentWigImage=_wig3;
		}else{
			_currentWigImage=_wig1;
		}
		addChild(_currentWigImage);
	}
	private function onTimerComplete(e:Event):void{
		removeChild(_currentWigImage);
		_rest.visible=true;
		_currentWigImage=null;
		_timer.reset();
	}
}
class SmallDog extends Sprite{
	private var _wig1:DisplayObject;
	private var _wig2:DisplayObject;
	private var _rest:DisplayObject;
	private var _currentWigImage:DisplayObject;
	private var _timer:Timer;
	public function SmallDog(){
		_rest=addChild(AssetsManager.getAssetByName("F14_1024x768_sml_dog_rest_x145_y626.png"));
		_wig1=AssetsManager.getAssetByName("F14_1024x768_sml_dog_wig1_x145_y626.png");
		_wig2=AssetsManager.getAssetByName("F14_1024x768_sml_dog_wig2_x145_y626.png");
		_timer=new Timer(1000/12,24);
		_timer.addEventListener(TimerEvent.TIMER,onTimer);
		_timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
	}
	public function wiggle():void{
		_timer.start();
	}
	private function onTimer(e:Event):void{
		_rest.visible=false;
		if(_currentWigImage){
			removeChild(_currentWigImage);
		}
		if(_currentWigImage==_wig1){
			_currentWigImage=_wig2;
		}else{
			_currentWigImage=_wig1;
		}
		addChild(_currentWigImage);
	}
	private function onTimerComplete(e:Event):void{
		removeChild(_currentWigImage);
		_rest.visible=true;
		_currentWigImage=null;
		_timer.reset();
	}
}
class Pig extends Sprite{
	private var _pig1:DisplayObject;
	private var _pig2:DisplayObject;
	public function Pig(){
		_pig1=AssetsManager.getAssetByName("F14_1024x768_pig1_x26_y626.png");
		_pig2=AssetsManager.getAssetByName("F14_1024x768_pig2_x26_y626.png");
		addChild(_pig1);
	}
	
	public function lookAtMe():void{
		removeChild(_pig1);
		addChild(_pig2);
	}
}