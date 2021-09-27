/**
 * Created by Слава on 13.09.2021.
 */

@RestResource(UrlMapping='/Sub_Todo__c/*')
global class SubTodoManager {

    private static final String CHECK_NULL = 'null';

    @HttpPost
    global static Id createSubTodo(
            String id,
            String name,
            String purchase,
            String comments,
            Boolean isCompleted,
            String todoId) {

        Sub_Todo__c thisSubTodo = new Sub_Todo__c(
                Name = name,
                Purchase__c = isEmpty(purchase),
                Comments__c = isEmpty(comments),
                isCompleted__c = isCompleted,
                External_Id__c = id,
                Todo__c = getTodoId(todoId)
                );

        SubTodoTriggerHandler.isDisabledForCallouts = true;

        insert thisSubTodo;
        return thisSubTodo.Id;
    }

    @HttpDelete
    global static void deleteSubTodo() {
        RestRequest request = RestContext.request;
        String subTodoId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1
        );

        SubTodoTriggerHandler.isDisabledForCallouts = true;

        List<Sub_Todo__c> thisSubTodos = [SELECT Id FROM Sub_Todo__c WHERE External_Id__c = :subTodoId OR Id = :subTodoId];
        
        delete thisSubTodos;
    }

    @HttpPut
    global static Id updateSubTodo(
            String id,
            String externalId,
            String name,
            String purchase,
            String comments,
            Boolean isCompleted) {

        SubTodoTriggerHandler.isDisabledForCallouts = true;

        Sub_Todo__c thisSubTodo = [SELECT Id FROM Sub_Todo__c WHERE External_Id__c = :id OR Id = :externalId];
        if (thisSubTodo == null) {
            return null;
        } else {
            thisSubTodo.Name = name;
            thisSubTodo.Purchase__c = isEmpty(purchase);
            thisSubTodo.Comments__c = isEmpty(comments);
            thisSubTodo.isCompleted__c = isCompleted;

            update thisSubTodo;
            return thisSubTodo.Id;
        }
    }

    private static String isEmpty(String checkEntity) {
        return checkEntity.equalsIgnoreCase(CHECK_NULL) ? null : checkEntity;
    }

    private static String getTodoId(String id) {
        if (String.isEmpty(isEmpty(id))) {
            return null;
        } else {
            List<Todo__c> todosId = [SELECT Id FROM Todo__c WHERE External_Id__c = :id];
            return todosId.isEmpty() ? id : todosId[0].Id;
        }
    }
}