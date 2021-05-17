
class Header {


  getHeaderToken(var token)  {
    Map<String,String> headers = {'Content-Type':'application/json' , 'Consumer' : '254321889'  ,'Authorization': 'Bearer $token'};
    return headers;
  }
}
