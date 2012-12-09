package com.scenes
{
	import com.container.Navigator;
	import com.gskinner.motion.GTween;
	import com.scenes.core.AbstractScreen;
	import com.scenes.last.Scene_2;
	import com.utils.AssetsManager;
	import com.utils.TouchHere;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	public class Scene_32 extends AbstractScreen
	{
		private var _train:Sprite;
		private var _timer:Timer;
		private var _scene_2:AbstractScreen;
		private var _navigator:Navigator;
		private var _circle:Shape;
		private var _hotSpot:Sprite;
		private var _touchHere:TouchHere=new TouchHere();
		public function Scene_32(navigator:Navigator)
		{
			_timer=new Timer(12);
			_navigator=navigator;
		}
		
		override public function start():void{
			if(!inited){
				 _train=new Sprite();
				var train1:Bitmap=AssetsManager.getBitmap("F32_1024x768_x-4500_y0.jpg",true);
				var train2:Bitmap=AssetsManager.getBitmap("F32_1024x768_x-4500_y0.jpg",true);
				//train1.cacheAsBitmap=true;
				train1.smoothing=true;
				//train2.cacheAsBitmap=true;
				train2.smoothing=true;
				_train.addChild(train1);
				_train.addChild(train2);
				train2.x=-4500;
				_train.x=-4500;
				addChild(_train);
				_hotSpot = new Sprite();
				_hotSpot.graphics.beginFill(0x333333,0);
				_hotSpot.graphics.drawRect(0,0,120,120);
				_hotSpot.graphics.endFill();
				_hotSpot.x=3680;
				_hotSpot.y=450;
				_train.addChild(_hotSpot);
				_train.addChild(_touchHere);
				_touchHere.x=_hotSpot.x+20;
				_touchHere.y=_hotSpot.y+20;
				_train.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				//var tween:GTween=new GTween(_train,50,{x:500});
				//tween.onComplete=onTweenComplete
				_timer.addEventListener(TimerEvent.TIMER,onTimer);
				_hotSpot.addEventListener(MouseEvent.CLICK,float);
			//	this.addEventListener(TransformGestureEvent.GESTURE_ZOOM,float);
				inited=true;
				
			}
			_touchHere.activate();
			_timer.start();
			
		}
		override public function stop():void{
			_timer.stop();
			_touchHere.deActivate();
		}
		
		private function float(e:Event):void{
			_touchHere.deActivate();
			if(!_scene_2){
				_scene_2=new Scene_2();
				_circle=new Shape();
				//_circle.graphics.beginFill(0xFFFFFF);
				_circle.graphics.beginGradientFill(GradientType.RADIAL,[0xFFFFFF,0xFFFFFF],[1,0.2],[40,180]);
				_circle.graphics.drawCircle(0,0,12);
				addChild(_circle);
				_scene_2.mask=_circle;
				addChild(_scene_2);
				_scene_2.start();
			}else{
				_scene_2.visible=true;
				//addChild(_scene_2);
			}
			
			
			
			_circle.x=_hotSpot.x+_train.x+_hotSpot.width/2;
			_circle.y=_hotSpot.y+_train.y+_hotSpot.height/2;
			
			new GTween(_circle,1.5,{width:3000,height:3000,x:0,y:0})
			var tmr:Timer=new Timer(8000,1);
			tmr.addEventListener(TimerEvent.TIMER_COMPLETE,endFloat);
			tmr.start();
			_navigator.visible=false;
		}
		
		private function endFloat(e:Event):void{
			
			var tween:GTween=new GTween(_circle,1.5,{width:12,height:12,x:_hotSpot.x+_train.x+_hotSpot.width/2,y:_hotSpot.y+_train.y+_hotSpot.height/2})
			tween.onComplete=removeFloat;
		}
		
		private function removeFloat(t:GTween):void{
			//_scene_2.stop();
			//removeChild(_scene_2);
			_scene_2.visible=false;
			_navigator.visible=true;
		}
		
		private function onMouseDown(e:MouseEvent):void{
			_train.startDrag(false,new Rectangle(_train.x-1000,_train.y,_train.width,0));
			_timer.stop();
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		private function onMouseUp(e:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			_train.stopDrag();
			_timer.start();
		}
		
		private function onTimer(e:TimerEvent):void{
			if(!_navigator.visible){
				return;  // when floating
			}
			if(_train.x>=500){
				_train.x=-4000;
			}
			_train.x=_train.x+2;
		}
//		private function onTweenComplete(t:GTween):void{
//			_train.x=-4000;
//			var tween:GTween=new GTween(_train,55,{x:500});
//			tween.onComplete=onTweenComplete
//		}
		
	}
}