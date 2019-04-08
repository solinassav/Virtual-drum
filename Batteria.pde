import java.net.*;
import java.io.*;
import java.net.InetAddress;
import java.net.Socket;
import websockets.*;
WebsocketClient wsc;
public Drum drum;
public InertialSensor mpu6050;
String dataStr;
float sensibilita;
Socket mouseSocket;
void settings() {
  size(displayWidth-100, displayHeight-100, P3D);
}
/*Connected to HUAWEI-2.4G-emPy
IP address: 192.168.100.10
*/
void setup() {
  sensibilita = 2;
  mpu6050 = new InertialSensor(0, 0, 0, sensibilita, "Template");
  drum = new Drum(mpu6050.getActualWindow());
  wsc = new WebsocketClient(this, "ws://192.168.1.202:81//");
}

void webSocketEvent(String msg) {
  if (msg == "Ciao" || msg == null || msg == "0.0") return; 
  dataStr = msg;
  dataStr=dataStr.substring(1,dataStr.length());
}
void draw() {
  background(255); 
  if (dataStr != null)
    mpu6050.updateSensore(dataStr);
  mpu6050.drawTemplateCreator();
  drum.setWindow(mpu6050.getActualWindow());
  drum.play();
}

void mouseDragged() {
  mpu6050.mouseDragged();
}
void mousePressed() {
  mpu6050.mousePressed();
}
void mouseReleased() {
}
public void keyPressed() {
  mpu6050.keyPressed(key, keyCode);
}
public void keyReleased() {
  mpu6050.keyReleased(key, keyCode);
}