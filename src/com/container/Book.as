package com.container
{
	import com.container.menu.Menu;
	import com.global.Session;
	import com.scenes.Scene_1;
	import com.scenes.Scene_10;
	import com.scenes.Scene_10B;
	import com.scenes.Scene_11;
	import com.scenes.Scene_13;
	import com.scenes.Scene_14;
	import com.scenes.Scene_15;
	import com.scenes.Scene_16;
	import com.scenes.Scene_17;
	import com.scenes.Scene_18;
	import com.scenes.Scene_19;
	import com.scenes.Scene_20;
	import com.scenes.Scene_21;
	import com.scenes.Scene_23;
	import com.scenes.Scene_24;
	import com.scenes.Scene_25;
	import com.scenes.Scene_26;
	import com.scenes.Scene_27;
	import com.scenes.Scene_28;
	import com.scenes.Scene_29;
	import com.scenes.Scene_30;
	import com.scenes.Scene_31b;
	import com.scenes.Scene_32;
	import com.scenes.Scene_4;
	import com.scenes.Scene_6;
	import com.scenes.Scene_7;
	import com.scenes.Scene_8;
	import com.scenes.Scene_9;
	import com.scenes.Scene_9a;
	import com.scenes.core.AbstractScreen;
	
	import flash.display.Sprite;
	import flash.utils.Timer;
	
	public class Book extends Sprite
	{
		private var _screens:Vector.<AbstractScreen>;
		private var _screenIndex:int=0;
		private var _navigator:Navigator;
		private var _menu:Menu;
		private var _progressProtectorTimer:Timer;
		public function Book()
		{
			_navigator = new Navigator();
			addChild(_navigator);
			_navigator.clicked.add(progress);
			_navigator.menuClicked.add(onMenuClicked);
			initScreens();
			_menu=new Menu();
			addChild(_menu);
			_menu.pageRequest.add(onPageRequest);
			_navigator.itemsCount=_screens.length;
			_progressProtectorTimer = new Timer(500,1);
		}
		
		private function onMenuClicked():void{
			_menu.show();
		}
		
		private function onPageRequest(indx:uint):void{
			if(indx>6){
				indx++;
			}
			if(indx>7){
				indx++;
			}
			if(indx>_screens.length-4){
				Session.getInstance().playEndMusic();
			}else{
				Session.getInstance().stopEndMusic();
			}
			_screens[_screenIndex].stop();
			_screenIndex=indx-1;
			removeChildAt(0);
			addChildAt(_screens[_screenIndex],0);
			_screens[_screenIndex].start();
			_navigator.setColor(_screenIndex);
		}
		
		private function initScreens():void{
			_screens = new Vector.<AbstractScreen>();
			addScreen(new Scene_1(_navigator));
			addScreen(new Scene_4());
			addScreen(new Scene_6());
			addScreen(new Scene_7());
			addScreen(new Scene_8());
			addScreen(new Scene_9a());
			addScreen(new Scene_9());
			addScreen(new Scene_10());
			addScreen(new Scene_10B());
			addScreen(new Scene_11());
			addScreen(new Scene_13());
			addScreen(new Scene_14());
			addScreen(new Scene_15());
			addScreen(new Scene_16());
			addScreen(new Scene_17());
			addScreen(new Scene_18());
			addScreen(new Scene_19());
			addScreen(new Scene_20());
			addScreen(new Scene_21());
			addScreen(new Scene_23());
			
			addScreen(new Scene_24());
			addScreen(new Scene_25());
			addScreen(new Scene_26());
			addScreen(new Scene_27());
			addScreen(new Scene_28());
			addScreen(new Scene_29());
			
			addScreen(new Scene_30());
			addScreen(new Scene_31b());
			addScreen(new Scene_32(_navigator));
			addChildAt(_screens[_screenIndex],0);
			_screens[_screenIndex].start();
		}
		private function addScreen(screen:AbstractScreen):void{
			_screens.push(screen);
		}
		
		public function reset():void{
			onPageRequest(1);
			_menu.hide();
		}
		
		public function stopCurrentScene():void{
			_screens[_screenIndex].stop();
		}
		
		private function progress(dir:int):void{
			if(_progressProtectorTimer.running){
				return;
			}else{
				_progressProtectorTimer.start();
			}
			_screens[_screenIndex].stop();
			if(dir==1){
				_screenIndex++;
			}
			if(dir==-1){
				_screenIndex--;
			}
			if(_screenIndex<0){
				_screenIndex = 0;
				return
			}else if(_screenIndex == _screens.length){
				_screenIndex--;
				return;
			}
			removeChildAt(0);
			addChildAt(_screens[_screenIndex],0);
			_screens[_screenIndex].start();
			_navigator.setColor(_screenIndex);
		}
		
	}
}