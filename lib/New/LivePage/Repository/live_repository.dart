import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aibak/Models/liverate_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../Models/liverate_model.dart';
//
// class LiveRateNotifier extends StateNotifier<LiveRateModel?> {
//   IO.Socket? _socket;
//   Map<String, dynamic> marketData = {};
//   LiveRateNotifier() : super(null) {
//     _initializeSocketConnection();
//   }
//   final link = 'https://capital-server-9ebj.onrender.com';
//   void _initializeSocketConnection() {
//     _socket = IO.io(link, <String, dynamic>{
//       'transports': ['websocket'],
//       'query': {
//         'secret': 'aurify@123', // Secret key for authentication
//       },
//     });
//     final commodityArray = ['GOLD', 'SILVER'];
//     _socket?.on('connect', (_) {
//       print('Connected to WebSocket server');
//       _requestMarketData(commodityArray);
//     });
//
//     _socket?.on('market-data', (data) {
//       // print("********************************************");
//       // print(data.toString());
//       if (data != null && data['symbol'] != null) {
//         marketData[data['symbol']] = data;
//         state = LiveRateModel.fromJson(marketData);
//         // print("###############################################");
//         // print(marketData);
//       }
//     });
//
//     _socket?.on('connect_error', (data) {
//       print('Connection Error: $data');
//     });
//
//     _socket?.on('disconnect', (_) {
//       print('Disconnected from WebSocket server');
//     });
//   }
//
//   void _requestMarketData(List<String> symbols) {
//     _socket?.emit('request-data', symbols);
//   }
//
//   @override
//   void dispose() {
//     _socket?.disconnect();
//     super.dispose();
//   }
// }
//
// final liveRateProvider =
//     StateNotifierProvider<LiveRateNotifier, LiveRateModel?>((ref) {
//   return LiveRateNotifier();
// });
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveRateNotifier extends StateNotifier<LiveRateModel?> {
  IO.Socket? _socket;
  Map<String, dynamic> marketData = {};

  LiveRateNotifier() : super(null) {
    initializeSocketConnection();
  }

  final link = 'https://capital-server-9ebj.onrender.com';

  Future<void> initializeSocketConnection() async {
    _socket = IO.io(link, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {
        'secret': 'aurify@123',
      },
    });

    final commodityArray = ['GOLD', 'SILVER'];

    _socket?.onConnect((_) {
      print('Connected to WebSocket server');
      _requestMarketData(commodityArray);
    });

    _socket?.on('market-data', (data) {
      if (data != null && data['symbol'] != null) {
        marketData[data['symbol']] = data;
        state = LiveRateModel.fromJson(marketData);
      }
    });

    _socket?.onConnectError((data) => print('Connection Error: $data'));
    _socket?.onDisconnect((_) => print('Disconnected from WebSocket server'));

    await _socket?.connect();
  }

  void _requestMarketData(List<String> symbols) {
    _socket?.emit('request-data', symbols);
  }

  @override
  void dispose() {
    _socket?.disconnect();
    super.dispose();
  }
}

final liveRateProvider =
    StateNotifierProvider<LiveRateNotifier, LiveRateModel?>((ref) {
  return LiveRateNotifier();
});
