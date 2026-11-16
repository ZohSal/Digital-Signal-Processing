# Lecture 07 - Audio Processing and AI

## Selected Option
Option C - Analyse an environmental sound

## Audio File and Source Attribution
- Filename: data/classification/1-100032-A-0.wav (class: dog)
- Source: Supplied course subset from the ESC-50 dataset (Environmental Sound Classification, Karol J. Piczak, CC BY-NC 3.0).

## Settings Used
- Sample rate: 16000 Hz (mono)
- STFT window lengths compared: 512 samples (32 ms) and 2048 samples (128 ms), Hanning window
- Hop length: 160 samples (10 ms) for both spectrograms
- Frequency range displayed: 0 to 5000 Hz

## How to Run the Notebook
1. Open analysis.ipynb in Google Colab (Python 3 CPU runtime).
2. Run the ZIP upload cell (Cell 2) and upload Audio_Course_Student_Package.zip.
3. Run the helper setup cell (Cell 3) to load the functions and create the results/figures/ folder.
4. Run the Task 1 and Task 2 cells to play the dog recording, plot the waveform and spectrum, and generate the 512 vs 2048 spectrogram comparison.

## Main Conclusion
The dog bark occurs as a single sharp burst between 2.2 s and 2.6 s, with most of its acoustic energy concentrated between 700 Hz and 2500 Hz (peaking around 800 Hz - 1800 Hz). Comparing the two spectrograms clearly shows the STFT time-frequency trade-off: the 512-sample window (32 ms) captures the exact start and stop timing of the bark cleanly, while the 2048-sample window (128 ms) separates the individual horizontal harmonic bands much better but smears the bark horizontally in time.

## Limitation
A fixed STFT window length cannot give both sharp time localisation and fine frequency resolution in the same spectrogram. Also, analysing one clean 5-second recording in isolation does not show how background noise or different dog barks would affect the frequency pattern.

## Use of AI Assistance
I used ChatGPT to help adapt the lecture notebook's STFT subplot code for comparing the 512 and 2048 window lengths on the dog recording and to check the window duration math in milliseconds at 16 kHz. I ran the cells myself in Colab, listened to the audio clip, and verified the exact bark timestamp (2.2 s - 2.6 s) and frequency band (700 Hz - 2500 Hz) directly from my generated plots.