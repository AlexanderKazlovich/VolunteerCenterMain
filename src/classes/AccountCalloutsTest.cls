/**
 * Created by Слава on 15.09.2021.
 */

@IsTest
public class AccountCalloutsTest {

    @IsTest
    static void makePostCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();

        Account account = new Account(Name = 'React');
        insert account;

        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM Account WHERE Name = 'React'].size());
    }

    @IsTest
    static void makeDeleteCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();

        Account account = new Account(Name = 'React');
        insert account;
        delete account;

        Test.stopTest();

        System.assertEquals(0, [SELECT Id FROM Account WHERE Name = 'React'].size());

    }

    @IsTest
    static void makePutCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();

        Account account = new Account(Name = 'React');
        insert account;

        account.Name = 'Locky';
        update account;

        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM Account WHERE Name = 'Locky'].size());
    }
}