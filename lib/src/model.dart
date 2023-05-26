import 'dart:convert';

import 'package:uuid/uuid.dart';

enum CollectorType { error, event, metric, trace, log, span }

enum CollectorSource { web, mobile, server, desktop, iot, other }

enum TelegramParseMode { markdown, markdownV2, html }

class Telegram {
  String? token;
  String? chatId;
  TelegramParseMode? parseMode;
  bool? disabled;

  Telegram({
    this.token,
    this.chatId,
    this.parseMode,
    this.disabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'chat_id': chatId,
      'parse_mode': parseMode,
      'disabled': disabled,
    };
  }

  static TelegramBuilder builder() {
    return TelegramBuilder();
  }
}

class TelegramBuilder {
  String? _token;
  String? _chatId;
  TelegramParseMode? _parseMode;
  bool? _disabled;

  TelegramBuilder();

  TelegramBuilder token(String? token) {
    _token = token;
    return this;
  }

  TelegramBuilder chatId(String? chatId) {
    _chatId = chatId;
    return this;
  }

  TelegramBuilder parseMode(TelegramParseMode? parseMode) {
    _parseMode = parseMode;
    return this;
  }

  TelegramBuilder disabled(bool? disabled) {
    _disabled = disabled;
    return this;
  }

  Telegram build() {
    return Telegram(
      token: _token,
      chatId: _chatId,
      parseMode: _parseMode,
      disabled: _disabled,
    );
  }
}

class Discord {
  String? webhookId;
  String? webhookToken;
  String? webhookUrl;
  bool? disabled;

  Discord({
    this.webhookId,
    this.webhookToken,
    this.webhookUrl,
    this.disabled,
  });

  Discord._builder(DiscordBuilder builder)
      : webhookId = builder._webhookId,
        webhookToken = builder._webhookToken,
        webhookUrl = builder._webhookUrl,
        disabled = builder._disabled;

  Map<String, dynamic> toMap() {
    return {
      'webhook_id': webhookId,
      'webhook_token': webhookToken,
      'webhook_url': webhookUrl,
      'disabled': disabled,
    };
  }

  static DiscordBuilder builder() {
    return DiscordBuilder();
  }
}

class DiscordBuilder {
  String? _webhookId;
  String? _webhookToken;
  String? _webhookUrl;
  bool? _disabled;

  DiscordBuilder();

  DiscordBuilder webhookId(String? webhookId) {
    _webhookId = webhookId;
    return this;
  }

  DiscordBuilder webhookToken(String? webhookToken) {
    _webhookToken = webhookToken;
    return this;
  }

  DiscordBuilder webhookUrl(String? webhookUrl) {
    _webhookUrl = webhookUrl;
    return this;
  }

  DiscordBuilder disabled(bool? disabled) {
    _disabled = disabled;
    return this;
  }

  Discord build() {
    return Discord._builder(this);
  }
}

class SDKInfo {
  String? name;
  String? version;
  String? versionCode;
  String? hostname;
  String? sender;

  SDKInfo({
    this.name,
    this.version,
    this.versionCode,
    this.hostname,
    this.sender,
  });

  SDKInfo._builder(SDKInfoBuilder builder)
      : name = builder._name,
        version = builder._version,
        versionCode = builder._versionCode,
        hostname = builder._hostname,
        sender = builder._sender;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'version': version,
      'version_code': versionCode,
      'hostname': hostname,
      'sender': sender,
    };
  }

  static SDKInfoBuilder builder() {
    return SDKInfoBuilder();
  }
}

class SDKInfoBuilder {
  String? _name;
  String? _version;
  String? _versionCode;
  String? _hostname;
  String? _sender;

  SDKInfoBuilder();

  SDKInfoBuilder name(String? name) {
    _name = name;
    return this;
  }

  SDKInfoBuilder version(String? version) {
    _version = version;
    return this;
  }

  SDKInfoBuilder versionCode(String? versionCode) {
    _versionCode = versionCode;
    return this;
  }

  SDKInfoBuilder hostname(String? hostname) {
    _hostname = hostname;
    return this;
  }

  SDKInfoBuilder sender(String? sender) {
    _sender = sender;
    return this;
  }

  SDKInfo build() {
    return SDKInfo._builder(this);
  }
}

class Target {
  Telegram? telegram;
  Discord? discord;
  SDKInfo? sdkInfo;

  Target({
    this.telegram,
    this.discord,
    this.sdkInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'telegram': telegram?.toMap(),
      'discord': discord?.toMap(),
      'sdk_info': sdkInfo?.toMap(),
    };
  }

  static TargetBuilder builder() {
    return TargetBuilder();
  }
}

class TargetBuilder {
  Telegram? _telegram;
  Discord? _discord;
  SDKInfo? _sdkInfo;

