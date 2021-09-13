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
            String todoId,
            String subTodoId) {

        Sub_Todo__c thisSubTodo = new Sub_Todo__c(
                Name = name,
                Purchase__c = isEmpty(purchase),
                Comments__c = isEmpty(comments),
                isCompleted__c = isCompleted,
                External_Id__c = id,
                Todo__c = isNullId(todoId),
                Sub_Todo__c = thisSubTodoId(subTodoId));

        insert thisSubTodo;
        return thisSubTodo.Id;
    }

    @HttpDelete
    global static void deleteSubTodo() {
        RestRequest request = RestContext.request;
        String subTodoId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1
        );
        List<Sub_Todo__c> thisSubTodos = [SELECT Id FROM Sub_Todo__c WHERE External_Id__c = :subTodoId];
        if (thisSubTodos.isEmpty()) {
            Todo__c thisTodo = [SELECT Id FROM Todo__c WHERE Id = :subTodoId];
            delete thisSubTodos;
        } else {
            delete thisSubTodos;
        }
    }

    @HttpPut
    global static Id updateSubTodo(
            String id,
            String externalId,
            String name,
            String purchase,
            String comments,
            Boolean isCompleted,
            String todoId,
            String subTodoId) {

        List<Sub_Todo__c> thisSubTodos = [SELECT Id FROM Sub_Todo__c WHERE External_Id__c = :id];
        if (thisSubTodos.isEmpty()) {
            Sub_Todo__c thisSubTodo = [SELECT Id FROM Sub_Todo__c WHERE Id = :externalId];
            thisSubTodo.Name = name;
            thisSubTodo.Purchase__c = isEmpty(purchase);
            thisSubTodo.Comments__c = isEmpty(comments);
            thisSubTodo.isCompleted__c = isCompleted;
            thisSubTodo.Todo__c = isNullId(todoId);
            thisSubTodo.Sub_Todo__c = thisSubTodoId(subTodoId);
            update thisSubTodo;
            return thisSubTodo.Id;
        } else {
            thisSubTodos[0].Name = name;
            thisSubTodos[0].Purchase__c = isEmpty(purchase);
            thisSubTodos[0].Comments__c = isEmpty(comments);
            thisSubTodos[0].isCompleted__c = isCompleted;
            thisSubTodos[0].Todo__c = isNullId(todoId);
            thisSubTodos[0].Sub_Todo__c = thisSubTodoId(subTodoId);
            update thisSubTodos[0];
            return thisSubTodos[0].Id;
        }
    }

    private static String isEmpty(String checkEntity) {
        return checkEntity = checkEntity.equalsIgnoreCase(CHECK_NULL) ? checkEntity = null : checkEntity;
    }

    private static String isNullId(String id) {
        if (String.isEmpty(isEmpty(id))) {
            return null;
        } else {
            Todo__c thisTodoId = [SELECT Id FROM Todo__c WHERE External_Id__c = :id];
            return thisTodoId.Id;
        }
    }

    private static String thisSubTodoId(String id) {
        if (String.isEmpty(isEmpty(id))) {
            return null;
        } else {
            Sub_Todo__c thisSubTodoId = [SELECT Id FROM Sub_Todo__c WHERE External_Id__c = :id];
            return thisSubTodoId.Id;
        }
    }
}