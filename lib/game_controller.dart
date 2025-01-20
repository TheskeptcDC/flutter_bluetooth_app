import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class GamepadLayout extends StatefulWidget {
  @override
  State<GamepadLayout> createState() => _GamepadLayoutState();
}

class _GamepadLayoutState extends State<GamepadLayout> {
  String mapJoystick(double x, double y) {
    // Thresholds for determining significant values
    const double threshold = 0.5;
    const double reverseThreshold = -0.5;

    // Check if x value is significant
    if (x == 0 && y == 0) {
      return 'S'; //stop
    } else if (x > threshold && y < 0) {
      return 'R'; //turn right
    } else if (x < 0 && y < 0) {
      return 'L'; //turn left
    } else if (x == 0 && y < 0) {
      return 'F';
    } else if (x < 0 && y > 0) {
      return 'Rv';
    }
    return 'S'; // Default return value
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Action Buttons section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.crop_square, size: 50),
                  onPressed: () => _sendCommand('Square'),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_upward, size: 50),
                  onPressed: () => _sendCommand('Triangle'),
                ),
                IconButton(
                  icon: Icon(Icons.circle, size: 50),
                  onPressed: () => _sendCommand('Circle'),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 50),
                  onPressed: () => _sendCommand('X'),
                ),
              ],
            ),
            // Joystick and Directional Buttons section
            Row(
              children: [
                // Joystick section
                Expanded(
                  child: Center(
                    child: Joystick(
                      mode: JoystickMode.all,
                      listener: (details) {
                        String command = mapJoystick(details.x, details.y);
                        print('Right Joystick: ${details.x}, ${details.y}');
                        print(command);
                      },
                    ),
                  ),
                ),
                // Directional Buttons section
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_up, size: 40),
                        onPressed: () => _sendCommand('Up'),
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
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Function to send the command
  void _sendCommand(String command) {
    print('Command Sent: $command');
  }
}

void main() {
  runApp(MaterialApp(
    home: GameControllerPage(connection: null),
  ));
}

class GameControllerPage extends StatefulWidget {
  final BluetoothConnection? connection;

  GameControllerPage({this.connection});

  @override
  State<GameControllerPage> createState() => _GameControllerPageState();
}

class _GameControllerPageState extends State<GameControllerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('apollo32'),
      ),
      body: GamepadLayout(),
    );
  }
}
