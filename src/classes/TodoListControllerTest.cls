/**
 * Created by Programming on 21.09.2021.
 */
@IsTest
private with sharing class TodoListControllerTest {

    @IsTest
    static void getUncompletedToDo(){
        Todo__c todo = new Todo__c(
                Name = 'test',
                Status__c = 'In progress'
        );

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();
            insert todo;
            todo.OwnerId = UserInfo.getUserId();
            update todo;
        Test.stopTest();

        List<Todo__c> listTodos = TodoListController.getUncompletedToDo();

        System.assertNotEquals(null, listTodos);
        System.assertEquals(1, listTodos.size());
        System.assertEquals('test', listTodos.get(0).Name);
        System.assertEquals('In progress', listTodos.get(0).Status__c);
    }

    @IsTest
    static void getNewToDoTest(){
        Todo__c todo = new Todo__c(
                Name = 'test',
                Status__c = 'New'
        );

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();
        insert todo;
        todo.OwnerId = UserInfo.getUserId();
        update todo;
        Test.stopTest();

        List<Todo__c> listTodos = TodoListController.getNewToDo();

        System.assertNotEquals(null, listTodos);
        System.assertEquals(1, listTodos.size());
        System.assertEquals('test', listTodos.get(0).Name);
        System.assertEquals('New', listTodos.get(0).Status__c);
    }

    @IsTest
    static void getCompletedToDoTest(){
        Todo__c todo = new Todo__c(
                Name = 'test',
                Status__c = 'Completed'
        );

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();
        insert todo;
        todo.OwnerId = UserInfo.getUserId();
        update todo;
        Test.stopTest();

        List<Todo__c> listTodos = TodoListController.getCompletedToDo();

        System.assertNotEquals(null, listTodos);
        System.assertEquals(1, listTodos.size());
        System.assertEquals('test', listTodos.get(0).Name);
        System.assertEquals('Completed', listTodos.get(0).Status__c);
    }

    @IsTest
    static void searchTest(){
        Id companyRecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName='Company'].get(0).Id;
        Account account = new Account(
                Name = 'test',
                RecordTypeId = companyRecordTypeId
        );

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();
        insert account;
        Test.stopTest();

        String myObject = 'Account';
        String searchTerm = 't';
        List<SObject> listTodos1 = TodoListController.search(searchTerm, myObject, null);
        List<SObject> listTodos2 = TodoListController.search(null, myObject, null);
        List<SObject> listTodos3 = TodoListController.search(searchTerm, myObject, 'Name = \'test\'');

        System.assertNotEquals(null, listTodos1);
        System.assertEquals(1, listTodos1.size());
        System.assertEquals('test', listTodos1.get(0).get('Name'));

        System.assertNotEquals(null, listTodos2);
        System.assertEquals(1, listTodos2.size());
        System.assertEquals('test', listTodos2.get(0).get('Name'));

        System.assertNotEquals(null, listTodos3);
        System.assertEquals(1, listTodos3.size());
        System.assertEquals('test', listTodos3.get(0).get('Name'));
    }

}