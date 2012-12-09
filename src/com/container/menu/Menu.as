package com.container.menu
{
	import com.global.Session;
	import com.gskinner.motion.GTween;
	import com.utils.AssetsManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class Menu extends Sprite
	{
		private var _bg:Sprite;
		private var _menu:DisplayObject;
		private var _readToMeHotSpot:Sprite;
		private var _readToMeMenu:ReadToMe;
		private var _narationHotSpot:Sprite;
		private var _narrationMenu:NarrationMenu;
		private var _sceneMenu:SceneMenu;
		private var _about:About;
		private var _share:Share;
		public var pageRequest:Signal=new Signal();
		public function Menu(){
			init();
		}
		
		private function init():void{
			_bg=new Sprite();
			_bg.addChild(AssetsManager.getAssetByName("scene_menu_background.png"));
			_menu=AssetsManager.getAssetByName("scene_menu_x0_y768.png");
			addChild(_bg);
			addChild(_menu);
			hide();
			//add hotspo
			var hotSpot:Sprite = new Sprite();
			hotSpot.addChild(AssetsManager.getAssetByName("settings_hotspot_x460_y730.png"));
			addChild(hotSpot);
			hotSpot.x=460;
			hotSpot.y=730;
			hotSpot.addEventListener(MouseEvent.CLICK,onDownBtn);
			_readToMeMenu=new ReadToMe();
			addChild(_readToMeMenu);
			
			addNarrationMenu();
			addScenesMenu();
			addAboutMenu();
			addHomeHotSpot();
			addShareHotSpot();
		}
		
		private function addShareHotSpot():void{
			_share = new Share(_bg);
			addChild(_share);
			_share.x=268;
			_share.y=-473;
			var hotSpot:Sprite=new Sprite();
			hotSpot.addChild(AssetsManager.getAssetByName("scene_menu_tell_a_friend_hotspot_x489_y556.png"));
			hotSpot.x=489;
			hotSpot.y=556;
			addChild(hotSpot);
			hotSpot.addEventListener(MouseEvent.CLICK,onShare);
		}
		
		private function onShare(e:MouseEvent):void{
			new GTween(_share,0.5,{y:37});
		}
		
		private function addHomeHotSpot():void{
			var hotSpot:Sprite=new Sprite();
			hotSpot.addChild(AssetsManager.getAssetByName("scene_menu_home_hotspot_x822_y490.png"));
			hotSpot.x=822;
			hotSpot.y=490;
			addChild(hotSpot);
			hotSpot.addEventListener(MouseEvent.CLICK,onHome);
		}
		
		private function onHome(e:MouseEvent):void{
			dispatchEvent(new Event("go_home",true));
			Session.getInstance().stopEndMusic();
		}
		
		private function addAboutMenu():void{
			var hotSpot:Sprite=new Sprite();
			hotSpot.addChild(AssetsManager.getAssetByName("scene_menu_about_hotspot_x573_y363.png"));
			hotSpot.x=573;
			hotSpot.y=363;
			addChild(hotSpot);
			hotSpot.addEventListener(MouseEvent.CLICK,onAboutClick);
			
			_about=new About();
			addChild(_about);
			_about.visible=false;
		}
		
		private function onAboutClick(e:MouseEvent):void{
			_about.show();
		}
		
		private function onDownBtn(e:MouseEvent):void{
			//hide();
			new GTween(_bg,0.5,{alpha:0});
			var tween:GTween=new GTween(_menu,0.5,{y:768});
			tween.onComplete=hide;
		}
		
		public function hide(t:GTween=null):void{
			_bg.alpha=0;
			_menu.y=768;
			this.visible=false;
		}
		
		public function show():void{
			this.visible=true;
			new GTween(_bg,0.5,{alpha:1});
			new GTween(_menu,0.5,{y:341});
		}
		
		private function addScenesMenu():void{
			
			var pagesHotSpot:Sprite=new Sprite();
			pagesHotSpot.addChild(AssetsManager.getAssetByName("scene_menu_pages_hotspot_x323_y548.png"));
			pagesHotSpot.x=323;
			pagesHotSpot.y=548;
			addChild(pagesHotSpot);
			pagesHotSpot.addEventListener(MouseEvent.CLICK,onPages);
			_sceneMenu=new SceneMenu(_bg);
			addChild(_sceneMenu);
			_sceneMenu.x=0;
			_sceneMenu.y=768;
			_sceneMenu.pageRequest.add(onPageRequest);
		}
		
		private function onPageRequest(indx:uint):void{
			pageRequest.dispatch(indx);
			onDownBtn(null);
		}
		
		private function onPages(e:MouseEvent):void{
			new GTween(_sceneMenu,0.5,{y:601});
			_sceneMenu.active=true;
		}
		
		private function addNarrationMenu():void{
			_narationHotSpot=new Sprite();
			_narationHotSpot.addChild(AssetsManager.getAssetByName("scene_menu_text_narration_hotspot_x51_y581.png"));
			_narationHotSpot.x=51;
			_narationHotSpot.y=581;
			addChild(_narationHotSpot);
			_narationHotSpot.addEventListener(MouseEvent.CLICK,onNarration);
			
			_narrationMenu = new NarrationMenu(AssetsManager.getAssetByName("text_narrate_ton_non_x318_y-327.png"),AssetsManager.getAssetByName("text_narrate_toff_non_x318_y-327.png"),AssetsManager.getAssetByName("text_narrate_ton_noff_x318_y-327.png"),AssetsManager.getAssetByName("text_narrate_toff_noff_x318_y-327.png"),_bg);
			addChild(_narrationMenu);
			_narrationMenu.x=318;
			_narrationMenu.y=-327;
		}
		
		private function onNarration(e:MouseEvent):void{
			new GTween(_narrationMenu,0.5,{y:37})
		}
		
		/*
		private function addReadToMeBut():void{
			_readToMeHotSpot=new Sprite();
			_readToMeHotSpot.addChild(AssetsManager.getAssetByName("scene_menu_reading_options_hotspot_x102_y365.png"));
			_readToMeHotSpot.x=102;
			_readToMeHotSpot.y=465;
			addChild(_readToMeHotSpot);
			_readToMeHotSpot.addEventListener(MouseEvent.CLICK,onReadToMe);
			_readToMeHotSpot.graphics.lineStyle(1);
			_readToMeHotSpot.graphics.drawRect(0,0,_readToMeHotSpot.width,_readToMeHotSpot.height);
		}
		private function onReadToMe(e:Event):void{
			
		}
		*/
	}
}