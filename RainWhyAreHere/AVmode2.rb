# Used in Collobration with Processing to make the Nominated Short Film : Rain why are you here 

with_fx :echo do
  use_bpm 80
  live_loop :os do
    nv=sync "/osc/notesend" #for Sonic PI 3 and later
    #puts nv #uncomment and comment next line to see OSC input
    #scale the mx and my values in nv[0] and nv[1] appropriately
    #raw mx 124(left)-516(right) and raw my 124 (top)-236(bottom
    use_synth [:tb303,:pretty_bell].tick
    puts (40+(nv[0]-124)/392*60).to_i.to_s+" "+(190-nv[1]/2).to_s
    play (40+(nv[1]-124)/392*60).to_i,cutoff: (190-nv[1]/2),sustain: 0.04,release: 0.01
    sleep [0.1,1,2].choose
  end
end

with_fx :ixi_techno do
  use_bpm 100
  live_loop :os1 do
    nv=sync "/osc/notesend" #for Sonic PI 3 and later
    #puts nv #uncomment and comment next line to see OSC input
    #scale the mx and my values in nv[0] and nv[1] appropriately
    #raw mx 124(left)-516(right) and raw my 124 (top)-236(bottom
    use_synth [:tb303,:pretty_bell,:prophet].tick
    puts (40+(nv[0]-124)/392*60).to_i.to_s+" "+(190-nv[1]/2).to_s
    play (40+(nv[1]-124)/392*60).to_i,cutoff: (190-nv[1]/2),amp: dice(2),pitch: 4
    sleep [0.3,0.4,0.5].choose
  end
end


live_loop :os2 do
  nv=sync "/osc/notesend" #for Sonic PI 3 and later
  #puts nv #uncomment and comment next line to see OSC input
  #scale the mx and my values in nv[0] and nv[1] appropriately
  #raw mx 124(left)-516(right) and raw my 124 (top)-236(bottom
  use_synth [:tb303,:pretty_bell].tick
  puts (40+(nv[1]-124)/392*60).to_i.to_s+" "+(190-nv[1]/2).to_s
  play (40+(nv[1]-124)/392*60).to_i,cutoff: (190-nv[1]/2),amp: dice(2),pitch: 4
  sleep [0.5,0.3,0.4].choose
end
