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
                '"todoId" : "' + thisTodoId(todoId) + '", ' +
                '"subTodoId" : "' + thisSubTodoId(subTodoId) + '"}';
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
                '"todoId" : "' + thisTodoId(todoId) + '", ' +
                '"subTodoId" : "' + thisSubTodoId(subTodoId) + '"}';
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

    private static String thisSubTodoId(String id) {
        if (String.isEmpty(id)) {
            return null;
        } else {
            Sub_Todo__c thisSubTodo = [SELECT Id, External_Id__c FROM Sub_Todo__c WHERE Id = :id];
            if (String.isNotEmpty(thisSubTodo.Id) && String.isNotEmpty(thisSubTodo.External_Id__c)) {
                return thisSubTodo.External_Id__c;
            } else {
                return thisSubTodo.Id;
            }
        }
    }

    private static String thisTodoId(String id) {
        if (String.isEmpty(id)) {
            return null;
        } else {
            Todo__c thisTodo = [SELECT Id, External_Id__c FROM Todo__c WHERE Id = :id];
            if (String.isNotEmpty(thisTodo.Id) && String.isNotEmpty(thisTodo.External_Id__c)) {
                return thisTodo.External_Id__c;
            } else {
                return thisTodo.Id;
            }
        }
    }
}