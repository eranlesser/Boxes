package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	public class ZuukaLoader extends Sprite
	{
		private var _stream:NetStream;
		public function ZuukaLoader()
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
			var tmr:Timer = new Timer(300,1);
			tmr.addEventListener(TimerEvent.TIMER_COMPLETE,onReady);
			tmr.start();
		}
		
		private function onReady(e:Event):void{
			play();
		}
		
		private function resume(e:MouseEvent):void{
			_stream.resume();
		}
		private function pause(e:MouseEvent):void{
			_stream.pause();
		}
		
		public function play():void{
			_stream.play("assets/splashscreen_iPad.flv");
		}
		
		public function onPlayStatus(infoObject:Object):void{
			
		}
		
		public function onXMPData(infoObject:Object):void{
			
		}
		
		public function onMetaData(infoObject:Object):void{
			trace(infoObject.width,infoObject.height)
		}
	}
}