package com.container
{
	import com.constants.Dimentions;
	import com.utils.AssetsManager;
	import com.utils.Btn;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class Navigator extends Sprite
	{
		public var clicked:Signal;
		public var menuClicked:Signal=new Signal();
		private var _colorLeftBtn:Btn;
		private var _whiteLeftBtn:Btn;
		private var _colorRightBtn:Btn;
		private var _whiteRightBtn:Btn;
		private var _whiteSettingsBut:Btn;
		private var _colorSettingsBut:Btn;
		private var _leftBtnHolder:Sprite;
		private var _rightBtnHolder:Sprite;
		private var _whiteScreensVector:Vector.<uint>;
		private var _itemsCount:uint;
		public function Navigator()
		{
			init();
		}
		
		public function set itemsCount(val:uint):void{
			_itemsCount=val;
		}
		
		private function init():void{
			clicked = new Signal();
			_whiteScreensVector=new <uint>[1,2,4,7,15,16,19,20,22,23,24,25,26,27];
			_whiteLeftBtn = new Btn("arrow_left_whiteBG_x5_y696.png","arrow_left_whiteBG_x5_y696.png");
			_whiteRightBtn = new Btn("arrow_right_whiteBG_x952_y696.png","arrow_right_whiteBG_x952_y696.png");
			_colorLeftBtn = new Btn("arrow_left_colorBG_x5_y696.png","arrow_left_colorBG_x5_y696.png");
			_colorRightBtn = new Btn("arrow_right_colorBG_x952_y696.png","arrow_right_colorBG_x952_y696.png");
			_whiteSettingsBut=new Btn("settings_whiteBG_x460_y730.png","settings_whiteBG_x460_y730.png");
			_colorSettingsBut=new Btn("settings_colorBG_x460_y730.png","settings_colorBG_x460_y730.png");
			
			//this.graphics.beginFill(0x999999,0.4);
			//this.graphics.drawRect(0,0,Dimentions.WIDTH,rightBtn.height);
			//this.graphics.endFill();
			addChild(_whiteLeftBtn);
			addChild(_whiteRightBtn);
			addChild(_colorLeftBtn);
			addChild(_colorRightBtn);
			addChild(_whiteSettingsBut);
			addChild(_colorSettingsBut);
			_whiteLeftBtn.x=5;
			_whiteRightBtn.x=952;
			_whiteLeftBtn.y=696;
			_whiteRightBtn.y=696;
			_colorLeftBtn.x=5;
			_colorRightBtn.x=952;
			_colorLeftBtn.y=696;
			_colorRightBtn.y=696;
			_whiteSettingsBut.x=460;
			_whiteSettingsBut.y=730;
			_colorSettingsBut.x=460;
			_colorSettingsBut.y=730;
			
			_colorSettingsBut.addEventListener(MouseEvent.CLICK,onMenuClicked);
			_whiteSettingsBut.addEventListener(MouseEvent.CLICK,onMenuClicked);
			var leftBtn:Sprite=new Sprite();
			var rightBtn:Sprite=new Sprite();
			leftBtn.addChild(AssetsManager.getAssetByName("arrow_left_hotspot_x5_y696.png"));
			rightBtn.addChild(AssetsManager.getAssetByName("arrow_right_hotspot_x952_y696.png"));
			leftBtn.addEventListener(MouseEvent.CLICK,leftBtnClicked);
			rightBtn.addEventListener(MouseEvent.CLICK,rightBtnClicked);
			addChild(leftBtn);
			addChild(rightBtn);
			rightBtn.x=952;
			rightBtn.y=676;
			leftBtn.x=5;
			leftBtn.y=676;
			_whiteLeftBtn.visible=false;
			_colorLeftBtn.visible=false;
		}
		private function isFirstOrLast(indx:uint):Boolean{
			if(indx==0){
				_whiteLeftBtn.visible=false;
				_colorLeftBtn.visible=false;
				return true;
			}else if(indx==_itemsCount-1){
				_whiteRightBtn.visible=false;
				_colorRightBtn.visible=false;
				return true;
			}
			return false;
		}
		public function setColor(screenIndex:uint):void{
			if(isFirstOrLast(screenIndex)){
				return;
			}
			if(_whiteScreensVector.indexOf(screenIndex)){
				_colorLeftBtn.visible=false;
				_colorRightBtn.visible=false;
				_whiteLeftBtn.visible=true;
				_whiteRightBtn.visible=true;
				_colorSettingsBut.visible=false;
				_whiteSettingsBut.visible=true;
			}else{
				_colorLeftBtn.visible=true;
				_colorRightBtn.visible=true;
				_whiteLeftBtn.visible=false;
				_whiteRightBtn.visible=false;
				_colorSettingsBut.visible=true;
				_whiteSettingsBut.visible=false;
			}
			//visible=(screenIndex!=8);
		}
		
		private function onMenuClicked(e:Event):void{
			menuClicked.dispatch();
		}
		
		private function leftBtnClicked(e:Event):void{
			clicked.dispatch(-1);
		}
		
		private function rightBtnClicked(e:Event):void{
			clicked.dispatch(1);
		}
	}
}