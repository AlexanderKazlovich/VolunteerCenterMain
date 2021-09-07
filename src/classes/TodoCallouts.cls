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
            String status
    ) {

        if(String.isBlank(priority)) {
            priority = '';
        }

        if(String.isBlank(status)) {
            status = '';
        }

        System.debug(thisDateTime);

        String dateSplit;
        String timeSplit;
        String dateTimeJson;

        String checkDate = String.valueOfGmt(thisDateTime);
        System.debug(checkDate);

        if(String.isNotBlank(checkDate)) {

            dateSplit = String.valueOf(thisDateTime.date());
            timeSplit = String.valueOf(thisDateTime.time());
            dateTimeJson = '"' + dateSplit + 'T' + timeSplit + '"';
            System.debug('dateTimeJson: ' + dateTimeJson);
        } else {
            dateTimeJson = '"1921-01-01T00:00:00.000Z"';
        }

        System.debug(dateTimeJson);
        System.debug(dateSplit);
        System.debug(timeSplit);

        String populateBody = '{' +
                '"name":"' + name + '", ' +
                '"comments":"' + comments + '", ' +
                '"thisDateTime" : ' + dateTimeJson + ', ' +
                '"priority" : "' + priority + '", ' +
                '"purchase" : "' + purchase + '", ' +
                '"status" : "' + status + '" }';
        System.debug(populateBody);
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
}