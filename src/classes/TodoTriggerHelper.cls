/**
 * Created by Programming on 06.09.2021.
 */

public with sharing class TodoTriggerHelper {

    public static void assignTodoOnQueue(List<Todo__c> newList) {
        for (Todo__c todo : newList) {
            String recordTypeName = Schema.SObjectType.Todo__c.getRecordTypeInfosById().get(todo.RecordTypeId).getName();
            if (recordTypeName == 'Emergency Assistance') {
                todo.OwnerId = '00G5g000000zZCREA2';
            } else if (recordTypeName == 'Finding People') {
                todo.OwnerId = '00G5g000000zZCWEA2';
            } else if (recordTypeName == 'Nursing Home') {
                todo.OwnerId = '00G5g000000zZCbEAM';
            } else if (recordTypeName == 'Orphans Home') {
                todo.OwnerId = '00G5g000000zZCgEAM';
            } else if (recordTypeName == 'Physical Help') {
                todo.OwnerId = '00G5g000000zZxIEAU';
            } else if (recordTypeName == 'Working with animals') {
                todo.OwnerId = '00G5g000000zZxmEAE';
            }
        }
    }

    public static void makeCallouts(List<Todo__c> newList) {
        for (Todo__c todo : newList) {
            TodoCallouts.makePostCallout(
                    todo.Id,
                    todo.Account__c,
                    todo.Name,
                    todo.Comments__c,
                    todo.DateTime__c,
                    todo.Priority__c,
                    todo.Purchase__c,
                    todo.Status__c);
        }
    }

    public static void deleteCallouts(List<Todo__c> oldList) {
        for (Todo__c todo : oldList) {
            TodoCallouts.makeDeleteCallout(todo.Id);
        }
    }

    public static void putCallouts(List<Todo__c> newList) {
        for (Todo__c todo: newList) {
            TodoCallouts.makePutCallout(
                    todo.Id,
                    todo.Account__c,
                    todo.Name,
                    todo.Comments__c,
                    todo.DateTime__c,
                    todo.Priority__c,
                    todo.Purchase__c,
                    todo.Status__c);
        }
    }
}