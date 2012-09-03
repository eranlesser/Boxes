package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;

	public class Scene_4 extends AbstractScreen
	{
		private var _frontBuilding:DisplayObject;
		private var _movingSky:Sprite;
		private var _acce:Accelerometer;
		private var _currendDelta:Number=0;
		
		private var _movingSkyTween:GTween;
		private var _buildingTween:GTween;
		
		public function Scene_4(){
			narationer=new NarationPlayer("narration/scene 4.mp3");
		}
		
		override public function start():void{
			if(!inited){
				_movingSky = new Sprite();
				_movingSky.addChild(AssetsManager.getAssetByName("F4_1024x768_sky_x0_y-386.png"));
			var moon:DisplayObject = AssetsManager.getAssetByName("F4_1024x768_moon_x70_y-316.png");
			var sun:DisplayObject = AssetsManager.getAssetByName("F4_1024x768_sun_x70_y644.png");
			sun.x=70;
			sun.y=644+386;
			moon.x=70;
			moon.y=-316+386;
			_movingSky.addChild(sun);
			_movingSky.addChild(moon);
			addChild(_movingSky);
			_movingSky.y=-475;
			var backBuilding:DisplayObject=(AssetsManager.getAssetByName("F4_1024x768_buildings_back_x0_y117.png"));
			_frontBuilding=(AssetsManager.getAssetByName("F4_1024x768_buildings_front_x0_y0.png"));
			addChild(backBuilding);
			addChild(_frontBuilding);
			inited=true;
			_acce = new Accelerometer();
			TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F4_1024x768_x666_y240.png"),666,240));
			}
			narationer.play(1);
			_acce.addEventListener(AccelerometerEvent.UPDATE,onAccelerometer);
		}
		
		
		
		private function resetTweens():void{
			if(!_movingSkyTween){
				return;
			}
			_movingSkyTween.resetValues();
			_buildingTween.resetValues();
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
			
			if(Math.abs(_currendDelta-delta)<0.05){
				return;
			}
			if(delta>1){
				delta=1;
			}
			_currendDelta=delta;
			resetTweens();
			_movingSkyTween = new GTween(_movingSky,2,{y:-950*delta});
			_buildingTween = new GTween(_frontBuilding,2,{alpha:1-1*delta})
		}
		
		
		override public function stop():void{
			_acce.removeEventListener(AccelerometerEvent.UPDATE,onAccelerometer);
			narationer.stop();
		}
		
		
		
	}
}