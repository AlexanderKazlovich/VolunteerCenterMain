/**
 * Created by Слава on 15.09.2021.
 */

@IsTest
public class ContactManagerTest {
//
//    @IsTest
//    static void testCreateContact() {
//        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
//        Id thisContactId = ContactManager.createContact(
//                '45fds4578956424789',
//                '',
//                'null',
//                'null',
//                '',
//                'null',
//                'null',
//                '1921-01-01 00:00:00',
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                'null');
//        System.assert(thisAccountId != null);
//        Account thisAccount = [SELECT Id, Name FROM Account WHERE Id = :thisAccountId];
//        System.assert(thisAccount != null);
//        System.assertEquals(thisAccount.Name, 'Groom');
//    }
//
//    @IsTest
//    static void testDeleteAccount() {
//        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
//        Account account = new Account(Name = 'Fav');
//        insert account;
//        System.debug(account.Id);
//        RestRequest request = new RestRequest();
//        request.requestURI = 'https://yourInstance.my.salesforce.com/services/apexrest/Cases/' + account.Id;
//        request.httpMethod = 'DELETE';
//        RestContext.request = request;
//        AccountManager.deleteAccount();
//        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :account.Id];
//        System.assert(accounts.size() == 0);
//    }
//
//    @IsTest
//    static void testUpdateAccount() {
//        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
//        Id accountFirstId = AccountManager.createAccount(
//                '45fds4578956424789',
//                '',
//                '',
//                'Company',
//                'Groom',
//                'null',
//                null,
//                'null',
//                'null',
//                'null',
//                'null',
//                null,
//                null,
//                null,
//                null,
//                null,
//                null,
//                null,
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                null,
//                null,
//                null,
//                null,
//                true);
//        System.assert(accountFirstId != null);
//        Account accountFirst = [SELECT Id, Name FROM Account WHERE Id = :accountFirstId];
//        System.assert(accountFirst != null);
//        System.assertEquals(accountFirst.Name, 'Groom');
//        Id accountSecondId = AccountManager.updateAccount(
//                '45fds4578956424789',
//                accountFirstId,
//                '',
//                '',
//                'Groom',
//                'null',
//                null,
//                'null',
//                'null',
//                'null',
//                'null',
//                null,
//                null,
//                null,
//                null,
//                null,
//                null,
//                null,
//                'null',
//                'Brest',
//                'null',
//                'null',
//                'null',
//                'null',
//                null,
//                null,
//                null,
//                null,
//                true);
//        System.assertEquals(accountFirstId, accountSecondId);
//        Account accountSecond = [SELECT Id, BillingCity FROM Account WHERE Id = :accountSecondId];
//        System.assert(accountSecond != null);
//        System.assertEquals(accountSecond.BillingCity, 'Brest');
//    }
//
//    @IsTest
//    static void testUpdateAccountSecond() {
//        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
//        Id accountFirstId = AccountManager.createAccount(
//                '45fds4578956424789',
//                '',
//                '',
//                'Company',
//                'Groom',
//                'null',
//                null,
//                'null',
//                'null',
//                'null',
//                'null',
//                null,
//                null,
//                null,
//                null,
//                null,
//                null,
//                null,
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                'null',
//                null,
//                null,
//                null,
//                null,
//                true);
//        System.assert(accountFirstId != null);
//        Account accountFirst = [SELECT Id, Name FROM Account WHERE Id = :accountFirstId];
//        System.assert(accountFirst != null);
//        System.assertEquals(accountFirst.Name, 'Groom');
//        Id accountSecondId = AccountManager.updateAccount(
//                '45fds4578956424789',
//                'null',
//                '',
//                '',
//                'Groom',
//                'null',
//                null,
//                'null',
//                'null',
//                'null',
//                'null',
//                null,
//                null,
//                null,
//                null,
//                null,
//                null,
//                null,
//                'null',
//                'Brest',
//                'null',
//                'null',
//                'null',
//                'null',
//                null,
//                null,
//                null,
//                null,
//                true);
//        System.assertEquals(accountFirstId, accountSecondId);
//        System.debug(accountFirstId);
//        System.debug(accountSecondId);
//        Account accountSecond = [SELECT Id, BillingCity FROM Account WHERE Id = :accountSecondId];
//        System.assert(accountSecond != null);
//        System.assertEquals(accountSecond.BillingCity, 'Brest');
//    }
}