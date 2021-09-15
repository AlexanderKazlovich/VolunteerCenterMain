/**
 * Created by Слава on 10.09.2021.
 */

public with sharing class AccountCallouts {

    private static final String ENDPOINT = 'callout:Connect/services/apexrest/Account/';
    private static Http http = new Http();
    private static HttpRequest request = new HttpRequest();

    @Future(Callout=true)
    public static void makePostCallout(
            String id,
            String parentId,
            String todoId,
            String recordTypeId,
            String name,
            String accountNumber,
            Decimal age,
            String accountSite,
            String phone,
            String fax,
            String webSite,
            Decimal annualRevenue,
            Integer numberOfEmployees,
            String type,
            String industry,
            String ownerShip,
            String rating,
            String active,
            String street,
            String city,
            String postalCode,
            String province,
            String country,
            String description,
            String customerPriority,
            String gender,
            String bloodType,
            String rhesusFactor,
            Boolean isFree) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"parentId":"' + thisParentId(parentId) + '", ' +
                '"todoId":"' + thisTodoId(todoId) + '", ' +
                '"recordType":"' + recordTypeName(recordTypeId) + '", ' +
                '"name":"' + name + '", ' +
                '"accountNumber":"' + accountNumber + '", ' +
                '"age":' + age + ', ' +
                '"accountSite":"' + accountSite + '", ' +
                '"phone":"' + phone + '", ' +
                '"fax":"' + fax + '", ' +
                '"webSite":"' + webSite + '", ' +
                '"annualRevenue":' + annualRevenue + ', ' +
                '"numberOfEmployees":' + numberOfEmployees + ', ' +
                '"type" : "' + isEmpty(type) + '", ' +
                '"industry" : "' + isEmpty(industry) + '", ' +
                '"ownerShip" : "' + isEmpty(ownerShip) + '", ' +
                '"rating" : "' + isEmpty(rating) + '", ' +
                '"active" : "' + isEmpty(active) + '", ' +
                '"street":"' + street + '", ' +
                '"city":"' + city + '", ' +
                '"postalCode":"' + postalCode + '", ' +
                '"province":"' + province + '", ' +
                '"country":"' + country + '", ' +
                '"description":"' + description + '", ' +
                '"customerPriority" : "' + isEmpty(customerPriority) + '", ' +
                '"gender" : "' + isEmpty(gender) + '", ' +
                '"bloodType" : "' + isEmpty(bloodType) + '", ' +
                '"rhesusFactor" : "' + isEmpty(rhesusFactor) + '", ' +
                '"isFree" : ' + isFree + '}';
        request.setEndpoint(ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(populateBody);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The Account is successful created with Id ' + response.getBody());
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
            System.debug('Account is deleted');
        } else {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        }
    }

    @Future(Callout=true)
    public static void makePutCallout(
            String id,
            String externalId,
            String parentId,
            String todoId,
            String name,
            String accountNumber,
            Decimal age,
            String accountSite,
            String phone,
            String fax,
            String webSite,
            Decimal annualRevenue,
            Integer numberOfEmployees,
            String type,
            String industry,
            String ownerShip,
            String rating,
            String active,
            String street,
            String city,
            String postalCode,
            String province,
            String country,
            String description,
            String customerPriority,
            String gender,
            String bloodType,
            String rhesusFactor,
            Boolean isFree) {

        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"externalId":"' + externalId + '", ' +
                '"parentId":"' + thisParentId(parentId) + '", ' +
                '"todoId":"' + thisTodoId(todoId) + '", ' +
                '"name":"' + name + '", ' +
                '"accountNumber":"' + accountNumber + '", ' +
                '"age":' + age + ', ' +
                '"accountSite":"' + accountSite + '", ' +
                '"phone":"' + phone + '", ' +
                '"fax":"' + fax + '", ' +
                '"webSite":"' + webSite + '", ' +
                '"annualRevenue":' + annualRevenue + ', ' +
                '"numberOfEmployees":' + numberOfEmployees + ', ' +
                '"type" : "' + isEmpty(type) + '", ' +
                '"industry" : "' + isEmpty(industry) + '", ' +
                '"ownerShip" : "' + isEmpty(ownerShip) + '", ' +
                '"rating" : "' + isEmpty(rating) + '", ' +
                '"active" : "' + isEmpty(active) + '", ' +
                '"street":"' + street + '", ' +
                '"city":"' + city + '", ' +
                '"postalCode":"' + postalCode + '", ' +
                '"province":"' + province + '", ' +
                '"country":"' + country + '", ' +
                '"description":"' + description + '", ' +
                '"customerPriority" : "' + isEmpty(customerPriority) + '", ' +
                '"gender" : "' + isEmpty(gender) + '", ' +
                '"bloodType" : "' + isEmpty(bloodType) + '", ' +
                '"rhesusFactor" : "' + isEmpty(rhesusFactor) + '", ' +
                '"isFree" : ' + isFree + '}';

        request.setEndpoint(ENDPOINT);
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(populateBody);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('The Account is changed created with Id ' + response.getBody());
        }
    }

    private static String isEmpty(String checked) {
        return checked = String.isBlank(checked) ? checked = '' : checked;
    }

    private static String recordTypeName(String recordTypeId) {
        RecordType thisRecordType = [SELECT Name FROM RecordType WHERE Id = :recordTypeId];
        return thisRecordType.Name;
    }

    private static String thisParentId(String id) {
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