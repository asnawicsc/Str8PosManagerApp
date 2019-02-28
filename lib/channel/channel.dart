import 'package:phoenix_wings/phoenix_wings.dart';
import '../channel/presence.dart';

typedef Null MapCallback(Map<String, dynamic> payload);
typedef Null PresenceCallback(List presences);

class Channel {
  final String url;
  final PhoenixSocket socket;
  final PhoenixChannel chatChannel;
  final String user;

  var _presences = {};

  var listBy = (String user, Map presence) => {
    'user': user,
    'onlineAt': presence['metas'][0]['online_at'],
  };

  void on(String msgType, MapCallback callback) {
    chatChannel.on(msgType, (Map payload, String _ref, String _joinRef) {
      callback(payload);
    });
  }

  void onPresence(PresenceCallback callback) {
    chatChannel.on("presence_state", (Map payload, String _ref, String _joinRef) {
      _presences = PhoenixPresence.syncState(_presences, payload);
      callback(PhoenixPresence.list(_presences, listBy));
    });
    chatChannel.on("presence_diff", (Map payload, String _ref, String _joinRef) {
      _presences = PhoenixPresence.syncDiff(_presences, payload);
      callback(PhoenixPresence.list(_presences, listBy));
    });
  }

  push(String event, Map payload) {
    print("payload....");
    print(payload);
    chatChannel.push(
      event: event,
      payload: payload,
    );
  }

  Channel._(this.url, this.socket, this.chatChannel, this.user) {
    chatChannel.join();
  }

  factory Channel({String url, String user, String licenseKey}) {
    url ??= "wss://pos.str8.my/socket/websocket";
    user ??= "Unknown";
    licenseKey ??= "";
    var _opts = new PhoenixSocketOptions();
    _opts.params["user"] = user;
    _opts.params["vsn"] = "2.0.0";
    var socket = new PhoenixSocket(url, socketOptions: _opts);

    socket.connect();

    socket.onError((error) => print("socket.onError: $error"));
    socket.onClose((msg) => print("socket.onClose: $msg"));

    var chatChannel = socket.channel("organization:$user", {"license_key": licenseKey});

    return Channel._(url, socket, chatChannel, user);
  }
}
