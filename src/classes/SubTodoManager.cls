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
                Todo__c = thisTodoId(todoId),
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
            Sub_Todo__c thisSubTodo = [SELECT Id FROM Sub_Todo__c WHERE Id = :subTodoId];
            delete thisSubTodo;
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

        if (String.isEmpty(isEmpty(externalId))) {
            Sub_Todo__c thisSubTodo = [SELECT Id FROM Sub_Todo__c WHERE External_Id__c = :id];
            thisSubTodo.Name = name;
            thisSubTodo.Purchase__c = isEmpty(purchase);
            thisSubTodo.Comments__c = isEmpty(comments);
            thisSubTodo.isCompleted__c = isCompleted;
            thisSubTodo.Todo__c = thisTodoId(todoId);
            thisSubTodo.Sub_Todo__c = thisSubTodoId(subTodoId);
            update thisSubTodo;
            return thisSubTodo.Id;
        } else {
            Sub_Todo__c thisSubTodo = [SELECT Id FROM Sub_Todo__c WHERE Id = :externalId];
            thisSubTodo.Name = name;
            thisSubTodo.Purchase__c = isEmpty(purchase);
            thisSubTodo.Comments__c = isEmpty(comments);
            thisSubTodo.isCompleted__c = isCompleted;
            thisSubTodo.Todo__c = thisTodoId(todoId);
            thisSubTodo.Sub_Todo__c = thisSubTodoId(subTodoId);
            update thisSubTodo;
            return thisSubTodo.Id;
        }
    }

    private static String isEmpty(String checkEntity) {
        return checkEntity.equalsIgnoreCase(CHECK_NULL) ? null : checkEntity;
    }

    private static String thisTodoId(String id) {
        if (String.isEmpty(isEmpty(id))) {
            return null;
        } else {
            List<Todo__c> todosId = [SELECT Id FROM Todo__c WHERE External_Id__c = :id];
            if (todosId.isEmpty()) {
                return id;
            } else {
                return todosId[0].Id;
            }
        }
    }

    private static String thisSubTodoId(String id) {
        if (String.isEmpty(isEmpty(id))) {
            return null;
        } else {
            List<Sub_Todo__c> subTodosId = [SELECT Id FROM Sub_Todo__c WHERE External_Id__c = :id];
            if (subTodosId.isEmpty()) {
                return id;
            } else {
                return subTodosId[0].Id;
            }
        }
    }
}