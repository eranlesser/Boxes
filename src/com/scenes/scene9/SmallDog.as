package com.scenes.scene9
{
	import com.scenes.components.AnimatedSprite;
	import com.utils.AssetsManager;
	import com.utils.SoundPlayer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class SmallDog extends Sprite
	{
			private var _dogSpot:Sprite;
			private var _aniDog:AnimatedSprite;
			public var click:Signal=new Signal();
			private var _sound:SoundPlayer = new SoundPlayer("middle dog.mp3");
			public function SmallDog()
			{
				var keyFrames:Vector.<DisplayObject> = new Vector.<DisplayObject>();
				keyFrames.push(AssetsManager.getAssetByName("F9_1024x768_smldog1_x468_y144.png"))
				keyFrames.push(AssetsManager.getAssetByName("F9_1024x768_smldog2_x468_y144.png"))
				keyFrames.push(AssetsManager.getAssetByName("F9_1024x768_smldog3_xx468_y144.png"))
				_aniDog=new AnimatedSprite(keyFrames);
				addChild(_aniDog);
				_aniDog.show();
				
				_dogSpot=new Sprite();
				_dogSpot.addChild(AssetsManager.getAssetByName("F9_1024x768_smldog_hotspot_x477_y158.png"));
				_dogSpot.addEventListener(MouseEvent.CLICK,onClick);
				addChild(_dogSpot);
				_dogSpot.x=9;
				_dogSpot.y=14;
			}
			
			private function onClick(e:MouseEvent):void{
				_aniDog.playFrames([1,2],90,23);
				click.dispatch();
				_sound.play();
			}
	}
}