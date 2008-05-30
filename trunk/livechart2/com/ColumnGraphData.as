import mx.utils.Delegate;
import Data;
class ColumnGraphData extends Data{
	private var Xname:String;
	private var Yname:String;
	private var Yscale:Array;
	private var DataTag:Array;
	
	function ColumnGraphData()
	{
		DataNo 			= new Number(1);
		SourceType		= new String("");
		SourceURL		= new String("");
		Header			= new String("");
		Xname			= new String("");
		Yname			= new String("");
		Yscale			= new Array(6);
		xml 			= new XML();
		xmlLoadedStatus   = new Boolean(false);
		for(var i=0;i<6;i++)
		{
			Yscale[i] = new Number(i * (100 / 5));
		}
		DataSetAmount 	= new Number(0);
		
	}
	public function getXname():String
	{
		return Xname;
	}
	public function getYname():String
	{
		return Yname;
	}
	public function getYscale():Array
	{
		return Yscale;
	}
	public function xmlLoad( xml_str : String ):Void 
	{
        // the object you receive is a STRING
        //so it needs to be parsed first
		var xml : XML = new XML();
		xml.ignoreWhite = true;
		xml.parseXML( xml_str );
		var GHeader:String 			= new String("");
		var GXname:String 			= new String("");
		var GYname:String 			= new String("");
		var GDataSetAmount:Number 	= new Number(0);

		//get root node and graph attributes
		var root = xml.firstChild;
		GHeader			= root.attributes.caption;
		GXname 			= root.attributes.xAxisName;
		GYname 			= root.attributes.yAxisName;
		GDataSetAmount  = root.childNodes.length;
		
		var GDataSetNames:Array 	= new Array(GDataSetAmount);
		var GDataColor:Array 		= new Array(GDataSetAmount);
		var GDataValue:Array 		= new Array(GDataSetAmount);
		//get set of data
		for(var i=0;i<root.childNodes.length;i+=1)
		{
			//get data description
			var node		= root.childNodes[i];
			GDataSetNames[i]	= node.attributes.label;
			GDataValue[i] 		= new Number(node.attributes.value);
			GDataColor[i] 		= node.attributes.color;
			//if user not define color, use default color, black.
			if(node.attributes.color == null)
				GDataColor[i] = 0;
			else
				GDataColor[i] = node.attributes.color;
		}

		//dynamic data variable
		DataSetNames 	= new Array(GDataSetAmount);
		DataColor 		= new Array(GDataSetAmount);
		DataValue 		= new Array(GDataSetAmount);
		for(var i=0;i<GDataSetAmount;i++)
		{
			DataSetNames[i] = "";
			DataColor[i] 	= 0;
			DataValue[i] 	= new Array(DataNo);
			for(var j=0;j<DataNo;j++)
			{
				DataValue[i][j] = new Number(0);
			}
		}
		
		//set graph variable with new data
		DataSetAmount 	= new Number(0);
		Header			= GHeader;
		Xname			= GXname;
		Yname			= GYname;
		DataSetNames	= GDataSetNames;
		DataColor		= GDataColor;
		DataSetAmount 	= GDataSetAmount;

		//Append new data 
		for(i=0;i<GDataSetAmount;i++)
		{
				DataValue[i][0] = GDataValue[i];
		}
		
		for(i=0;i<DataNo;i++)
			trace(DataValue[i]);
			
		//calculate Y's axis scale
		var NewMaxData:Number = new Number(FindMax());
		
		if(NewMaxData >= Yscale[5])
		{
			NewMaxData = NewMaxData + (5-(NewMaxData%5));
			NewMaxData = NewMaxData + (NewMaxData / 5);
			NewMaxData = NewMaxData - (NewMaxData%5);
			
			for(i=0;i<6;i++)
			{
				Yscale[i] = i * (NewMaxData / 5);
			}
		}
		else if(NewMaxData<Number(Yscale[4]))
		{
			var temp:Number = new Number(Yscale[4]);
			if(NewMaxData<100)
			{
				temp = 100;
			}
			else
			{
				temp = temp + (5 - (temp % 5));
			}
			for(i=0;i<6;i++)
			{
				Yscale[i] = i * (temp/ 5);
			}
			
		}
		xmlLoadedStatus = true;
   	}
}