/**
 * Created by Programming on 13.09.2021.
 */
@IsTest
private with sharing class TodoCleanerBatchTest {
    @IsTest
    private static void deleteTodosTest(){


        Todo__c todo1 = new Todo__c(Name='test1');
        Todo__c todo2 = new Todo__c(Name='test2');

        Datetime fourMonthsLater = System.today().addMonths(-4);
        Datetime twoMonthsLater = System.today().addMonths(-2);

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        insert new List<Todo__c>{todo1, todo2};

        Test.setCreatedDate(todo1.Id, fourMonthsLater);
        Test.setCreatedDate(todo2.Id, twoMonthsLater);
        Test.startTest();
            Database.executeBatch(new TodoCleanerBatch());
        Test.stopTest();


        System.assertEquals(0, [SELECT Name FROM Todo__c WHERE Name='test1'].size());
        System.assertEquals(1, [SELECT Name FROM Todo__c WHERE Name='test2'].size());

    }

}