package com.scenes
{
	import com.constants.Dimentions;
	import com.global.Session;
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class Scene_28 extends AbstractScreen{
		private var _clouds:Sprite;
		private var _baloon:DisplayObject;
		private var _tween:GTween;
		private var _bird1:DisplayObject;
		private var _bird2:DisplayObject;
		private var _bird3:DisplayObject;
		private var _birdsLayers:Vector.<Sprite>;
		private var _birdLayer1:Sprite;
		private var _birdLayer2:Sprite;
		private var _birdLayer3:Sprite;
		private var _birdLayer4:Sprite;
		private var _birdLayer5:Sprite;
		private var _birdSound1:SoundPlayer;
		private var _birdSound2:SoundPlayer;
		private var _birdSoundSurpeise:SoundPlayer;
		private var _hitSurprise:Boolean=false;
		private var _baloonTween:GTween;
		private var _touchHere1:TouchHere=new TouchHere();
		private var _touchHere2:TouchHere=new TouchHere();
		private var _touchHere3:TouchHere=new TouchHere();
		public function Scene_28(){
			narationer=new NarationPlayer("narration/scene 28.mp3","narration/scene 29.mp3","narration/scene 30.mp3");
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F27_1024x768_background.jpg"));
				addClouds();
				cloudTween();
				addBaloon();
				addChildAtLocation("F28_1024x768_sea_x0_y606.png",0,606);
				//TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F28_1024x768_x60_y60.png"),60,60));
				inited=true;
				initBirds();
				initSounds();
				_touchHere1.x=Dimentions.WIDTH/2+Dimentions.WIDTH/4;
				_touchHere1.y=Dimentions.HEIGHT/2+Dimentions.HEIGHT/4-100;
				_touchHere2.x=Dimentions.WIDTH/2+Dimentions.WIDTH/4;
				_touchHere2.y=Dimentions.HEIGHT/2-Dimentions.HEIGHT/4;
				_touchHere3.x=Dimentions.WIDTH/2-Dimentions.WIDTH/4;
				_touchHere3.y=Dimentions.HEIGHT/2;
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F29_1024x768_x60_y60.png"),61,60));
				addChild(_touchHere1);
				addChild(_touchHere2);
				addChild(_touchHere3);
			}
			_baloon.x=200;
			_baloon.y=151;
			_baloonTween=new GTween(_baloon,15,{x:1067,y:2});
			_touchHere1.activate();
			_touchHere2.activate();
			_touchHere3.activate();
			narationer.soundComplete.add(playNaration2);
			narationer.play();
			Session.getInstance().stopEndMusic();
		}
		
		private function playNaration2():void{
			narationer.soundComplete.remove(playNaration2);
			narationer.soundComplete.add(playNaration3);
			narationer.play();
		}
		private function playNaration3():void{
			narationer.soundComplete.remove(playNaration3);
			narationer.play();
		}
		
		override public function stop():void{
			_baloonTween.end();
			_touchHere1.deActivate();
			_touchHere2.deActivate();
			_touchHere3.deActivate();
			narationer.reset();
			narationer.stop();
		}
		
		private function addClouds():void{
			_clouds = new Sprite();
			var cloud1:DisplayObject = AssetsManager.getAssetByName("F28_1024x768_clouds_x-356_y141.png");
			var cloud2:DisplayObject = AssetsManager.getAssetByName("F28_1024x768_clouds_x-356_y141.png");
			_clouds.addChild(cloud1);
			_clouds.addChild(cloud2);
			cloud2.x = cloud2.width;
			addChild(_clouds);
			_clouds.x=-356;
			_clouds.y=141;
			//_clouds.cacheAsBitmap = true;
		}
		
		private function addBaloon():void{
			_baloon = AssetsManager.getAssetByName("F28_1024x768_ballon_x200_y151.png");
			
			_baloon.cacheAsBitmap = true;
			addChild(_baloon);
		}
		
		private function cloudTween():void{
			_tween = new GTween(_clouds,12,{x:-_clouds.width/2-356});
			_tween.onComplete = onTweenComplete;
		}
		
		
		private function onTweenComplete(tween:GTween):void{
			_clouds.x=-356;
			cloudTween();
		}
		
		private function initSounds():void{
			_birdSound1 = new SoundPlayer("BIRD 1.mp3");
			_birdSound2 = new SoundPlayer("BIRD 2.mp3");
			_birdSoundSurpeise = new SoundPlayer("BIRD SURPRISE.mp3");
		}
		
		private function initBirds():void{
			_birdsLayers = new Vector.<Sprite>();
			var birdLayer1:Sprite = new Sprite();
			addChild(birdLayer1);
			_birdsLayers.push(birdLayer1);
			var birdLayer2:Sprite = new Sprite();
			addChild(birdLayer2);
			_birdsLayers.push(birdLayer2);
			var birdLayer3:Sprite = new Sprite();
			addChild(birdLayer3);
			_birdsLayers.push(birdLayer3);
			var birdLayer4:Sprite = new Sprite();
			addChild(birdLayer4);
			_birdsLayers.push(birdLayer4);
			var birdLayer5:Sprite = new Sprite();
			addChild(birdLayer5);
			_birdsLayers.push(birdLayer5);
			_birdsLayers = _birdsLayers.reverse();
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			var mouseDown:NativeSignal = new NativeSignal(this,TouchEvent.TOUCH_TAP);
			mouseDown.add(addBird);
		}
		
		private function addBird(e:TouchEvent):void{
			_touchHere1.deActivate();
			_touchHere2.deActivate();
			_touchHere3.deActivate();
			
			if(e.stageY>570||e.stageY<20){
				return;
			}
			var randomBird:uint = 1+Math.round(Math.random())+Math.round(Math.random());// 1,2,3
			var bird:DisplayObject = addChildAtLocation("F29_1024x768_bird"+randomBird+".png",e.stageX,e.stageY);
			var rawRandomSize:Number = Math.random()*4;
			var randomSize:Number = Math.round(Math.random()*4);//0,1,2,3,4,
			_birdsLayers[randomSize].addChild(bird);
			bird.scaleY = rawRandomSize/4+0.25;
			var tween:GTween;
			if(Math.random()>0.5){
				bird.scaleX = rawRandomSize/4+0.25;
				tween = new GTween(bird,5,{x:bird.x-1500});
			}else{//-1
				bird.scaleX =-rawRandomSize/4-0.25;
				tween = new GTween(bird,5,{x:bird.x+1500});
			}
			var surpriseChance:Number=0.6;
			if(_hitSurprise){
				surpriseChance=0.88;
			}
			if(Math.random()>surpriseChance){
				_birdSoundSurpeise.play();
				_hitSurprise=true;
			}
			else if(randomBird==1){
				_birdSound1.play();
			}else if(randomBird==2){
				_birdSound2.play()
			}else{
				if(Math.random()>0.5)
					_birdSound1.play();
				else
					_birdSound2.play();
			}
			e.updateAfterEvent();
		}
	}
}