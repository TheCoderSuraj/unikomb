import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:unikomb/core/auth/functions/auth/auth.dart';

import '../../../community/models/community_model.dart';
import '../../models/message_model.dart';
import '../../storage_constants.dart';
import 'events_model.dart';

part 'add_community.dart';
part 'get_community.dart';
part 'description.dart';
part 'events.dart';
part 'general_talk.dart';

class CommunityApi {
  static void addCommunityFireStore(
    CommunityModel cm, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) {
    _addCommunityFireStore(cm, onSuccess: onSuccess, onError: onError);
  }

  static void addMemberInGroup(
    String mId,
    String dId, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) {
    _addMemberInGroup(
      mId,
      dId,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static void removeMemberInGroup(
    String mId,
    String dId, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) {
    _removeMemberInGroup(
      mId,
      dId,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static Future<CommunityModel?> getCommunity(String id) async {
    return _getCommunity(id);
  }

  static Future<String> getCommunityDescription(
    String cId, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) {
    return _getCommunityDescription(
      cId,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static Future<void> addCommunityDescription(
    String cId,
    String value, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    _addCommunityDescription(
      cId,
      value,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  static Stream<QuerySnapshot> getCommunityEvent(
    String cId, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) {
    return _getCommunityEvent(cId, onError: onError, onSuccess: onSuccess);
  }

  static Future<void> addCommunityEvent(
    String cId,
    EventModel data, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    _addCommunityEvent(
      cId,
      data,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static void sendMessage(
    String cId,
    MessageModel msg, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) {
    _sendMessage(cId, msg, onError: onError, onSuccess: onSuccess);
  }

  Stream<QuerySnapshot> getCommunityTalk(
    String cId, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) {
    return _getCommunityEvent(
      cId,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
