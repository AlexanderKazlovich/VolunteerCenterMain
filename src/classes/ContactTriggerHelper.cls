/**
 * Created by Слава on 10.09.2021.
 */

public with sharing class ContactTriggerHelper {

    public static void makeCallouts(List<Contact> newList) {
        for (Contact contact : newList) {
            ContactCallouts.makePostCallout(
                    contact.Id,
                    contact.FirstName,
                    contact.Salutation,
                    contact.LastName,
                    contact.AccountId,
                    contact.Title,
                    contact.Department,
                    contact.Birthdate,
                    contact.Phone,
                    contact.MobilePhone,
                    contact.Fax,
                    contact.Email,
                    contact.MailingStreet,
                    contact.MailingCity,
                    contact.MailingPostalCode,
                    contact.MailingState,
                    contact.MailingCountry,
                    contact.Description);
        }
    }

    public static void deleteCallouts(List<Contact> oldList) {
        for (Contact contact : oldList) {
            ContactCallouts.makeDeleteCallout(contact.Id);
        }
    }

    public static void putCallouts(List<Contact> newList) {
        for (Contact contact : newList) {
            ContactCallouts.makePutCallout(
                    contact.Id,
                    contact.FirstName,
                    contact.Salutation,
                    contact.LastName,
                    contact.AccountId,
                    contact.Title,
                    contact.Department,
                    contact.Birthdate,
                    contact.Phone,
                    contact.MobilePhone,
                    contact.Fax,
                    contact.Email,
                    contact.MailingStreet,
                    contact.MailingCity,
                    contact.MailingPostalCode,
                    contact.MailingState,
                    contact.MailingCountry,
                    contact.Description);
        }
    }

}