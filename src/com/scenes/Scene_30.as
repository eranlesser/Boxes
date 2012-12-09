package com.scenes
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	
	import flash.display.DisplayObject;
	
	public class Scene_30 extends AbstractScreen{
		
		private var _baloon:DisplayObject;
		private var _tween:GTween;
		
		public function Scene_30(){
			//narationer=new NarationPlayer("narration/scene 30.mp3");
		}
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F30_1024x768_background.jpg"));
				_baloon = AssetsManager.getAssetByName("F30_1024x768_ballon_x-43_y207.png");
				addChild(_baloon);
				//_baloon.cacheAsBitmap = true;
				//TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F30_1024x768_x61_y60.png"),61,60));
				
				inited=true;
			}
			_baloon.x=-43;
			_baloon.y=207;
			_baloon.scaleX=1;
			_baloon.scaleY=1;
			
			_tween=new GTween(_baloon,6,{x:1053,y:42,scaleX:0.8,scaleY:0.8});
			
			//narationer.play();
		}
		
		override public function stop():void{
			//narationer.stop();
			_tween.end();
		}
	}
}
