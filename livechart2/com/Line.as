import LineGraphData;
class Line
{
	private var Graph:MovieClip;
	private var Data:LineGraphData;
	
	function Line(target:MovieClip)
	{
		Graph = target;
		this.Data = new LineGraphData();
	}
	public function LoadDataStatus():Boolean
	{
		return this.Data.LoadDataStatus();
	}
	public function ClearLoadStatus():Void
	{
		this.Data.ClearLoadStatus();
	}
	public function ClearGraph():Void
	{
		Graph.clear();
	}
	public function DotYPosition(Data:Number,GraphHeight:Number):Number
	{
		if(Data<=0)
			return GraphHeight;
		else
			return (GraphHeight-((GraphHeight/(this.Data.getYscale())[5])*Data));

	}
	// ---------	DRAW FILLED circle, -----------	//
	//if argument styleMaker == 22.5 you get a full circle 
	//    66 makes a star like figure
	// usage :  fillCircle(radius,x,y,22.5)
	function fillCircle(r:Number,x:Number,y:Number,color:Number,target:MovieClip)
	{
		var styleMaker:Number = 22.5;
		target.moveTo(x+r,y);
		target.lineStyle(1,color);
		target.beginFill(color,100);
		var style:Number = Math.tan(styleMaker*Math.PI/180);
		for (var angle:Number=45;angle<=360;angle+=45)
		{
			var endX:Number = r * Math.cos(angle*Math.PI/180);
			var endY:Number = r * Math.sin(angle*Math.PI/180);
			var cX:Number   = endX + r* style * Math.cos((angle-90)*Math.PI/180);
			var cY:Number   = endY + r* style * Math.sin((angle-90)*Math.PI/180);
			target.curveTo(cX+x,cY+y,endX+x,endY+y);
		}
		target.endFill();
	}
	public function DrawCross(x:Number,y:Number,color:Number,target:MovieClip):Void
	{
		target.lineStyle(1,color,100);
		target.moveTo(x-5,y-5);
		target.lineTo(x+5,y+5);
		target.moveTo(x-5,y+5);
		target.lineTo(x+5,y-5);
		target.moveTo(x,y);
	}
	public function UpdateData(xml:String):Void
	{
		this.Data.xmlLoad(xml);
	}
	public function UpdateGraph(target:MovieClip):Void
	{
		//remove old graph
		target.clear();
		target.GraphLine.clear();
		target.GraphBody.clear();
		target.error.removeTextField();
		for(var i=0;i<50;i++)
		{
			target["Detail"+i].removeTextField();
		}
		
		//update graph
		var x;
		var y;
		var Depth = 1;
		
		target._x = 0;
		target._y = 0;
		
		//graph body variables
		var GraphX 			= 105;
		var GraphY 			= 80;
		var FixGraphWidth 	= 350;
		
		if(FixGraphWidth%this.Data.getDataNo()>0)
			var GraphWidth		= FixGraphWidth + (this.Data.getDataNo() - (FixGraphWidth%this.Data.getDataNo()));
		else
			var GraphWidth = FixGraphWidth;
			
		var FixGraphHeight 	= 250;
		var GraphHeight		= FixGraphHeight + (5 - (FixGraphHeight%5));
		
		//graph header variables
		var HeaderX 	= GraphX;
		var HeaderY 	= GraphY - 65;
		var HeaderWidth = GraphWidth;
		var HeaderHeight= 31;
		
		//y axis's name variables
		var YTagHeight 	= 20;
		var YTagWidth 	= 114;
		var YTagX 		= GraphX - (YTagWidth/2);
		var YTagY 		= GraphY - (YTagHeight + 10);
		
		//x axis's name variables
		var XTagHeight	= 20;
		var XTagWidth	= 114;
		var XTagX		= GraphX + GraphWidth+5;
		var XTagY		= GraphY + GraphHeight - (XTagHeight/2);
		
		//y tag's variables
		var YHeight = 16;
		var YWidth 	= 90;
		var Yx 		= GraphX - YWidth - 5;
		var Yy 		= GraphY + GraphHeight - (YHeight/2);
		
		//detail box variable
		var DBX			= GraphX + GraphWidth + 15;
		var DBY			= GraphY;
		var DBWidth		= 150
		var DBHeight	= (30*this.Data.getDataSetAmount())+10;
		
		var fillType = "linear";
		var colors = [0x000000, 0x000000];
		var alphas = [30,0];
		var ratios = [0, 255];
		var matrix = {matrixType:"box", x:105, y:80, w:350, h:250, r:90/180*Math.PI};
		//draw graph body
		target.createEmptyMovieClip("GraphBody",Depth++);
		target.GraphBody._x = GraphX;
		target.GraphBody._y = GraphY;
		target.GraphBody.moveTo(0,0);
		target.GraphBody.lineStyle(2,0,100);
		target.GraphBody.beginGradientFill(fillType, colors, alphas, ratios, matrix);
		target.GraphBody.lineTo(0,GraphHeight);
		target.GraphBody.lineTo(GraphWidth,GraphHeight);
		target.GraphBody.lineTo(GraphWidth,0);
		target.GraphBody.lineTo(0,0);
		target.GraphBody.endFill();
		
		//draw grid line
		for(i=0;i<4;i++)
		{
			target.GraphBody.moveTo(0,(i+1)*(GraphHeight/5));
			target.GraphBody.lineStyle(1,0,10);
			target.GraphBody.lineTo(GraphWidth,(i+1)*(GraphHeight/5));
		}
		
		target.createEmptyMovieClip("GraphLine",Depth++);
		target.GraphLine._x = GraphX;
		target.GraphLine._y = GraphY;
		
		//draw header
		target.createTextField("Header",Depth++,HeaderX,HeaderY,HeaderWidth,HeaderHeight);
		target.Header.text = this.Data.getHeader();
		var myformat   = new TextFormat();
		myformat.size  = 22;
		myformat.align = "center";
		myformat.bold  = true;
		target.Header.setTextFormat(myformat);
		
		//draw axis detail
		var myformat = new TextFormat();
		for (i=0; i<6; i++) 
		{
			target.createTextField("Y_"+i, Depth++, Yx, Yy - i*(GraphHeight/5), YWidth, YHeight);
			target["Y_"+i].text = (this.Data.getYscale())[i];
			myformat.size = 10;
			myformat.align = "right";
			target["Y_"+i].setTextFormat(myformat);
		}
		
		//draw y's axis name
		target.createTextField("Y_name",Depth++,YTagX,YTagY,YTagWidth,YTagHeight);
		target["Y_name"].text 	= this.Data.getYname();
		myformat.size 			= 10;
		myformat.align 			= "center";
		target["Y_name"].setTextFormat(myformat);
		
		//draw x's axis name
		target.createTextField("X_name",Depth++,XTagX,XTagY,XTagWidth,XTagHeight);
		target["X_name"].text 	= this.Data.getXname();
		myformat.size 			= 10;
		myformat.align 			= "left";
		target["X_name"].setTextFormat(myformat);
		
		//draw detail box
		if (this.Data.getDataSetAmount()>0) 
		{
			target.createEmptyMovieClip("DetailBox", Depth++);
			target.DetailBox._x = DBX;
			target.DetailBox._y = DBY;
			/*target.DetailBox.moveTo(0, 0);
			target.DetailBox.lineStyle(1, 0, 80);
			target.DetailBox.lineTo(0, DBHeight);
			target.DetailBox.lineTo(DBWidth, DBHeight);
			target.DetailBox.lineTo(DBWidth, 0);
			target.DetailBox.lineTo(0, 0);*/
			for (var i=0; i<this.Data.getDataSetAmount(); i++) 
			{
				//draw color detail box
				fillType = "linear";
				colors = [(this.Data.getDataColor())[i], (this.Data.getDataColor())[i]];
				alphas = [80, 50];
				ratios = [0, 255];
				matrix = {matrixType:"box", x:10, y:10+(30*i), w:20, h:20, r:0/180*Math.PI};
				target.DetailBox.beginGradientFill(fillType, colors, alphas, ratios, matrix);
				target.DetailBox.lineStyle(1, (this.Data.getDataColor())[i], 80);
				target.DetailBox.moveTo(10, 10+(30*i));
				target.DetailBox.lineTo(10, 30+(30*i));
				target.DetailBox.lineTo(30, 30+(30*i));
				target.DetailBox.lineTo(30, 10+(30*i));
				target.Detailbox.lineTo(10, 10+(30*i));
				target.Detailbox.endFill();
				//draw line name
				target.DetailBox.createTextField("Detail"+i, Depth++, 35, 10+(30*i), 100, 20);
				target.DetailBox["Detail"+i].text = (this.Data.getDataSetNames())[i];
				myformat.size = 14;
				myformat.align = "left";
				target.DetailBox["Detail"+i].setTextFormat(myformat);
			}
		}
		
		//draw line
		for(var i=0;i<this.Data.getDataSetAmount();i++)
		{
			//go to first point of each data set
			x = 0; y = DotYPosition((this.Data.getDataValue())[i][0],GraphHeight);
			target.GraphLine.moveTo(x,y);
			
			target.GraphLine.lineStyle(0,(this.Data.getDataColor())[i],100);	
			//draw the remainning
			for(var j=0;j<this.Data.getDataNo();j++)
			{
				//draw point and line
				x = j*(GraphWidth/(this.Data.getDataNo()-1));	y = DotYPosition((this.Data.getDataValue())[i][j],GraphHeight);
				target.GraphLine.lineTo(x,y);
			}
		}
	}
}