package com.global
{
	import com.container.Book;
	import com.utils.EndMusic;
	import com.utils.SoundPlayer;
	
	import flash.media.SoundChannel;

	public class Session
	{
		private static var instance:Session;
		private static var allowInstantiation:Boolean;
		
		private var _busLightsOn:Boolean = false;
		private var _busXPoint:int = -512;
		private var _openScreenSound:SoundPlayer;
		private var _endMusic:EndMusic;
		private var _endMusicChannel:SoundChannel;
		private var _endMusicPlaying:Boolean=false;
		public function Session(){
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
			_endMusic=new EndMusic()//SoundPlayer("boxes ending music-2.mp3");
		}
		
		
		
		public static function getInstance():Session {
			if (instance == null) {
				allowInstantiation = true;
				instance = new Session();
				allowInstantiation = false;
			}
			return instance;
		}
		
		public function playEndMusic():void{
			if(!_endMusicPlaying){
				_endMusicChannel=_endMusic.play(0,1000);
				_endMusicPlaying=true;
			}
		}
		
		public function stopEndMusic():void{
			if(_endMusicChannel){
				_endMusicChannel.stop();
			}
			_endMusicPlaying=false;
		}
		
		
		public function get busLightsOn():Boolean{
			return _busLightsOn;
		}
		
		public function set busLightsOn(flag:Boolean):void{
			_busLightsOn = flag;
		}
		public function get busXPoint():int{
			return _busXPoint;
		}
		
		public function set busXPoint(xx:int):void{
			_busXPoint = xx;
		}
		
		public function get openScreenSound():SoundPlayer{
			return _openScreenSound;
		}
		
		public function set openScreenSound(soundPlayer:SoundPlayer):void{
			_openScreenSound=soundPlayer;
		}
	}
}