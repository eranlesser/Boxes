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
	
	public class Scene_24 extends AbstractScreen
	{
		private var _baloon:DisplayObject;
		private var _soundPlayer:SoundPlayer;
		private var _tween:GTween;
		public function Scene_24()
		{
		}
		
		override public function start():void{
			if(!inited){
				bg = AssetsManager.getAssetByName("F24_1024x768_background_sky.jpg");
				_baloon = AssetsManager.getAssetByName("F24_1024x768_ballon_x184_y523.png");
				_baloon.x = 184;
				_baloon.y = 523;
				addChild(_baloon);
				var sea:DisplayObject = AssetsManager.getAssetByName("F24_1024x768_sea_x0_y520.png");
				addChild(sea);
				sea.y=520;
				_soundPlayer = new SoundPlayer("RISING BALOON-FOR SCENE 24.mp3");
				TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F24_1024x768_x306_y206.png"),306,206));
				narationer=new NarationPlayer("narration/scene 24.mp3");
				inited=true;
			}
			_baloon.y = 523;
			_soundPlayer.play();
			narationer.play();
			_tween = new GTween(_baloon,10,{y:363},{ease:Sine.easeOut});
		}
		
		override public function stop():void{
			_tween.end();
			_soundPlayer.stop();
			narationer.stop();
		}
	}
}