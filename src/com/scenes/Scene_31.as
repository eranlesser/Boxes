package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	
	import flash.display.DisplayObject;
	
	public class Scene_31 extends AbstractScreen
	{
		
		private var _baloon:DisplayObject;
		private var _city:DisplayObject;
		private var _tween:GTween;
		private var _flag:Flag;
		public function Scene_31(){
			narationer=new NarationPlayer("narration/scene 31.mp3");
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F31_1024x768_background.jpg"));
				_baloon = AssetsManager.getAssetByName("F31_1024x768_ballon_x251_y299.png");
				_city=AssetsManager.getAssetByName("F31_1024x768_city_x0_y464.png");
				_city.y=464;
				addChild(_city);
				addChild(_baloon);
				_flag=new Flag();
				addChild(_flag);
				//TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F31_1024x772_x0_y56.png"),800,56));
				inited=true;
			}
			narationer.play();
			_baloon.x=251;
			_baloon.y=299;
			animateBaloon();
			_flag.play();
		}
		private function follow(t:GTween):void{
			_flag.x=_baloon.x-_flag.width-10;
			_flag.y=_baloon.y+_baloon.height/2-_flag.height/2;
		}
		
		override public function stop():void{
			narationer.stop();
			_tween.onChange=null;
			_tween.end();
			_flag.stop();
		}
		
		private function animateBaloon():void{
			_tween = new GTween(_baloon,18,{x:1303,y:42,scaleX:0.5,scaleY:0.5});
			_tween.onChange=follow;
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