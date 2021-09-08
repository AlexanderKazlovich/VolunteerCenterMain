/**
 * Created by Слава on 07.09.2021.
 */

public with sharing class TodoCallouts {

    private static final String ENDPOINT = 'callout:Connect/services/apexrest/Todo__c';
    private static Http http = new Http();
    private static HttpRequest request = new HttpRequest();

    @Future(Callout=true)
    public static void makePostCallout(
            String name,
            String comments,
            Datetime thisDateTime,
            String priority,
            String purchase,
            String status) {

        if(String.isBlank(priority)) {
            priority = '';
        }

        if(String.isBlank(status)) {
            status = '';
        }

        String populateBody = '{' +
                '"name":"' + name + '", ' +
                '"comments":"' + comments + '", ' +
                '"thisDateTime" : ' + handleDateTime(thisDateTime) + ', ' +
                '"priority" : "' + priority + '", ' +
                '"purchase" : "' + purchase + '", ' +
                '"status" : "' + status + '" }';
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

    private static String handleDateTime(Datetime thisDateTime) {
        String dateSplit;
        String timeSplit;
        String dateTimeJson;

        String checkDate = String.valueOfGmt(thisDateTime);

        if(String.isNotBlank(checkDate)) {
            dateSplit = String.valueOf(thisDateTime.date());
            timeSplit = String.valueOf(thisDateTime.time());
            dateTimeJson = '"' + dateSplit + 'T' + timeSplit + '"';
        } else {
            dateTimeJson = '"1921-01-01T00:00:00.000Z"';
        }
        return dateTimeJson;
    }
}