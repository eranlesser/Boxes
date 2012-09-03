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
	
	public class Scene_16 extends AbstractScreen{
		private var _catDoor:DisplayObject;
		private var _bang:DisplayObject;
		private var _catDrink:DisplayObject;
		private var _bird:DisplayObject;
		private var _door:DisplayObject;
		private var _popUp:Sprite;
		private var _bangSound:SoundPlayer=new SoundPlayer("COMICS 1 ZBENG.mp3");
		private var _duckSound:SoundPlayer=new SoundPlayer("DUCK.mp3");
		private var _catDrinkSound:SoundPlayer=new SoundPlayer("CAT DRINK.mp3");
		private var _miauSound:SoundPlayer=new SoundPlayer("miau.mp3");
		private var _doorSlam:SoundPlayer=new SoundPlayer("DOOR SLAM-FOR SCENE 16.mp3");
		private var _miau:SoundPlayer=new SoundPlayer("miau and pop 2.mp3");
		private var _catDoorTouch:TouchHere=new TouchHere();
		private var _bangTouch:TouchHere=new TouchHere();
		private var _catDrinkTouch:TouchHere=new TouchHere();
		private var _birdTouch:TouchHere=new TouchHere();
		private var _doorTouch:TouchHere=new TouchHere();
		private var _popupIndicator:TouchHere = new TouchHere();
		public function Scene_16(){
			narationer=new NarationPlayer("narration/scene 16.mp3");
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F16_1024x768_background.jpg"));
				_catDoor=addChildAtLocation("F16_1024x768_cat_door_x0_y106.jpg",0,106);
				_bang=addChildAtLocation("F16_1024x768_bang_x313_y166.png",313,166);
				_catDrink=addChildAtLocation("F16_1024x768_cat_drink_x280_y482.jpg",280,482);
				_bird=addChildAtLocation("F16_1024x768_bird_x392_y372.png",392,372);
				_door=addChildAtLocation("F16_1024x768_door_x552_y198.png",552,198);
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F16_1024x768_x36_y341.png"),36,341));
				addHotSpots();
				_popUp=new Sprite();
				_popUp.addChild(AssetsManager.getAssetByName("F16_1024x768_popup_x0_y0.png"));
				_popUp.addChild(_popupIndicator);
				_popupIndicator.x=_popUp.width/2;
				_popupIndicator.y=_popUp.height/2;
				_catDoorTouch.x=22;
				_catDoorTouch.y=120;
				addChild(_catDoorTouch);
				_bangTouch.x=320;
				_bangTouch.y=180;
				addChild(_bangTouch);
				_catDrinkTouch.x=320;
				_catDrinkTouch.y=490;
				addChild(_catDrinkTouch);
				_birdTouch.x=440;
				_birdTouch.y=560;
				addChild(_birdTouch);
				_doorTouch.x=730;
				_doorTouch.y=390;
				addChild(_doorTouch);
				inited=true;
			}
			narationer.play();
			_catDoor.visible=false;
			_bang.visible=false;
			_catDrink.visible=false;
			_bird.visible=false;
			_door.visible=false;
			_catDoorTouch.activate();
			_bangTouch.activate();
			_catDrinkTouch.activate();
			_birdTouch.activate();
			_doorTouch.activate();
		}
		
		override public function stop():void{
			narationer.stop();
			_catDoorTouch.deActivate();
			_bangTouch.deActivate();
			_catDrinkTouch.deActivate();
			_birdTouch.deActivate();
			_doorTouch.deActivate();
			_popupIndicator.deActivate();
			_popUp.visible=false;
		}
		
		private function addHotSpots():void{
			narationer.soundComplete.remove(addHotSpots);
			activateClickSignal("F16_1024x768_cat_door_hotspot_x0_y106.png",0,106,catEnter);
			activateClickSignal("F16_1024x768_bang_hotspot_x126_y0.png",126,0,bang);
			activateClickSignal("F16_1024x768_cat_drink_hotspot_x0_y375.png",0,375,catDrink);
			activateClickSignal("F16_1024x768_bird_hotspot_x392_y372.png",392,372,bird);
			activateClickSignal("F16_1024x768_door_hotspot_x562_y210.png",562,210,door);
		}
		private function catEnter(e:Event):void{
			if(!_catDoor.visible){
				_catDoor.visible=true;
				_miauSound.play();
				_catDoorTouch.deActivate();
			}
		}
		private function bang(e:Event):void{
			if(!_bang.visible){
			_bang.visible=true;
			_bangSound.play();
			_bangSound.soundComplete.add(onBangDone);
			_bangTouch.deActivate();
			}
		}
		
		private function onBangDone():void{
			_bang.visible=false;
			_bangSound.soundComplete.remove(onBangDone);
		}
		
		private function catDrink(e:Event):void{
			if(!_catDrink.visible){
			_catDrink.visible=true;
			_catDrinkSound.play();
			_catDrinkSound.soundComplete.add(onCatDrinkDone);
			_catDrinkTouch.deActivate();
			}
		}
		
		private function onCatDrinkDone():void{
			_catDrink.visible=false;
			_catDrinkSound.soundComplete.remove(onCatDrinkDone);
		}
		
		private function bird(e:Event):void{
			if(!_bird.visible){
			_bird.visible=true;	
			_duckSound.play();
			_duckSound.soundComplete.add(onBirdDone);
			_birdTouch.deActivate();
			}
		}
		
		private function onBirdDone():void{
			_bird.visible=false;
			_duckSound.soundComplete.remove(onBirdDone);
		}
		
		private function door(e:Event):void{
			if(!_door.visible){
				_popUp.visible=true;
				addChildAt(_popUp,2);
				_popUp.addEventListener(MouseEvent.CLICK,onPopClicked);
				_miau.play();
				_doorTouch.deActivate();
				_popupIndicator.activate();
			}
		}
		private function onPopClicked(e:Event):void{
			_popUp.removeEventListener(MouseEvent.CLICK,onPopClicked);
			removeChildAt(2);
			_door.visible=true;
			_doorSlam.play();
			_popupIndicator.deActivate();
			
		}
	}
}