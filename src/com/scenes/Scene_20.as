package com.scenes
{
	import com.global.TextAndNarration;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SequanceUtil;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;
	
	public class Scene_20 extends AbstractScreen{
		
		
		private var _timer:Timer;
		private var _climbingMan:ClimbingMan;
		private var _moveUpCounter:uint=0;
		private var _breathSound:SoundPlayer;
		private var _touchHere:TouchHere;
		private var _manTouched:NativeSignal;
		public function Scene_20(){
			narationer=new NarationPlayer("narration/scene 20.mp3");
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F27_1024x768_background.jpg"));
				_breathSound=new SoundPlayer("HEAVY BREATH FOR LOOP-FOR SCENE 20.mp3")
				_climbingMan=new ClimbingMan();
				addChild(_climbingMan);
				_climbingMan.x=538;
				_climbingMan.y=621;
				_touchHere=new TouchHere();
				_touchHere.x=530+_climbingMan.width/2;
				_touchHere.y=621+42;
				addChild(_touchHere);
				_climbingMan.sequanceDone.add(moveManUp);
				_manTouched=activateClickSignal("F20_1024x768_climb_hotspot_x553_y663.png",553,663,onManClicked);
				addChildAtLocation("F20_1024x768_laddar_x496_y-28.png",496,-28);
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F20_1024x768_x56_y357.png"),56,357));
				inited=true;
			}else{
				_manTouched.add(onManClicked);
			}
			_touchHere.activate();
			_moveUpCounter=0;
			narationer.play();
		}
		
		override public function stop():void{
			narationer.stop();
			_breathSound.stop();
			_climbingMan.reset();
			_climbingMan.y=621;
			_touchHere.deActivate();
			_manTouched.remove(onManClicked);
			if(_timer){
				_timer.removeEventListener(TimerEvent.TIMER,onTimer);
				_timer.stop();
			}
		}
		
		private function moveManUp():void{
			_climbingMan.y-=78;
			_moveUpCounter++;
			if(_moveUpCounter>13){
				_timer.stop();
				_breathSound.stop();
			}
		}
		private function onManClicked(e:Event):void{
			_timer = new Timer(1000/8);
			_timer.addEventListener(TimerEvent.TIMER,onTimer);
			_timer.start();
			_breathSound.play(true);
			_touchHere.deActivate();
			_manTouched.remove(onManClicked);
		}
		
		
		private function onTimer(e:Event):void{
			_climbingMan.climb()
		}
	}
}
import com.utils.SequanceUtil;

import flash.display.DisplayObject;
import flash.display.Sprite;

import org.osflash.signals.Signal;

class ClimbingMan extends Sprite{
	private var _climbSequance:Vector.<DisplayObject>;
	private var _climbIndex:uint=0;
	private var _delayer:uint=0;
	public var sequanceDone:Signal=new Signal();
	public function ClimbingMan(){
		_climbSequance = SequanceUtil.createSequanceVector(2,8,"F20_1024x768_climb","_x538_y621.png");
		addChild(_climbSequance[_climbIndex]);
	}
	
	public function reset():void{
		_climbIndex=0;
		_delayer=0;
		removeChildAt(0);
		addChild(_climbSequance[_climbIndex]);
	}
	
	public function climb():void{
		if(_climbIndex==0){
			sequanceDone.dispatch();
		}
		if(_climbIndex==2){
			if(_delayer==2){
				_delayer=0;
			}else{
				_delayer++;
				return;
			}
		}
		removeChildAt(0);
		addChild(_climbSequance[_climbIndex]);
		_climbIndex++;
		if(_climbIndex==_climbSequance.length){
			_climbIndex=0;
		}
	}
	
	
	
}