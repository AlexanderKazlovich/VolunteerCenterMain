/**
 * Created by Слава on 15.09.2021.
 */

@IsTest
public class SubTodoCalloutTest {

    @IsTest
    static void makePostCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();

        Sub_Todo__c subTodo = new Sub_Todo__c(
                Name = 'Groom');
        insert subTodo;

        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM Sub_Todo__c WHERE Name = 'Groom'].size());
    }

    @IsTest
    static void makeDeleteCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Test.startTest();

        Sub_Todo__c subTodo = new Sub_Todo__c(
                Name = 'Groom');
        insert subTodo;

        delete subTodo;

        Test.stopTest();

        System.assertEquals(0, [SELECT Id FROM Sub_Todo__c WHERE Name = 'Groom'].size());

    }

    @IsTest
    static void makePutCalloutTest() {

        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());

        Sub_Todo__c subTodo = new Sub_Todo__c(
                Name = 'Groom');
        insert subTodo;

        Test.startTest();

        subTodo.Name = 'Locky';
        update subTodo;

        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM Sub_Todo__c WHERE Name = 'Locky'].size());
    }

}