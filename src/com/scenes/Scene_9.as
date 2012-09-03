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
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class Scene_9 extends AbstractScreen{
		private var _backGround:Sprite;
		private var _lights:DisplayObject;
		private var _licensePlate:TextField;
	
		private var _lightsClickSignal:NativeSignal;
		private var _plateClickSignal:NativeSignal;
		
		private var _soundPlayer:SoundPlayer;
		private var _lightSoundPlayer:SoundPlayer;
		private var _flicker:DisplayObject;
		private var _text2:DisplayObject;
		private var _touchHere:TouchHere=new TouchHere();
		
		private var _dog:BigDog;
		private var _smallDog:SmallDog;
		private var _pig:Pig;
		
		
		public function Scene_9()
		{
			narationPlayer=new NarationPlayer("narration/scene 9 b.mp3");
		}
		
		override public function start():void{
			if(!inited){
				_backGround = new Sprite();
				_backGround.addChild(AssetsManager.getAssetByName("F9_1024x768_background.jpg"));
				addChild(_backGround);
				_backGround.x = -512;
				_lights = AssetsManager.getAssetByName("F9_1024x768_buslights_x-428_y264.png");
				_backGround.addChild(_lights);
				_lights.x = 512-428;
				_lights.y = 264;
				_licensePlate = new TextField();
				var fmt:TextFormat = new TextFormat("Tahoma",22,null,true);
				_licensePlate.setTextFormat(fmt);
				_licensePlate.defaultTextFormat = fmt;
				_licensePlate.embedFonts = true;
				var spr:Sprite = new Sprite();
				spr.addChild(_licensePlate);
				addChild(spr);
				spr.x = 619;
				spr.y = 341;
				spr.rotation = 30;
				_licensePlate.maxChars = 9;
				_licensePlate.autoSize = TextFieldAutoSize.LEFT;
				_licensePlate.text="here"
				_backGround.addChild(_touchHere);
				_touchHere.x=540-_backGround.x;;
				_touchHere.y=320;
				initAnimals();
				activateClickSignal("F9_1024x768_hotspot_light1_x532_y315.png",512+532,315,onLightsClicked,_backGround);
				activateClickSignal("F9_1024x768_hotspot_light2_x835_y297.png",512+835,297,onLightsClicked,_backGround);
				activateClickSignal("F9_1024x768_hotspot_plates_x612_y311.png",512+612,311,onPlateClicked,_backGround);
				_flicker=AssetsManager.getAssetByName("F9_1024x768_buslights_flicker_x543_y308.png");
				_backGround.addChild(_flicker);
				_flicker.alpha=0;
				_flicker.x=512+543;
				_flicker.y=308;
				flicker();
				_soundPlayer = new SoundPlayer("BUS ARRIVES-FOR SCENE 9.mp3");
				_lightSoundPlayer = new SoundPlayer("lights.mp3");
				this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				this.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				this.addEventListener(MouseEvent.MOUSE_OUT,onMouseUp);
				_text2=addText(AssetsManager.getAssetByName("Text2_F9_1024x768_x568_y447.png"),62,447);
				_text2.x+=-_backGround.x;
				_backGround.addChild(_text2);
				TextAndNarration.registerText(_text2);
				
				inited=true;
			}
			if(_soundPlayer.isLoaded){
				onSoundLoaded();
			}else{
				_soundPlayer.ready.add(onSoundLoaded);
			}
			_lights.visible = Session.getInstance().busLightsOn;
			_text2.alpha=0;
			_backGround.x = Session.getInstance().busXPoint;
			var tween:GTween = new GTween(_backGround,1.5,{x:-512},{ease:Sine.easeOut});
			var text2Tween:GTween=new GTween(_text2,0.3,{alpha:1});
			text2Tween.delay=1;
			_touchHere.activate();
			narationPlayer.play(2);
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
			_pig=new Pig();
			_pig.x=383;
			_pig.y=139;
			_backGround.addChild(_pig);
			
		}
		
		
		
		private function flicker():void{
			
			var flickTween:GTween=new GTween(_flicker,0.5,{alpha:1});
			var unFlickTween:GTween=new GTween(_flicker,0.5,{alpha:0});
			var delayTween:GTween=new GTween(_flicker,3);
			flickTween.nextTween=unFlickTween;
			unFlickTween.nextTween=delayTween;
			delayTween.nextTween=flickTween;
		}
		
		private function onSoundLoaded():void{
			//var tween:GTween = new GTween(_backGround,1.5,{x:0},{ease:Sine.easeOut});
			_soundPlayer.play();
		}
		
		override public function stop():void{
			Session.getInstance().busXPoint = _backGround.x;
			_soundPlayer.stop();
			narationPlayer.stop();
			_touchHere.deActivate();
			
		}
		private function onPlateClicked(e:MouseEvent):void{
							
		}
		
		private function onLightsClicked(e:Event):void{
			_lights.visible = !_lights.visible;
			Session.getInstance().busLightsOn = _lights.visible;
			_lightSoundPlayer.play();
			_flicker.visible=false;
			_touchHere.deActivate();
		}
		
		private function onMouseDown(e:MouseEvent):void{
			var ypos:Number = e.currentTarget.y;
			var xpos:Number = e.currentTarget.x;
			
			_backGround.startDrag(false,new Rectangle(-512,0,stage.stageWidth-512,0));
		}
		
		private function onMouseUp(e:MouseEvent):void{
			_backGround.stopDrag();
			
		}
	}
}