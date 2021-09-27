/**
 * Created by Слава on 11.09.2021.
 */

@RestResource(UrlMapping='/Todo__c/*')
global with sharing class TodoManager {

    private static final String CHECK_DATE = '1920-12-31 22:10:00';
    private static final String CHECK_NULL = 'null';

    @HttpPost
    global static Id createTodo(
            String id,
            String accountId,
            String recordTypeName,
            String name,
            String comments,
            Datetime thisDateTime,
            String priority,
            String purchase,
            String status) {

        Todo__c thisTodo = new Todo__c(
                Name = name,
                Account__c = thisAccountId(accountId),
                RecordTypeId = thisRecordType(recordTypeName),
                Comments__c = isEmpty(comments),
                DateTime__c = isEmptyDateTime(thisDateTime),
                Priority__c = priority,
                Purchase__c = isEmpty(purchase),
                External_Id__c = id,
                Status__c = status);

        TodoTriggerHandler.isDisabledForCallouts = true;

        insert thisTodo;
        return thisTodo.Id;
    }

    @HttpDelete
    global static void deleteTodo() {
        RestRequest request = RestContext.request;
        String toDoId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1);

        TodoTriggerHandler.isDisabledForCallouts = true;

        List<Todo__c> thisTodos = [SELECT Id FROM Todo__c WHERE External_Id__c = :toDoId OR Id = :toDoId];
        
        delete thisTodos;
    }

    @HttpPut
    global static Id updateTodo(
            String id,
            String externalId,
            String accountId,
            String name,
            String comments,
            Datetime thisDateTime,
            String priority,
            String purchase,
            String status) {

        TodoTriggerHandler.isDisabledForCallouts = true;

        Todo__c thisToDo = [SELECT Id FROM Todo__c WHERE External_Id__c = :id OR Id = :externalId];
        if (thisToDo == null) {
            return null;
        } else {
            thisToDo.Name = name;
            thisToDo.Account__c = thisAccountId(accountId);
            thisToDo.Comments__c = isEmpty(comments);
            thisToDo.DateTime__c = isEmptyDateTime(thisDateTime);
            thisToDo.Priority__c = priority;
            thisToDo.Purchase__c = isEmpty(purchase);
            thisToDo.Status__c = status;

            update thisToDo;
            return thisToDo.Id;
        }
    }

    private static String isEmpty(String checkEntity) {
        return checkEntity.equalsIgnoreCase(CHECK_NULL) ? null : checkEntity;
    }

    private static Datetime isEmptyDateTime(Datetime checkEntity) {
        String checkThisDateTime = String.valueOfGmt(checkEntity);
        return checkThisDateTime.equalsIgnoreCase(CHECK_DATE) ? null : checkEntity;
    }

    private static String thisAccountId(String id) {
        if (String.isBlank(isEmpty(id))) {
            return null;
        } else {
            List<Account> accountsId = [SELECT Id FROM Account WHERE External_Id__c = :id];
            return accountsId.isEmpty() ? id : accountsId[0].Id;
        }
    }

    private static String thisRecordType(String recordType) {
        return [SELECT Id FROM RecordType WHERE RecordType.Name = :recordType].get(0).Id;
    }
}