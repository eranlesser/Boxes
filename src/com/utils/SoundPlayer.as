package com.utils
{
	import com.container.Book;
	import com.gskinner.motion.GTween;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;

	public class SoundPlayer{
		
		private var _sound:Sound;
		private var _channel:SoundChannel;
		public var soundComplete:Signal = new Signal();
		public var ready:Signal = new Signal();
		private var _loop:Boolean;
		private var _isLoaded:Boolean=false;
		public var muteVolume:Number=1;
		private var _pauseIndx:Number=0;
		public function SoundPlayer(mp3File:String){
			loadSound(mp3File);
			
		}
		
		public function play(loop:Boolean=false):void{
			_loop = loop;
			if(_channel){
				var soundtransform:SoundTransform=_channel.soundTransform;
				soundtransform.volume=1;
			}
			_channel = _sound.play();
			_channel.soundTransform=soundtransform;
			_channel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
		}
		
		public function pause():void{
			
			if(_channel){
				_pauseIndx=_channel.position;
				_channel.stop();
			}
		}
		public function unPause():void{
			if(_channel){
				var soundtransform:SoundTransform=_channel.soundTransform;
			}
			_channel = _sound.play(_pauseIndx);
			_channel.soundTransform=soundtransform;
			_channel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
		}
		
		public function stop():void{
			_loop=false;
			if(_channel){
				_channel.stop();
			}
		}
		
		public function mute(duration:Number):void{
			var tween:GTween = new GTween(this,duration,{muteVolume:0});
			tween.onChange = onTweenCue;
			tween.onComplete = onTweenComplete;
			_loop=false;
		}
		
		public function unMute(duration:Number):void{
				var tween:GTween = new GTween(this,duration,{muteVolume:1});
				tween.onChange = onUnmute;
				tween.onComplete = onUnmuteComplete;
		}
		private function onUnmute(tween:GTween):void{
				if(_channel){
					var soundTransform:SoundTransform = _channel.soundTransform;
					soundTransform.volume = muteVolume;
					_channel.soundTransform = SoundTransform(soundTransform);
				}
		}
		private function onUnmuteComplete(tween:GTween):void{
				if(_channel){
					var soundTransform:SoundTransform = _channel.soundTransform;
					soundTransform.volume = 1;
					_channel.soundTransform = SoundTransform(soundTransform);
				}
		}
		private function onTweenCue(tween:GTween):void{
				if(_channel){
					var soundTransform:SoundTransform = _channel.soundTransform;
					soundTransform.volume = muteVolume;
					_channel.soundTransform = SoundTransform(soundTransform);
				}
		}
		private function onTweenComplete(tween:GTween):void{
				if(_channel){
					var soundTransform:SoundTransform = _channel.soundTransform;
					soundTransform.volume = 0;
					_channel.soundTransform = SoundTransform(soundTransform);
				}
		}
		
		private function loadSound(mp3File:String):void{
			_sound = new Sound();
			var req:URLRequest = new URLRequest("../../assets/sounds/"+mp3File);
			try {
				_sound.addEventListener(Event.COMPLETE,onSoundReady);
				_sound.load(req);
				//performance - to avoid cutting sound beginings
				_channel = _sound.play();
				_channel.stop();
			}
			catch (err:Error) {
				trace(err.message);
			}
			_sound.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		private function onSoundComplete(e:Event):void{
			soundComplete.dispatch();
			_channel.removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
			if(_loop){
				play(true);
			}
		}
		
		private function onSoundReady(e:Event):void{
			_sound.removeEventListener(Event.COMPLETE,onSoundReady);
			ready.dispatch();
			_isLoaded=true;
		}
		
		public function get isLoaded():Boolean{
			return _isLoaded;
		}
		
		private function errorHandler(errorEvent:IOErrorEvent):void {
			trace("The sound could not be loaded: " + errorEvent.text);
		}
		
		
	}
}