  TargetBuilder();

  TargetBuilder telegram(Telegram? telegram) {
    _telegram = telegram;
    return this;
  }

  TargetBuilder discord(Discord? discord) {
    _discord = discord;
    return this;
  }

  TargetBuilder sdkInfo(SDKInfo? sdkInfo) {
    _sdkInfo = sdkInfo;
    return this;
  }

  Target build() {
    return Target(
      telegram: _telegram,
      discord: _discord,
      sdkInfo: _sdkInfo,
    );
  }
}

class CollectorRequest {
  String? id;
  String? type;
  String? source;
  String? message;
  dynamic data;
  String? userAgent;
  int? timestamp;
  Target? target;
  List<String>? tags;

  CollectorRequest(
      {this.id,
      this.type,
      this.source,
      this.message,
      this.data,
      this.userAgent,
      this.timestamp,
      this.target,
      this.tags});

  String? getId() {
    id ??= Uuid().v4();
    return id;
  }

  int? getTimestamp() {
    timestamp ??= DateTime.now().millisecondsSinceEpoch;
    return timestamp;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': getId(),
      'type': type,
      'source': source,
      'message': message,
      'data': data,
      'user_agent': userAgent,
      'timestamp': getTimestamp(),
      'target': target?.toMap(),
      'tags': tags,
    };
  }

  String toJson() => json.encode(toMap());

  static CollectorRequestBuilder builder() {
    return CollectorRequestBuilder();
  }
}

class CollectorRequestBuilder {
  String? _id;
  String? _type;
  String? _source;
  String? _message;
  dynamic _data;
  String? _userAgent;
  int? _timestamp;
  Target? _target;
  List<String>? _tags;

  CollectorRequestBuilder();

  CollectorRequestBuilder id(String? id) {
    _id = id;
    return this;
  }

  CollectorRequestBuilder type(String? type) {
    _type = type;
    return this;
  }

  CollectorRequestBuilder source(String? source) {
    _source = source;
    return this;
  }

  CollectorRequestBuilder message(String? message) {
    _message = message;
    return this;
  }

  CollectorRequestBuilder data(dynamic data) {
    _data = data;
    return this;
  }

  CollectorRequestBuilder userAgent(String? userAgent) {
    _userAgent = userAgent;
    return this;
  }

  CollectorRequestBuilder timestamp(int? timestamp) {
    _timestamp = timestamp;
    return this;
  }

  CollectorRequestBuilder target(Target? target) {
    _target = target;
    return this;
  }

  CollectorRequestBuilder tags(List<String>? tags) {
    _tags = tags;
    return this;
  }

  CollectorRequest build() {
    return CollectorRequest(
      id: _id,
      type: _type,
      source: _source,
      message: _message,
      data: _data,
      userAgent: _userAgent,
      timestamp: _timestamp,
      target: _target,
      tags: _tags,
    );
  }
}

class CollectorResponse {
  String? message;
  String? id;

  CollectorResponse({this.message, this.id});

  bool get isSuccess => message == 'ok';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());

  factory CollectorResponse.fromMap(Map<String, dynamic> map) {
    return CollectorResponse(
      message: map['message'],
      id: map['id'],
    );
  }

  factory CollectorResponse.fromJson(String source) =>
      CollectorResponse.fromMap(json.decode(source));
}

class VLogsOptions {
  String? url;
  String? appId;
  String? apiKey;
  int? connectionTimeout;
  bool? testConnection;

  VLogsOptions({
    this.url,
    this.appId,
    this.apiKey,
    this.connectionTimeout,
    this.testConnection,
  });

  VLogsOptions._builder(VLogsOptionsBuilder builder)
      : url = builder._url,
        appId = builder._appId,
        apiKey = builder._apiKey,
        connectionTimeout = builder._connectionTimeout,
        testConnection = builder._testConnection;
}

class VLogsOptionsBuilder {
  String? _url;
  String? _appId;
  String? _apiKey;
  int? _connectionTimeout;
  bool? _testConnection;

  VLogsOptionsBuilder();

  VLogsOptionsBuilder url(String? url) {
    _url = url;
    return this;
  }

  VLogsOptionsBuilder appId(String? appId) {
    _appId = appId;
    return this;
  }

  VLogsOptionsBuilder apiKey(String? apiKey) {
    _apiKey = apiKey;
    return this;
  }

  VLogsOptionsBuilder connectionTimeout(int? connectionTimeout) {
    _connectionTimeout = connectionTimeout;
    return this;
  }

  VLogsOptionsBuilder testConnection(bool? testConnection) {
    _testConnection = testConnection;
    return this;
  }

  VLogsOptions build() {
    return VLogsOptions._builder(this);
  }
}
