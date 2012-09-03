package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	
	import flash.display.DisplayObject;
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Scene_26 extends AbstractScreen{
		private var _acce:Accelerometer;
		private var _acceText:TextField;
		
		private var _baloon:DisplayObject;
		private var _beach:DisplayObject;
		private var _man:DisplayObject;
		private var _people:DisplayObject;
		private var _sea:DisplayObject;
		private var _tween:GTween;
		private var _currendDelta:Number=0;
		
		private var _baloonTween:GTween;
		private var _beachTween:GTween;
		private var _manTween:GTween;
		private var _peopleTween:GTween;
		private var _seaTween:GTween;
		private var _soundPlayer:SoundPlayer;
		public function Scene_26(){
		
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F26_1024x768_background.jpg"));
				_baloon = AssetsManager.getAssetByName("F26_1024x768_baloon_x479_y239.png");
				_beach = AssetsManager.getAssetByName("F26_1024x768_beach_x0_y597.png");
				_man = AssetsManager.getAssetByName("F26_1024x768_man_x343_y342.png");
				_people = AssetsManager.getAssetByName("F26_1024x768_people_x0_y281.png");
				_sea = AssetsManager.getAssetByName("F26_1024x768_sea_x0_y399.png");
				addChild(_baloon);
				addChild(_sea);
				addChild(_man);
				addChild(_beach);
				addChild(_people);
				
				
				_acce = new Accelerometer();
				_acce.addEventListener(AccelerometerEvent.UPDATE,onAccelerometer);
				_soundPlayer = new SoundPlayer("WALK IN WATER.mp3");
				_soundPlayer.play();
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F26_1024x768_x58_y60.png"),58,60));
				narationer=new NarationPlayer("narration/scene 26.mp3");
				inited=true;
			}
			narationer.play(2);
			_baloon.x=479;
			_baloon.y=239;
			_beach.y=597;
			_man.x=323;
			_man.y=342;
			_people.y=281;
			_sea.y=399;
		}
		override public function stop():void{
			_soundPlayer.stop();
			narationer.stop();
		}
		
		private function onAccelerometer(e:AccelerometerEvent):void{
			
			var delta:Number =Math.round(e.accelerationZ*100)/100;
			if(delta<0){
				return;
			}
			if(delta<0.7){
				delta = 0.7;
			}
			delta = (delta-0.7)*(10/2);
			
			if(Math.abs(_currendDelta-delta)<0.03){
				return;
			}
			if(delta>1){
				delta=1;
			}
			_currendDelta=delta;
			resetTweens();
			_baloonTween = new GTween(_baloon,0.5,{x:479+(500-479)*delta,y:239+(50-239)*delta});
			_beachTween = new GTween(_beach,0.5,{y:597+(663-597)*delta});
			_manTween = new GTween(_man,0.5,{x:323+(620-323)*delta,y:342-(340-342)*delta,scaleX:1-0.4*delta,scaleY:1-0.4*delta});
			_peopleTween = new GTween(_people,0.5,{y:281+(511-281)*delta})
			_seaTween = new GTween(_sea,0.5,{y:399+(425-399)*delta});
		}
		
		private function resetTweens():void{
			if(!_baloonTween){
				return;
			}
			_baloonTween.resetValues();
			_baloonTween.end();
			_beachTween.resetValues();
			_beachTween.end();
			_manTween.resetValues();
			_manTween.end();
			_peopleTween.resetValues();
			_peopleTween.end();
			_seaTween.resetValues();
			_seaTween.end();
		}
		
	}
}