package com.scenes.last
{
	import com.global.Session;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.SoundPlayer;

	public class Scene_2 extends AbstractScreen
	{
		private var _distanceJoints:FlowWorld;
		public function Scene_2()
		{
				
		}
		
		override public function start():void{
			//addChild(AssetsManager.getAssetByName("boxes02.jpg"));
			if(!inited){
				inited=true;
				bg = AssetsManager.getAssetByName("F2_1024x768_background.jpg");
				_distanceJoints = new FlowWorld();
				addChild(_distanceJoints);
			}else{
				_distanceJoints.resume();
			}
			//Session.getInstance().openScreenSound.unPause();
		}
		
		override public function stop():void{
			_distanceJoints.pause();
			//Session.getInstance().openScreenSound.pause();
		}
	}
}