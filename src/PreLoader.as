package
{
	import flash.display.Sprite;
	
	public class PreLoader extends Sprite
	{
		[Embed(source="assets/boxes_splash.jpg")]
		private var Bg:Class;
		public function PreLoader(){
			addChild(new Bg());
		}
	}
}