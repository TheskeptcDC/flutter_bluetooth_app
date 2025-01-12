import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'game_controller.dart';

class DeviceSelectionPage extends StatefulWidget {
  @override
  _DeviceSelectionPageState createState() => _DeviceSelectionPageState();
}

class _DeviceSelectionPageState extends State<DeviceSelectionPage> {
  final List<BluetoothDevice> devicesList = [];
  BluetoothConnection? connection;

  @override
  void initState() {
    super.initState();
    getPairedDevices();
  }

  void getPairedDevices() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    } catch (e) {
      print("Error getting bonded devices: $e");
    }

    setState(() {
      devicesList.addAll(devices);
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      print('Attempting to connect to ${device.name} (${device.address})');
      connection = await BluetoothConnection.toAddress(device.address);
      print('Connected to the device');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameControllerPage(connection: connection),
        ),
      );
    } catch (e) {
      print('Cannot connect, exception occurred');
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to ${device.name}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Bluetooth Device'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: getPairedDevices,
            child: const Text('Refresh Paired Devices'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: devicesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devicesList[index].name?.isNotEmpty == true
                      ? devicesList[index].name!
                      : 'Unknown Device'),
                  subtitle: Text(devicesList[index].address.toString()),
                  onTap: () => connectToDevice(devicesList[index]),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameControllerPage(connection: null),
                ),
              );
            },
            child: const Text('Control Pad'),
          ),
        ],
      ),
    );
  }
}
