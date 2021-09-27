/**
 * Created by Слава on 15.09.2021.
 */

@IsTest
public class TodoManagerTest {

    @IsTest
    static void testCreateTodo() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Datetime thisDateTime = Datetime.newInstance(2021, 2, 17, 22, 00, 00);
        Id thisTodoId = TodoManager.createTodo(
                '45fds4578956424789',
                '',
                'Physical Help',
                'Make',
                'null',
                thisDateTime,
                '',
                'null',
                '');
        System.assert(thisTodoId != null);
        Todo__c thisTodo = [SELECT Id, Name FROM Todo__c WHERE Id = :thisTodoId];
        System.assert(thisTodo != null);
        System.assertEquals(thisTodo.Name, 'Make');
    }

    @IsTest
    static void testDeleteTodo() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Todo__c todo = new Todo__c(Name = 'Fav');
        insert todo;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://yourInstance.my.salesforce.com/services/apexrest/Todo__c/' + todo.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        TodoManager.deleteTodo();
        List<Todo__c> todos = [SELECT Id FROM Todo__c WHERE Id = :todo.Id];
        System.assert(todos.size() == 0);
    }

    @IsTest
    static void testUpdateTodo() {
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Datetime thisDateTime = Datetime.newInstance(2021, 2, 17, 22, 00, 00);
        Id todoId = TodoManager.createTodo(
                '45fds4578956424789',
                '',
                'Physical Help',
                'Make',
                'null',
                thisDateTime,
                '',
                'null',
                '');
        System.assert(todoId != null);
        Todo__c thisTodo = [SELECT Id, Name FROM Todo__c WHERE Id = :todoId];
        System.assert(thisTodo != null);
        System.assertEquals(thisTodo.Name, 'Make');
        Id todoSecondId = TodoManager.updateTodo(
                '45fds4578956424789',
                todoId,
                '',
                'Make',
                'Good',
                thisDateTime,
                '',
                'null',
                '');
        System.assertEquals(todoId, todoSecondId);
        Todo__c todoSecond = [SELECT Id, Comments__c FROM Todo__c WHERE Id = :todoSecondId];
        System.assert(todoSecondId != null);
        System.assertEquals(todoSecond.Comments__c, 'Good');
    }
}