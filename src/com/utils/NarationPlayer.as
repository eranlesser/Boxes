package com.utils
{
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	import org.osmf.events.TimeEvent;

	public class NarationPlayer
	{
		private var _players:Vector.<SoundPlayer>;
		private var _soundComplete:Signal=new Signal();
		private var _allSoundsComplete:Signal=new Signal();
		private var _playerIndex:uint=0;
		private var _playSequance:Boolean=true;
		private var _delayTimer:Timer;
		public function NarationPlayer(... args)
		{
			_players=new Vector.<SoundPlayer>();
			for each(var soundFile:String in args){
				loadSoundFile(soundFile);
			}
		}
		
		public function reset():void{
			_playerIndex=0;
		}
		
		public function play(delay:Number=0):void{
			//_playSequance=playSequance;
			//_playerIndex=playerIndex;
			if(!TextAndNarration.narrationOn){
				return;
			}
			if(delay>0){
				_delayTimer=new Timer(delay*1000,1);
				_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE,playDelayedSound);
				_delayTimer.start();
			}else{
				_players[_playerIndex].play();
			}
		}
		
		private function playDelayedSound(e:TimerEvent):void{
			_players[_playerIndex].play();
		}
		
		public function get allSoundsComplete():Signal{
			return _allSoundsComplete;
		}
		
		public function get soundComplete():Signal{
			return _soundComplete;
		}
		
		public function stop():void{
			for each(var player:SoundPlayer in _players){
				player.stop();
			}
			if(_delayTimer){
				_delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,playDelayedSound);
				_delayTimer.stop();
			}
		}
		
		private function loadSoundFile(url:String):void{
			var player:SoundPlayer=new SoundPlayer(url);
			player.soundComplete.add(onPlayersoundComplete);
			_players.push(player);
		}
		
		private function onPlayersoundComplete():void{
			if(_playerIndex==_players.length-1){
				_allSoundsComplete.dispatch();
			}else{
				_playerIndex++;
			}
			_soundComplete.dispatch();
		}
	}
}