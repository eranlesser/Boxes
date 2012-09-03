package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Scene_11 extends AbstractScreen{
		
		private var _elevator:Elevator;
		private var _windows:Windows;
		private var _twistTween:GTween;
		
		public function Scene_11(){
			narationer=new NarationPlayer("narration/scene 11.mp3","narration/scene 12.mp3");
		}
		
		override public function start():void{
			if(!inited){
				TextAndNarration.registerText(addChildAtLocation("Text1_F11_1024x768_x511_y146.png",511,146));
				
				_elevator = new Elevator();
				addChild(_elevator);
				
				
				_windows = new Windows();
				addChild(_windows);
				
				inited=true;
			}
			narationer.soundComplete.add(progressNaration);
			narationer.play();
			initElevator();
			initWindows();
			_elevator.initButtonGlow(null);
			_elevator.reachedTheTop.add(twist);
			
		}
		
		override public function stop():void{
			if(_twistTween){
				_twistTween.onComplete=null;
				_twistTween.end();
			}
			_elevator.stop();
			_elevator.reset();
			_windows.reset();
			narationer.stop();
			narationer.reset();
		}
		
		private function progressNaration():void{
			narationer.soundComplete.remove(progressNaration);
			narationer.play();
		}
		
		private function initWindows():void{
			_windows.x=775+206;
			
		}
		private function initElevator():void{
			_elevator.x=106;
			_elevator.y=145;
		}
		
		private function activateWindow(t:GTween):void{
			_windows.activate();
		}
		
		private function twist():void{
			_twistTween=new GTween(_windows,6,{x:-2},{ease:Sine.easeInOut});
			_twistTween.delay=10;
			_twistTween.onComplete=activateWindow;
		}
		
		
		
	}
}
import com.global.TextAndNarration;
import com.gskinner.motion.GTween;
import com.utils.AssetsManager;
import com.utils.SoundPlayer;
import com.utils.TouchHere;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.osflash.signals.Signal;

class Elevator extends Sprite{
	private var _buttonGlow:DisplayObject;
	private var _buttonGlowShow:GTween;
	private var _buttonGlowFade:GTween;
	private var _elevatorButtons:Vector.<DisplayObject>;
	private var _upTimer:Timer;
	private var _elevatorMusic:SoundPlayer;
	private var _elevatorSounds:Vector.<SoundPlayer>;
	private var _elevatorTween:GTween;
	private var _elevetorHotSpot:Sprite;
	public var reachedTheTop:Signal;
	
	private var _buttonSpot:Sprite;
	public function Elevator(){
		init();
	}
	
	private function init():void{
		_elevatorMusic=new SoundPlayer("elevator music rerender.mp3");
		initElevatorSounds();
		reachedTheTop = new Signal();
		addChild(AssetsManager.getAssetByName("F11_1024x768_elevator_x106_y145.jpg"));
		_buttonGlow= addChild(AssetsManager.getAssetByName("F11_1024x768_button_glow_x317_y580.png"));
		_buttonGlow.x=317-106;
		_buttonGlow.y=580-145;
		_buttonSpot = new Sprite();
		_buttonSpot.addChild(AssetsManager.getAssetByName("F11_1024x768_button_hotspot_x300_y563.PNG"));
		addChild(_buttonSpot);
		_buttonSpot.x=300-106;
		_buttonSpot.y=563-145;
		_buttonSpot.graphics.beginFill(0xFFFFFF,0);
		_buttonSpot.graphics.drawCircle(22,22,44);
		_buttonSpot.graphics.endFill();
		_elevetorHotSpot = new Sprite();
		_elevetorHotSpot.addChild(AssetsManager.getAssetByName("F11_1024x768_button_hotspot_x106_y142.PNG"));
		_elevetorHotSpot.addEventListener(MouseEvent.CLICK,onElevatorClick);
		addChild(_elevetorHotSpot);
		_elevetorHotSpot.x=106;
		_elevetorHotSpot.y=142;
		initElevatorButtons();
		
		
	}
	
	
	public function reset():void{
		if(_elevatorTween){
			_elevatorTween.end();
			_upTimer.stop();
			_upTimer.reset();
		}
		
		_elevetorHotSpot.addEventListener(MouseEvent.CLICK,onElevatorClick);
		for each(var btn:DisplayObject in _elevatorButtons){
			btn.visible=false;
		}
	}
	
	
	private function initElevatorButtons():void{
		_elevatorButtons = new Vector.<DisplayObject>();
		addElavatorButton(319,509);
		addElavatorButton(342,508);
		addElavatorButton(363,506);
		addElavatorButton(318,485);
		addElavatorButton(340,485);
		addElavatorButton(362,484);
		addElavatorButton(317,465);
		addElavatorButton(339,463);
		addElavatorButton(361,462);
	}
	
