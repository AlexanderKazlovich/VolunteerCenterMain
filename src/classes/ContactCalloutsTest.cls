/**
 * Created by Слава on 15.09.2021.
 */

@IsTest
public class ContactCalloutsTest {

    @IsTest
    static void makePostCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();

        Contact contact = new Contact(LastName = 'Ivanov');
        insert contact;

        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM Contact WHERE Name = 'Ivanov'].size());
    }

    @IsTest
    static void makeDeleteCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();

        Contact contact = new Contact(LastName = 'Ivanov');
        insert contact;
        delete contact;

        Test.stopTest();

        System.assertEquals(0, [SELECT Id FROM Contact WHERE Name = 'Ivanov'].size());

    }

    @IsTest
    static void makePutCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();

        Contact contact = new Contact(LastName = 'Ivanov');
        insert contact;

        contact.LastName = 'Locky';
        update contact;

        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM Contact WHERE Name = 'Locky'].size());
    }
}