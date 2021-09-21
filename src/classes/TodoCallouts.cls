/**
 * Created by Слава on 07.09.2021.
 */

public with sharing class TodoCallouts {

    private static final String ENDPOINT = 'callout:Connect/services/apexrest/Todo__c/';
    private static Http http = new Http();
    private static HttpRequest request = new HttpRequest();

    @Future(Callout=true)
    public static void makePostCallout(
            String id,
            String accountId,
            String recordTypeId,
            String name,
            String comments,
            Datetime thisDateTime,
            String priority,
            String purchase,
            String status) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"accountId":"' + getAccountId(accountId) + '", ' +
                '"recordTypeName":"' + getRecordTypeName(recordTypeId) + '", ' +
                '"name":"' + name + '", ' +
                '"comments":"' + comments + '", ' +
                '"thisDateTime" : ' + handleDateTime(thisDateTime) + ', ' +
                '"priority" : "' + isEmpty(priority) + '", ' +
                '"purchase" : "' + purchase + '", ' +
                '"status" : "' + isEmpty(status) + '" }';

        request.setEndpoint(ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(populateBody);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The Todo is successful created with Id ' + response.getBody());
        }
    }

    @Future(Callout=true)
    public static void makeDeleteCallout(String id, String externalId) {
        if (String.isNotEmpty(externalId)) {
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
            String accountId,
            String name,
            String comments,
            Datetime thisDateTime,
            String priority,
            String purchase,
            String status) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"externalId":"' + externalId + '", ' +
                '"accountId":"' + getAccountId(accountId) + '", ' +
                '"name":"' + name + '", ' +
                '"comments":"' + comments + '", ' +
                '"thisDateTime" : ' + handleDateTime(thisDateTime) + ', ' +
                '"priority" : "' + isEmpty(priority) + '", ' +
                '"purchase" : "' + purchase + '", ' +
                '"status" : "' + isEmpty(status) + '" }';

        request.setEndpoint(ENDPOINT);
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(populateBody);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The Todo is successful changed with Id ' + response.getBody());
        }
    }

    private static String handleDateTime(Datetime thisDateTime) {
        return thisDateTime != null
                ? JSON.serialize(thisDateTime)
                : JSON.serialize(Datetime.newInstance(1921, 1,1));
    }

    private static String isEmpty(String checked) {
        return checked = String.isBlank(checked) ? '' : checked;
    }

    private static String getAccountId(String id) {
        if (String.isBlank(id)) {
            return null;
        } else {
            Account account = [SELECT Id, External_Id__c FROM Account WHERE Id = :id];
            if (account == null) {
                return null;
            } else {
                return String.isNotBlank(account.External_Id__c) ? account.External_Id__c : account.Id;
            }
        }
    }

    private static String getRecordTypeName(String recordTypeId) {
        return [SELECT Name FROM RecordType WHERE Id = :recordTypeId][0].Name;
    }
}