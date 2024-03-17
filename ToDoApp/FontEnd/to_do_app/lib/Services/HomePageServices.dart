
import 'dart:convert';
import 'package:to_do_app/Config/Configurations.dart';
import 'package:to_do_app/Model/StatusModel.dart';

import 'package:http/http.dart'as http;

class HomepageService{

    static List<StatusModel>statusModels = [];

    static List<List<StatusModel>>groupModel = [];

    static Future<List<StatusModel>> getDataByStatus()async{
        // var response = await http.get(Uri.parse(ConfigEndpoints.statusTask));
        var response = await http.get(Uri.parse("http://192.168.0.103:8080/api/tasks/statusTask?status=IN_PROGRESS"));
        if(response.statusCode == 200){
            statusModels.clear();
            var apiData = jsonDecode(response.body);
            for(Map<String,dynamic> index in apiData){
                statusModels.add(StatusModel.fromJson(index));
            }

            print("StatusModel : $statusModels");
        }
        return statusModels;
    }

    static Future<List<List<StatusModel>>> getDataByGroups()async{
        var response = await http.get(Uri.parse(ConfigEndpoints.taskByGroup));
        if(response.statusCode == 200){
            groupModel.clear();
            var apiData = jsonDecode(response.body);
            for(int i=0;i<apiData.length;i++){
                List<StatusModel>ls = [];
                for(Map<String,dynamic> index in apiData[i]){
                    ls.add(StatusModel.fromJson(index));
                }
                groupModel.add(ls);
            }
        }
        return groupModel;
    }
}