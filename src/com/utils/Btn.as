package com.utils
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;
	
	public class Btn extends Sprite{
		
		private var _clicked:		Signal;
		private var _isClicked:		Boolean = false;
		private var _icon1:			DisplayObject;
		private var _icon2:			DisplayObject;
		
		public var selected:Signal = new Signal();
		
		public function Btn(icon1:String,icon2:String){
			_clicked = new Signal();
			_icon1 = AssetsManager.getAssetByName(icon1);
			_icon2 = AssetsManager.getAssetByName(icon2);
			addChild(_icon1);
			init();
		}
		public function get clicked():Signal{
			return _clicked;
		}
		
		public function set enabled(able:Boolean):void{
			if(able){
				this.alpha = 1;
				this.mouseEnabled = true;
			}else{
				this.alpha = 0;
				this.mouseEnabled = false;
				
			}
		}
		
		public function set state(state:String):void{
			removeChildAt(0);
			if(state=="on"){
				addChild(_icon1);
				_isClicked=false;
			}else if(state=="off"){
				addChild(_icon2);
				_isClicked=true;
			}
		}
		
		public function get isClicked():Boolean{
			return _isClicked;
		}
		
		public function toggle():void{
			_isClicked = !_isClicked;
			if(_icon2){
				toggleIcons();
			}
		}
		private function init():void{
			var nativeClicked:NativeSignal = new NativeSignal(this,MouseEvent.CLICK);
			nativeClicked.add(onClicked);
		}
		
		private function toggleIcons():void{
			if(removeChildAt(0)==_icon1){
				addChild(_icon2);
			}else{
				addChild(_icon1);
			}
		}
		
		private function onClicked(e:MouseEvent):void{
			//toggle()
			_clicked.dispatch();
			selected.dispatch(this);
		}
		
	}
}