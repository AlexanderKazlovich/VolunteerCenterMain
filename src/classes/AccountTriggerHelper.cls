/**
 * Created by Слава on 10.09.2021.
 */

public with sharing class AccountTriggerHelper {

    public static void makeCallouts(List<Account> newList) {
        for (Account account : newList) {
            AccountCallouts.makePostCallout(
                    account.Id,
                    account.ParentId,
                    account.Todo__c,
                    account.RecordTypeId,
                    account.Name,
                    account.AccountNumber,
                    account.Age__c,
                    account.Site,
                    account.Phone,
                    account.Fax,
                    account.Website,
                    account.AnnualRevenue,
                    account.NumberOfEmployees,
                    account.Type,
                    account.Industry,
                    account.Ownership,
                    account.Rating,
                    account.Active__c,
                    account.BillingStreet,
                    account.BillingCity,
                    account.BillingPostalCode,
                    account.BillingState,
                    account.BillingCountry,
                    account.Description,
                    account.CustomerPriority__c,
                    account.Gender__c,
                    account.Blood_Type__c,
                    account.Rhesus_Factor__c,
                    account.isFree__c);
        }
    }

    public static void deleteCallouts(List<Account> oldList) {
        for (Account account : oldList) {
            AccountCallouts.makeDeleteCallout(account.Id);
        }
    }

    public static void putCallouts(List<Account> newList) {
        for (Account account : newList) {
            AccountCallouts.makePutCallout(
                    account.Id,
                    account.ParentId,
                    account.Todo__c,
                    account.Name,
                    account.AccountNumber,
                    account.Age__c,
                    account.Site,
                    account.Phone,
                    account.Fax,
                    account.Website,
                    account.AnnualRevenue,
                    account.NumberOfEmployees,
                    account.Type,
                    account.Industry,
                    account.Ownership,
                    account.Rating,
                    account.Active__c,
                    account.BillingStreet,
                    account.BillingCity,
                    account.BillingPostalCode,
                    account.BillingState,
                    account.BillingCountry,
                    account.Description,
                    account.CustomerPriority__c,
                    account.Gender__c,
                    account.Blood_Type__c,
                    account.Rhesus_Factor__c,
                    account.isFree__c);
        }
    }
}