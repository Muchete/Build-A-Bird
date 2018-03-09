class Sample {

	public AudioPlayer player;
	public int speed, endTime = 200000000;
	String status;

	Sample (String filename, int loopStart, int loopEnd) {
		player = m.loadFile(filename);
		player.setLoopPoints(loopStart,loopEnd);

		status = "ready";

		sampleList.add(this);
	}

	void play(){
		player.play();
	}

	void playLoop(int n){
		player.loop(n);
	}

	// void playRandomLoop(int min, int max) {
	// 	if (!player.isPlaying()) {

	// 		int r = int(random(min,max));
	// 		endTime = millis() + (player.length() * (r + 1));

	// 		player.loop(r);

	// 	}
	// }

	void createLoopSequence(int loopMin, int loopMax, int spaceMin, int spaceMax){
		int iterations = int(random(loopMin,loopMax));
		int spaceBetween = int(random(spaceMin,spaceMax) * 1000);
		endTime = millis() + (player.length() * (iterations + 1));
		endTime = endTime + spaceBetween;

		playLoop(iterations);
	}

	void update(){
		if (millis()>endTime){
			println("done!");
		}
	}
}