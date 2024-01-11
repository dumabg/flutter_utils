import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_utils/mocking/mock_factory.dart';

class Sample {
  final String msg;
  final int value;
  factory Sample(String msg, int value) {
    return mock?.of<Sample>(<String, dynamic>{'msg': msg, 'value': value}) ??
        Sample.$(msg, value);
  }
  @protected
  Sample.$(this.msg, this.value);
  String hello() => 'Hello $msg $value';
}

class SampleMock implements Sample {
  @override
  String get msg => "SampleMock a";

  @override
  int get value => 2;

  @override
  String hello() => "Hello from mock: $msg - $value";
}

class SampleMockWithParams extends Sample {
  SampleMockWithParams(super.msg, super.value) : super.$();

  @override
  String hello() => "Hello from mock: $msg - $value";
}

void main() {
  test('Mock no registered', () {
    mock = MockFactory();
    var sample = Sample('a', 1);
    expect(sample.msg, 'a');
    expect(sample.value, 1);
    expect(sample.hello(), 'Hello a 1');
  });
  test('Mock registered, ignore params', () {
    mock = MockFactory();
    mock!.register<Sample>((params) => SampleMock());
    var sample = Sample('a', 1);
    expect(sample.msg, 'SampleMock a');
    expect(sample.value, 2);
    expect(sample.hello(), 'Hello from mock: SampleMock a - 2');
  });
  test('Mock registered, use params', () {
    mock = MockFactory();
    mock!.register<Sample>((Map<String, dynamic>? params) =>
        SampleMockWithParams(params!['msg'] as String, params['value'] as int));
    var sample = Sample('use params', 3);
    expect(sample.msg, 'use params');
    expect(sample.value, 3);
    expect(sample.hello(), 'Hello from mock: use params - 3');
  });
}
