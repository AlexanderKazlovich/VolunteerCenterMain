/**
 * Created by Слава on 15.09.2021.
 */

@IsTest
public class SubTodoManagerTest {

    @IsTest
    static void testCreateSubTodo() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Id thisSubTodoId = SubTodoManager.createSubTodo(
                '45fds4578956424789',
                'Delete',
                'null',
                'null',
                true,
                '',
                '');
        System.assert(thisSubTodoId != null);
        Sub_Todo__c thisSubTodo = [SELECT Id, Name FROM Sub_Todo__c WHERE Id = :thisSubTodoId];
        System.assert(thisSubTodo != null);
        System.assertEquals(thisSubTodo.Name, 'Delete');
    }

    @IsTest
    static void testDeleteTodo() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Sub_Todo__c subTodo = new Sub_Todo__c(Name = 'Fav');
        insert subTodo;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://yourInstance.my.salesforce.com/services/apexrest/SubTodo__c/' + subTodo.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        SubTodoManager.deleteSubTodo();
        List<Sub_Todo__c> subTodos = [SELECT Id FROM Sub_Todo__c WHERE Id = :subTodo.Id];
        System.assert(subTodos.size() == 0);
    }

    @IsTest
    static void testUpdateSubTodo() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Id subTodoId = SubTodoManager.createSubTodo(
                '45fds4578956424789',
                'Delete',
                'null',
                'null',
                true,
                '',
                '');
        System.assert(subTodoId != null);
        Sub_Todo__c thisSubTodo = [SELECT Id, Name FROM Sub_Todo__c WHERE Id = :subTodoId];
        System.assert(thisSubTodo != null);
        System.assertEquals(thisSubTodo.Name, 'Delete');
        Id subTodoSecondId = SubTodoManager.updateSubTodo(
                '45fds4578956424789',
                subTodoId,
                'Delete',
                'null',
                'yes',
                true,
                '',
                '');
        System.assertEquals(subTodoId, subTodoSecondId);
        Sub_Todo__c subTodoSecond = [SELECT Id, Comments__c FROM Sub_Todo__c WHERE Id = :subTodoSecondId];
        System.assert(subTodoSecondId != null);
        System.assertEquals(subTodoSecond.Comments__c, 'yes');
    }

    @IsTest
    static void testUpdateSubTodoSecond() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Id subTodoId = SubTodoManager.createSubTodo(
                '45fds4578956424789',
                'Delete',
                'null',
                'null',
                true,
                '',
                '');
        System.assert(subTodoId != null);
        Sub_Todo__c thisSubTodo = [SELECT Id, Name FROM Sub_Todo__c WHERE Id = :subTodoId];
        System.assert(thisSubTodo != null);
        System.assertEquals(thisSubTodo.Name, 'Delete');
        Id subTodoSecondId = SubTodoManager.updateSubTodo(
                '45fds4578956424789',
                '',
                'Delete',
                'null',
                'yes',
                true,
                '',
                '');
        System.assertEquals(subTodoId, subTodoSecondId);
        Sub_Todo__c subTodoSecond = [SELECT Id, Comments__c FROM Sub_Todo__c WHERE Id = :subTodoSecondId];
        System.assert(subTodoSecondId != null);
        System.assertEquals(subTodoSecond.Comments__c, 'yes');
    }
}