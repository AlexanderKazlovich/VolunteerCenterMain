/**
 * Created by Programming on 15.09.2021.
 */

public with sharing class TodoCalloutsMock implements HttpCalloutMock{

    public HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('');
        response.setStatusCode(200);
        return response;
    }
}