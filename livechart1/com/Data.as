import mx.control.*;
import mx.utils.Delegate;
class Data{
	
	//private var Initialed:Boolean;
	private var SourceType:String;
	private var SourceURL:String;
	private var Header:String;
	private var DataSetNames:Array;
	private var DataColor:Array;
	private var DataValue:Array;
	private var DataSetAmount:Number;
	private var DataNo:Number;
	private var xml:XML;
	private var xmlLoadedStatus:Boolean;
	
	function Data()
	{
	}
	public function setDataNo(DN:Number):Void
	{
		DataNo = DN;
	}
	public function getDataNo():Number
	{
		return DataNo;
	}
	public function setHeader(inHeader:String)
	{
		Header = inHeader;
	}
	public function getHeader():String
	{
		return Header;
	}
	public function getDataSetNames():Array
	{
		return DataSetNames;
	}
	public function getDataColor():Array
	{
		return DataColor;
	}
	public function getDataValue():Array
	{
		return DataValue;
	}
	public function getDataSetAmount():Number
	{
		return DataSetAmount;
	}	
	public function SetDataSource(type:String, url:String)
	{
		SourceType = type;
		SourceURL  = url;
	}
	
	public function LoadDataStatus():Boolean
	{
		return xmlLoadedStatus;
	}
	
	public function ClearLoadStatus():Void
	{
		xmlLoadedStatus = false;
	}

	public function FindMax():Number
	{
		var Max:Number = 0;
		for(var i=0;i<DataSetAmount;i++)
		{
			for(var j=0;j<DataNo;j++)
			{
				if(Number(DataValue[i][j])>Max)
					Max = DataValue[i][j];
			}
		}
		return Max;
	}
	
	public function FindMin():Number
	{
		var Min:Number = new Number(0);
		Min = DataValue[0][0];
		for(var i=0;i<DataSetAmount;i++)
		{
			for(var j=0;j<DataNo;j++)
			{
				if(Min>DataValue[i][j])
					Min = DataValue[i][j];
			}
		}
		return Min;
	}
}