package com.container.menu
{
	import com.gskinner.motion.GTween;
	import com.mailchimp.Subscribe;
	import com.utils.AssetsManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class Share extends Sprite
	{
		private var _sucsribeTxt:TextField;
		public function Share(bg:Sprite)
		{
			addChild(AssetsManager.getAssetByName("share_x268_y-473.png"));
			bg.addEventListener(MouseEvent.CLICK,goUp);
			var goUpSprite:Sprite=new Sprite();
			goUpSprite.graphics.beginFill(0xFFFFFF,0);
			goUpSprite.graphics.drawRect(0,0,100,60);
			goUpSprite.graphics.endFill();
			addChild(goUpSprite);
			goUpSprite.x=(this.width-goUpSprite.width)/2
			goUpSprite.addEventListener(MouseEvent.CLICK,goUp);
			_sucsribeTxt = new TextField();
			_sucsribeTxt.type=TextFieldType.INPUT;
			_sucsribeTxt.width=304;
			_sucsribeTxt.height=30;
			addChild(_sucsribeTxt);
			_sucsribeTxt.x=308-268;
			_sucsribeTxt.y=180;
			_sucsribeTxt.defaultTextFormat=new TextFormat("Arial",22);
			var sucscribe:Sprite=new Sprite();
			sucscribe.addChild(AssetsManager.getAssetByName("share_subscribe_hotspot_x498_y-191.png"))
			sucscribe.x=498-268;
			sucscribe.y=215;
			sucscribe.addEventListener(MouseEvent.CLICK,onSucscribe);
			 addChild(sucscribe);
			//sucscribe.graphics.lineStyle(1);
			//sucscribe.graphics.drawRect(0,0,sucscribe.width,sucscribe.height);
			var moreZuka:Sprite = new Sprite();
			moreZuka.addChild(AssetsManager.getAssetByName("share_morezuuka_hotspot_x389_y-95.png"));
			moreZuka.x=389-268;
			moreZuka.y=320;
			moreZuka.addEventListener(MouseEvent.CLICK,onZuuka);
			//moreZuka.graphics.lineStyle(1);
			//moreZuka.graphics.drawRect(0,0,moreZuka.width,moreZuka.height);
			addChild(moreZuka);
			var faceBook:Sprite = new Sprite();
			faceBook.addChild(AssetsManager.getAssetByName("share_facebook_hotspot_x656_y-308.png"));
			addChild(faceBook);
			faceBook.x=656-268
			faceBook.y=104;
			
			faceBook.addEventListener(MouseEvent.CLICK,function():void{
				var url:URLRequest = new URLRequest("http://www.facebook.com/BoxesByLioraGrossman");
				navigateToURL(url, "_blank");

			})
			var twitter:Sprite = new Sprite();
			twitter.addChild(AssetsManager.getAssetByName("share_facebook_hotspot_x656_y-308.png"));
			addChild(twitter);
			twitter.x=656-268
			twitter.y=192;
			twitter.addEventListener(MouseEvent.CLICK,function():void{
				var url:URLRequest = new URLRequest("http://twitter.com/boxesapp");
				navigateToURL(url, "_blank");
			})
		}
		
		private function onSucscribe(e:MouseEvent):void{
//			new Subscribe("us2",_sucsribeTxt.text);
//			_sucsribeTxt.text="";
			var urlString:String = "mailto:";
			urlString += _sucsribeTxt.text;
			urlString += "?subject=";
			urlString += "Recommended  children app story";
			urlString += "&body=";
			urlString += "Hi, I just finished reading this Great story. I'm sure you will enjoy it as well. Read about it here: http://www.facebook.com/BoxesByLioraGrossman";
			navigateToURL(new URLRequest(urlString));
			_sucsribeTxt.text="";

		}
		private function onZuuka(e:MouseEvent):void{
			var url:URLRequest = new URLRequest("http://www.zuuka.com");
			navigateToURL(url, "_blank");
			

		}
		
		private function goUp(e:Event):void{
			new GTween(this,0.5,{y:-473})
			dispatchEvent(new Event("close"));
		}
	}
}