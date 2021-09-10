/**
 * Created by Слава on 10.09.2021.
 */

public with sharing class AccountTriggerHelper {

    public static void makeCallouts(List<Account> newList) {
        for (Account account : newList) {
            AccountCallouts.makePostCallout(
                    account.Id,
                    account.ParentId,
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
                    account.CustomerPriority__c
            );
        }
    }

}