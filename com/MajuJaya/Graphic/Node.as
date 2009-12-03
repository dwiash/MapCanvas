package com.MajuJaya.Graphic
{
  import mx.flash.UIMovieClip;
  import flash.display.MovieClip;
  import flash.events.MouseEvent;
  import mx.controls.Alert;

  public dynamic class Node extends UIMovieClip
  {
    public var selected:Boolean = false;
    public var ex:Number;
    public var ye:Number;
		
		
    public function Node(nodeName:String, xPos:Number, yPos:Number, type:int)
    {
      super();
      this.name = nodeName;
      this.x = xPos;
      this.y = yPos;
      drawNode(type);
    }
		
		
    private function drawNode(type:int):void
    {
      var circle:MovieClip = new MovieClip();
      
      if(type == 99){
        circle.graphics.lineStyle(1, 0xFFFFFF, 0);
        circle.graphics.beginFill(0xDF0055, 0.7);
        circle.graphics.drawCircle(0, 0, 10);
        circle.graphics.endFill();
        circle.buttonMode = false;
      }else if(type == 98){
        circle.graphics.lineStyle(1, 0xffffff, 0);
        circle.graphics.beginFill(0x0055DF, 0.7);
        circle.graphics.drawCircle(0, 0, 10);
        circle.graphics.endFill();
        circle.buttonMode = false;
      }else{
        circle.graphics.lineStyle(2);
        circle.graphics.beginFill(0xffffff);
        circle.graphics.drawCircle(0, 0, 4);
        circle.graphics.endFill();
        circle.buttonMode = true;
        circle.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
        circle.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
      }

      circle.useHandCursor = true;
      circle.name = name;
      addChild(circle);
      
    }
    
		
    private function onMouseOver(e:MouseEvent):void
    {
      this.alpha = 0.8;
    }


    private function onMouseOut(e:MouseEvent):void
    {
      this.alpha = 1;
    }

        
	}
	
	
}