	private function addElavatorButton(xx:int,yy:int):void{
		var btn:DisplayObject = AssetsManager.getAssetByName("F11_1024x768_button_glow_x317_y580.png");
		_elevatorButtons.push(btn);
		btn.x=xx-106;
		btn.y=yy-145;
		addChild(btn);
		btn.visible=false;
	}
	
	private function initElevatorSounds():void{
		_elevatorSounds=new Vector.<SoundPlayer>();
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 1.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 2.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 3.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 4.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 5.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 6.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 7.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 8.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 9.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 10.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 11.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 12.mp3"));
		_elevatorSounds.push(new SoundPlayer("ELV BEEP 13.mp3"));
	}
	
	
	
	private function onElevatorClick(e:MouseEvent):void{
		
		Sprite(e.target).removeEventListener(MouseEvent.CLICK,onElevatorClick);
		_buttonGlowShow.resetValues();
		_buttonGlowFade.resetValues();
		_buttonGlow.visible=false;
		_elevatorTween = new GTween(this,8,{y:-670});
		_elevatorTween.onComplete=onElevatorComplete;
		_upTimer = new Timer(1000,8);
		_upTimer.addEventListener(TimerEvent.TIMER,onUpTimer);
		_upTimer.start();
		_elevatorButtons[0].visible=true;
		//_elevatorMusic.play();
		reachedTheTop.dispatch();
		_elevatorMusic.play();
		
	}
	
	private function onElevatorComplete(t:GTween):void{
		//reachedTheTop.dispatch();
		//_elevatorMusic.stop();
		_elevatorMusic.mute(1)
	}
	
	public function stop():void{
		_elevatorMusic.mute(1);
	}
	
	private function onUpTimer(e:TimerEvent):void{
		
		for each(var btn:DisplayObject in _elevatorButtons){
			btn.visible=false;
		}
		_elevatorButtons[Timer(e.target).currentCount].visible=true;
		_elevatorSounds[Timer(e.target).currentCount].play();
	}
	
	public function initButtonGlow(e:Event):void{
		_buttonGlow.visible=true;
		_buttonGlowFade = new GTween(_buttonGlow,5/25,{alpha:0},{delay:15/25});
		_buttonGlowFade.onComplete = buttonGlow;
		
	}
	
	private function buttonGlow(fadeTween:GTween):void{
		_buttonGlowShow = new GTween(_buttonGlow,5/25,{alpha:1},{delay:30/25});
		fadeTween.nextTween = _buttonGlowShow;
		_buttonGlowShow.nextTween=fadeTween;
	}
}



class Windows extends Sprite{
	
	private var _topLeftWindowOpen:DisplayObject;
	private var _topLeftWindowClosed:DisplayObject;
	private var _topRightWindowOpen:DisplayObject;
	private var _topRightWindowClosed:DisplayObject;
	
	private var _butLeftWindowOpen:DisplayObject;
	private var _butLeftWindowClosed:DisplayObject;
	private var _butRightWindowOpen:DisplayObject;
	private var _butRightWindowClosed:DisplayObject;
	
	private var _topLeftSpot:Sprite;
	private var _topRightSpot:Sprite;
	private var _butLeftSpot:Sprite;
	private var _butRightSpot:Sprite;
	
	private var _topLeftTouchHere:TouchHere;
	private var _topRightTouchHere:TouchHere;
	private var _butLeftTouchHere:TouchHere;
	private var _butRightTouchHere:TouchHere;
	
	private var _leftLight:DisplayObject;
	private var _paperDrop:DisplayObject;
	private var _smoke:DisplayObject;
	
	private var _window1Sound:SoundPlayer;
	private var _window2Sound:SoundPlayer;
	private var _window3Sound:SoundPlayer;
	private var _window4Sound:SoundPlayer;
	private var _mailSound:SoundPlayer;
	
	public function Windows(){
		init();
	}
	
