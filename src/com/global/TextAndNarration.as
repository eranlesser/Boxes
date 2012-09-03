package com.global
{
	import com.container.Book;
	
	import flash.display.DisplayObject;

	public class TextAndNarration
	{
		public static var _texts:Vector.<DisplayObject>=new Vector.<DisplayObject>();
		public static var narrationOn:Boolean=true;
		private static var _textVisible:Boolean=true;
		public function TextAndNarration()
		{
		}
		
		public static function registerText(txt:DisplayObject):void{
			_texts.push(txt);
			txt.visible=_textVisible;
		}
		
		public static function set textsVisible(flag:Boolean):void{
			for each(var text:DisplayObject in _texts){
				text.visible=flag;
			}
			_textVisible=flag;
		}
	}
}