/**
 * Created by Слава on 09.09.2021.
 */

public class SubTodoCallouts {

    private static final String ENDPOINT = 'callout:Connect/services/apexrest/Sub_Todo__c/';
    private static Http http = new Http();
    private static HttpRequest request = new HttpRequest();

    @Future(Callout=true)
    public static void makePostCallout(
            String id,
            String name,
            String purchase,
            String comments,
            Boolean isCompleted,
            String todoId,
            String subTodoId) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"name":"' + name + '", ' +
                '"purchase" : "' + purchase + '", ' +
                '"comments":"' + comments + '", ' +
                '"isCompleted" : ' + isCompleted + ', ' +
                '"todoId" : "' + todoId + '", ' +
                '"subTodoId" : "' + subTodoId + '"}';
        request.setEndpoint(ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(populateBody);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The SubTodo is successful created with Id ' + response.getBody());
        }
    }

    @Future(Callout=true)
    public static void makeDeleteCallout(String id, String externalId) {
        if (String.isNotEmpty(id) && String.isNotEmpty(externalId)) {
            request.setEndpoint(ENDPOINT + externalId);
        } else {
            request.setEndpoint(ENDPOINT + id);
        }
        request.setEndpoint(ENDPOINT + id);
        request.setMethod('DELETE');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug('Todo is deleted');
        } else {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        }
    }

    @Future(Callout=true)
    public static void makePutCallout(
            String id,
            String externalId,
            String name,
            String purchase,
            String comments,
            Boolean isCompleted,
            String todoId,
            String subTodoId) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"externalId":"' + externalId + '", ' +
                '"name":"' + name + '", ' +
                '"purchase" : "' + purchase + '", ' +
                '"comments":"' + comments + '", ' +
                '"isCompleted" : ' + isCompleted + ', ' +
                '"todoId" : "' + todoId + '", ' +
                '"subTodoId" : "' + subTodoId + '"}';
        request.setEndpoint(ENDPOINT);
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(populateBody);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The SubTodo is successful created with Id ' + response.getBody());
        }
    }
}