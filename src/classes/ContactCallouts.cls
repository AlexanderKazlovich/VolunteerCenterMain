/**
 * Created by Слава on 10.09.2021.
 */

public with sharing class ContactCallouts {

    private static final String ENDPOINT = 'callout:Connect/services/apexrest/Contact/';
    private static Http http = new Http();
    private static HttpRequest request = new HttpRequest();

    @Future(Callout=true)
    public static void makePostCallout(
            String id,
            String salutation,
            String firstName,
            String lastName,
            String accountId,
            String title,
            String department,
            Date birthdate,
            String phone,
            String mobile,
            String fax,
            String email,
            String street,
            String city,
            String postalCode,
            String state,
            String country,
            String description) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"salutation":"' + isEmpty(salutation) + '", ' +
                '"firstName":"' + firstName + '", ' +
                '"lastName":"' + lastName + '", ' +
                '"accountId":"' + thisAccountId(accountId) + '", ' +
                '"title":"' + title + '", ' +
                '"department":"' + department + '", ' +
                '"birthdate": ' + handleDate(birthdate) + ', ' +
                '"phone":"' + phone + '", ' +
                '"mobile":"' + mobile + '", ' +
                '"fax":"' + fax + '", ' +
                '"email":"' + email + '", ' +
                '"street":"' + street + '", ' +
                '"city":"' + city + '", ' +
                '"postalCode":"' + postalCode + '", ' +
                '"state":"' + state + '", ' +
                '"country":"' + country + '", ' +
                '"description":"' + description + '"}';

        request.setEndpoint(ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(populateBody);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The Contact is successful created with Id ' + response.getBody());
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
            System.debug('Contact is deleted');
        } else {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        }
    }

    @Future(Callout=true)
    public static void makePutCallout(
            String id,
            String externalId,
            String salutation,
            String firstName,
            String lastName,
            String accountId,
            String title,
            String department,
            Date birthdate,
            String phone,
            String mobile,
            String fax,
            String email,
            String street,
            String city,
            String postalCode,
            String state,
            String country,
            String description) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"externalId":"' + externalId + '", ' +
                '"salutation":"' + isEmpty(salutation) + '", ' +
                '"firstName":"' + firstName + '", ' +
                '"lastName":"' + lastName + '", ' +
                '"accountId":"' + thisAccountId(accountId) + '", ' +
                '"title":"' + title + '", ' +
                '"department":"' + department + '", ' +
                '"birthdate": ' + handleDate(birthdate) + ', ' +
                '"phone":"' + phone + '", ' +
                '"mobile":"' + mobile + '", ' +
                '"fax":"' + fax + '", ' +
                '"email":"' + email + '", ' +
                '"street":"' + street + '", ' +
                '"city":"' + city + '", ' +
                '"postalCode":"' + postalCode + '", ' +
                '"state":"' + state + '", ' +
                '"country":"' + country + '", ' +
                '"description":"' + description + '"}';

        request.setEndpoint(ENDPOINT);
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(populateBody);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The Contact is successful created with Id ' + response.getBody());
        }
    }

    private static String isEmpty(String checked) {

        return checked = String.isBlank(checked) ? checked = '' : checked;

    }

    private static String handleDate(DateTime thisDate) {

        String dateSplit;
        String dateTimeJson;

        String checkDate = String.valueOfGmt(thisDate);

        if (String.isNotBlank(checkDate)) {
            dateSplit = String.valueOf(thisDate.dateGmt());
            dateTimeJson = '"' + dateSplit + '"';
        } else {
            dateTimeJson = '"1921-01-01"';
        }
        return dateTimeJson;
    }

    private static String thisAccountId(String id) {
        if (String.isEmpty(id)) {
            return null;
        } else {
            Account account = [SELECT Id, External_Id__c FROM Account WHERE Id = :id];
            if (String.isNotEmpty(account.Id) && String.isNotEmpty(account.External_Id__c)) {
                return account.External_Id__c;
            } else {
                return account.Id;
            }
        }
    }
}