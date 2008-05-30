import mx.utils.Delegate;
import Data;
class PieGraphData extends Data{
	
	private var DataTag:Array;
	
	function PieGraphData()
	{
		SourceType		= new String("");
		SourceURL		= new String("");
		Header			= new String("");
		xml 			= new XML();
		xmlLoadedStatus   = new Boolean(false);
		DataNo			= new Number(1);
		DataSetAmount 	= new Number(0);
	}
	public function xmlLoaded( xml_str : String ):Void 
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
		
		//set dynamic variable
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
		Header			= GHeader;
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

		xmlLoadedStatus = true;
   	}

	public function GetData(url:String):Void
	{
		var unique=new Date().getTime() //will always be unique
		xmlLoadedStatus = false;
		var xmlObject:XML = new XML();
			xmlObject.ignoreWhite = true;
			xmlObject.load(url+'?unique='+unique);//sending url request
			xmlObject.onData = Delegate.create(this, xmlLoaded);
   	}

}