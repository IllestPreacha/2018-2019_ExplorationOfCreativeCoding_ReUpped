SinOsc s => dac; // these are the sounds that will occur
Phasor p => dac;
500::ms => dur tempo;  // the tempo that it will work on

while(true)
{
    
tempo => now;
Std.rand2f(30.0,1000.0) => s.freq; // frequencies

slower();
}


fun void slower()
{
2*tempo => now;  // 
Std.rand2f(30.0,1000.0) => p.freq;   
    
}