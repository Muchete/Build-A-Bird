class Sample {

	public ArrayList<AudioPlayer> playerList = new ArrayList<AudioPlayer>();

	public int speed, loopCount, iterations, spaceBetween, loopMin,
	       loopMax, spaceMin, spaceMax, endTime;
	public float loopSpace;
	public String status = "OFF";
	public boolean running = false, islooping = false;
	public float loopSpaceRandomness = 0.4;
	public int longestSample = 0;
	public String connector;


	Sample (String[] filenames) {

		for (String name : filenames) {
			AudioPlayer player;
			player = m.loadFile("sounds/" + name);
			playerList.add(player);

			if (player.length() > longestSample){
				longestSample = player.length();
			}
		}

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
		if (running){
			status = "OFF";
			running = false;
			println("stopped Loop");
		}
	}

	void start(String c){
		connector = c;
		if (!running){
			startLoop(loopMin,loopMax, loopSpace, spaceMin, spaceMax);
		}
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
		//plays random sample
		int s = int(random(0, playerList.size()));
		playerList.get(s).rewind();
		playerList.get(s).play();

		if (connector != null){
			client.publish("/activeSound", connector);
		}
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
		endTime = millis() + longestSample + 
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