package com.scenes.core
{
	import com.container.Book;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class AbstractScreen extends Sprite{
		
		protected var clicked:NativeSignal;
		protected var inited:Boolean = false;
		protected var narationPlayer:NarationPlayer;
		protected var narationer:NarationPlayer;
		private var _textLayer:Sprite;
		private var _graphicsLayer:Sprite;
		private var _bg:DisplayObject;
		private var _indx:TextField;
		private var _delayTimers:Vector.<Timer>;
		
		
		public function AbstractScreen(){
			clicked = new NativeSignal(this,MouseEvent.CLICK);
			//addEventListener(Event.ADDED_TO_STAGE,onAdded);
			//addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			_graphicsLayer=new Sprite();
			super.addChild(_graphicsLayer);
			_textLayer=new Sprite();
			super.addChild(_textLayer);
			_textLayer.mouseChildren=false;
			_textLayer.mouseEnabled=false;
			_delayTimers=new Vector.<Timer>();
		}
		private function onAdded(e:Event):void{
			_indx = new TextField();
			_indx.text = this.toString();
			parent.addChild(_indx);
			_indx.x=40;
			_indx.setTextFormat(new TextFormat("Arial",16));
			_indx.autoSize=TextFieldAutoSize.LEFT;
		}
		
		private function onRemoved(e:Event):void{
			parent.removeChild(_indx);
		}
		public function start():void{
		}
		
		public function stop():void{
		}
		
		override public function addChild(child:DisplayObject):DisplayObject{
			_graphicsLayer.addChild(child);
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject{
			_graphicsLayer.removeChild(child);
			return child;
		}
		
		public function addText(txt:DisplayObject,xx:int,yy:int):DisplayObject{
			_textLayer.addChild(txt);
			txt.x=xx;
			txt.y=yy;
			return txt;
		}
		
		protected function activateClickSignal(assetName:String,xx:int,yy:int,clickFunction:Function,container:DisplayObjectContainer=null):NativeSignal{
			var hotSpot:Sprite=new Sprite();
			hotSpot.addChild(AssetsManager.getAssetByName(assetName));
			hotSpot.x=xx;
			hotSpot.y = yy;
			if(container){
				container.addChild(hotSpot);
			}else{
				addChild(hotSpot);
			}
			var clickSignal:NativeSignal = new NativeSignal(hotSpot,MouseEvent.CLICK);
			clickSignal.add(clickFunction);
			return clickSignal;
		}
		
		
		protected function setDelay(duration:uint,completeFunction:Function):void{
			var timer:Timer = new Timer(duration,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,completeFunction);
			timer.start();
			_delayTimers.push(timer);
		}
		
		protected function stopAllDelayers():void{
			for each(var timer:Timer in _delayTimers){
				if(timer.running){
					timer.stop();
				}
			}
		}
		
		protected function set bg(dobj:DisplayObject):void{
			_bg = dobj;
			super.addChildAt(_bg,0);
		}
		
		protected function addChildAtLocation(assetName:String,xx:int,yy:int):DisplayObject{
			var child:DisplayObject = AssetsManager.getAssetByName(assetName);
			child.x = xx;
			child.y = yy;
			addChild(child);
			return child;
		}
	}
}