	private function init():void{
		_window1Sound=new SoundPlayer("WINDOW OPEN 1.mp3");
		_window2Sound=new SoundPlayer("WINDOW OPEN 2.mp3");
		_window3Sound=new SoundPlayer("WINDOW OPEN 3.mp3");
		_window4Sound=new SoundPlayer("WINDOW SHADE OPEN.mp3");
		var windowBg:Bitmap=AssetsManager.getBitmap("F11_1024x768_windows_BG_x775_y0.jpg");
		windowBg.cacheAsBitmap=true;
		addChild(windowBg);
		windowBg.775;
		_leftLight=addChildAtLocation("F11_1024x768_light_x952_y76.jpg",952,76);
		_paperDrop=addChildAtLocation("F11_1024x768_paper_drop_x1590_y48.jpg",1590,48);
		_paperDrop.alpha=0;
		_butRightWindowClosed=addChildAtLocation("F11_1024x768_right_lower_win_closed_x1405_y470.PNG",1405,470);
		_butRightWindowOpen=addChildAtLocation("F11_1024x768_right_lower_win_open_x1406_y471.PNG",1406,471);
		_topRightWindowClosed=addChildAtLocation("F11_1024x768_right_upper_win_closed_x1473_y27.PNG",1473,27);
		_topRightWindowOpen=addChildAtLocation("F11_1024x768_right_upper_win_open_x1394_y27.PNG",1394,27);
		_butLeftWindowClosed=addChildAtLocation("F11_1024x768_left_lower_win_closed_x989_y437.PNG",989,437);
		_butLeftWindowOpen=addChildAtLocation("F11_1024x768_left_lower_win_open_x828_y396.PNG",828,396);
		_topLeftWindowClosed=addChildAtLocation("F11_1024x768_left_upper_win_closed_x948_y72.PNG",948,72);
		_topLeftWindowOpen=addChildAtLocation("F11_1024x768_left_upper_win_open_x817_y16.PNG",817,16);
		_butRightWindowOpen.visible=false;
		_butLeftWindowOpen.visible=false;
		_topLeftWindowOpen.visible=false;
		_topRightWindowOpen.visible=false;
		
		_topRightSpot=new Sprite();
		_topRightSpot.addChild(AssetsManager.getAssetByName("F11_1024x768_right_upper_win_hotspot_x1473_y27.PNG"));
		_topRightSpot.x=1473-775;
		_topRightSpot.y=27;
		addChild(_topRightSpot);
		
		_topRightTouchHere=new TouchHere();
		_topRightSpot.addChild(_topRightTouchHere);
		_topRightTouchHere.x=_topRightSpot.width/2;
		_topRightTouchHere.y=_topRightSpot.height/2;
		
		_topLeftSpot=new Sprite();
		_topLeftSpot.addChild(AssetsManager.getAssetByName("F11_1024x768_left_upper_win_hotspot_x948_y72.PNG"));
		_topLeftSpot.x=948-775;
		_topLeftSpot.y=72;
		addChild(_topLeftSpot);
		
		_topLeftTouchHere=new TouchHere();
		_topLeftSpot.addChild(_topLeftTouchHere);
		_topLeftTouchHere.x=_topLeftSpot.width/2;
		_topLeftTouchHere.y=_topLeftSpot.height/2;
		
		_butLeftSpot=new Sprite();
		_butLeftSpot.addChild(AssetsManager.getAssetByName("F11_1024x768_left_lower_win_hotspot_x989_y437.PNG"));
		_butLeftSpot.x=989-775;
		_butLeftSpot.y=437;
		addChild(_butLeftSpot);
		
		_butLeftTouchHere=new TouchHere();
		_butLeftSpot.addChild(_butLeftTouchHere);
		_butLeftTouchHere.x=_butLeftSpot.width/2;
		_butLeftTouchHere.y=_butLeftSpot.height/2;
		
		_butRightSpot=new Sprite();
		_butRightSpot.addChild(AssetsManager.getAssetByName("F11_1024x768_right_lower_win_hotspot_x1405_y470.PNG"));
		_butRightSpot.x=1405-775;
		_butRightSpot.y=470;
		addChild(_butRightSpot);
		
		_butRightTouchHere=new TouchHere();
		_butRightSpot.addChild(_butRightTouchHere);
		_butRightTouchHere.x=_butRightSpot.width/2;
		_butRightTouchHere.y=_butRightSpot.height/2;
		
		
	}
	
