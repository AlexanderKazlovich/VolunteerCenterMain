/**
 * Created by Слава on 07.09.2021.
 */

public with sharing class TodoTriggerHandler {

    public static void handleBeforeInsert(List<Todo__c> newList) {
        for (Todo__c todo: newList) {
            TodoCallouts.makePostCallout(todo.Name);
        }
        // EXECUTE BEFORE INSERT LOGIC
    }

    public static void handleBeforeUpdate(List<Todo__c> newList, List<Todo__c> oldList, Map<Id, Todo__c> newMap, Map<Id, Todo__c> oldMap) {
        // BEFORE UPDATE LOGIC
    }


    public static void handleBeforeDelete(List<Todo__c> oldList, Map<Id, Todo__c> oldMap) {
        // BEFORE DELETE LOGIC
    }

    public static void handleAfterInsert(List<Todo__c> newList, Map<Id, Todo__c> newMap) {
        // EXECUTE AFTER INSERT LOGIC
    }

    public static void handleAfterUpdate(List<Todo__c> newList, List<Todo__c> oldList, Map<Id, Todo__c> newMap, Map<Id, Todo__c> oldMap) {
        // AFTER UPDATE LOGIC
    }

    public static void handleAfterDelete(List<Todo__c> oldList, Map<Id, Todo__c> oldMap) {
        // AFTER DELETE LOGIC
    }

    public static void handleAfterUndelete(List<Todo__c> newList, Map<Id, Todo__c> newMap) {
        // AFTER UNDELETE LOGIC
    }

}