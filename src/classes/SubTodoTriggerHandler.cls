/**
 * Created by Слава on 09.09.2021.
 */

public with sharing class SubTodoTriggerHandler {

    public static void handleBeforeInsert(List<Sub_Todo__c> newList) {
        // EXECUTE BEFORE INSERT LOGIC
    }

    public static void handleBeforeUpdate(List<Sub_Todo__c> oldList, List<Sub_Todo__c> newList, Map<Id, Sub_Todo__c> newMap, Map<Id, Sub_Todo__c> oldMap) {
        // BEFORE UPDATE LOGIC
    }


    public static void handleBeforeDelete(List<Sub_Todo__c> oldList, Map<Id, Sub_Todo__c> oldMap) {
        // BEFORE DELETE LOGIC
    }

    public static void handleAfterInsert(List<Sub_Todo__c> newList, Map<Id, Sub_Todo__c> newMap) {
        SubTodoTriggerHelper.makeCallouts(newList);
        // EXECUTE AFTER INSERT LOGIC
    }

    public static void handleAfterUpdate(List<Sub_Todo__c> oldList, List<Sub_Todo__c> newList, Map<Id, Sub_Todo__c> newMap, Map<Id, Sub_Todo__c> oldMap) {
        // AFTER UPDATE LOGIC
    }

    public static void handleAfterDelete(List<Sub_Todo__c> oldList, Map<Id, Sub_Todo__c> oldMap) {
        // AFTER DELETE LOGIC
    }

    public static void handleAfterUndelete(List<Sub_Todo__c> newList, Map<Id, Sub_Todo__c> newMap) {
        // AFTER UNDELETE LOGIC
    }
}