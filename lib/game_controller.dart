import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class GameControllerPage extends StatelessWidget {
  final BluetoothConnection? connection;

  GameControllerPage({required this.connection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PS2 Gamepad"),
      ),
      body: Center(
        child: GamepadLayout(),
      ),
    );
  }
}

class GamepadLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Joystick section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Joystick(direction: 'Left'),
            SizedBox(width: 20),
            Joystick(direction: 'Right'),
          ],
        ),
        SizedBox(height: 30),
        // Action Buttons section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.crop_square, size: 50),
              onPressed: () => _sendCommand('Square'),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.arrow_upward, size: 50),
              onPressed: () => _sendCommand('Triangle'),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.circle, size: 50),
              onPressed: () => _sendCommand('Circle'),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.close, size: 50),
              onPressed: () => _sendCommand('X'),
            ),
          ],
        ),
        SizedBox(height: 50),
        // Directional Buttons section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.keyboard_arrow_up, size: 40),
              onPressed: () => _sendCommand('Up'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left, size: 40),
              onPressed: () => _sendCommand('Left'),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down, size: 40),
              onPressed: () => _sendCommand('Down'),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right, size: 40),
              onPressed: () => _sendCommand('Right'),
            ),
          ],
        ),
      ],
    );
  }

  // Function to send the command
  void _sendCommand(String command) {
    // Handle sending the command to the Bluetooth device or perform an action
    print('Command Sent: $command');
  }
}

class Joystick extends StatelessWidget {
  final String direction;

  Joystick({required this.direction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          direction,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GameControllerPage(connection: null),
  ));
}
