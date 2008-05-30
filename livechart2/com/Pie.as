import PieGraphData;
class Pie 
{
	
	private var Graph:MovieClip;
	private var Data:PieGraphData;
	
	function Pie(target:MovieClip) {
		Graph = target;
		this.Data = new PieGraphData();
	}
	public function LoadDataStatus():Boolean {
		return this.Data.LoadDataStatus();
	}
	public function ClearLoadStatus():Void {
		this.Data.ClearLoadStatus();
	}
	public function ClearGraph():Void {
		Graph.clear();
	}
	public function UpdateData(xml:String):Void {
		this.Data.xmlLoad(xml);
	}
	public function UpdateGraph(target:MovieClip):Void 
	{
		target.clear();
		target.GraphBody.clear();
		target.error.removeTextField();
		target.GraphPie.clear();
		
		for(var i=0;i<50;i++)
		{
			target.GraphPie["t_"+i].removeTextField();
			target.DetailBox["Detail"+i].removeTextField();
		}
		
		//graph body variables
		var GraphX 			= 105;
		var GraphY 			= 80;
		var GraphWidth 		= 350 
		var GraphHeight 	= 250;
		
		//graph header variables
		var HeaderX 	= GraphX;
		var HeaderY 	= GraphY - 65;
		var HeaderWidth = GraphWidth;
		var HeaderHeight= 31;
		
		//detail box variable
		var DBX			= GraphX + GraphWidth + 15;
		var DBY			= GraphY;
		var DBWidth		= 150
		var DBHeight	= (30*this.Data.getDataSetAmount())+10;
		
		var depth:Number= new Number(10000);
		var r:Number	= new Number(80);
		var cx:Number	= new Number(GraphWidth/2);
		var cy:Number	= new Number(GraphHeight/2);
		var sx:Number	= new Number(0);
		var sy:Number	= new Number(0);
		var ex:Number	= new Number(0);
		var ey:Number	= new Number(0);
		var j:Number	= new Number(0);
		var k:Number	= new Number(0);
		var sum:Number 	= new Number(0);
		var angle:Array = new Array(this.Data.getDataSetAmount()+1);
		var newx:Number = new Number(0);
		var newy:Number = new Number(0);
		var px:Number 	= new Number(0);
		var py:Number 	= new Number(0);
		var textwidth:Number	= new Number(100);
		var textheight:Number	= new Number(16);
		var myformat:TextFormat = new TextFormat();
		var boxx:Number = new Number(0);
		var boxy:Number = new Number(0);
		
		for(i=0;i<this.Data.getDataSetAmount();i++)
		{
			sum +=	Number((this.Data.getDataValue())[i][0]);
		}
		for(i=0;i<this.Data.getDataSetAmount();i++)
		{
			angle[i] = new Number(0);
		}
		for(i=1;i<this.Data.getDataSetAmount()+1;i++)
		{
			angle[i] = new Number(((this.Data.getDataValue())[i-1][0]/sum)*2*Math.PI);
		}
		for(i=1;i<this.Data.getDataSetAmount()+1;i++)
		{
			angle[i] += angle[i-1];
		}var Depth = 1;
		target._x = 0;
		target._y = 0;
		var fillType = "linear";
		var colors = [0xFFFFCC, 0xFFFFCC];
		var alphas = [100, 100];
		var ratios = [0, 255];
		var matrix = {matrixType:"box", x:105, y:80, w:350, h:250, r:90/180*Math.PI};
		
		//draw graph body
		target.createEmptyMovieClip("GraphBody", Depth++);
		target.GraphBody._x = GraphX;
		target.GraphBody._y = GraphY;
		target.GraphBody.moveTo(0, 0);
		target.GraphBody.lineStyle(0, 0, 0);
		target.GraphBody.beginGradientFill(fillType, colors, alphas, ratios, matrix);
		target.GraphBody.lineTo(0, GraphHeight);
		target.GraphBody.lineTo(GraphWidth, GraphHeight);
		target.GraphBody.lineTo(GraphWidth, 0);
		target.GraphBody.lineTo(0, 0);
		target.GraphBody.endFill();
		
		//draw header
		target.createTextField("Header", Depth++, HeaderX, HeaderY, HeaderWidth, HeaderHeight);
		target.Header.text = this.Data.getHeader();
		var myformat = new TextFormat();
		myformat.size = 22;
		myformat.align = "center";
		myformat.bold = true;
		target.Header.setTextFormat(myformat);
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
					
		//draw pie
		target.createEmptyMovieClip("GraphPie", Depth++);
		target.GraphPie._x = GraphX;
		target.GraphPie._y = GraphY;
		for(k=0;k<this.Data.getDataSetAmount()+1;k++)
		{
			px = cx + (5+r)*Math.cos(((angle[k+1]-angle[k])/2)+angle[k]);
			py = cy + (5+r)*Math.sin(((angle[k+1]-angle[k])/2)+angle[k]);
			target.GraphPie.moveTo(cx,cy);
			
			target.GraphPie.lineStyle(0, 0, 0);
			target.GraphPie.beginFill((this.Data.getDataColor())[k]);
			
			for(i=angle[k],j=angle[k];i<angle[k+1];i+=0.001)
			{
				sx = r*Math.cos(j);
				sy = r*Math.sin(j);
				ex = r*Math.cos(i);
				ey = r*Math.sin(i);
				target.GraphPie.curveTo(cx+sx, cy+sy, cx+ex, cy+ey);
				j=i;
			}
			target.GraphPie.lineTo(cx,cy);
			target.GraphPie.endFill();
			
			target.GraphPie.moveTo(px,py);
			target.GraphPie.lineStyle(1, 0x000000, 100);
			target.GraphPie.lineTo(px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k]),py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k]));
			
			//draw text box on each section
			
			if(k<this.Data.getDataSetAmount())
			{
				if( (
					 ( (((angle[k+1]-angle[k])/2)+angle[k]) > (7*Math.PI)/4 ) &&
					 ( (((angle[k+1]-angle[k])/2)+angle[k]) <= 2*Math.PI ) 
					) ||
					( 
					 ( (((angle[k+1]-angle[k])/2)+angle[k]) >= 0 ) &&
					 ( (((angle[k+1]-angle[k])/2)+angle[k]) < Math.PI/4 ) 
					)
				  ) 
				{	
					boxx = px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k]);
					boxy = py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k])-(textheight/2);
					myformat.align = "left";
				}
				
				else if((((angle[k+1]-angle[k])/2)+angle[k])==Math.PI/4)
				{	
					boxx = px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k]);	
					boxy = py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k]);
					myformat.align = "left";
				}
				else if((((angle[k+1]-angle[k])/2)+angle[k])>Math.PI/4 && (((angle[k+1]-angle[k])/2)+angle[k])<(3*Math.PI)/4)
				{
					boxx = px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k])-(textwidth/2);
					boxy = py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k]);
					myformat.align = "center";
				}
				else if((((angle[k+1]-angle[k])/2)+angle[k])==(3*Math.PI)/4)
				{
					boxx = px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k])-textwidth;
					boxy = py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k]);
					myformat.align = "right";
				}
				else if((((angle[k+1]-angle[k])/2)+angle[k])>(3*Math.PI)/4 && (((angle[k+1]-angle[k])/2)+angle[k])<(5*Math.PI)/4)
				{	
					boxx = px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k])-textwidth;	
					boxy = py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k])-(textheight/2);	
					myformat.align = "right";
				}
				else if((((angle[k+1]-angle[k])/2)+angle[k])==(5*Math.PI)/4)
				{
					boxx = px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k])-textwidth;
					boxy = py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k])-textheight;
					myformat.align = "right";
				}
				else if((((angle[k+1]-angle[k])/2)+angle[k])>(5*Math.PI)/4 && (((angle[k+1]-angle[k])/2)+angle[k])<(7*Math.PI)/4)
				{	
					boxx = px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k])-(textwidth/2);
					boxy = py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k])-textheight;	
					myformat.align = "center";
				}
				else if((((angle[k+1]-angle[k])/2)+angle[k])==(7*Math.PI)/4)
				{	
					boxx = px+15*Math.cos(((angle[k+1]-angle[k])/2)+angle[k]);
					boxy = py+15*Math.sin(((angle[k+1]-angle[k])/2)+angle[k])-textheight;
					myformat.align = "left";
				}
				myformat.size  = 12;
				target.GraphPie.createTextField("t_"+(k+1),depth++,boxx,boxy,textwidth,textheight);
				//target["t_"+(k+1)].border = true;
				target.GraphPie["t_"+(k+1)].text	= (this.Data.getDataValue())[k][0];
				target.GraphPie["t_"+(k+1)].setTextFormat(myformat);
			}
		}	
	}
}
