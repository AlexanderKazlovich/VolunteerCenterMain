/**
 * Created by Слава on 11.09.2021.
 */

@RestResource(UrlMapping='/Todo__c/*')
global with sharing class TodoManager {

    private static final String CHECK_DATE = '1921-01-01 00:00:00';
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

        insert thisTodo;
        return thisTodo.Id;
    }

    @HttpDelete
    global static void deleteTodo() {
        RestRequest request = RestContext.request;
        String todoId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1
        );
        List<Todo__c> thisTodos = [SELECT Id FROM Todo__c WHERE External_Id__c = :todoId];
        if (thisTodos.isEmpty()) {
            Todo__c thisTodo = [SELECT Id FROM Todo__c WHERE Id = :todoId];
            delete thisTodo;
        } else {
            delete thisTodos;
        }
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

        if (String.isEmpty(isEmpty(externalId))) {
            Todo__c thisTodo = [SELECT Id FROM Todo__c WHERE External_Id__c = :id];
            thisTodo.Name = name;
            thisTodo.Account__c = thisAccountId(accountId);
            thisTodo.Comments__c = isEmpty(comments);
            thisTodo.DateTime__c = isEmptyDateTime(thisDateTime);
            thisTodo.Priority__c = priority;
            thisTodo.Purchase__c = isEmpty(purchase);
            thisTodo.Status__c = status;
            update thisTodo;
            return thisTodo.Id;
        } else {
            Todo__c thisTodo = [SELECT Id FROM Todo__c WHERE Id = :externalId];
            thisTodo.Name = name;
            thisTodo.Account__c = thisAccountId(accountId);
            thisTodo.Comments__c = isEmpty(comments);
            thisTodo.DateTime__c = isEmptyDateTime(thisDateTime);
            thisTodo.Priority__c = priority;
            thisTodo.Purchase__c = isEmpty(purchase);
            thisTodo.Status__c = status;
            update thisTodo;
            return thisTodo.Id;
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
        if (String.isEmpty(isEmpty(id))) {
            return null;
        } else {
            List<Account> accountsId = [SELECT Id FROM Account WHERE External_Id__c = :id];
            if (accountsId.isEmpty()) {
                return id;
            } else {
                return accountsId[0].Id;
            }
        }
    }

    private static String thisRecordType(String recordType) {
        return [SELECT Id FROM RecordType WHERE RecordType.Name = :recordType].get(0).Id;
    }
}