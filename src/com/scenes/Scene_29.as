package com.scenes
{
	import com.constants.Dimentions;
	import com.global.Session;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Scene_29 extends AbstractScreen{
		private var _cloud1:DisplayObject;
		private var _cloud2:DisplayObject;
		
		private var _hat:Sprite;
		private var _baloonPoint:Point;
		private var _hatDragged:Boolean=false;
		private var _baloonTween:GTween;
		private var _baloon:DisplayObject;
		private var _touchHere:TouchHere=new TouchHere();
		private var _flag:Flag;
		public function Scene_29(){
			narationPlayer=new NarationPlayer("narration/scene 31.mp3");
			
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F27_1024x768_background.jpg"));
				addClouds();
				addBaloon();
				_flag=new Flag();
				addChild(_flag);
				_hat=new Sprite();
				_hat.addChild(AssetsManager.getAssetByName("F29_1024x768_hat_x221_y586.png"));
				addChild(_hat);
				
				_hat.addEventListener(MouseEvent.MOUSE_DOWN,onHatDown)
				this.addEventListener(MouseEvent.MOUSE_UP,onHatUp);
				addChild(_touchHere);
				//_hat.startDrag();
				
				inited=true;
			}
			_hat.x=221;
			_hat.y=586;
			_baloon.x=-50;
			_baloon.y=236;
			_baloonPoint=new Point(_baloon.x,_baloon.y);
			_baloonTween= new GTween(_baloon,15,{x:1035,y:-81});
			_baloonTween.onChange=onBaloonMove;
			Session.getInstance().playEndMusic();
			narationPlayer.play();
			_touchHere.activate(3000);
			_flag.play();
		}
		
		private function follow(t:GTween):void{
			_flag.x=_baloon.x-_flag.width-18;
			_flag.y=_baloon.y+_baloon.height/2-_flag.height;
		}
		
		
		
		override public function stop():void{
			_flag.stop();
			narationPlayer.stop();
			_baloonTween.onChange=null;
			_baloonTween.end();
			_hatDragged=false;
			_touchHere.deActivate();
		}
		
		private function onHatDown(e:MouseEvent):void{
			_touchHere.deActivate();
			_hat.startDrag();
			_hatDragged=true;
		}
		
		private function onHatUp(e:MouseEvent):void{
			_hat.stopDrag();
		}
		
		
		
		private function addClouds():void{
			_cloud1 = AssetsManager.getAssetByName("F29_1024x768_cloud1_x-500_y79.png");
			_cloud2 = AssetsManager.getAssetByName("F29_1024x768_cloud2_x-564_y466.png");
			_cloud1.x = -500;
			_cloud1.y = 79;
			_cloud2.x = -564;
			_cloud2.y = 466;
			addChild(_cloud1);
			addChild(_cloud2);
			//_cloud1.cacheAsBitmap = true;
			//_cloud2.cacheAsBitmap = true;
			var cloud1Tween:GTween = new GTween(_cloud1,12,{x:Dimentions.WIDTH});
			cloud1Tween.onComplete = onCloud1Complete;
			var cloud2Tween:GTween = new GTween(_cloud2,15,{x:Dimentions.WIDTH});
			cloud2Tween.onComplete = onCloud2Complete;
		}
		
		private function onCloud1Complete(tween:GTween):void{
			var cloud:DisplayObject = tween.target as DisplayObject;
			cloud.x=-500;
			var cloud1Tween:GTween = new GTween(_cloud1,12,{x:Dimentions.WIDTH});
			cloud1Tween.onComplete = onCloud1Complete; 
		}
		private function onCloud2Complete(tween:GTween):void{
			var cloud:DisplayObject = tween.target as DisplayObject;
			cloud.x=-564;
			var cloud1Tween:GTween = new GTween(_cloud2,15,{x:Dimentions.WIDTH});
			cloud1Tween.onComplete = onCloud2Complete; 
		}
		
		private function addBaloon():void{
			_baloon = AssetsManager.getAssetByName("F29_1024x768_ballon_x-50_y236.png");
			addChild(_baloon);
		}
		private function onBaloonMove(t:GTween):void{
			follow(t);
			if(_hatDragged){
				return;
			}
			//var baloon:DisplayObject=t.target as DisplayObject;
			_hat.x+=_baloon.x-_baloonPoint.x;
			_hat.y+=_baloon.y-_baloonPoint.y;
			_baloonPoint=new Point(_baloon.x,_baloon.y);
			_touchHere.x=_hat.x+10;
			_touchHere.y=_hat.y+10;
		}
	}
}

import com.scenes.components.AnimatedSprite;
import com.utils.SequanceUtil;

import flash.display.DisplayObject;
import flash.display.Sprite;

class Flag extends Sprite{
	private var _animatedFlag:AnimatedSprite;
	public function Flag(){
		init();
	}
	
	
	private function init():void{
		var imageSequance:Vector.<DisplayObject>=SequanceUtil.createSequanceVector2(9,40,"Bye-bye!-F30_1024x768_000",".png");
		_animatedFlag=new AnimatedSprite(imageSequance);
		addChild(_animatedFlag);
		_animatedFlag.show();
	}
	
	public function play():void{
		_animatedFlag.play(200,true);
	}
	
	public function stop():void{
		_animatedFlag.stop();
	}
	
}