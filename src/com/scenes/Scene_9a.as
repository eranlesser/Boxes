package com.scenes
{
	import com.global.Session;
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;
	import com.scenes.core.AbstractScreen;
	import com.scenes.scene9.BigDog;
	import com.scenes.scene9.Pig;
	import com.scenes.scene9.SmallDog;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Scene_9a extends AbstractScreen
	{
		private var _backGround:Sprite;
		private var _lights:DisplayObject;
		private var _registeredX:int;
		private var _lightSoundPlayer:SoundPlayer;
		
		private var _dog:BigDog;
		private var _smallDog:SmallDog;
		private var _pig:Pig;
		private var _dogTouchHere:TouchHere = new TouchHere();
		public function Scene_9a()
		{
			narationPlayer=new NarationPlayer("narration/scene 9 a.mp3");
		}
		
		override public function start():void{
			if(!inited){
				_backGround = new Sprite();
				_backGround.addChild(AssetsManager.getAssetByName("F9_1024x768_background.jpg"));
				addChild(_backGround);
				_lights = AssetsManager.getAssetByName("F9_1024x768_buslights_x-428_y264.png");
				_backGround.addChild(_lights);
				_lights.x = 512-428;
				_lights.y = 264;
				_lightSoundPlayer = new SoundPlayer("lights.mp3");
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text1_F9_1024x768_x62_y558.png"),62,558));
				initAnimals();
				inited=true;
			}else{
				_backGround.x = Session.getInstance().busXPoint;
				var tween:GTween = new GTween(_backGround,1.5,{x:0},{ease:Sine.easeOut});
			}
			narationPlayer.play(1);
			_lights.visible = Session.getInstance().busLightsOn;
			_dogTouchHere.activate();
		}
		private function initAnimals():void{
			
			_dog=new BigDog();
			_backGround.addChild(_dog);
			_dog.x=544;
			_dog.y=127;
			_smallDog=new SmallDog();
			_backGround.addChild(_smallDog);
			_smallDog.x=468;
			_smallDog.y=144;
			_smallDog.click.add(removeTouchHere);
			_pig=new Pig();
			_pig.x=383;
			_pig.y=139;
			_backGround.addChild(_pig);
			
			_backGround.addChild(_dogTouchHere)
			_dogTouchHere.x=_smallDog.x+_smallDog.width/2-30;
			_dogTouchHere.y=_smallDog.y+_smallDog.height/2-20;
		}
		
		override public function stop():void{
			Session.getInstance().busXPoint = _backGround.x;
			narationPlayer.stop();
			_dogTouchHere.deActivate();
		}
		
		private function removeTouchHere():void{
			_dogTouchHere.deActivate();
		}
		
		private function onLightsClicked(e:Event):void{
			_lights.visible = !_lights.visible;
			Session.getInstance().busLightsOn = _lights.visible;
			_lightSoundPlayer.play();
		}
	}
}