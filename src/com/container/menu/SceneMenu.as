package com.container.menu
{
	import com.constants.Dimentions;
	import com.gskinner.motion.GTween;
	import com.utils.AssetsManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import org.osflash.signals.Signal;

	public class SceneMenu extends Sprite{
		
		private var _thumbs:Sprite;
		public var pageRequest:Signal=new Signal();
		public function SceneMenu(bg:Sprite){
			init();
			bg.addEventListener(MouseEvent.CLICK,goUp);
			//addEventListener(MouseEvent.CLICK,onClick);
		}
		
		public function set active(flag:Boolean):void{
			if(flag){
				Multitouch.inputMode = MultitouchInputMode.GESTURE;
				addEventListener(TransformGestureEvent.GESTURE_SWIPE , onSwipe);
			}else{
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			}
		}
		
		private function onClick(e:MouseEvent):void{
			var newX:int;
			newX = _thumbs.x-158*3; 
			if(newX<-(_thumbs.width-Dimentions.WIDTH+21)){
				newX=-(_thumbs.width-Dimentions.WIDTH+21);
			}
			new GTween(_thumbs,0.5,{x:newX});
		}
		
		private function onSwipe (e:TransformGestureEvent):void{
			var newX:int;
			if (e.offsetX == 1) { 
				//User swiped towards right
				newX = _thumbs.x+158*3;
				if(newX>0){
					newX=0;
				}
				
			}
			if (e.offsetX == -1) { 
				//User swiped towards left
				newX = _thumbs.x-158*3; 
				if(newX<-(_thumbs.width-Dimentions.WIDTH+21)){
					newX=-(_thumbs.width-Dimentions.WIDTH+21);
				}
			} 
			new GTween(_thumbs,0.5,{x:newX});
		}
		
		private function goUp(e:MouseEvent):void{
			active=false;
			new GTween(this,0.5,{y:768})
		}
		
		private function init():void{
			addChild(AssetsManager.getAssetByName("pages_strip_x0_y768.png"));
			_thumbs=new Sprite();
			addChild(_thumbs);
			for(var i:uint=1;i<=26;i++){
				var sceneThumb:SceneThumb=new SceneThumb(i);
				_thumbs.addChild(sceneThumb);
				sceneThumb.x=(i-1)*158+21;
				sceneThumb.y=3;
				sceneThumb.click.add(onThumbClicked);
			}
			var hotSpot:Sprite=new Sprite();
			hotSpot.graphics.beginFill(0xFFFFFF,0);
			hotSpot.graphics.drawRect(0,0,120,40);
			hotSpot.graphics.endFill();
			addChild(hotSpot);
			hotSpot.x=(Dimentions.WIDTH-hotSpot.width)/2;
			hotSpot.y=this.height-hotSpot.height;
			hotSpot.addEventListener(MouseEvent.CLICK,goUp);
		}
		
		private function onThumbClicked(indx:uint):void{
			pageRequest.dispatch(indx);
			goUp(null);
		}
		
	}
}
import com.utils.AssetsManager;

import flash.display.Sprite;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

class SceneThumb extends Sprite{
	public var click:Signal=new Signal();
	private var _index:uint;
	public function SceneThumb(indx:uint){
		_index=indx;
		var numberStr:String;
		//if(indx>=10){
			numberStr=indx.toString();
		//}else{
		//	numberStr="0"+indx.toString();
		//}
		addChild(AssetsManager.getAssetByName(numberStr+".jpg"));
		addEventListener(MouseEvent.CLICK,onClick);
	}
	
	private function onClick(e:MouseEvent):void{
		click.dispatch(_index);
	}
	
}