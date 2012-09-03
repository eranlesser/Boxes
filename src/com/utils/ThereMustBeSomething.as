package com.utils
{
	public class ThereMustBeSomething
	{
		private static var _instance:ThereMustBeSomething;
		private var _soundPlayer:SoundPlayer;
		public function ThereMustBeSomething(enforcer:Enforcer)
		{
			_soundPlayer=new SoundPlayer("narration/12.mp3");
		}
		
		public static function get instance():ThereMustBeSomething{
			
			if(!_instance){
				_instance=new ThereMustBeSomething(new Enforcer());
			}
			return _instance;
		}
		
		public function play():void{
			_soundPlayer.play();
		}
		public function stop():void{
			_soundPlayer.stop();
		}
	}
}

class Enforcer{
	
}