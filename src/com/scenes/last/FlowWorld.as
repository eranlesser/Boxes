package com.scenes.last 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.b2Body;
	
	import com.constants.Dimentions;
	import com.gskinner.motion.GTween;
	import com.utils.AssetsManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class FlowWorld extends World
	{
		
		private var _man:Sprite;
		private var _cat:Sprite;
		private var _manBut:Sprite;
		private var _manContainer:Sprite;
		private var _catContainer:Sprite;
		private var _manBody:b2Body;
		private var _catBody:b2Body;
		private var _manAngleTweener:GTween;
		
		override protected function setup():void
		{
			addAssets();
			_manBody = createBox(0, 230,100, 80);
			_catBody = createBox(-300, 330,80, 50);
			var distanceJointDef:b2DistanceJointDef = new b2DistanceJointDef();  
			distanceJointDef.Initialize(_manBody, _catBody, _manBody.GetWorldCenter(), _catBody.GetWorldCenter());
			_world.CreateJoint(distanceJointDef);
		}
		
		override protected function update(e:Event):void{
			super.update(e);
			drawBody();
			
		}
		
		protected function drawBody():void
		{
			
			if(_manBody.GetPosition().x * PIXELS_TO_METRE<0){
				_manBody.SetPosition(new b2Vec2(0,_manBody.GetPosition().y))
			}
			if(_manBody.GetPosition().x * PIXELS_TO_METRE>Dimentions.WIDTH){
				_manBody.SetPosition(new b2Vec2(Dimentions.WIDTH/PIXELS_TO_METRE,(_manBody.GetPosition().y)))
			}
			if(_manBody.GetPosition().y * PIXELS_TO_METRE<0){
				_manBody.SetPosition(new b2Vec2(_manBody.GetPosition().x,0))
			}
			
			_manContainer.x = _manBody.GetWorldCenter().x * PIXELS_TO_METRE//-_manSkinTop.width/2;
			_manContainer.y = _manBody.GetWorldCenter().y * PIXELS_TO_METRE//-_manSkinTop.height/2;
			_manContainer.rotation = calculateRotation(new Point(_catContainer.x,_catContainer.y),new Point(_manContainer.x,_manContainer.y)) * (180 / Math.PI)-70-180;
			_catContainer.x = _catBody.GetWorldCenter().x * PIXELS_TO_METRE//-_catSkinTop.width/2;
			_catContainer.y = _catBody.GetWorldCenter().y * PIXELS_TO_METRE//-_catSkinTop.height/2;
			_catContainer.rotation = calculateRotation(new Point(_manContainer.x,_manContainer.y),new Point(_catContainer.x,_catContainer.y)) * (180 / Math.PI)-70;
			_manBut.rotation=_catContainer.rotation/14;
			
			//_manBut.y=-_manBut.rotation*2;
			//_manBut.x=-12//+_manBut.rotation*4;;
		}
		private function calculateRotation(point1:Point,point2:Point):Number{
			var dx:Number = point2.x - point1.x;
			var dy:Number = point2.y - point1.y;
			return -Math.atan2(dx,dy);
		}
		
		
		
		
		private function addAssets():void{
			_manContainer=new Sprite();
			var tempContainer:Sprite=new Sprite();
			var manUp:DisplayObject=AssetsManager.getAssetByName("F2_1024x768_man_upper_x-88_y230.png");
			_manBut=new Sprite();
			var manButAsset:DisplayObject=AssetsManager.getAssetByName("F2_1024x768_man_bottom_x-158_y324.png")
			_manBut.addChild(manButAsset);
			_manBut.graphics.beginFill(0x333333,0.6);
			_manBut.graphics.drawRect(25,25,50,50);
			tempContainer.addChild(_manBut);
			tempContainer.addChild(manUp);
			_manBut.x=90;
			_manBut.y=25;
			manButAsset.x=-manButAsset.width+25;
			manButAsset.y=-manButAsset.height/2+40;
			manUp.x=70;
			manUp.y=-94;
			_manContainer.addChild(tempContainer);
			tempContainer.x-=tempContainer.width/2;
			_catContainer=new Sprite();
			var tempCatContainer:Sprite=new Sprite();
			var tail:DisplayObject = AssetsManager.getAssetByName("F2_1024x768_cat_tail_x-388_y395.png")
			var catUp:DisplayObject=AssetsManager.getAssetByName("F2_1024x768_cat_body_x-319_y330.png");
			tempCatContainer.addChild(tail);
			tempCatContainer.addChild(catUp);
			catUp.x=69;
			catUp.y=-65;
			_catContainer.addChild(tempCatContainer);
			tempCatContainer.x-=tempCatContainer.width/2;
			addChild(_manContainer);
			addChild(_catContainer);
		}
	}
}