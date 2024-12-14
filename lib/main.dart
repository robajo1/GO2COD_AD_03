import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(FlashlightApp());
}

class FlashlightApp extends StatelessWidget {
  const FlashlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FlashlightScreen(),
    );
  }
}

class FlashlightScreen extends StatefulWidget {
  const FlashlightScreen({super.key});

  @override
  _FlashlightScreenState createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  bool isTorchOn = false;

  Future<void> toggleFlashlight() async {
    try {
      if (isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        isTorchOn = !isTorchOn;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Torch not available on this device!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isTorchOn
                    ? [Colors.yellow.shade700, Colors.orange.shade600]
                    : [Colors.grey.shade800, Colors.grey.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isTorchOn ? 150 : 100,
                    width: isTorchOn ? 150 : 100,
                    decoration: BoxDecoration(
                      color: isTorchOn ? Colors.yellow.shade300 : Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: [
                        if (isTorchOn)
                          const BoxShadow(
                            color: Colors.yellowAccent,
                            blurRadius: 30,
                            spreadRadius: 15,
                          ),
                      ],
                    ),
                    child: Icon(
                      Icons.lightbulb,
                      size: isTorchOn ? 80 : 60,
                      color: isTorchOn ? Colors.orange : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: toggleFlashlight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        isTorchOn ? 'Turn Off' : 'Turn On',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
