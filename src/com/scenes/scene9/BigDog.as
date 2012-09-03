package com.scenes.scene9
{
	import com.scenes.components.AnimatedSprite;
	import com.utils.AssetsManager;
	import com.utils.SoundPlayer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BigDog extends Sprite{
		
		private var _dogSpot:Sprite;
		private var _aniDog:AnimatedSprite;
		private var _sound:SoundPlayer = new SoundPlayer("right-dog.mp3");
		public function BigDog()
		{
			var keyFrames:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			keyFrames.push(AssetsManager.getAssetByName("F9_1024x768_bigdog1_x544_y127.png"))
			keyFrames.push(AssetsManager.getAssetByName("F9_1024x768_bigdog2_x544_y127.png"))
			keyFrames.push(AssetsManager.getAssetByName("F9_1024x768_bigdog3_x544_y127.png"))
			keyFrames.push(AssetsManager.getAssetByName("F9_1024x768_bigdog4_x544_y127.png"))
			_aniDog=new AnimatedSprite(keyFrames);
			addChild(_aniDog);
			_aniDog.show();
			
			_dogSpot=new Sprite();
			_dogSpot.addChild(AssetsManager.getAssetByName("F9_1024x768_bigdog_hotspot_x585_y142.png"));
			_dogSpot.addEventListener(MouseEvent.CLICK,onClick);
			addChild(_dogSpot);
			_dogSpot.x=41;
			_dogSpot.y=14;
		}
		
		private function onClick(e:MouseEvent):void{
			_aniDog.playFrames([1,2,3],90,23);
			_sound.play();
		}
	}
}