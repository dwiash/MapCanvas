package com.MajuJaya.Graphic
{
	import mx.flash.UIMovieClip;
	import flash.display.MovieClip;

	public dynamic class Edge extends UIMovieClip
	{
		public var weight:int;
		public var coordinate:String;
		public var selected:Boolean = false;
		
		
		public function Edge(edgeName:String, edgeCoordinate:String, edgeWeight:int)
		{
			super();
			
			this.name = edgeName;
			coordinate = edgeCoordinate;
			weight = edgeWeight;
			
			drawEdge();
			
		}
		
		private function drawEdge():void {

			var Coor:Array=coordinate.split(";");
			var CoorItem:String;
			var edgeLine:MovieClip = new MovieClip();
			
			edgeLine.graphics.lineStyle(4);
			
			for (var i:int=0; i<Coor.length; i++) {
				
				CoorItem=Coor[i];
				
				var co:Array=CoorItem.split(",");
				
				if (i==0) {
					edgeLine.graphics.moveTo(co[0], co[1]);
				} else {
					edgeLine.graphics.lineTo(co[0], co[1]);
				}
				
			}
			
			addChild(edgeLine);		
			
		}
		
	}
}
