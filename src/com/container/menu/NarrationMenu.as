package com.container.menu
{
	import com.container.Book;
	import com.global.TextAndNarration;
	import com.gskinner.motion.GTween;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class NarrationMenu extends Sprite{
		
		private var _yes_yes_state:DisplayObject;
		private var _no_yes_state:DisplayObject;
		private var _yes_no_state:DisplayObject;
		private var _no_no_state:DisplayObject;
		private var _curState:DisplayObject;
		private var _leftValue:Boolean=true;
		private var _rightValue:Boolean=true;
		public function NarrationMenu(yes_yes_state:DisplayObject,no_yes_state:DisplayObject,yes_no_state:DisplayObject,no_no_state:DisplayObject,bg:Sprite){
			_yes_yes_state=yes_yes_state;
			_yes_no_state=yes_no_state;
			_no_yes_state=no_yes_state;
			_no_no_state=no_no_state;
			_curState=addChild(_yes_yes_state);
			init();
			bg.addEventListener(MouseEvent.CLICK,goUp);
		}
		
		private function init():void{
			var leftSpr:Sprite=new Sprite();
			addChild(leftSpr);
			leftSpr.graphics.beginFill(0xFFFFFF,0);
			leftSpr.graphics.drawRect(0,0,width/2,height);
			leftSpr.graphics.endFill();
			leftSpr.addEventListener(MouseEvent.MOUSE_DOWN,onLeftClicked);
			
			var rightSpr:Sprite=new Sprite();
			addChild(rightSpr);
			rightSpr.graphics.beginFill(0xFFFFFF,0);
			rightSpr.graphics.drawRect(width/2,0,width/2,height);
			rightSpr.graphics.endFill();
			rightSpr.addEventListener(MouseEvent.MOUSE_DOWN,onRightClicked);
			
			var goUpSprite:Sprite=new Sprite();
			goUpSprite.graphics.beginFill(0xFFFFFF,0);
			goUpSprite.graphics.drawRect(0,0,100,60);
			goUpSprite.graphics.endFill();
			addChild(goUpSprite);
			goUpSprite.x=(this.width-goUpSprite.width)/2
			goUpSprite.addEventListener(MouseEvent.CLICK,goUp);
		}
		
		private function goUp(e:Event):void{
			new GTween(this,0.5,{y:-327})
		}
		
		private function onLeftClicked(e:MouseEvent):void{
			_leftValue=!_leftValue;
			TextAndNarration.textsVisible=_leftValue;
			update();
		}
		private function onRightClicked(e:MouseEvent):void{
			_rightValue=!_rightValue;
			TextAndNarration.narrationOn=_rightValue;
			update();
		}
		private function update():void{
			removeChild(_curState);
			if(_leftValue&&_rightValue){
				_curState=_yes_yes_state;
			}
			if(_leftValue&&!_rightValue){
				_curState=_yes_no_state;
			}
			if(!_leftValue&&_rightValue){
				_curState=_no_yes_state;
			}
			if(!_leftValue&&!_rightValue){
				_curState=_no_no_state;
			}
			addChild(_curState);
			
		}
	}
}