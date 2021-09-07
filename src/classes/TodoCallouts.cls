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
//            Datetime thisDateTime,
            Boolean isCompleted,
            String priority,
            String purchase
    ) {
        String populateBody = '{' +
                '"name":"' + name + '", ' +
                '"comments":"' + comments + '", ' +
//                '"thisDateTime" : ' + thisDateTime + ', ' +
                '"isCompleted" : ' + isCompleted + ', ' +
                '"priority" : "' + priority + '", ' +
                '"purchase" : "' + purchase + '" }';
//                '}';
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