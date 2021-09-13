/**
 * Created by Programming on 06.09.2021.
 */

public with sharing class TodoTriggerHelper {

    public static void assignTodoOnQueue(List<Todo__c> newList) {
        for (Todo__c todo : newList) {
            String recordTypeName = Schema.SObjectType.Todo__c.getRecordTypeInfosById().get(todo.RecordTypeId).getDeveloperName();
            if (recordTypeName == 'Emergency_Assistance') {
                todo.OwnerId = getQueueId(recordTypeName);
            } else if (recordTypeName == 'Finding_People') {
                todo.OwnerId = getQueueId(recordTypeName);
            } else if (recordTypeName == 'Nursing_Home') {
                todo.OwnerId = getQueueId(recordTypeName);
            } else if (recordTypeName == 'Orphans_Home') {
                todo.OwnerId = getQueueId(recordTypeName);
            } else if (recordTypeName == 'Physical_Help') {
                todo.OwnerId = getQueueId(recordTypeName);
            } else if (recordTypeName == 'Working_with_animals') {
                todo.OwnerId = getQueueId(recordTypeName);
            }
        }
    }

    public static Id getQueueId(String recordTypeName) {
        return [SELECT Id FROM Group WHERE Type='Queue' AND DeveloperName = :recordTypeName].get(0).Id;
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
            TodoCallouts.makeDeleteCallout(
                    todo.Id,
                    todo.External_Id__c);
        }
    }

    public static void putCallouts(List<Todo__c> newList) {
        for (Todo__c todo: newList) {
            TodoCallouts.makePutCallout(
                    todo.Id,
                    todo.External_Id__c,
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