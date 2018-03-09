class Sample {

	public AudioPlayer player;
	public int speed, loopCount, iterations, spaceBetween, loopMin,
	       loopMax, spaceMin, spaceMax, endTime;
	public float loopSpace;
	public String status = "OFF";
	public boolean running = false, islooping = false;

	Sample (String filename) {
		player = m.loadFile(filename);

		sampleList.add(this);
	}

	 void play() {
		player.rewind();
		player.play();
	}

	void defineLoop(int lmi, int lma, float ls, int smi, int sma){
		loopMin = lmi;
		loopMax = lma;
		loopSpace = ls;
		spaceMin = smi;
		spaceMax = sma;
	}

	void startLoop(int lmi, int lma, float ls, int smi, int sma) {
		status = "ON";
		running = true;
		loopMin = lmi;
		loopMax = lma;
		loopSpace = ls;
		spaceMin = smi;
		spaceMax = sma;
		createLoopSequence();
	}

	void stopLoop() {
		status = "OFF";
		running = false;
		println("stopped Loop");
	}

	void restartLoop() {
		createLoopSequence();
	}

	void toggle(){
		if (running){
			stopLoop();
		} else {
			startLoop(loopMin,loopMax, loopSpace, spaceMin, spaceMax);
		}
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
		endTime = millis() + player.length() + int(loopSpace * 1000);
	}

	void setLoopEndTime() {
		endTime = millis() + spaceBetween;
	}

	void update() {

		switch (status) {
		case "ON":

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
			break;
		case "OFF":

			break;
		}
	}
}