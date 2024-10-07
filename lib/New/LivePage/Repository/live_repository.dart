import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aibak/Core/Utils/firebase_constants.dart';
import '../../../../Models/liverate_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Models/get_commodity_model.dart';
import '../../../Models/get_server_details.dart';

final liveRateProvider =
    StateNotifierProvider<LiveRateNotifier, LiveRateModel?>((ref) {
  return LiveRateNotifier();
});

class LiveRateNotifier extends StateNotifier<LiveRateModel?> {
  IO.Socket? _socket;
  Map marketData = {};
  final String link = 'https://capital-server-9ebj.onrender.com';

  LiveRateNotifier() : super(null) {
    fetchServerLink().then(
      (value) {
        initializeSocketConnection(link: value);
      },
    );
  }

  Future<List<String>> fetchCommodityArray() async {
    const id = "IfiuH/ko+rh/gekRvY4Va0s+aGYuGJEAOkbJbChhcqo=";
    final response = await http.get(
      Uri.parse(
          '${FirebaseConstants.baseUrl}get-commodities/${FirebaseConstants.adminId}'),
      headers: {
        'X-Secret-Key': id,
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // List<dynamic> data = json.decode(response.body);
      final commudity = GetCommodityModel.fromMap(json.decode(response.body));
      // return data.map((item) => item.toString()).toList();

      return commudity.commodities;
    } else {
      throw Exception('Failed to load commodity data');
    }
  }

  Future<String> fetchServerLink() async {
    final response = await http.get(
      Uri.parse('${FirebaseConstants.baseUrl}get-server'),
      headers: {
        'X-Secret-Key': FirebaseConstants.secretKey,
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // List<dynamic> data = json.decode(response.body);
      final commudity = GetServerModel.fromMap(json.decode(response.body));
      // return data.map((item) => item.toString()).toList();
      return commudity.info.serverUrl;
    } else {
      throw Exception('Failed to load commodity data');
    }
  }

  Future<void> initializeSocketConnection({required String link}) async {
    _socket = IO.io(link, {
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {
        'secret': 'aurify@123',
      },
    });

    _socket?.onConnect((_) async {
      print('Connected to WebSocket server');
      List<String> commodityArray = await fetchCommodityArray();

      _requestMarketData(commodityArray);
    });

    _socket?.on('market-data', (data) {
      if (data is Map<String, dynamic> && data['symbol'] is String) {
        marketData[data['symbol']] = data;
        try {
          state = LiveRateModel.fromJson(marketData);
        } catch (e) {
          print("Error parsing market data: $e");
          // Handle the error appropriately
        }
      } else {
        print("Received invalid market data format");
      }
    });

    _socket?.onConnectError((data) => print('Connection Error: $data'));
    _socket?.onDisconnect((_) => print('Disconnected from WebSocket server'));

    await _socket?.connect();
  }

  void _requestMarketData(List<String> symbols) {
    // print("HERE IS THE SYMBOLS");
    // print(symbols);
    // print(symbols);
    // print(symbols);
    // print(symbols);
    // print(symbols);
    // print(symbols);
    // print(symbols);
    // print(symbols);
    // print(symbols);
    // print(symbols);
    // print(symbols);
    _socket?.emit('request-data', [symbols]);
  }

  @override
  void dispose() {
    _socket?.disconnect();
    super.dispose();
  }
}
