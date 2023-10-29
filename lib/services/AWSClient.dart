// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';

class AWSClientCustom {
  String? accessKeyId = dotenv.env['ACCESS_KEY'];
  String? secretKeyId = dotenv.env['SECRET_KEY'];
  String? region =
      dotenv.env['REGION']; // replace with your account's region name
  String? bucketname = dotenv.env['BUCKET'];
  String? s3Endpoint = dotenv.env['S3_BUCKET_URL'];

  dynamic uploadData(String folderName, String fileName, Uint8List data) async {
    final length = data.length;

    final uri = Uri.parse(s3Endpoint!);
    final req = http.MultipartRequest("POST", uri);
    final multipartFile = http.MultipartFile(
        'file', http.ByteStream.fromBytes(data), length,
        filename: fileName);

    final policy = Policy.fromS3PresignedPost(
        '$folderName/$fileName', bucketname!, accessKeyId!, 15, length,
        region: region!);

    final key =
        SigV4.calculateSigningKey(secretKeyId!, policy.datetime, region!, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;
    try {
      final res = await req.send();
      await for (var value in res.stream.transform(utf8.decoder)) {
        return value;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  dynamic downloadData(String folderName, String fileName) async {
    final uri = Uri.parse(s3Endpoint!);
    final req = http.MultipartRequest("GET", uri);
//    final multipartFile = http.MultipartFile(
//        'file', http.ByteStream.fromBytes(data), length,
//        filename: fileName);

    final policy = Policy.fromS3PresignedPost(
        '$folderName/$fileName', bucketname!, accessKeyId!, 15, 500,
        region: region!);
    final key =
        SigV4.calculateSigningKey(secretKeyId!, policy.datetime, region!, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

//    req.files.add(multipartFile);
//    req.fields['key'] = policy.key;
//     req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;

    try {
      final res = await req.send();
      await for (var value in res.stream.transform(utf8.decoder)) {
        return value;
      }
      return true;
    } catch (e) {
      return e;
    }
  }
}

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize,
      {this.region = 'us-east-1'});

  factory Policy.fromS3PresignedPost(
    String key,
    String bucket,
    String accessKeyId,
    int expiryMinutes,
    int maxFileSize, {
    required String region,
  }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final p = Policy(key, bucket, datetime, expiration, cred, maxFileSize,
        region: region);
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
{ "expiration": "${this.expiration}",
  "conditions": [
    {"bucket": "${this.bucket}"},
    ["starts-with", "\$key", "${this.key}"],
    {"acl": "public-read"},
    ["content-length-range", 1, ${this.maxFileSize}],
    {"x-amz-credential": "${this.credential}"},
    {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
    {"x-amz-date": "${this.datetime}" }
  ]
}
''';
  }
}
