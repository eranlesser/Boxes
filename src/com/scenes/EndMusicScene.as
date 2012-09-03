package com.scenes
{
	import com.scenes.core.AbstractScreen;
	import com.utils.EndMusic;
	
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class EndMusicScene extends AbstractScreen
	{
		private var _sound:Sound;
		public function EndMusicScene()
		{
		}
		
		override public function start():void{
			_sound=new EndMusic();
			_sound.play(0,3);
		}
	}
}