package com.scenes
{
	import com.constants.Dimentions;
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.sensors.Accelerometer;
	import flash.utils.Timer;
	
	public class Scene_14 extends AbstractScreen
	{
		private var _characters:Vector.<DisplayObject>;
		private var _acce:Accelerometer;
		private var _tweens:Vector.<GTween>;
		private var _clickTweens:Vector.<GTween>;
		private var _negativeShakeActive:Boolean=false;
		private var _positiveShakeActive:Boolean=false;
		private var _timer:Timer=new Timer(600,1);
		private var _currendDelta:Number=0;
		private var _wasClicked:Boolean;
		private var _touchHere:TouchHere=new TouchHere();
		
		public function Scene_14(){
			_characters=new Vector.<DisplayObject>();
			_tweens=new Vector.<GTween>();
			_clickTweens=new Vector.<GTween>();
			narationer=new NarationPlayer("narration/scene 14 a.mp3","narration/scene 14 b.mp3");
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F14_1024x768_background.jpg"));
				var txt:DisplayObject=AssetsManager.getAssetByName("Text_F14_1024x768_x290_y301.png");
				TextAndNarration.registerText(addChild(txt));
				txt.x=301;
				txt.y=298;
				_acce = new Accelerometer();
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
				_touchHere.x=Dimentions.WIDTH/2;
				_touchHere.y=Dimentions.HEIGHT/2;
				inited=true;
			}
			this.addEventListener(MouseEvent.CLICK,onClick);
			initCharacters();
			moveCharacters(null);
			narationer.play();
			narationer.soundComplete.add(onNaration1Complete);
			_acce.addEventListener(AccelerometerEvent.UPDATE,onAccelerometer);
			addChild(_touchHere);
			_touchHere.activate();
			_wasClicked=false;
		}
		
		
		
		private function timerComplete(e:TimerEvent):void{
			_negativeShakeActive=false;
			_positiveShakeActive=false;
		}
		
		override public function stop():void{
			this.removeEventListener(MouseEvent.CLICK,onClick);
			narationer.stop()
			narationer.reset();
			_acce.removeEventListener(AccelerometerEvent.UPDATE,onAccelerometer);
			narationer.soundComplete.remove(onNaration1Complete);
			while(_tweens.length>0){
				_tweens.pop().onComplete=null;
			}
			while(_characters.length>0){
				removeCharacter(_characters[0]);
			}
			_touchHere.deActivate();
		}
		
		
		private function moveCharacters(tween:GTween):void{
			while(_tweens.length>0){
				_tweens.pop().onComplete=null;
			}
			for each(var character:DisplayObject in _characters){
				var tween:GTween=new GTween(character,0.5,{x:(character.x-_currendDelta*Dimentions.WIDTH/2*character.width/300)})
				_tweens.push(tween);
				tween.onComplete=moveCharacters;
			}
		}
		
		private function onAccelerometer(e:AccelerometerEvent):void{
			_currendDelta =Math.round(e.accelerationX*100)/100;
		}
		
		private function doShake(e:Event):void{
			while(_tweens.length>0){
				var ptween:GTween=_tweens.pop();
				ptween.resetValues();
				ptween.onComplete=null;
				ptween.end();
			}
			for each(var character:DisplayObject in _characters){
				var tween:GTween=new GTween(character,3,{scaleX:0.01,scaleY:0.01,y:character.height/2},{ease:Sine.easeIn});
				tween.onComplete=onOutOfStage;
				_clickTweens.push(tween);
			}
			_touchHere.deActivate();
		}
		
		private function onOutOfStage(t:GTween):void{
			removeCharacter(DisplayObject(t.target));	
		}
		
		private function removeCharacter(character:DisplayObject):void{
			removeChild(DisplayObject(character));
			_characters.splice(_characters.indexOf(character),1);
			for each(var tween:GTween in _clickTweens){
				if(tween.target==character){
					tween.onComplete=null;
					tween.end();
					_clickTweens.splice(_clickTweens.indexOf(tween),1);
				}
			}
		}
		
		
		
		private function onClick(e:MouseEvent):void{
			_acce.removeEventListener(AccelerometerEvent.UPDATE,onAccelerometer);
			doShake(e);
			this.removeEventListener(MouseEvent.CLICK,onClick);
			_wasClicked=true;
		}
		
		private function onNaration1Complete():void{
			narationer.soundComplete.remove(onNaration1Complete);
			narationer.play(1);
		}
		
		private function initCharacters():void{
			_characters.push(addChildAtLocation("F14_1024x768_character11_x663_y-146.png",663,-146));
			_characters.push(addChildAtLocation("F14_1024x768_character10_x4_y-92.png",4,-92));
			addChildAtLocation("F14_1024x768_man_x591_y117.png",591,117);
			_characters.push(addChildAtLocation("F14_1024x768_character7_x64_y93.png",64,93));
			_characters.push(addChildAtLocation("F14_1024x768_character6_x-112_y-152.png",-112,-152));
			_characters.push(addChildAtLocation("F14_1024x768_character5_x709_y-36.png",709,-36));
			_characters.push(addChildAtLocation("F14_1024x768_character4_x142_y-145.png",142,-145));
			_characters.push(addChildAtLocation("F14_1024x768_character2_x238_y-252.png",238,-252));
			_characters.push(addChildAtLocation("F14_1024x768_character1_x670_y39.png",670,39));
			_characters.push(addChildAtLocation("F14_1024x768_character3_x-146_y354.png",-146,354));
		}
	}
}
