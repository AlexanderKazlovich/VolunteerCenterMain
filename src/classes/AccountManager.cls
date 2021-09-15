/**
 * Created by Слава on 14.09.2021.
 */

@RestResource(UrlMapping='/Account/*')
global with sharing class AccountManager {

    private static final String CHECK_NULL = 'null';

    @HttpPost
    global static Id createAccount(
            String id,
            String parentId,
            String todoId,
            String recordType,
            String name,
            String accountNumber,
            Double age,
            String accountSite,
            String phone,
            String fax,
            String webSite,
            Double annualRevenue,
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

        Account thisAccount = new Account(
                External_Id__c = id,
                ParentId = thisParentId(parentId),
                Todo__c = thisTodoId(todoId),
                RecordTypeId = thisRecordType(recordType),
                Name = name,
                AccountNumber = isEmpty(accountNumber),
                Age__c = age,
                Site = isEmpty(accountSite),
                Phone = isEmpty(phone),
                Fax = isEmpty(fax),
                Website = isEmpty(webSite),
                AnnualRevenue = annualRevenue,
                NumberOfEmployees = numberOfEmployees,
                Type = type,
                Industry = industry,
                Ownership = ownerShip,
                Rating = rating,
                Active__c = active,
                BillingStreet = isEmpty(street),
                BillingCity = isEmpty(city),
                BillingPostalCode = isEmpty(postalCode),
                BillingState = isEmpty(province),
                BillingCountry = isEmpty(country),
                Description = isEmpty(description),
                CustomerPriority__c = customerPriority,
                Gender__c = gender,
                Blood_Type__c = bloodType,
                Rhesus_Factor__c = rhesusFactor,
                IsFree__c = isFree);

        insert thisAccount;
        return thisAccount.Id;
    }


    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1
        );
        List<Account> thisAccounts = [SELECT Id FROM Account WHERE External_Id__c = :accountId];
        if (thisAccounts.isEmpty()) {
            Account thisAccount = [SELECT Id FROM Account WHERE Id = :accountId];
            delete thisAccount;
        } else {
            delete thisAccounts;
        }
    }

    @HttpPut
    global static Id updateAccount(
            String id,
            String externalId,
            String parentId,
            String todoId,
            String name,
            String accountNumber,
            Double age,
            String accountSite,
            String phone,
            String fax,
            String webSite,
            Double annualRevenue,
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

//        List<Account> thisAccounts = [SELECT Id FROM Account WHERE External_Id__c = :id];
//        if (thisAccounts.isEmpty()) {
//            Account thisAccount = [SELECT Id FROM Account WHERE Id = :externalId];
//            thisAccount.ParentId = thisParentId(parentId);
//            thisAccount.Todo__c = thisTodoId(todoId);
//            thisAccount.Name = name;
//            thisAccount.AccountNumber = isEmpty(accountNumber);
//            thisAccount.Age__c = age;
//            thisAccount.Site = isEmpty(accountSite);
//            thisAccount.Phone = isEmpty(phone);
//            thisAccount.Fax = isEmpty(fax);
//            thisAccount.Website = isEmpty(webSite);
//            thisAccount.AnnualRevenue = annualRevenue;
//            thisAccount.NumberOfEmployees = numberOfEmployees;
//            thisAccount.Type = type;
//            thisAccount.Industry = industry;
//            thisAccount.Ownership = ownerShip;
//            thisAccount.Rating = rating;
//            thisAccount.Active__c = active;
//            thisAccount.BillingStreet = isEmpty(street);
//            thisAccount.BillingCity = isEmpty(city);
//            thisAccount.BillingPostalCode = isEmpty(postalCode);
//            thisAccount.BillingState = isEmpty(province);
//            thisAccount.BillingCountry = isEmpty(country);
//            thisAccount.Description = isEmpty(description);
//            thisAccount.CustomerPriority__c = customerPriority;
//            thisAccount.Gender__c = gender;
//            thisAccount.Blood_Type__c = bloodType;
//            thisAccount.Rhesus_Factor__c = rhesusFactor;
//            thisAccount.IsFree__c = isFree;
//            update thisAccount;
//            return thisAccount.Id;
//        } else {
//            thisAccounts[0].ParentId = thisParentId(parentId);
//            thisAccounts[0].Todo__c = thisTodoId(todoId);
//            thisAccounts[0].Name = name;
//            thisAccounts[0].AccountNumber = isEmpty(accountNumber);
//            thisAccounts[0].Age__c = age;
//            thisAccounts[0].Site = isEmpty(accountSite);
//            thisAccounts[0].Phone = isEmpty(phone);
//            thisAccounts[0].Fax = isEmpty(fax);
//            thisAccounts[0].Website = isEmpty(webSite);
//            thisAccounts[0].AnnualRevenue = annualRevenue;
//            thisAccounts[0].NumberOfEmployees = numberOfEmployees;
//            thisAccounts[0].Type = type;
//            thisAccounts[0].Industry = industry;
//            thisAccounts[0].Ownership = ownerShip;
//            thisAccounts[0].Rating = rating;
//            thisAccounts[0].Active__c = active;
//            thisAccounts[0].BillingStreet = isEmpty(street);
//            thisAccounts[0].BillingCity = isEmpty(city);
//            thisAccounts[0].BillingPostalCode = isEmpty(postalCode);
//            thisAccounts[0].BillingState = isEmpty(province);
//            thisAccounts[0].BillingCountry = isEmpty(country);
//            thisAccounts[0].Description = isEmpty(description);
//            thisAccounts[0].CustomerPriority__c = customerPriority;
//            thisAccounts[0].Gender__c = gender;
//            thisAccounts[0].Blood_Type__c = bloodType;
//            thisAccounts[0].Rhesus_Factor__c = rhesusFactor;
//            thisAccounts[0].IsFree__c = isFree;
//            update thisAccounts;
//            return thisAccounts[0].Id;
//        }

        if(String.isEmpty(isEmpty(externalId))) {
            Account thisAccount = [SELECT Id FROM Account WHERE External_Id__c = :id];
            thisAccount.ParentId = thisParentId(parentId);
            thisAccount.Todo__c = thisTodoId(todoId);
            thisAccount.Name = name;
            thisAccount.AccountNumber = isEmpty(accountNumber);
            thisAccount.Age__c = age;
            thisAccount.Site = isEmpty(accountSite);
            thisAccount.Phone = isEmpty(phone);
            thisAccount.Fax = isEmpty(fax);
            thisAccount.Website = isEmpty(webSite);
            thisAccount.AnnualRevenue = annualRevenue;
            thisAccount.NumberOfEmployees = numberOfEmployees;
            thisAccount.Type = type;
            thisAccount.Industry = industry;
            thisAccount.Ownership = ownerShip;
            thisAccount.Rating = rating;
            thisAccount.Active__c = active;
            thisAccount.BillingStreet = isEmpty(street);
            thisAccount.BillingCity = isEmpty(city);
            thisAccount.BillingPostalCode = isEmpty(postalCode);
            thisAccount.BillingState = isEmpty(province);
            thisAccount.BillingCountry = isEmpty(country);
            thisAccount.Description = isEmpty(description);
            thisAccount.CustomerPriority__c = customerPriority;
            thisAccount.Gender__c = gender;
            thisAccount.Blood_Type__c = bloodType;
            thisAccount.Rhesus_Factor__c = rhesusFactor;
            thisAccount.isFree__c = isFree;
            update thisAccount;
            return thisAccount.Id;
        } else {
            Account thisAccount = [SELECT Id FROM Account WHERE Id = :externalId];
            thisAccount.ParentId = thisParentId(parentId);
            thisAccount.Todo__c = thisTodoId(todoId);
            thisAccount.Name = name;
            thisAccount.AccountNumber = isEmpty(accountNumber);
            thisAccount.Age__c = age;
            thisAccount.Site = isEmpty(accountSite);
            thisAccount.Phone = isEmpty(phone);
            thisAccount.Fax = isEmpty(fax);
            thisAccount.Website = isEmpty(webSite);
            thisAccount.AnnualRevenue = annualRevenue;
            thisAccount.NumberOfEmployees = numberOfEmployees;
            thisAccount.Type = type;
            thisAccount.Industry = industry;
            thisAccount.Ownership = ownerShip;
            thisAccount.Rating = rating;
            thisAccount.Active__c = active;
            thisAccount.BillingStreet = isEmpty(street);
            thisAccount.BillingCity = isEmpty(city);
            thisAccount.BillingPostalCode = isEmpty(postalCode);
            thisAccount.BillingState = isEmpty(province);
            thisAccount.BillingCountry = isEmpty(country);
            thisAccount.Description = isEmpty(description);
            thisAccount.CustomerPriority__c = customerPriority;
            thisAccount.Gender__c = gender;
            thisAccount.Blood_Type__c = bloodType;
            thisAccount.Rhesus_Factor__c = rhesusFactor;
            thisAccount.isFree__c = isFree;
            update thisAccount;
            return thisAccount.Id;
        }
    }

    private static String thisRecordType(String recordType) {
        RecordType thisRecordType = [SELECT Id FROM RecordType WHERE RecordType.Name = :recordType];
        return thisRecordType.Id;
    }

    private static String isEmpty(String checkEntity) {
        return checkEntity = checkEntity.equalsIgnoreCase(CHECK_NULL) ? checkEntity = null : checkEntity;
    }

    private static String thisParentId(String id) {
        if (String.isEmpty(isEmpty(id))) {
            return null;
        } else {
            List<Account> accountsId = [SELECT Id FROM Account WHERE External_Id__c = :id];
            if (accountsId.isEmpty()) {
                return id;
            } else {
                return accountsId[0].Id;
            }
        }
    }

    private static String thisTodoId(String id) {
        if (String.isEmpty(isEmpty(id))) {
            return null;
        } else {
            List<Todo__c> todosId = [SELECT Id FROM Todo__c WHERE External_Id__c = :id];
            if (todosId.isEmpty()) {
                return id;
            } else {
                return todosId[0].Id;
            }
        }
    }
}