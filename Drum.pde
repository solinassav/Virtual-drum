import processing.sound.*;
SoundFile snare, tom1, tom2, tom3, piatto1, piatto2;
class Drum {
  float feature;
  boolean isSmitted;
  boolean isSmittedHold;
  Window window;
  float[] direction = new float[3];
  public Drum(Window window) {
    snare = new SoundFile(Batteria.this, "snare.mp3");
    tom1 = new SoundFile(Batteria.this, "tom1.mp3");
    tom2 = new SoundFile(Batteria.this, "tom2.mp3");
    tom3 = new SoundFile(Batteria.this, "tom3.mp3");
    piatto1 = new SoundFile(Batteria.this, "piatto1.mp3");
    piatto2 = new SoundFile(Batteria.this, "piatto2.mp3");
    this.window = window;
    for (int i = 0; i<3; i++) {
      direction[i]=0;
    }
  }
  public void setWindow(Window window, boolean isSmitted) {
    this.isSmitted = isSmitted;
    this.window = window;
    for (int i =0; i<3; i++) {
      direction[i] = window.getDirectionWindow()[i][window.getWindowSize()-1];
    }
  }
  public void setWindow(Window window) {
    this.window = window;
    for (int i =0; i<3; i++) {
      direction[i] = window.getDirectionWindow()[i][window.getWindowSize()-1];
    }
    feature = window.getDirectionWindow()[2][window.getWindowSize()-1]-window.getDirectionWindow()[2][window.getWindowSize()-2];
    isSmitted=false;
    if (feature>10.5)
      isSmitted=true;
  }
  public void play() {
    if (this.isSmitted()) {
      if (direction[1]>0 ) {
        if (direction[0]>0) {
          if (direction[1]<tan(radians(45))*direction[0]) {
            snare.play();
          } else if (direction[1]>tan(radians(45))*direction[0]) {
            if (direction[2]>-100) {
              tom1.play();
            } else if (direction[2]<-100) {
              piatto1.play();
            }
          }
        } else if (direction[0]<0) {
          if (direction[1]<-tan(radians(45))*direction[0]) {
            tom3.play();
          } else if (direction[1]>-tan(radians(45))*direction[0]) {
            if (direction[2]>-100) {
              tom2.play();
            } else if (direction[2]<-100) {
              piatto2.play();
            }
          }
        }
      }
    }
  }
  private boolean isSmitted() {
    boolean out;
    if (isSmitted && !isSmittedHold) {
      out= true;
    } else {
      out= false;
    }
    isSmittedHold = isSmitted;
    return out;
  }
}