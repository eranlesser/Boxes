package com.scenes
{
	import com.global.TextAndNarration;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class Scene_13 extends AbstractScreen
	{
		private var _manStand:Sprite = new Sprite();
		private var _manWalk:Sprite = new Sprite();
		private var _manClicked:NativeSignal;
		private var _soundPlayer:SoundPlayer;
		private var _thereMustBe:SoundPlayer;
		private var _touchHere:TouchHere;
		private var _narationPlayed:Boolean;
		private var _textBox:DisplayObject;
		public function Scene_13(){
			_thereMustBe=new SoundPlayer("narration/scene 13 b.mp3");
			narationer=new NarationPlayer("narration/scene 13 a.mp3","narration/scene 13 c.mp3");
		}
		
		override public function start():void{
			if(!inited){
				bg = AssetsManager.getAssetByName("F13_1024x768_background.jpg");
				_manStand.addChild(AssetsManager.getAssetByName("F13_1024x768_manstand_x217_y317.png"));
				 _manWalk.addChild(AssetsManager.getAssetByName("F13_1024x768_manwalk_x316_y428.png"));
				addChild(_manWalk);
				addChild(_manStand);
				_manWalk.x = 316;
				_manWalk.y = 428;
				_manStand.x = 217;
				_manStand.y = 317;
				_manClicked = new NativeSignal(_manWalk,MouseEvent.CLICK);
				_soundPlayer = new SoundPlayer("RESTAURANT-FOR SCENE 13.mp3");
				_touchHere=new TouchHere();
				_touchHere.x=_manWalk.x+_manWalk.width/2-10;
				_touchHere.y=_manWalk.y+_manWalk.height/2;
				addChild(_touchHere);
				_textBox=AssetsManager.getAssetByName("Text_F13_1024x768_x523_y511.png");
				addChild(_textBox);
				_textBox.x=523;
				_textBox.y=511;
				TextAndNarration.registerText(_textBox);
				inited = true;
			}
			_touchHere.activate(8000);
			narationer.soundComplete.add(activate);
			narationer.play();
			_soundPlayer.play(true);
			_manStand.visible = false;
			_manWalk.visible=true;
			_narationPlayed=false;
		}
		
		private function activate():void{
			_manClicked.add(onManClicked);
			narationer.soundComplete.remove(activate);
			_soundPlayer.play(true);
		}
		
		override public function stop():void{
			narationer.soundComplete.remove(activate);
			narationer.stop();
			narationer.reset();
			_soundPlayer.stop();
			_thereMustBe.stop();
			_manClicked.remove(onManClicked);
			_touchHere.deActivate();
		}
		
		private function onManClicked(e:MouseEvent):void{
			_manClicked.remove(onManClicked);
			_soundPlayer.mute(0.8);
			
			_touchHere.deActivate();
			setDelay(800,onSoundMute);
			
		}
		private function onSoundMute(e:Event):void{
			_manStand.visible = true;
			_manWalk.visible = false;
			_thereMustBe.play();
			_thereMustBe.soundComplete.add(onManUnclicked);
			if(!_narationPlayed){
				_thereMustBe.soundComplete.addOnce(playNaration2);
			}else{
				activate();
			}
		}
		
		private function onManUnclicked():void{
			_manStand.visible = false;
			_manWalk.visible = true;
			_soundPlayer.unMute(1);
			
		}
		private function playNaration2():void{
			narationer.play();
			narationer.soundComplete.add(activate);
			_narationPlayed=true;
		}
	}
}