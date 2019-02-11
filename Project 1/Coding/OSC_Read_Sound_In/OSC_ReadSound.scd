
(
~ampFast1 = Bus.control;
~ampSlow1 = Bus.control;
~midiNum1 = Bus.control;
~beatTrack = Bus.control;
~ampFast2 = Bus.control;
~ampSlow2 = Bus.control;
~midiNum2 = Bus.control;




SynthDef(\micAnalysis, {
	arg inputChan1 = 0, inputChan2 = 1, outBus = 8;
	var micIn1, amplitudeFast, amplitudeSlow, freq, hasFreq,  chain, onsets,
	    micIn2, amplitudeFast2, amplitudeSlow2, freq2, hasFreq2, chain2, onsets2,
	    trackb, tempo;



	micIn1 = SoundIn.ar(inputChan1);

	micIn2 = SoundIn.ar(inputChan2);

	///////////////////////
	// FIRST MIC ANALYSIS//
	/////////////////////////
	amplitudeFast = Amplitude.kr(micIn1, attackTime: 0.01, releaseTime: 0.01);
	// amplitudeFast.poll(label: \ampVal_Fast);
	Out.kr(~ampFast1, amplitudeFast);

	amplitudeSlow = Amplitude.kr(micIn1, attackTime: 1, releaseTime: 1);
	// amplitudeSlow.poll(label: \ampVal_Slow);
	Out.kr(~ampSlow1, amplitudeSlow);

	# freq, hasFreq = Pitch.kr(micIn1, ampThreshold: 0.02, median: 7);
	// freq.poll(label: \freqHz);
	// freq.cpsmidi.poll(label: \freqMIDI);
	// hasFreq.poll(label: \freqConfidence);
	Out.kr(~midiNum1, freq.cpsmidi);

	tempo = BeatTrack.kr(FFT(LocalBuf(1024),micIn1));
	tempo.poll;
	Out.kr(~beatTrack, tempo);



	chain = FFT(LocalBuf(512), micIn1);
    onsets = Onsets.kr(chain, 0.9, \rcomplex); //change the second value in Onsets to adjust mic onset sensitivity.
	// Out.ar(0, WhiteNoise.ar(onsets.lag(0.001, 0.5)*0.5 ));
	SendReply.kr(onsets, "/onsetOccured", 0, -1 );

	/////////////////////////
	// SECOND MIC ANALYSIS //
	/////////////////////////
	amplitudeFast2 = Amplitude.kr(micIn2, attackTime: 0.01, releaseTime: 0.01);
	Out.kr(~ampFast2, amplitudeFast2);

	amplitudeSlow2 = Amplitude.kr(micIn2, attackTime: 1, releaseTime: 1);
	Out.kr(~ampSlow2, amplitudeSlow2);

	# freq2, hasFreq2 = Pitch.kr(micIn2, ampThreshold: 0.02, median: 7);
	// freq.poll(label: \freqHz);
	// freq.cpsmidi.poll(label: \freqMIDI);
	// hasFreq.poll(label: \freqConfidence);
	Out.kr(~midiNum2, freq2.cpsmidi);

	chain2 = FFT(LocalBuf(512), micIn2);
    onsets2 = Onsets.kr(chain2, 0.9, \rcomplex); //change the second value in Onsets to adjust mic onset sensitivity.
	// Out.ar(0, WhiteNoise.ar(onsets.lag(0.001, 0.5)*0.5 ));
	SendReply.kr(onsets2, "/onset 2 Occured", 0, -1 );


}).add;
)







(
~analyzer.free;
~analyzer = Synth(\micAnalysis);

n = NetAddr("127.0.0.1", 7000); // processing address

OSCdef(\x, { |msg|
    var time, value;
    //msg.postln;

	n.sendMsg("1: ONSET",  );
}, "/onsetOccured");



t.stop;

t = Task({
	inf.do({
		var ampSlow, ampFast, note, ampSlow2, ampFast2, note2, freq1, tempo;

		/////////////////////////
		// MIC 1 ANALYSIS SEND //
		/////////////////////////
		ampSlow = ~ampSlow1.getSynchronous();
		//ampSlow.postln;

		ampFast = ~ampFast1.getSynchronous();
		//ampFast.postln;

		note = ~midiNum1.getSynchronous();
		//note.postln;

		tempo = ~beatTrack.getSynchronous();

		// n.sendMsg("/sc2proc", [ampSlow, ampFast, note]);
		n.sendMsg("1: ampSlow", ampSlow);

		n.sendMsg("1: ampFast", ampFast);

		n.sendMsg("1: note", note);

		n.sendMsg("1: tempo", tempo);


		/////////////////////////
		// MIC 2 ANALYSIS SEND //
		/////////////////////////
		ampSlow2 = ~ampSlow2.getSynchronous();
		//ampSlow2.postln;

		ampFast2 = ~ampFast2.getSynchronous();
		//ampFast2.postln;

		note2 = ~midiNum2.getSynchronous();
		//note2.postln;

		// n.sendMsg("/sc2proc", [ampSlow, ampFast, note]);
		n.sendMsg("2: ampSlow", ampSlow2);

		n.sendMsg("2: ampFast", ampFast2);

		n.sendMsg("2: note", note2);
		0.05.wait;


	});
}).start;
)
//add in second microphone to code.
// come by tommorrow 10/12
//talk to partners about visuals and what we want to be audio reactive.

