import javax.sound.sampled._

object EQHelper {
  def main2(args:Array[String]):Unit = {
	val data = sineWave16BitMono(96,0.8)
	val sdl = getLine
	try
	{
		for(_ <- 0 until 1000)
			sdl.write(data,0,data.length);
		
		sdl.start()
		
		for(_ <- 0 until 1000)
			sdl.write(data,0,data.length);
		
		sdl.drain()
		sdl.stop()
		sdl.flush()
	}
	finally
	{
		if(sdl.isOpen)
			sdl.close()
	}
  }
  
  def sineWave16BitMono(noSamples:Int,amp:Double): Array[Byte] = {
    import java.lang.Math.{PI,sin,round}
    import java.nio.{ByteBuffer,ShortBuffer,ByteOrder}
    
	val buf = ByteBuffer.allocate(noSamples*2)
	val totAmp = java.lang.Short.MAX_VALUE*amp;
	buf.order(ByteOrder.LITTLE_ENDIAN)
	
	for(i <- 0 until noSamples)
	{
	  val sample = round(sin(2*PI*i/noSamples)*totAmp).toShort
	  buf.putShort(sample)
	}	
	  
	buf.array
  }
  
  def getLine = {
  	val format     = new AudioFormat(44100,16,1,false,true)
	val mixerInfo  = AudioSystem.getMixerInfo()(0)
	val line       = AudioSystem.getSourceDataLine(format,mixerInfo)
	val lineInfo   = line.getLineInfo().asInstanceOf[DataLine.Info]
	line.open(format,lineInfo.getMinBufferSize)
	line
  }
}