package com.container.menu
{
	import com.gskinner.motion.GTween;
	import com.utils.AssetsManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class About extends Sprite{
		private var _darkLayer:Sprite;
		public function About(){
			init();
		}
		
		private function init():void{
			x=38;
			y=-709;
			_darkLayer=new Sprite();
			_darkLayer.addChild(AssetsManager.getAssetByName("about_darker_BG_x0_y0.png"));
			_darkLayer.x=-38;
			//_darkLayer.addEventListener(MouseEvent.CLICK,goUp);
			addChild(_darkLayer);
			_darkLayer.alpha=0;
			var about:DisplayObject=addChild(AssetsManager.getAssetByName("about_image_x38_y-709.png"));
			about.y=37;
			
			
			var goUpSprite:Sprite=new Sprite();
			goUpSprite.graphics.beginFill(0x333333,0);
			goUpSprite.graphics.drawRect(0,0,100,80);
			goUpSprite.graphics.endFill();
			addChild(goUpSprite);
			goUpSprite.x=(this.width-goUpSprite.width)/2-38;
			goUpSprite.addEventListener(MouseEvent.CLICK,goUp);
			
			addHotSpots()
		}
		
		private function addHotSpots():void{
			
			var _liora:Sprite=new Sprite();
			_liora.addChild(AssetsManager.getAssetByName("about_liora_hotspot_x258_y-524.png"));
			_liora.x=258-38;
			_liora.y=-524+709+37;
			addChild(_liora);
			_liora.addEventListener(MouseEvent.CLICK,onLioraMailClick);
			
			var _lioraSite:Sprite=new Sprite();
			_lioraSite.addChild(AssetsManager.getAssetByName("about_liora_site_hotspot_x70_y-524.png"));
			_lioraSite.x=70-38;
			_lioraSite.y=-524+709+37;
			addChild(_lioraSite);
			_lioraSite.addEventListener(MouseEvent.CLICK,onLioraClick);
			
			var _katz:Sprite=new Sprite();
			_katz.addChild(AssetsManager.getAssetByName("about_katz_hotspot_x70_y-181.png"));
			_katz.x=70-38;
			_katz.y=-181+709+37;
			addChild(_katz);
			_katz.addEventListener(MouseEvent.CLICK,onKatzMailClick);
			
			
			var _sharon:Sprite=new Sprite();
			_sharon.addChild(AssetsManager.getAssetByName("about_sharon_hotspot_x542_y-378.png"));
			_sharon.x=542-38;
			_sharon.y=-378+709+37;
			addChild(_sharon);
			_sharon.addEventListener(MouseEvent.CLICK,onSharonMailClick);
			
			var _yaira:Sprite=new Sprite();
			_yaira.addChild(AssetsManager.getAssetByName("about_yaira_hotspot_x542_y-230.png"));
			_yaira.x=542-38;
			_yaira.y=-230+709+37;
			addChild(_yaira);
			_yaira.addEventListener(MouseEvent.CLICK,onYairaMailClick);
			
			var _yoran:Sprite=new Sprite();
			_yoran.addChild(AssetsManager.getAssetByName("about_yoran_hotspot_x70_y-352.png"));
			_yoran.x=70-38;
			_yoran.y=-352+709+37;
			addChild(_yoran);
			_yoran.addEventListener(MouseEvent.CLICK,onYoranClick);
		
			var _eran:Sprite=new Sprite();
			_eran.addChild(AssetsManager.getAssetByName("about_eran_site_hotspot_x542_y-564.png"));
			_eran.x=542-38;
			_eran.y=-564+709+37;
			addChild(_eran);
			_eran.addEventListener(MouseEvent.CLICK,onEranClick);
			
			var _libi:Sprite=new Sprite();
			_libi.addChild(AssetsManager.getAssetByName("about_libby_hotspot_x542_y-78.png"));
			_libi.x=542-38;
			_libi.y=-78+709+37;
			addChild(_libi);
			_libi.addEventListener(MouseEvent.CLICK,onLibiMailClick);
		}
		private function goUp(e:Event):void{
			hide();
		}
		
		public function show():void{
			this.visible=true;
			_darkLayer.alpha=1;
			new GTween(this,1,{y:0});
			new GTween(_darkLayer,1,{alpha:1});
		}
		
		private function hide():void{
			new GTween(this,1,{y:-709});
			var hideTween:GTween=new GTween(_darkLayer,1,{alpha:0});
			hideTween.onComplete=onHiden;
		}
		
		private function onHiden(t:GTween):void{
			t.onComplete=null;
			_darkLayer.alpha=0;
			this.visible=false;
		}
		
		private function onLioraClick(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("http://www.lioragrossman.com");
			navigateToURL(url, "_blank");
		}
		private function onEranClick(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("http://www.creativelamas.com");
			navigateToURL(url, "_blank");
		}
		private function onLioraMailClick(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("mailto:lioragrossman@gmail.com");
			navigateToURL(url, "_blank");
		}
		private function onKatzMailClick(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("mailto:katzyair@gmail.com");
			navigateToURL(url, "_blank");
		}
		private function onSharonMailClick(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("mailto:sharonkastoriano@gmail.com");
			navigateToURL(url, "_blank");
		}
		private function onYairaMailClick(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("mailto:yaira-s@gmail.com");
			navigateToURL(url, "_blank");
		}
		private function onLibiMailClick(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("mailto:librix77@gmail.com");
			navigateToURL(url, "_blank");
		}
		private function onYoranClick(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("mailto:yoranbar@gmail.com");
			navigateToURL(url, "_blank");
		}
	}
}