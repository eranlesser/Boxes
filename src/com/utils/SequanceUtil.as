package com.utils
{
	import flash.display.DisplayObject;

	public class SequanceUtil
	{
		public function SequanceUtil()
		{
		}
		
		public static function createSequanceVector2(start:uint,end:uint,fileName:String,ending:String,skip:uint=1):Vector.<DisplayObject>{
			var sequance:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			var slicedFileName:String;
			for(var i:uint=start;i<=end;i=i+skip){
				slicedFileName = fileName;
				var fileCounter:String=i.toString();
				if(fileCounter.length==1){
					fileCounter="0"+fileCounter;
				}
				sequance.push(AssetsManager.getAssetByName(slicedFileName+fileCounter+ending))
			}
			return sequance;
		}
		
		public static function createSequanceVector(start:uint,end:uint,fileName:String,ending:String,skip:uint=1):Vector.<DisplayObject>{
			var sequance:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			var slicedFileName:String;
			for(var i:uint=start;i<=end;i=i+skip){
				slicedFileName = fileName;
				sequance.push(AssetsManager.getAssetByName(slicedFileName+i.toString()+ending))
			}
			return sequance;
		}
		
		public static function createStringVector(start:uint,end:uint,fileName:String,ending:String,skip:uint=1):Vector.<String>{
			var sequance:Vector.<String> = new Vector.<String>();
			var slicedFileName:String;
			for(var i:uint=start;i<=end;i=i+skip){
				slicedFileName = fileName;
				sequance.push(slicedFileName+i.toString()+ending)
			}
			return sequance;
		}
	}
}