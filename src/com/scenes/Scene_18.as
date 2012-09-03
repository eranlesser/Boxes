package com.scenes
{
	import com.global.TextAndNarration;
	import com.scenes.core.AbstractScreen;
	import com.utils.AssetsManager;
	import com.utils.NarationPlayer;
	import com.utils.SoundPlayer;
	import com.utils.TouchHere;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Scene_18 extends AbstractScreen{
		private var _diver:DisplayObject;
		private var _diverHotSpot:Sprite;
		private var _soundPlayerDiverUp:SoundPlayer;
		private var _soundPlayerDiverDown:SoundPlayer;
		private var _hotSpotLayer:Sprite;
		private var _narrationPlayer:NarationPlayer;
		private var _clickableMasks:Vector.<ClickableMask>;
		private var _touchHere:TouchHere=new TouchHere();
		public function Scene_18(){
			_narrationPlayer=new NarationPlayer("narration/scene 18.mp3");
			_clickableMasks=new Vector.<ClickableMask>();
		}
		
		override public function start():void{
			if(!inited){
				addChild(AssetsManager.getAssetByName("F18_1024x768_background.jpg"));
				_hotSpotLayer=new Sprite();
				addMasks();
				addDiver();
				_soundPlayerDiverDown = new SoundPlayer("DIVER DIVE DOWN.mp3");
				 _soundPlayerDiverUp = new SoundPlayer("DIVER POPS UP.mp3");
				 TextAndNarration.registerText(addText(AssetsManager.getAssetByName("Text_F18_1024x768_x212_y671.png"),212,671));
			}else{
				for each(var clickableMask:ClickableMask in _clickableMasks){
					clickableMask.reset();
				}
				_diver.x=940;
				_diver.y=320;
			}
			_narrationPlayer.play();
			_touchHere.activate();
			inited=true;
		}
		override public function stop():void{
			_narrationPlayer.stop();
			_touchHere.deActivate();
			for each(var clickableMask:ClickableMask in _clickableMasks){
				clickableMask.stop();
			}
		}
		private function addDiver():void{
			_diver = AssetsManager.getAssetByName("F18_1024x768_diver_x940_y320.png");
			addChild(_diver)
			_diver.x=940;
			_diver.y=320;
			var diverMask:DisplayObject = AssetsManager.getAssetByName("F18_1024x768_diver_mask_x918_y361.png");
			addChild(diverMask);
			diverMask.x=918;
			diverMask.y=361;
			_diverHotSpot = new Sprite();
			_diverHotSpot.addChild(AssetsManager.getAssetByName("F18_1024x768_diver_hotspot_x940_y280.png"));
			addChild(_diverHotSpot);
			_diverHotSpot.x=940;
			_diverHotSpot.y=280;
			_diverHotSpot.addEventListener(MouseEvent.CLICK,onDiverClick);
			addChild(_touchHere);
			_touchHere.x=_diverHotSpot.x+_diverHotSpot.width/2;
			_touchHere.y=_diverHotSpot.y+_diverHotSpot.height/2;
			
		}
		
		
		
		private function onDiverClick(e:MouseEvent):void{
			_touchHere.deActivate();
			if(_diver.y==320){
				_diver.y=239;
				_soundPlayerDiverUp.play();
			}else{
				_diver.y=320;
				_soundPlayerDiverDown.play();
			}
		}
		
		private function addMasks():void{
			
			_clickableMasks.push(addChild(new ClickableMask("F18_1024x768_man1_x610_y293.png",610,293,"F18_1024x768_man1_hotspot_x616_y355.png",616,355,"BEN-GURION GETS COLOR.mp3",_hotSpotLayer)))
			_clickableMasks.push(addChild(new ClickableMask("F18_1024x768_woman1_x0_y10.png",0,10,"F18_1024x768_woman1_hotspot_x0_y0.png",0,0,"ARTIK LADY GETS COLOR.mp3",_hotSpotLayer)))
			_clickableMasks.push(addChild(new ClickableMask("F18_1024x768_woman2_x307_y38.png",307,38,"F18_1024x768_woman2_hotspot_x313_y37.png",313,37,"BLACK LADY GETS COLOR.mp3",_hotSpotLayer)))
			_clickableMasks.push(addChild(new ClickableMask("F18_1024x768_man3_x65_y355.png",65,355,"F18_1024x768_man3_hotspot_x199_y403.png",199,403,"RUNNING MAN GETS COLOR.mp3",_hotSpotLayer)))
			_clickableMasks.push(addChild(new ClickableMask("F18_1024x768_legs_x891_y506.png",891,506,"F18_1024x768_legs_hotspot_x919_y510.png",919,510,"LEGS GET COLOR.mp3",_hotSpotLayer)))
			var man2:ClickableMask=new ClickableMask("F18_1024x768_man2_x656_y0.png",656,0,"F18_1024x768_man2_hotspot1_x661_y0.png",661,0,"TOWEL GETS COLOR.mp3",_hotSpotLayer);
			addChild(man2);
			_clickableMasks.push(man2);
			man2.addClickHotSpot("F18_1024x768_man2_hotspot2_x795_y278.png",795,278);
			addChild(_hotSpotLayer);
			
		}
	}
	
	
}
import com.gskinner.motion.GTween;
import com.utils.AssetsManager;
import com.utils.SoundPlayer;
import com.utils.TouchHere;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

class ClickableMask extends Sprite{
	private var _mask:DisplayObject;
	private var _soundPlayer:SoundPlayer;
	private var _hotSpotLayer:Sprite;
	private var _clickSpot:Sprite;
	private var _touchHere:TouchHere = new TouchHere();
	public function ClickableMask(mask:String,mx:int,my:int,hotSpot:String,hx:int,hy:int,soundFile:String,hotSpotLayer:Sprite):void{
		_mask = AssetsManager.getAssetByName(mask);
		_hotSpotLayer=hotSpotLayer;
		addChild(_mask);
		_mask.x=mx;
		_mask.y=my;
		_clickSpot = new Sprite();
		_clickSpot.addChild(AssetsManager.getAssetByName(hotSpot));
		_hotSpotLayer.addChild(_clickSpot);
		_clickSpot.x=hx;
		_clickSpot.y=hy;
		_clickSpot.addEventListener(MouseEvent.CLICK,onClick);
		addChild(_touchHere)
		_touchHere.x=hx+_clickSpot.width/2;
		_touchHere.y=hy+_clickSpot.height/2;
		_touchHere.activate();
		_soundPlayer = new SoundPlayer(soundFile);
	}
	
	public function reset():void{
		_mask.alpha=1;
		_clickSpot.addEventListener(MouseEvent.CLICK,onClick);
		_touchHere.activate();
	}
	
	public function stop():void{
		_clickSpot.removeEventListener(MouseEvent.CLICK,onClick);
		_touchHere.deActivate();
	}
	
	public function addClickHotSpot(hotSpot:String,xx:int,yy:int):void{
		var clickSpot:Sprite = new Sprite();
		clickSpot.addChild(AssetsManager.getAssetByName(hotSpot));
		_hotSpotLayer.addChild(clickSpot);
		clickSpot.x=xx;
		clickSpot.y=yy;
		clickSpot.addEventListener(MouseEvent.CLICK,onClick);
	}
	
	private function onClick(e:MouseEvent):void{
		_clickSpot.removeEventListener(MouseEvent.CLICK,onClick);
		new GTween(_mask,0.25,{alpha:0});
		_soundPlayer.play();
		_touchHere.deActivate();
	}
}