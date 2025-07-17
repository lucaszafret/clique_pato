import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Pato());
  }
}

class Pato extends StatefulWidget {
  const Pato({super.key});

  @override
  State<Pato> createState() => _PatoState();
}

class _PatoState extends State<Pato> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _imagemPato = 0;

  //Patos
  final List<String> _patosImagens = [
    'assets/patinho.jpg',
    'assets/patu.jpg',
    'assets/pato.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer.setPlayerMode(PlayerMode.lowLatency);
  }

  Future<void> _playQuack() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('quack.mp3'));
    } catch (e) {}
  }

  void _onTapPato() async {
    _playQuack();
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      if (_imagemPato < _patosImagens.length - 1) {
        _imagemPato++;
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _onTapPato,
        child: SizedBox.expand(
          child: Image.asset(_patosImagens[_imagemPato], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
