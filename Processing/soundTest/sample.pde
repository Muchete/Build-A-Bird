class Sample {

	public AudioPlayer player;
	public int speed, loopCount, iterations, spaceBetween, loopMin,
	       loopMax, spaceMin, spaceMax, endTime;
	public float loopSpace;
	public String status = "OFF";
	public boolean running = false, islooping = false;
	public float loopSpaceRandomness = 0.4;

	Sample (String filename) {
		player = m.loadFile(filename);
		sampleList.add(this);
	}

	//callable functions: 

	//creates loop without starting it
	void defineLoop(int lmi, int lma, float ls, int smi, int sma){
		loopMin = lmi;
		loopMax = lma;
		loopSpace = ls;
		spaceMin = smi;
		spaceMax = sma;
	}

	//creates loop and starts it
	void startLoop(int lmi, int lma, float ls, int smi, int sma) {
		status = "ON";
		running = true;
		defineLoop(lmi, lma, ls, smi, sma);
		createLoopSequence();
	}

	//stops loop
	void stopLoop() {
		status = "OFF";
		running = false;
		println("stopped Loop");
	}

	//starts or stops loop (needs to be previously defined)
	void toggle(){
		if (running){
			stopLoop();
		} else {
			startLoop(loopMin,loopMax, loopSpace, spaceMin, spaceMax);
		}
	}

	// necessary functions
	void play() {
		player.rewind();
		player.play();
	}

	void restartLoop() {
		createLoopSequence();
	}

	void createLoopSequence() {
		loopCount = 0;
		islooping = true;
		iterations = int(random(loopMin, loopMax));
		spaceBetween = int(random(spaceMin, spaceMax) * 1000);
		setEndTime();

		println("created loop");
	}

	void setEndTime() {
		endTime = millis() + player.length() + 
		int(random(1-loopSpaceRandomness,1+loopSpaceRandomness) * loopSpace * 1000);
	}

	void setLoopEndTime() {
		endTime = millis() + spaceBetween;
	}

	void update() {
		if (running){
			if (millis() > endTime) {
				if (islooping) {
					if (loopCount < iterations) {
						loopCount++;
						setEndTime();
						play();
					} else {
						setLoopEndTime();
						islooping = false;
					}
				} else {
					restartLoop();
				}
			}
		}
	}

}