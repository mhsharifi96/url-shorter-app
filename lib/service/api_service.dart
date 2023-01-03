import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:material_3_demo/models/link_model.dart';

import '../constants.dart';

class ApiService {
  Future<LinkModel?> getLink() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.singleLinkEndpoint);
      var response = await http.get(url);

      if (response.statusCode == StatusCodeConstants.SUCCESS_CODE) {
        Map<String, dynamic> LinkMap = json.decode(response.body);
        LinkModel _model = LinkModel.fromJson(LinkMap);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<LinkModel?> createLink(String? main_link, String? short_link) async {
    try {
      var body = {'main_link':main_link,'short_link':short_link};
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.linkEndpoint);
      var response = await http.post(url,body: body);
      if (response.statusCode == StatusCodeConstants.CREATED_CODE) {
        Map<String, dynamic> LinkMap = json.decode(response.body);
        LinkModel _model = LinkModel.fromJson(LinkMap);
        return _model;
      }
      else {
        print(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
