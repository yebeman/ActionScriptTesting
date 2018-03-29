package com
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;

	public class Upload extends MovieClip
	{
		private var _main:MovieClip;

		public var file:FileReference;


		public function Upload(fla:MovieClip,f:FileReference,str:String)
		{
			_main = fla;
			file = f;
			addListeners(file);
			var variables_re:URLVariables = new URLVariables();
	
			_main.UPLOAD_URL.method = URLRequestMethod.POST;
			_main.UPLOAD_URL.data = variables_re;
			variables_re.folderName = str;
			var varLoader_re:URLLoader = new URLLoader 
			varLoader_re.load(_main.UPLOAD_URL);
			file.upload(_main.UPLOAD_URL);
			trace(_main.UPLOAD_URL);
		}

		private function addListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(Event.CANCEL, cancelHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			dispatcher.addEventListener(Event.COMPLETE,completeHandler);
			dispatcher.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadCompleteDataHandler);
		}

		private function openHandler(event:Event):void
		{
			trace("OPEN HANDLER");
		}

		private function cancelHandler(event:Event):void
		{
			trace("CANCEL HANDLER");
		}

		private function progressHandler(event:ProgressEvent):void
		{
			_main.txt.text = "Uploading progress... " + Math.ceil(event.bytesLoaded / event.bytesTotal) * 100 + " %";
		}

		private function completeHandler(event:Event):void
		{
			trace("complete");
		}

		private function uploadCompleteDataHandler(event:Event):void
		{
			_main.txt.text = "Uploading Successfull";
			file.removeEventListener(Event.OPEN,openHandler);
			file.removeEventListener(ProgressEvent.PROGRESS,progressHandler);
			file.removeEventListener(Event.COMPLETE,completeHandler);
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadCompleteDataHandler);
			_main.uploadCompleted();
		}

	}
}