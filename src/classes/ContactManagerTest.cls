/**
 * Created by Слава on 15.09.2021.
 */

@IsTest
public class ContactManagerTest {

    @IsTest
    static void testCreateContact() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Date thisDate = Date.newInstance(2022, 2, 17);
        Id thisContactId = ContactManager.createContact(
                '45fds4578956424789',
                '',
                'null',
                'Groom',
                '',
                'null',
                'null',
                thisDate,
                'null',
                'null',
                'null',
                'null',
                'null',
                'null',
                'null',
                'null',
                'null',
                'null');
        System.assert(thisContactId != null);
        Contact thisContact = [SELECT Id, Name FROM Contact WHERE Id = :thisContactId];
        System.assert(thisContact != null);
        System.assertEquals(thisContact.Name, 'Groom');
    }

    @IsTest
    static void testDeleteContact() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Contact contact = new Contact(LastName = 'Fav');
        insert contact;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://yourInstance.my.salesforce.com/services/apexrest/Contacts/' + contact.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        ContactManager.deleteContact();
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Id = :contact.Id];
        System.assert(contacts.size() == 0);
    }

    @IsTest
    static void testUpdateContact() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Date thisDate = Date.newInstance(2022, 2, 17);
        Id contactFirstId = ContactManager.createContact(
                '45fds4578956424789',
                '',
                'null',
                'Groom',
                '',
                'null',
                'null',
                thisDate,
                'null',
                'null',
                'null',
                'null',
                'null',
                'null',
                'null',
                'null',
                'null',
                'null');
        System.assert(contactFirstId != null);
        Contact contactFirst = [SELECT Id, LastName FROM Contact WHERE Id = :contactFirstId];
        System.assert(contactFirst != null);
        System.assertEquals(contactFirst.LastName, 'Groom');
        Id contactSecondId = ContactManager.updateContact(
                '45fds4578956424789',
                contactFirstId,
                '',
                'null',
                'Groom',
                '',
                'null',
                'null',
                thisDate,
                'null',
                'null',
                'null',
                'null',
                'null',
                'Brest',
                'null',
                'null',
                'null',
                'null');
        System.assertEquals(contactFirstId, contactSecondId);
        Contact contactSecond = [SELECT Id, MailingCity FROM Contact WHERE Id = :contactSecondId];
        System.assert(contactSecondId != null);
        System.assertEquals(contactSecond.MailingCity, 'Brest');
    }
}