package com.scenes
{
	import com.global.TextAndNarration;
	import com.scenes.components.TextBox;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;

	public class Scene_23 extends AbstractScreen
	{
	private var _face1:Face;
	private var _face2:Face;
	private var _face3:Face;
	private var _face4:Face;
	private var _face5:Face;
	private var _face6:Face;
	private var _hotSpotLayer:Sprite = new Sprite();
	private var _textBox:DisplayObject;
	private var _naration2:NarationPlayer;
		public function Scene_23()
		{
			narationer=new NarationPlayer("narration/scene 21 b.mp3");
			narationer.soundComplete.add(playNextNarration);
			_naration2=new NarationPlayer("narration/scene 22.mp3");
		}
		
		override public function start():void{
			if(!inited){
				bg = AssetsManager.getAssetByName("F23_1024x768_back.jpg");
				_face1 = addFace(AssetsManager.getAssetByName("F23_1024x768_face1_x14_y459.PNG"),"small man laugh.mp3","F23_1024x768_hotspot1_x0_y409.PNG",0,409);
				_face2 = addFace(AssetsManager.getAssetByName("F23_1024x768_face2_x126_y80.PNG"),"fat lady laugh.mp3","F23_1024x768_hotspot2_x119_y21.PNG",119,21);
				_face3 = addFace(AssetsManager.getAssetByName("F23_1024x768_face3_x440_y255.PNG"),"bald man laugh.mp3","F23_1024x768_hotspot3_x381_y240.PNG",381,240);
				_face4 = addFace(AssetsManager.getAssetByName("F23_1024x768_face4_x683_y38.PNG"),"tall man laugh.mp3","F23_1024x768_hotspot4_x606_y1.PNG",606,1);
				_face5 = addFace(AssetsManager.getAssetByName("F23_1024x768_face5_x857_y275.PNG"),"black woman laugh.mp3","F23_1024x768_hotspot5_x812_y230.PNG",812,230);
				_face6 = addFace(AssetsManager.getAssetByName("F23_1024x768_face6_x893_y378.PNG"),"fish and diver laugh.mp3","F23_1024x768_hotspot6_x865_y426.PNG",865,426);
				addChildAt(_hotSpotLayer,numChildren);
				_textBox=AssetsManager.getAssetByName("Text_F23_1024x768_x292_y562.PNG");
				addChild(_textBox);
				_textBox.x=292;
				_textBox.y=562;
				TextAndNarration.registerText(_textBox);
				inited=true;
			}
			narationer.play();
			_face1.activate();
			_face2.activate();
			_face3.activate();
			_face4.activate();
			_face5.activate();
			_face6.activate();
		}
		override public function stop():void{
			narationer.stop();
			_naration2.stop();
			_face1.deactivate();
			_face2.deactivate();
			_face3.deactivate();
			_face4.deactivate();
			_face5.deactivate();
			_face6.deactivate();
		}
		
		private function playNextNarration():void{
			_naration2.play();
		}
		
		private function addFace(dobj:DisplayObject,soundFile:String,hotSpotFile:String,xx:int,yy:int):Face{
			var face:Face = new Face(dobj,soundFile,hotSpotFile,xx,yy,_hotSpotLayer);
			addChild(face);
			return face;
		}
	}
}
import com.utils.AssetsManager;
import com.utils.SoundPlayer;
import com.utils.TouchHere;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.natives.NativeSignal;

class Face extends Sprite{
	private var _soundPlayer:SoundPlayer;
	private var _hotSpot:Sprite = new Sprite();
	private var _touchHere:TouchHere = new TouchHere();
	public function Face(dobj:DisplayObject,soundFile:String,hotSpotFile:String,xx:int,yy:int,hotSpotLayer:Sprite):void{
		var spr:Sprite = new Sprite();
		spr.addChild(dobj);
		addChild(spr);
		_soundPlayer = new SoundPlayer(soundFile);
		_hotSpot.addChild(AssetsManager.getAssetByName(hotSpotFile));
		_hotSpot.x=xx;
		_hotSpot.y=yy;
		_hotSpot.addEventListener(MouseEvent.CLICK,onClick);
		hotSpotLayer.addChild(_hotSpot);
		hotSpotLayer.addChild(_touchHere);
		_touchHere.x=xx+_hotSpot.width/2-22;
		_touchHere.y=yy+44;
		
		
		alpha=0;
	}
	
	public function activate():void{
		_touchHere.activate();
	}
	
	public function deactivate():void{
		_touchHere.deActivate();
	}
	
	public function onClick(e:MouseEvent):void{
		alpha=1;
		_soundPlayer.play();
		_soundPlayer.soundComplete.add(onSoundComplete);
		_hotSpot.removeEventListener(MouseEvent.CLICK,onClick);
		_touchHere.deActivate();
	}
	
	private function onSoundComplete():void{
		alpha=0;
		_soundPlayer.soundComplete.remove(onSoundComplete);
		_hotSpot.addEventListener(MouseEvent.CLICK,onClick);
	}
}