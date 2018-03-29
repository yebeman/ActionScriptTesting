package com
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.*;
	import flash.display.MovieClip;

	public class imgLoader extends MovieClip
	{
		var picLoader:Loader;
		var _main:MovieClip;
		var xPoss;
		var yPoss;
		public function imgLoader(fla:MovieClip,img:String,xPos,yPos)
		{
			this.xPoss=xPos;
			this.yPoss=yPos;
			_main = fla;
			picLoader= new Loader();
			var picImg:String = img;
			var picURLReq:URLRequest = new URLRequest(picImg);
			picLoader.load(picURLReq);
			picLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onPicProgress);
			picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadPicCompleted);

		}
		private function onPicProgress(e:Event):void
		{
			var temp:int = Math.ceil(e.target.bytesLoaded / e.target.bytesTotal) * 100;
			_main.txt.text = "Please wait downloading image.. " + temp + " %";
		}

		function loadPicCompleted(evt:Event):void
		{

			_main.clip_container.addChild(picLoader);
			if (_main.clip_container.numChildren > 2)
			{
				_main.clip_container.removeChildAt(1);
			}

			picLoader.x = this.xPoss;
			picLoader.y = this.yPoss;


			if (picLoader.width > 140)
			{
				picLoader.width = 140;
			}
			if (picLoader.height > 150)
			{
				picLoader.height = 150;
			}
			
			
			_main.txt.text = "";
			_main.txt.text="Uploading completed "
			_main.profilePic();//
			
		}
	}
}