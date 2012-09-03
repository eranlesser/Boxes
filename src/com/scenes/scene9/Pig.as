package com.scenes.scene9
{
	import com.utils.AssetsManager;
	import com.utils.SoundPlayer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Pig extends Sprite
	{
		private var _state1:DisplayObject;
		private var _state2:DisplayObject;
		private var _hotSpot:Sprite;
		private var _timer:Timer;
		private var _sound:SoundPlayer = new SoundPlayer("left-pig.mp3");
		public function Pig()
		{
			init();
		}
		
		private function init():void{
			_state1=AssetsManager.getAssetByName("F9_1024x768_pig1_x383_y139.png");
			_state2=AssetsManager.getAssetByName("F9_1024x768_pig2_x383_y139.png");
			_hotSpot=new Sprite();
			_hotSpot.addChild(AssetsManager.getAssetByName("F9_1024x768_pig_hotspot_x393_y159.png"));
			addChild(_state1);
			addChild(_state2);
			_hotSpot.x=10;
			_hotSpot.y=20;
			_state2.visible=false;
			addChild(_hotSpot);
			_hotSpot.addEventListener(MouseEvent.CLICK,onClick);
			_timer=new Timer(2000,1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerDone);
		}
		
		private function onClick(e:MouseEvent):void{
			_state2.visible=true;
			_state1.visible=false;
			_timer.start();
			_sound.play();
		}
		
		private function onTimerDone(e:TimerEvent):void{
			_state1.visible=true;
			_state2.visible=false;
		}
	}
}