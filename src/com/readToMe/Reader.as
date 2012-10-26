package com.readToMe
{
	import com.utils.AssetsManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class Reader extends Sprite
	{
		private var _playBtn:Sprite;
		private var _pauseBtn:Sprite;
		private var _homeBtn:Sprite;
		private var _stream:NetStream;
		public function Reader()
		{
			init();
		}
		
		private function init():void{
			var connection:NetConnection=new NetConnection();
			connection.connect(null);
			_stream=new NetStream(connection);
			_stream.client=this;
			var video:Video=new Video(1024,768);
			addChild(video);
			video.attachNetStream(_stream);
			
			_homeBtn=new Sprite();
			_homeBtn.addChild(AssetsManager.getAssetByName("home_icon_x5_y696.png"));
			addChild(_homeBtn);
			_homeBtn.x=5;
			_homeBtn.y=696;
			_homeBtn.addEventListener(MouseEvent.CLICK,onHome);
			_playBtn=new Sprite();
			_playBtn.addChild(AssetsManager.getAssetByName("play_icon_x952_y696.png"));
			addChild(_playBtn);
			_playBtn.x=952;
			_playBtn.y=696;
			_playBtn.addEventListener(MouseEvent.CLICK,resume);
			_pauseBtn=new Sprite();
			_pauseBtn.addChild(AssetsManager.getAssetByName("pause_icon_x952_y696.png"));
			addChild(_pauseBtn);
			_pauseBtn.x=952;
			_pauseBtn.y=696;
			_pauseBtn.addEventListener(MouseEvent.CLICK,pause);
		}
		
		private function resume(e:MouseEvent):void{
			_stream.resume();
			_pauseBtn.visible=true;
			_playBtn.visible=false;
		}
		private function pause(e:MouseEvent):void{
			_stream.pause();
			_pauseBtn.visible=false;
			_playBtn.visible=true;
		}
		
		private function onHome(e:MouseEvent):void{
			dispatchEvent(new Event("go_home",true));
			_stream.pause();
		}
		
		public function play():void{
			_stream.play("assets/boxes_video.flv");
			_pauseBtn.visible=true;
			_playBtn.visible=false;
		}
		
		public function onPlayStatus(infoObject:Object):void{
			
		}
		
		public function onMetaData(infoObject:Object):void{
			trace(infoObject.width,infoObject.height)
		}
	}
}