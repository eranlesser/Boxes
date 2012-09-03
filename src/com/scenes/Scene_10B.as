package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Bounce;
	import com.gskinner.motion.easing.Cubic;
	import com.scenes.components.TextBox;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class Scene_10B extends AbstractScreen
	{
		private var _bg:Sprite;
		private var _bus:Sprite;
		private var _jumping:Boolean = false;
		private var _busSpeed:uint=10;
		private var _jumpValue:uint =3;
		private var _jumpFrequancey:uint = 80;
		private var _soundPlayer:SoundPlayer;
		private var _bgTween:GTween;
		private var _thereMustBeSound:NarationPlayer;
		private var _narationPlayer:NarationPlayer;
		private var _bag:DisplayObject;
		private var _textBox1:TextBox;
		private var _breakSound:SoundPlayer;
		private var _bagFallSound:SoundPlayer;
		private var _pressHere:TouchHere=new TouchHere();
		public function Scene_10B(){
			_narationPlayer=new NarationPlayer("narration/scene 10 d.mp3");
			_thereMustBeSound=new NarationPlayer("narration/scene 10 b.mp3");
			_thereMustBeSound.soundComplete.add(playNaration);
			_breakSound=new SoundPlayer("BUS BREAK AND STOP-FOR SCENE 10.mp3");
			_bagFallSound=new SoundPlayer("BUS BREAK AND STOP-FOR SCENE 10.mp3");
		}
		
		override public function start():void{
			if(!inited){
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				setUpBg();
				_bus=new Sprite();
				_bus.addChild(AssetsManager.getAssetByName("F10_1024x768_inside_bus_x-30_y-37.png"));
				_bag=AssetsManager.getAssetByName("F10_1024x768_bag_x739_y27.png");
				
				
				_bus.x=-30;
				_bus.y = -37;
				addChild(_bus);
				_bus.addChild(_bag);
				_bus.addChild(_pressHere)
				_bg.x=-_bg.width/2;
				_soundPlayer = new SoundPlayer("BUS DRIVE AND RADIO-FOR SCENE 10.mp3");
				resume();
				
				_textBox1=new TextBox("Text_box_F10_1024x768_x85_y463.png","Text2_F10_1024x768_x128_y507.png",128-85,507-463);
				addChild(_textBox1);
				_textBox1.x=85;
				_textBox1.y=462;
				TextAndNarration.registerText(_textBox1);
				inited = true;
				
			}
			
			_bag.x=739+30;
			_bag.y=27+37;
			_pressHere.x=_bag.x+_bag.width/2;
			_pressHere.y=_bag.y+_bag.height/2;
			_pressHere.activate();
			_bag.rotation=0;
			if(_bgTween){
				_bgTween.paused = false;
				_soundPlayer.unMute(2);
			}
			_thereMustBeSound.play();
			clicked.add(slowDown);
			_soundPlayer.play(true);
			
		}
		
		private function playNaration():void{
			_narationPlayer.play();
		}
		
		override public function stop():void{
			_soundPlayer.stop();
			_narationPlayer.stop();
			_thereMustBeSound.stop();
			if(narationPlayer){
				narationPlayer.stop();
			}
			clicked.remove(slowDown);
			_pressHere.deActivate();
		}
		
		private function setUpBg():void{
			_bg = new Sprite();
			var bg1:DisplayObject = AssetsManager.getAssetByName("F10_1024x768_bus_bg_x0_y40.jpg");
			var bg2:DisplayObject = AssetsManager.getAssetByName("F10_1024x768_bus_bg_x0_y40.jpg");
			_bg.addChild(bg1);
			_bg.addChild(bg2);
			bg2.x = bg2.width;
			addChild(_bg);
			_bg.y = 40;
			_bg.cacheAsBitmap = true;
		}
//___________________________________________________BgTween
		private function bgTween():void{
			_bg.x=-_bg.width/2;
			_bgTween = new GTween(_bg,15,{x:0});
			_bgTween.onComplete = onTweenComplete;
			_bgTween.onChange = randomizeJumps;
		}
		private function onTweenComplete(tween:GTween):void{
			bgTween();
		}
//___________________________________________________#BgTween

//___________________________________________________Jumps
		
		private function randomizeJumps(tween:GTween):void{
			
			if(Math.random()>_jumpFrequancey/100&&!_jumping){
				var yValue:Number = Math.random()*_jumpValue;
				_jumping = true;
				var jumpTween:GTween = new GTween(_bus,0.3,{y:-yValue-37},{ease:Bounce.easeOut})
				jumpTween.onComplete = onJumpComplete;
			}
		}
		private function onJumpComplete(tween:GTween):void{
			var jumpDown:GTween = new GTween(_bus,0.3,{y:-37},{ease:Bounce.easeOut});
			jumpDown.onComplete = onJumpDownComplete;
		}
		private function onJumpDownComplete(tween:GTween):void{
			_jumping = false;
		}
//___________________________________________________#Jumps
		
//___________________________________________________Click
		
		private function slowDown(e:Event):void{
			_bgTween.paused = true;
			clicked.remove(slowDown);
			var tween:GTween = new GTween(_bg,1,{x:_bg.x+100},{ease:Cubic.easeOut});
			//tween.onComplete=dropBag;
			dropBag();
			_soundPlayer.mute(1);
			_breakSound.play();
			_pressHere.deActivate();
		}
		
		private function dropBag():void{
			var tween:GTween=new GTween(_bag,0.6,{x:711});
			tween.onComplete=dropBag2;
		}
		
		private function dropBag2(t:GTween):void{
			var tween:GTween=new GTween(_bag,0.8,{x:1084,y:135,rotation:23});
		}
		
		private function resume():void{
			var position:Number = (_bg.x/(-_bg.width/2))*15;
			_bgTween = new GTween(_bg,position, {x:0});
			_bgTween.onComplete = onTweenComplete;
			_bgTween.onChange = randomizeJumps;
			
		}
		
	}
}

/*
private function stopBus(tween:GTween):void{
if(_isStopped){
return;
}
//setDelay(1500,accelerate);
//_thereMustBeSound.play();
//_thereMustBeSound.soundComplete.add(accelerate);
//narationPlayer.pause();
if(!_waStopped&&false){
var bagTween:GTween=new GTween(_bag,0.5,{x:-169,y:130,rotation:-23});
_bagFallSound.play();
//_textBox2.visible=true;
_textBox1.visible=false;
_waStopped=true;
_thereMustBeSound.soundComplete.addOnce(continueNaration);

}else{
//_thereMustBeSound.soundComplete.remove(accelerate);
}

}


*/