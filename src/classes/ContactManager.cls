/**
 * Created by Слава on 14.09.2021.
 */

@RestResource(UrlMapping='/Contact/*')
global with sharing class ContactManager {

    private static final String CHECK_DATE = '1921-01-01 00:00:00';
    private static final String CHECK_NULL = 'null';

    @HttpPost
    global static Id createContact(
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

        Contact thisContact = new Contact(
                External_Id__c = id,
                Salutation = salutation,
                FirstName = isEmpty(firstName),
                LastName = isEmpty(lastName),
                AccountId = thisAccountId(accountId),
                Title = isEmpty(title),
                Department = isEmpty(department),
                Birthdate = thisDate(birthdate),
                Phone = isEmpty(phone),
                MobilePhone = isEmpty(mobile),
                Fax = isEmpty(fax),
                Email = isEmpty(email),
                MailingStreet = isEmpty(street),
                MailingCity = isEmpty(city),
                MailingPostalCode = isEmpty(postalCode),
                MailingState = isEmpty(state),
                MailingCountry = isEmpty(country),
                Description = isEmpty(description));

        insert thisContact;
        return thisContact.Id;
    }

    @HttpDelete
    global static void deleteContact() {
        RestRequest request = RestContext.request;
        String contactId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1
        );
        List<Contact> thisContacts = [SELECT Id FROM Contact WHERE External_Id__c = :contactId];
        if (thisContacts.isEmpty()) {
            Contact thisContact = [SELECT Id FROM Contact WHERE Id = :contactId];
            delete thisContact;
        } else {
            delete thisContacts;
        }
    }

    @HttpPut
    global static Id updateContact(
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

        List<Contact> thisContacts = [SELECT Id FROM Contact WHERE External_Id__c = :id];
        if (thisContacts.isEmpty()) {
            Contact thisContact = [SELECT Id FROM Contact WHERE Id = :externalId];
            thisContact.Salutation = salutation;
            thisContact.FirstName = isEmpty(firstName);
            thisContact.LastName = isEmpty(lastName);
            thisContact.AccountId = thisAccountId(accountId);
            thisContact.Title = isEmpty(title);
            thisContact.Department = isEmpty(department);
            thisContact.Birthdate = thisDate(birthdate);
            thisContact.Phone = isEmpty(phone);
            thisContact.MobilePhone = isEmpty(mobile);
            thisContact.Fax = isEmpty(fax);
            thisContact.Email = isEmpty(email);
            thisContact.MailingStreet = isEmpty(street);
            thisContact.MailingCity = isEmpty(city);
            thisContact.MailingPostalCode = isEmpty(postalCode);
            thisContact.MailingState = isEmpty(state);
            thisContact.MailingCountry = isEmpty(country);
            thisContact.Description = isEmpty(description);
            update thisContact;
            return thisContact.Id;
        } else {
            thisContacts[0].Salutation = salutation;
            thisContacts[0].FirstName = isEmpty(firstName);
            thisContacts[0].LastName = isEmpty(lastName);
            thisContacts[0].AccountId = thisAccountId(accountId);
            thisContacts[0].Title = isEmpty(title);
            thisContacts[0].Department = isEmpty(department);
            thisContacts[0].Birthdate = thisDate(birthdate);
            thisContacts[0].Phone = isEmpty(phone);
            thisContacts[0].MobilePhone = isEmpty(mobile);
            thisContacts[0].Fax = isEmpty(fax);
            thisContacts[0].Email = isEmpty(email);
            thisContacts[0].MailingStreet = isEmpty(street);
            thisContacts[0].MailingCity = isEmpty(city);
            thisContacts[0].MailingPostalCode = isEmpty(postalCode);
            thisContacts[0].MailingState = isEmpty(state);
            thisContacts[0].MailingCountry = isEmpty(country);
            thisContacts[0].Description = isEmpty(description);
            update thisContacts[0];
            return thisContacts[0].Id;
        }
    }

    private static String isEmpty(String checkEntity) {
        return checkEntity.equalsIgnoreCase(CHECK_NULL) ? null : checkEntity;
    }

    private static String thisAccountId(String id) {
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

    private static Date thisDate(Date checkEntity) {
        String checkThisDateTime = String.valueOfGmt(checkEntity);
        return checkThisDateTime.equalsIgnoreCase(CHECK_DATE) ? null : checkEntity;
    }
}