	public function activate():void{
		_topRightSpot.addEventListener(MouseEvent.CLICK,onTopRightClick);
		_topLeftSpot.addEventListener(MouseEvent.CLICK,onTopLeftClick);
		_butLeftSpot.addEventListener(MouseEvent.CLICK,onButLeftClick);
		_butRightSpot.addEventListener(MouseEvent.CLICK,onButRightClick);
		
		_topLeftTouchHere.activate();
		_topRightTouchHere.activate();
		_butRightTouchHere.activate();
		_butLeftTouchHere.activate();
	}
	
	
	
	public function reset():void{
		//topleft
		_topLeftWindowClosed.visible=true;
		_topLeftWindowOpen.visible=false;
		_leftLight.alpha=1;
		//topright
		_topRightWindowClosed.visible=true;
		_topRightWindowOpen.visible=false;
		_paperDrop.alpha=0;
		//butleft
		_butLeftWindowClosed.visible=true;
		_butLeftWindowOpen.visible=false;
		//butright
		_butRightWindowClosed.visible=true;
		_butRightWindowOpen.visible=false;
		
		_topRightSpot.removeEventListener(MouseEvent.CLICK,onTopRightClick);
		_topLeftSpot.removeEventListener(MouseEvent.CLICK,onTopLeftClick);
		_butLeftSpot.removeEventListener(MouseEvent.CLICK,onButLeftClick);
		_butRightSpot.removeEventListener(MouseEvent.CLICK,onButRightClick);
		
		_topLeftTouchHere.deActivate();
		_topRightTouchHere.deActivate();
		_butRightTouchHere.deActivate();
		_butLeftTouchHere.deActivate();
		
		if(_mailSound){
			_mailSound.stop();
		}
		
	}
	
	private function onTopLeftClick(e:MouseEvent):void{
		_topLeftTouchHere.deActivate();
		if(_topLeftWindowClosed.visible){
			_topLeftWindowClosed.visible=false;
			_topLeftWindowOpen.visible=true;
			_window1Sound.play();
			_topLeftTouchHere.activate();
		}else{
			if(_leftLight.alpha==1){
				new GTween(_leftLight,0.5,{alpha:0});
			}else if(_leftLight.alpha==0){
				new GTween(_leftLight,0.5,{alpha:1});
			}//else is tweening
			var soundPlayer:SoundPlayer=new SoundPlayer("INSIDE WINDOW LIGHT SWITCH.mp3");
			soundPlayer.play();
		}
		
	}
	
	private function onTopRightClick(e:MouseEvent):void{
		_topRightTouchHere.deActivate();
		if(_topRightWindowClosed.visible){
			_topRightWindowClosed.visible=false;
			_topRightWindowOpen.visible=true;
			_window2Sound.play();
			_topRightTouchHere.activate();
		}else{
			_paperDrop.alpha=1;
			var soundPlayer:SoundPlayer=new SoundPlayer("INSIDE WINDOW PAPER.mp3");
			soundPlayer.play();
			soundPlayer.soundComplete.add(paperSoundComplete);
		}
		
	}
	private function paperSoundComplete():void{
		_paperDrop.alpha=0;
	}
	private function onButLeftClick(e:MouseEvent):void{
		_butLeftTouchHere.deActivate();
		if(_butLeftWindowClosed.visible){
			_butLeftWindowClosed.visible=false;
			_butLeftWindowOpen.visible=true;
			_window3Sound.play();
			_butLeftTouchHere.activate();
		}else{
			_butLeftSpot.removeEventListener(MouseEvent.CLICK,onButLeftClick);
			_mailSound=new SoundPlayer("INSIDE WINDOW MAIL.mp3");
			_mailSound.play();
		}
		
	}
	
	private function onButRightClick(e:MouseEvent):void{
		_butRightTouchHere.deActivate();
		if(_butRightWindowClosed.visible){
			_butRightWindowClosed.visible=false;
			_butRightWindowOpen.visible=true;
			_window4Sound.play();
		}else{
			_smoke =AssetsManager.getAssetByName("F11_1024x768_smoke_particle.png")
			_smoke.x=759;
			_smoke.y=557;
		}
		
	}
	
	private function addChildAtLocation(assetName:String,xx:uint,yy:uint):DisplayObject{
		var child:DisplayObject = AssetsManager.getAssetByName(assetName);
		child.x = xx-775;
		child.y = yy;
		addChild(child);
		return child;
	}
	
	
}