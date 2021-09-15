/**
 * Created by Programming on 15.09.2021.
 */

@IsTest
private class TodoCalloutsTest {

    @IsTest
    static void makePostCalloutTest(){
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Test.startTest();
        Account account = new Account(Name='test', RecordTypeId='0125g000000mI2mAAE');
        insert account;
        Todo__c todo = new Todo__c(
                Name='testCallout',
                RecordTypeId = '0125g000000mGq4AAE',
                Account__c = account.Id,
                Comments__c = 'test comments',
                DateTime__c = System.today(),
                Priority__c = 'High',
                Purchase__c = 'test',
                Status__c = 'New'
        );
        insert todo;
        Test.stopTest();
        System.assertEquals(1, [SELECT Id FROM Todo__c WHERE Name='testCallout' AND Status__c='New'].size());
    }

    @IsTest
    static void makeDeleteCalloutTest(){
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Test.startTest();
        Account account = new Account(Name='test', RecordTypeId='0125g000000mI2mAAE');
        insert account;
        Todo__c todo = new Todo__c(
                Name='testCallout',
                RecordTypeId = '0125g000000mGq4AAE',
                Account__c = account.Id,
                Comments__c = 'test comments',
                DateTime__c = System.today(),
                Priority__c = 'High',
                Purchase__c = 'test',
                Status__c = 'New'
        );
        insert todo;
        delete todo;
        Test.stopTest();
        System.assertEquals(0, [SELECT Id FROM Todo__c WHERE Name='testCallout' AND Status__c='New'].size());
    }

    @IsTest
    static void makePutCalloutTest(){
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Test.startTest();
        Account account = new Account(Name='test', RecordTypeId='0125g000000mI2mAAE');
        insert account;
        Todo__c todo = new Todo__c(
                Name='testCallout',
                RecordTypeId = '0125g000000mGq4AAE',
                Account__c = account.Id,
                Comments__c = 'test comments',
                DateTime__c = System.today(),
                Priority__c = 'High',
                Purchase__c = 'test',
                Status__c = 'New'
        );
        insert todo;

        todo.Name = 'testCalloutUpdated';
        todo.Status__c = 'Completed';
        update todo;

        Test.stopTest();
        System.assertEquals(0, [SELECT Id FROM Todo__c WHERE Name='testCallout' AND Status__c='New'].size());
        System.assertEquals(1, [SELECT Id FROM Todo__c WHERE Name='testCalloutUpdated' AND Status__c='Completed'].size());
    }


}