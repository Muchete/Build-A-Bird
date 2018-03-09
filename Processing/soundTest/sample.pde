class Sample {

	public AudioPlayer player;
	public int speed, loopCount, iterations, spaceBetween, loopMin,
	       loopMax, spaceMin, spaceMax, endTime = 200000000;
	public float loopSpace;
	public String status = "OFF";
	public boolean running = false, islooping = false;

	Sample (String filename) {
		player = m.loadFile(filename);
		// player.setLoopPoints(loopStart,loopEnd);

		sampleList.add(this);
	}

	 void play() {
		player.rewind();
		player.play();
	}

	void doLoop(int lmi, int lma, float ls, int smi, int sma) {
		status = "ON";
		loopMin = lmi;
		loopMax = lma;
		loopSpace = ls;
		spaceMin = smi;
		spaceMax = sma;
		createLoopSequence();
	}

	void stopLoop() {
		status = "OFF";
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

		println("millis(): " + millis());
		println("player.length(): " + player.length());
		println("iterations: " + iterations);
		println("spaceBetween: " + spaceBetween);
		println("endTime: " + endTime);
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