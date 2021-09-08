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
            String name,
            String comments,
            Datetime thisDateTime,
            String priority,
            String purchase,
            String status) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
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
    public static void makeDeleteCallout(String id) {
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

    private static String handleDateTime(Datetime thisDateTime) {

        String dateSplit;
        String timeSplit;
        String dateTimeJson;

        String checkDate = String.valueOfGmt(thisDateTime);

        if (String.isNotBlank(checkDate)) {
            dateSplit = String.valueOf(thisDateTime.dateGmt());
            timeSplit = String.valueOf(thisDateTime.timeGmt());
            dateTimeJson = '"' + dateSplit + 'T' + timeSplit + '"';
        } else {
            dateTimeJson = '"1921-01-01T00:00:00.000Z"';
        }
        return dateTimeJson;

    }

    private static String isEmpty(String checked) {

        return checked = String.isBlank(checked) ? checked = '' : checked;

    }
}