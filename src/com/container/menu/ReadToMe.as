package com.container.menu
{
	import com.gskinner.motion.GTween;
	import com.utils.AssetsManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ReadToMe extends Sprite
	{
		private var _readToMe:DisplayObject;
		private var _readByMyself:DisplayObject;
		private var _movingPart:Sprite;
		public function ReadToMe(){
			init();
		}
		
		private function init():void{
			_movingPart=new Sprite();
			_readToMe = AssetsManager.getAssetByName("read_mode_readtome_x318_y-327.png");
			_readByMyself = AssetsManager.getAssetByName("read_mode_readbymyself_x318_y-327.png");
			_movingPart.addChild(_readToMe);
			_movingPart.addChild(_readByMyself);
			addChild(_movingPart);
			_movingPart.x=318;
			_movingPart.y=-327;
			hide();
		}
		
		public function show():void{
			this.visible=true;
			new GTween(_movingPart,0.5,{y:37});
		}
		
		private function hide():void{
			this.visible=false;
		}
	}
}