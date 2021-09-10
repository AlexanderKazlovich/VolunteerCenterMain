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
            String recordType,
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
            Boolean isFree
    ) {
        String populateBody = '{' +
                '"id":"' + id + '", ' +
                '"parentId":"' + parentId + '", ' +
                '"todoId":"' + todoId + '", ' +
                '"recordType":"' + recordType + '", ' +
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
                '"isFree" : ' + isFree + ' ' +
                +'}';
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
            System.debug('The Account is successful created with Id ' + response.getBody());
        }
    }

    private static String isEmpty(String checked) {

        return checked = String.isBlank(checked) ? checked = '' : checked;

    }

}