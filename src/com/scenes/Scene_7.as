package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.components.AnimatedSprite;
	import com.scenes.components.Bubbles;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SequanceUtil;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Scene_7 extends AbstractScreen
	{
		private var _water:AnimatedSprite;
		private var _bubbles:Bubbles;
		private var _shower:AnimatedSprite;
		private var _mouth:DisplayObject;
		private var _upperLeftStar:DisplayObject;
		private var _upperRightStar:DisplayObject;
		private var _buttomLeftStar:DisplayObject;
		
		private var _auoPlayer:SoundPlayer;
		private var _closetPlayer:SoundPlayer;
		private var _waterPlayer:SoundPlayer;
		private var _bubblePlayer:SoundPlayer;
		private var _miauPlayer:SoundPlayer;
		
		private var _upperLeftTouchHere:TouchHere;
		private var _upperRightTouchHere:TouchHere;
		private var _buttomLeftTouchHere:TouchHere;
		private var _buttomRightTouchHere:TouchHere;
		private var _miauTouchHere:TouchHere;
		public function Scene_7(){
			narationPlayer=new NarationPlayer("narration/scene 7.mp3");
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F7_1024x768_back_image.jpg"));
				initWater();
				_upperLeftStar = addChildAtLocation("F7_1024x768_bang_tap_x300_y230.png",300,230);
				_upperRightStar = addChildAtLocation("F7_1024x768_bang_drawer_x635_y130.png",635,130);
				_buttomLeftStar = addChildAtLocation("F7_1024x768_bang_shower_x326_y524.png",326,524);
				initBubble();
				initShower();
				addChildAtLocation("F7_1024x768_shower_mask_x58_y369.png",58,369);
				_mouth = addChildAtLocation("F7_1024x768_mouth_x751_y693.png",751,693);
				initMouth();
				initUpperRight();
				_auoPlayer = new SoundPlayer("aou.mp3");
				_closetPlayer=new SoundPlayer("open closet and hit.mp3");
				_waterPlayer=new SoundPlayer("water and hit.mp3");
				_bubblePlayer=new SoundPlayer("shower hit and bubbles.mp3");
				_miauPlayer=new SoundPlayer("miau.mp3");
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text1_F7_1024x768_x35_y29.png"),35,29));
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text2_F7_1024x768_x552_y229.png"),552,229));
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text3_F7_1024x768_x121_y657.png"),121,657));
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text4_F7_1024x768_x602_y387.png"),602,387));
				inited=true;
			}
			narationPlayer.play();
			_mouth.visible = false;
			_upperLeftStar.visible = false;
			_upperRightStar.visible = false;
			_buttomLeftStar.visible = false;
			
			_buttomLeftTouchHere.activate();
			_upperLeftTouchHere.activate();
			_buttomRightTouchHere.activate();
			_upperRightTouchHere.activate();
			_miauTouchHere.activate();
		}
		
		override public function stop():void{
			narationPlayer.stop();
			_waterPlayer.stop();
			_bubblePlayer.stop();
			onWaterSoundComplete();
			onBubbleSoundComplete();
			
			_buttomLeftTouchHere.deActivate();
			_upperLeftTouchHere.deActivate();
			_buttomRightTouchHere.deActivate();
			_upperRightTouchHere.deActivate();
			_miauTouchHere.deActivate();
		}
		
		private function initWater():void{
			_water = new AnimatedSprite(SequanceUtil.createSequanceVector(1,3,"F7_1024x768_water","_x345_y147.png"));
			addChild(_water);
			_water.show();
			_water.alpha = 0;
			_water.x = 345;
			_water.y = 147;
			activateClickSignal("F7_1024x768_hotspot_upper_left_x0_y0.png",0,0,onUpperLeftClick)
			_upperLeftTouchHere=new TouchHere();
			addChild(_upperLeftTouchHere);
			_upperLeftTouchHere.x=345+_water.width/2;
			_upperLeftTouchHere.y=147+_water.height/2;
		}
		
		private function initShower():void{
			_shower = new AnimatedSprite(SequanceUtil.createSequanceVector(1,3,"F7_1024x768_shower","_x347_y453.png"));
			addChild(_shower);
			_shower.show();
			_shower.visible = false;
			_shower.x = 347;
			_shower.y = 453;
			activateClickSignal("F7_1024x768_hotspot_lower_left_x0_y418.png",0,418,onLowerLeftClick);
			_buttomLeftTouchHere=new TouchHere();
			addChild(_buttomLeftTouchHere);
			_buttomLeftTouchHere.x=347;
			_buttomLeftTouchHere.y=453;
		}
		private function initMouth():void{
			activateClickSignal("F7_1024x768_hotspot_lower_right_x516_y418.png",516,418,onLowerRightClick);
			_buttomRightTouchHere=new TouchHere();
			addChild(_buttomRightTouchHere);
			_buttomRightTouchHere.x=516+230;
			_buttomRightTouchHere.y=418+200;
		}
		
		private function initUpperRight():void{
			activateClickSignal("F7_1024x768_hotspot_upper_mid_x507_y0.png",507,0,onUpperRightClick)
			activateClickSignal("F7_1024x768_hotspot_cat_x528_y248.png",528,248,miau);
			_upperRightTouchHere=new TouchHere();
			addChild(_upperRightTouchHere);
			_upperRightTouchHere.x=507+120;
			_upperRightTouchHere.y=150;
			_miauTouchHere=new TouchHere();
			addChild(_miauTouchHere);
			_miauTouchHere.x=528+70;
			_miauTouchHere.y=248+30;
		}
		
		private function miau(e:MouseEvent):void{
			_miauPlayer.play();
			_miauTouchHere.deActivate();
		}
		
		private function onUpperLeftClick(e:Event):void{
			_upperLeftTouchHere.deActivate();
			if(_water.alpha==0){
				//_water.visible = true;
				_water.alpha=1;
				_water.play(100,true);
				_upperLeftStar.visible = true;
				_waterPlayer.play();
				_waterPlayer.soundComplete.add(onWaterSoundComplete);
			}
		}
		
		private function onWaterSoundComplete():void{
			_water.stop();
			_water.alpha = 0;
			//new GTween(_water,0.5,{alpha:0});
			_upperLeftStar.visible = false;
		}
		
		private function onUpperRightClick(e:Event):void{
			_upperRightTouchHere.deActivate();
			if(!_upperRightStar.visible){
				_upperRightStar.visible = true;
				_closetPlayer.play();
			}else{
				_upperRightStar.visible = false;
				_closetPlayer.stop();
			}
		}
		private function onLowerLeftClick(e:Event):void{
			_buttomLeftTouchHere.deActivate();
			if(!_shower.visible){
				_shower.visible = true;
				_shower.alpha=1;
				_shower.play(100,true);
				var showerVanish:GTween=new GTween(_shower,1,{alpha:0});
				showerVanish.delay=2;
				_buttomLeftStar.visible = true;
				_bubbles.start();
				_bubblePlayer.play();
				_bubblePlayer.soundComplete.add(onBubbleSoundComplete);
			}
		}
		private function onBubbleSoundComplete():void{
			_shower.stop();
			_shower.visible = false;
			_buttomLeftStar.visible = false;
			_bubbles.stop();
			_bubblePlayer.stop();
		}
		private function onLowerRightClick(e:Event):void{
			_buttomRightTouchHere.deActivate();
			if(!_mouth.visible){
				_mouth.visible = true;
				_auoPlayer.play();
				_auoPlayer.soundComplete.add(closeMouth);
			}
		}
		
		private function closeMouth():void{
			_mouth.visible = false;
		}
		
		private function initBubble():void{
			_bubbles =  new Bubbles();//SequanceUtil.createSequanceVector(1,3,"F7_1024x768_bubble",".png");
			addChild(_bubbles);
			_bubbles.x=80;
			_bubbles.y=369;
		}
		
	}
}