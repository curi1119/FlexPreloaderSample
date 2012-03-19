package org.curi {

  import flash.events.Event;
  import flash.events.ProgressEvent;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.utils.getTimer;

  import mx.events.RSLEvent;
  import mx.preloaders.*;
  import mx.preloaders.SparkDownloadProgressBar;

  public class CustomPreloader extends SparkDownloadProgressBar{
    [Embed(source="/assets/wait.png")]
    [Bindable]
    public var backgroundImg:Class;

    private var _initProgressCount:int = 0;

    private var _titleTxF:TextField;
    private var _statusTxF:TextField;

    public function CustomPreloader() {
      trace('const');
      super();
    }

    override protected function showDisplayForInit(elapsedTime:int, count:int):Boolean {
      return true;
    }

    override protected function showDisplayForDownloading(elapsedTime:int, event:ProgressEvent):Boolean {
      return true;
    }

    override public function initialize():void{
      trace('initialize');
      this.stageWidth = 800;
      this.stageHeight = 600;

      this.backgroundImage = backgroundImg;
      this.backgroundSize = '100%';

      _titleTxF       = addChild(new TextField) as TextField;
      _titleTxF.x = 100;
      _titleTxF.y = 100;
      _titleTxF.width = 500;
      _titleTxF.defaultTextFormat = new TextFormat(null, 32, 0xFFFFFF);
      _titleTxF.text = 'title';

      _statusTxF = addChild(new TextField) as TextField;
      _statusTxF.x = 150;
      _statusTxF.y = 140;
      _statusTxF.width = 500;
      _statusTxF.defaultTextFormat = new TextFormat(null, 24, 0xFFFFFF);
      _statusTxF.text = 'loaded';
    }


    override protected function progressHandler(e:ProgressEvent):void {
       trace('progressHandler');
      _titleTxF.text = 'Downloading......';

      var loadedBytes:int = e.bytesLoaded;
      var totalBytes:int = e.bytesTotal;
      trace(loadedBytes);
      trace(totalBytes);
      var status:String = loadedBytes.toString() + " / " + totalBytes.toString();
      _statusTxF.text = status;
    }

    override protected function completeHandler(event:Event):void{
      trace('completeHandler');
      createChildren();
    }

    //Flex initialize
    override protected function initProgressHandler(e:Event):void {
      trace('initProgressHandler');
      _titleTxF.text = 'Initializing......';
      _initProgressCount++;
      var status:String = _initProgressCount.toString();
      _statusTxF.text = status;
    }

    override protected function initCompleteHandler(event:Event):void{
      trace('initCompleteHandler');
      dispatchEvent(new Event(Event.COMPLETE));
    }
  }

}