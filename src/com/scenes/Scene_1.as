package com.scenes
{
	import com.container.Navigator;
	import com.global.Session;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.SpriteSheet;
	import com.utils.TouchHere;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.natives.NativeSignal;

	public class Scene_1 extends AbstractScreen{
		
		private var _bg:DisplayObject;
		private var _front:DisplayObject;
		private var _peep:DisplayObject;
		private var _cat:DisplayObject;
		private var _text:DisplayObject;
		private var _smokeIndex:uint = 0;
		private var _smokeSheet:SpriteSheet;
		private var _catClick:NativeSignal;
		private var _catTouchHere:TouchHere;
		private var _peepTouchHere:TouchHere;
		private var _smoke:Smoke;
		private var _windowOpen:SoundPlayer;
		private var _windowClose:SoundPlayer;
		private var _miauSound:SoundPlayer;
		private var _navigator:Navigator;
		private var _clicked:Boolean=false;
		
		private var _frontTween:GTween;
		private var _textTween:GTween;
		private var _bgTween:GTween;
		
		public function Scene_1(navigator:Navigator){
			narationPlayer=new NarationPlayer("narration/scene 1.mp3");
			Session.getInstance().openScreenSound=new SoundPlayer("boxes open music.mp3");
			_navigator=navigator;
			
		}
		
		override public function start():void{
			if(!inited){
				addBg();
				addSmoke();
				addCat();
				
				addFront();
				_peep = AssetsManager.getAssetByName("F1_BOXES_1024x768_peep_x799_y247.png");
				_peep.x = 799;
				_peep.y = 247;
				_text = AssetsManager.getAssetByName("F1_BOXES_1024x768_subtitle_x191_y679.png");
				_text.x = 191;
				_text.y = 679;
				
				addChild(_peep);
				addChild(_text);
				_peep.visible = false;
				_text.alpha = 0;
				_windowOpen=new SoundPlayer("WINDOW OPEN.mp3");
				_windowClose=new SoundPlayer("WINDOW CLOSE.mp3");
				this.addEventListener(MouseEvent.CLICK,animation1);
				_miauSound=new SoundPlayer("miau.mp3");
				Session.getInstance().openScreenSound.play(true);
				Session.getInstance().openScreenSound.pause();
				_navigator.visible=false;
				_peepTouchHere=new TouchHere();
				_catTouchHere=new TouchHere();
				inited=true;
			}
			Session.getInstance().openScreenSound.unPause();
			
			_smoke.start();
			if(_clicked){
				_navigator.visible=false;
				_front.alpha=1;
				_bg.alpha=1;
				_text.alpha=0;
				this.addEventListener(MouseEvent.CLICK,animation1);
				_clicked=false;
			}
			
		}
		override public function stop():void{
			super.stopAllDelayers();
			_smoke.stop();
			narationPlayer.stop();
			if(_bgTween){
				_bgTween.onComplete=null;
				_bgTween.end();
			}
			if(_frontTween){
				_frontTween.end();
			}
			if(_textTween)
				_textTween.end();
			_cat.x=158;
			_cat.y=443;
			_peep.visible=false;
			Session.getInstance().openScreenSound.pause();
			_peepTouchHere.deActivate();
			_catTouchHere.deActivate();
			_navigator.visible=true;
		}
		private function addSmoke():void{
			_smoke=new Smoke();
			_smoke.x=456;
			_smoke.y=253;
			addChild(_smoke);
			
		}
		
		private function addCat():void{
			_cat=AssetsManager.getAssetByName("F1_BOXES_1024x768_cat_x158_y443.png");
			addChild(_cat);
			_cat.x=158;
			_cat.y=443;
		}
		
		private function addBg():void{
			addChild(AssetsManager.getAssetByName("F1_BOXES_1024x768_bg7.jpg"));
			_bg=addChild(AssetsManager.getAssetByName("F1_BOXES_1024x768_bg1.jpg"));
		}
		private function addFront():void{
			addChild(AssetsManager.getAssetByName("F1_BOXES_1024x768_front7.png"));
			_front=addChild(AssetsManager.getAssetByName("F1_BOXES_1024x768_front1.png"));
		}
		
		private function animation1(e:MouseEvent):void{//front & bg
			_clicked=true;
			_bgTween=new GTween(_bg,3,{alpha:0})
			_frontTween=new GTween(_front,3,{alpha:0})
			_frontTween.onComplete=(animation2);
			narationPlayer.play();
			this.removeEventListener(MouseEvent.CLICK,animation1);
			_navigator.visible=true;
		}
		
		private function animation2(t:GTween):void{//smoke
			activateClickSignal("F1_BOXES_1024x768_hotspot_win_x730_y228.png",730,228,toggleWindow);
			_catClick=activateClickSignal("F1_BOXES_1024x768_hotspot_cat_x98_y125.png",98,125,showCat);
			addChild(_catTouchHere);
			_catTouchHere.x=98+30;
			_catTouchHere.y=125+330;
			_catTouchHere.activate();
			addChild(_peepTouchHere);
			_peepTouchHere.x=730+100;
			_peepTouchHere.y=228+50;
			_peepTouchHere.activate();
			_textTween = new GTween(_text,1,{alpha:1},{delay:1.5});
		}
		
		private function showCat(e:MouseEvent):void{
			var tween:GTween=new GTween(_cat,0.25,{x:79,y:460});
			tween.onComplete=onCatOut;
			_catClick.remove(showCat);
			_miauSound.play();
			_catTouchHere.deActivate();
		}
		
		private function onCatOut(t:GTween):void{
			setDelay(2000,hideCat);
		}
		private function hideCat(e:Event):void{
			var tween:GTween=new GTween(_cat,0.25,{x:158,y:443});
			tween.onComplete=onCatHidden;
		}
		private function onCatHidden(t:GTween):void{
			_catClick.add(showCat);
		}
		
		private function toggleWindow(e:MouseEvent):void{
			_peepTouchHere.deActivate();
			_peep.visible = !_peep.visible;
			if(_peep.visible){
				_windowOpen.play();
			}else{
				_windowClose.play();
			}
		}
		
	}
}
import com.gskinner.motion.GTween;
import com.utils.AssetsManager;
import com.utils.SoundPlayer;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

class Smoke extends Sprite{
	private var _particle:DisplayObject;
	private var _timer:Timer;
	
	
	public function Smoke(){
		_timer=new Timer(1000/30);
		_timer.addEventListener(TimerEvent.TIMER,shoot);
	}
	
	public function start():void{
		
		_timer.start();
		
	}
	
	public function stop():void{
		_timer.stop();
	}
	
	private function shoot(e:Event):void{
		var particle:Bitmap = AssetsManager.getBitmap("F1_BOXES_1024x768_smoke_particle.png",true);
		particle.cacheAsBitmap=true;
		addChild(particle);
		particle.scaleX=0.2;
		particle.scaleY=0.2;
		particle.rotation=45-90*Math.random()
		var tween:GTween=new GTween(particle,1,{y:-350,x:(40-Math.random()*80),scaleX:1,scaleY:1});
		tween.onComplete=shootDone;
	}
	private function shootDone(t:GTween):void{
		removeChild(DisplayObject(t.target));
	}
}
